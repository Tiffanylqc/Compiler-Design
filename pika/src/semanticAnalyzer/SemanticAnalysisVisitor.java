package semanticAnalyzer;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import lexicalAnalyzer.Keyword;
import lexicalAnalyzer.Lextant;
import lexicalAnalyzer.Punctuator;
import logging.PikaLogger;
import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import parseTree.nodeTypes.ArrayTypeNode;
import parseTree.nodeTypes.AssignStatementNode;
import parseTree.nodeTypes.OperatorNode;
import parseTree.nodeTypes.BooleanConstantNode;
import parseTree.nodeTypes.CastOperatorNode;
import parseTree.nodeTypes.CharacterConstantNode;
import parseTree.nodeTypes.BlockStatementNode;
import parseTree.nodeTypes.DeclarationNode;
import parseTree.nodeTypes.ErrorNode;
import parseTree.nodeTypes.IdentifierNode;
import parseTree.nodeTypes.IfStatementNode;
import parseTree.nodeTypes.IntegerConstantNode;
import parseTree.nodeTypes.FloatingConstantNode;
import parseTree.nodeTypes.NewlineNode;
import parseTree.nodeTypes.PrintStatementNode;
import parseTree.nodeTypes.ProgramNode;
import parseTree.nodeTypes.ReleaseStatementNode;
import parseTree.nodeTypes.SpaceNode;
import parseTree.nodeTypes.StringConstantNode;
import parseTree.nodeTypes.TabNode;
import parseTree.nodeTypes.WhileStatementNode;
import parseTree.nodeTypes.PrimitiveTypeNode;
import semanticAnalyzer.signatures.FunctionSignature;
import semanticAnalyzer.signatures.FunctionSignatures;
import semanticAnalyzer.types.Array;
import semanticAnalyzer.types.PrimitiveType;
import semanticAnalyzer.types.Type;
import symbolTable.Binding;
import symbolTable.Scope;
import tokens.LextantToken;
import tokens.Token;

class SemanticAnalysisVisitor extends ParseNodeVisitor.Default {
	
	public SemanticAnalysisVisitor(){
	}
	
	@Override
	public void visitLeave(ParseNode node) {
		throw new RuntimeException("Node class unimplemented in SemanticAnalysisVisitor: " + node.getClass());
	}
	
	///////////////////////////////////////////////////////////////////////////
	// constructs larger than statements
	@Override
	public void visitEnter(ProgramNode node) {
		enterProgramScope(node);
	}
	public void visitLeave(ProgramNode node) {
		leaveScope(node);
	}
	public void visitEnter(BlockStatementNode node) {
		enterSubscope(node);
	}
	public void visitLeave(BlockStatementNode node) {
		leaveScope(node);
	}
	
	
	///////////////////////////////////////////////////////////////////////////
	// helper methods for scoping.
	private void enterProgramScope(ParseNode node) {
		Scope scope = Scope.createProgramScope();
		node.setScope(scope);
	}	

	private void enterSubscope(ParseNode node) {
		Scope baseScope = node.getLocalScope();
		Scope scope = baseScope.createSubscope();
		node.setScope(scope);
	}		
	private void leaveScope(ParseNode node) {
		node.getScope().leave();
	}
	
	///////////////////////////////////////////////////////////////////////////
	// statements and declarations
	@Override
	public void visitLeave(PrintStatementNode node) {
	}
	@Override
	public void visitLeave(DeclarationNode node) {
		IdentifierNode identifier = (IdentifierNode) node.child(0);
		ParseNode initializer = node.child(1);
		
		Type declarationType = initializer.getType();
		node.setType(declarationType);
		
		identifier.setType(declarationType);
		
		if(node.getToken().isLextant(Keyword.CONST)){
			addBinding(identifier, declarationType, false);
		}
		else if(node.getToken().isLextant(Keyword.VAR))
			addBinding(identifier, declarationType, true);
	}
	
	///////////////////////////////////////////////////////////////////////////
	// ArrayNode
//	@Override
//	public void visitLeave(ArrayNode node){
//		node.setType(new Array(node.child(0).getType()));
//	}
	///////////////////////////////////////////////////////////////////////////
	// ArrayTypeNode
	@Override
	public void visitLeave(ArrayTypeNode node){
		node.setType(new Array(node.child(0).getType()));
	}
	///////////////////////////////////////////////////////////////////////////
	// assignment
	@Override
	public void visitLeave(AssignStatementNode node) {
		assert node.nChildren() == 2;
		
		if(node.child(0) instanceof IdentifierNode){
			IdentifierNode left  = (IdentifierNode)node.child(0);
			Binding binding = left.findVariableBinding();
			if(binding.getMutable()==false){
				ImmutableError(left);
				node.setType(PrimitiveType.ERROR);
				return;
			}
		}
		else if(!(node.child(0).getToken().isLextant(Punctuator.ARRAY_INDEXING)))//illegal type
			return;
		else//array indexing no need to do type check
			;
		
		ParseNode left = node.child(0);
		ParseNode right = node.child(1);
		List<Type> childTypes = Arrays.asList(right.getType(),left.getType());
		
		Lextant operator = operatorFor(node);
		FunctionSignatures signatures = FunctionSignatures.signaturesOf(operator);
		FunctionSignature signature = signatures.acceptingSignature(childTypes);
		
//		if(signature.accepts(childTypes)) 
		if(!signature.isNull()){
			if(left.getType()!=signature.getParamTypes()[1]&&!(left.getType() instanceof Array)){
				CastOperatorNode insertedNode=new CastOperatorNode(left.getToken());
				PrimitiveTypeNode type=new PrimitiveTypeNode(left.getToken());
				type.setType(signature.getParamTypes()[1]);
					
				insertedNode.appendChild(left);
				insertedNode.appendChild(type);
				insertedNode.setType(signature.getParamTypes()[1]);
				node.getChildren().remove(0);
				node.getChildren().add(0, insertedNode);
				insertedNode.setParent(node);
//				node.replaceChild(node.child(0), insertedNode);
			}
			
			if(right.getType()!=signature.getParamTypes()[0]&&!(right.getType() instanceof Array)){
				
				CastOperatorNode insertedNode=new CastOperatorNode(right.getToken());
				PrimitiveTypeNode type=new PrimitiveTypeNode(right.getToken());
				type.setType(signature.getParamTypes()[0]);
					
				insertedNode.appendChild(right);
				insertedNode.appendChild(type);
				insertedNode.setType(signature.getParamTypes()[0]);
				node.getChildren().remove(1);
				node.getChildren().add(1, insertedNode);
				insertedNode.setParent(node);
//				node.replaceChild(node.child(1), insertedNode);
			}
			node.setType(signature.resultType());
			node.setSignature(signature);
		}
		else {
			typeCheckError(node, Arrays.asList(left.getType(),right.getType()));
			node.setType(PrimitiveType.ERROR);
		}
	}
	private Lextant operatorFor(AssignStatementNode node) {
		LextantToken token = (LextantToken) node.getToken();
		return token.getLextant();
	}
	///////////////////////////////////////////////////////////////////////////
	// while 
	@Override
	public void visitLeave(WhileStatementNode node){
		assert node.nChildren()==2;
		ParseNode condition=node.child(0);
		if(condition.getType()!=PrimitiveType.BOOLEAN){
			typeCheckError(node, Arrays.asList(condition.getType()));
			node.setType(PrimitiveType.ERROR);
		}
	}
	
	///////////////////////////////////////////////////////////////////////////
	// If 
	@Override
	public void visitLeave(IfStatementNode node){
		assert node.nChildren()==2||node.nChildren()==3;
		ParseNode condition=node.child(0);
		if(condition.getType()!=PrimitiveType.BOOLEAN){
			typeCheckError(node, Arrays.asList(condition.getType()));
			node.setType(PrimitiveType.ERROR);
		}
	}
	///////////////////////////////////////////////////////////////////////////
	// Release
	@Override
	public void visitLeave(ReleaseStatementNode node){
		assert node.nChildren()==1;
		
		if((node.child(0).getType()!=PrimitiveType.STRING) && !((node.child(0).getType() instanceof Array ))){
			typeCheckError(node, Arrays.asList(node.child(0).getType()));
			node.setType(PrimitiveType.ERROR);
		}
	}
	///////////////////////////////////////////////////////////////////////////
	// ArrayIndexing
//	@Override
//	public void visitLeave(ArrayIndexingNode node){
//		ParseNode array=node.child(0);
//		ParseNode index=node.child(1);
//		if(!(array.getType() instanceof Array)){
//			typeCheckError(node, Arrays.asList(array.getType()));
//			node.setType(PrimitiveType.ERROR);
//			return;
//		}
//		if(index.getType()!=PrimitiveType.INTEGER){
//			typeCheckError(node, Arrays.asList(index.getType()));
//			node.setType(PrimitiveType.ERROR);
//			return;
//		}
//	}
	
	///////////////////////////////////////////////////////////////////////////
	// expressions
	@Override
	public void visitLeave(OperatorNode node) {
		assert (node.nChildren()>=1);
		List<Type> childTypes=new ArrayList<Type>();
		if(node.getToken().isLextant(Punctuator.OPEN_BRACKET)){//populate array creation type check promotion
			boolean convertable;
			List<Type> finalTypes=new ArrayList<Type>();
			for(ParseNode child1:node.getChildren()){
				convertable=true;
				
				for(ParseNode child2:node.getChildren()){
					if(!FunctionSignature.canConvert(child2.getType(),child1.getType())){
						convertable=false;
						break;
					}	
				}
				if(convertable==true){
					boolean exist=false;
					for(int i=0;i<finalTypes.size();i++){
						if(finalTypes.get(i).equivalent(child1.getType().getConcreteType())){
							exist=true;
							break;
						}
					}
					if(exist==false)
						finalTypes.add(child1.getType().getConcreteType());					
				}
			}
			if(finalTypes.size()==0){
				typeCheckError(node, childTypes);
				node.setType(PrimitiveType.ERROR);
				return;
			}
			else if(finalTypes.size()==1){
				
				childTypes=new ArrayList<Type>();
				childTypes.add(finalTypes.get(0));
			}
			else{
				if(finalTypes.contains(PrimitiveType.CHARACTER)){
					childTypes=new ArrayList<Type>();
					childTypes.add(PrimitiveType.CHARACTER);
				}
				else if(finalTypes.contains(PrimitiveType.INTEGER)){
					childTypes=new ArrayList<Type>();
					childTypes.add(PrimitiveType.INTEGER);
				}
				else if(finalTypes.contains(PrimitiveType.FLOATING)){
					childTypes=new ArrayList<Type>();
					childTypes.add(PrimitiveType.FLOATING);
				}
				else //(finalTypes.contains(PrimitiveType.RATIONAL))
				{
					childTypes=new ArrayList<Type>();
					childTypes.add(PrimitiveType.RATIONAL);
				}
			}
			
			
		}
		else if(node.nChildren()==2){//binary operator
			ParseNode left  = node.child(0);
			ParseNode right = node.child(1);
			childTypes = Arrays.asList(left.getType(), right.getType());
		}
		else{//unary operator
			ParseNode child=node.child(0);
			childTypes = Arrays.asList(child.getType());
		}
		Lextant operator = operatorFor(node);
		FunctionSignatures signatures = FunctionSignatures.signaturesOf(operator);
		FunctionSignature signature = signatures.acceptingSignature(childTypes);
		
//		if(signature.accepts(childTypes)) {
		if(!signature.isNull()){
			if(node.nChildren()==2&&!node.getToken().isLextant(Punctuator.OPEN_BRACKET)){
				if(node.child(0).getType()!=signature.getParamTypes()[0]&&!(node.child(0).getType() instanceof Array)){
					CastOperatorNode insertedNode=new CastOperatorNode(node.child(0).getToken());
					PrimitiveTypeNode type=new PrimitiveTypeNode(node.child(0).getToken());
					type.setType(signature.getParamTypes()[0]);
					
					insertedNode.appendChild(node.child(0));
					insertedNode.appendChild(type);
					insertedNode.setType(signature.getParamTypes()[0]);
					node.getChildren().remove(0);
					node.getChildren().add(0, insertedNode);
					insertedNode.setParent(node);
//					node.replaceChild(node.child(0), insertedNode);
				}
				if(node.child(1).getType()!=signature.getParamTypes()[1]&&!(node.child(1).getType() instanceof Array)){
					CastOperatorNode insertedNode=new CastOperatorNode(node.child(1).getToken());
					PrimitiveTypeNode type=new PrimitiveTypeNode(node.child(1).getToken());
					type.setType(signature.getParamTypes()[1]);
					
					insertedNode.appendChild(node.child(1));
					insertedNode.appendChild(type);
					insertedNode.setType(signature.getParamTypes()[1]);
					node.getChildren().remove(1);
					node.getChildren().add(1, insertedNode);
					insertedNode.setParent(node);
//					node.replaceChild(node.child(1), insertedNode);
				}
			}
			else if(node.nChildren()==1&&!node.getToken().isLextant(Punctuator.OPEN_BRACKET)){
				if(node.child(0).getType()!=signature.getParamTypes()[0]&&!(node.child(0).getType() instanceof Array)){
					CastOperatorNode insertedNode=new CastOperatorNode(node.child(0).getToken());
					PrimitiveTypeNode type=new PrimitiveTypeNode(node.child(0).getToken());
					type.setType(signature.getParamTypes()[0]);
					
					insertedNode.appendChild(node.child(0));
					insertedNode.appendChild(type);
					insertedNode.setType(signature.getParamTypes()[0]);
					
					node.getChildren().remove(0);
					node.getChildren().add(0, insertedNode);
					insertedNode.setParent(node);			
//					node.replaceChild(node.child(0), insertedNode);
				}
			}
			else {
				for(int i=0;i<node.nChildren();i++){
					if(node.getChildren().get(i).getType()!=childTypes.get(0)&&!(node.getChildren().get(i).getType() instanceof Array)){
						ParseNode child=node.getChildren().get(i);
						CastOperatorNode insertedNode=new CastOperatorNode(child.getToken());
						PrimitiveTypeNode type=new PrimitiveTypeNode(child.getToken());
						type.setType(childTypes.get(0));
						
						insertedNode.appendChild(node.child(i));
						insertedNode.appendChild(type);
						insertedNode.setType(childTypes.get(0));
						node.getChildren().remove(i);
						node.getChildren().add(i, insertedNode);
						insertedNode.setParent(node);
					}
				}
			}
			node.setType(signature.resultType());
			node.setSignature(signature);
		}
		else {
			typeCheckError(node, childTypes);
			node.setType(PrimitiveType.ERROR);
		}
	}
	private Lextant operatorFor(OperatorNode node) {
		LextantToken token = (LextantToken) node.getToken();
		return token.getLextant();
	}
	///////////////////////////////////////////////////////////////////////////
	// expressions
	///////////////////////////////////////////////////////////////////////////
	// cast expression
	@Override
	public void visitLeave(CastOperatorNode node){
		assert node.nChildren() == 2;
		ParseNode expression  = node.child(0);
		ParseNode type = node.child(1);
		List<Type> childTypes = Arrays.asList(expression.getType(), type.getType());
		
		Lextant operator = operatorFor(node);
		FunctionSignatures signatures = FunctionSignatures.signaturesOf(operator);
		FunctionSignature signature = signatures.acceptingSignatureStrict(childTypes);
		
//		if(signature.accepts(childTypes)) 
		if(!signature.isNull())
		{
			expression.setType(signature.getParamTypes()[0]);
			type.setType(signature.getParamTypes()[1]);
			
			node.setType(signature.resultType());
			node.setSignature(signature);
		}
		else {
			typeCheckError(node, childTypes);
			node.setType(PrimitiveType.ERROR);
		}
	}
	private Lextant operatorFor(CastOperatorNode node) {
		LextantToken token = (LextantToken) node.getToken();
		return token.getLextant();
	}
	
	///////////////////////////////////////////////////////////////////////////
	// simple leaf nodes
	@Override
	public void visit(BooleanConstantNode node) {
		node.setType(PrimitiveType.BOOLEAN);
	}
	@Override
	public void visit(ErrorNode node) {
		node.setType(PrimitiveType.ERROR);
	}
	@Override
	public void visit(IntegerConstantNode node) {
		node.setType(PrimitiveType.INTEGER);
	}
	@Override
	public void visit(FloatingConstantNode node) {
		node.setType(PrimitiveType.FLOATING);
	}
	@Override
	public void visit(CharacterConstantNode node) {
		node.setType(PrimitiveType.CHARACTER);
	}
	@Override
	public void visit(StringConstantNode node) {
		node.setType(PrimitiveType.STRING);
	}
	
	public void visit(PrimitiveTypeNode node){
		Token token=node.getToken();
		if(token.isLextant(Keyword.BOOL))
			node.setType(PrimitiveType.BOOLEAN);
		if(token.isLextant(Keyword.INT))
			node.setType(PrimitiveType.INTEGER);
		if(token.isLextant(Keyword.FLOAT))
			node.setType(PrimitiveType.FLOATING);
		if(token.isLextant(Keyword.CHAR))
			node.setType(PrimitiveType.CHARACTER);
		if(token.isLextant(Keyword.STRING))
			node.setType(PrimitiveType.STRING);
		if(token.isLextant(Keyword.RAT))
			node.setType(PrimitiveType.RATIONAL);
	}
	
	@Override
	public void visit(NewlineNode node) {
	}
	@Override
	public void visit(SpaceNode node) {
	}
	public void visit(TabNode node) {
	}
	///////////////////////////////////////////////////////////////////////////
	// IdentifierNodes, with helper methods
	@Override
	public void visit(IdentifierNode node) {
		if(!isBeingDeclared(node)) {		
			Binding binding = node.findVariableBinding();
			
			node.setType(binding.getType());
			node.setBinding(binding);
		}
		// else parent DeclarationNode does the processing.
	}
	private boolean isBeingDeclared(IdentifierNode node) {
		ParseNode parent = node.getParent();
		return (parent instanceof DeclarationNode) && (node == parent.child(0));
	}
	private void addBinding(IdentifierNode identifierNode, Type type, boolean mutable) {
		Scope scope = identifierNode.getLocalScope();
		Binding binding = scope.createBinding(identifierNode, type, mutable);
		identifierNode.setBinding(binding);
	}
	
	///////////////////////////////////////////////////////////////////////////
	// error logging/printing

	private void typeCheckError(ParseNode node, List<Type> operandTypes) {
		Token token = node.getToken();
		
		logError("operator " + token.getLexeme() + " not defined for types " 
				 + operandTypes  + " at " + token.getLocation());	
	}
	private void ImmutableError(ParseNode node) {
		Token token = node.getToken();
		
		logError("identifier " + token.getLexeme() + " is defined as const(immutable) at " + token.getLocation());	
	}
	private void logError(String message) {
		PikaLogger log = PikaLogger.getLogger("compiler.semanticAnalyzer");
		log.severe(message);
	}
}
package semanticAnalyzer;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import asmCodeGenerator.Labeller;
import lexicalAnalyzer.Keyword;
import lexicalAnalyzer.Lextant;
import lexicalAnalyzer.Punctuator;
import logging.PikaLogger;
import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import parseTree.nodeTypes.ArrayTypeNode;
import parseTree.nodeTypes.AssignStatementNode;
import parseTree.nodeTypes.OperatorNode;
import parseTree.nodeTypes.ParamSpecificationNode;
import parseTree.nodeTypes.BooleanConstantNode;
import parseTree.nodeTypes.BreakNode;
import parseTree.nodeTypes.CastOperatorNode;
import parseTree.nodeTypes.CharacterConstantNode;
import parseTree.nodeTypes.ContinueNode;
import parseTree.nodeTypes.BlockStatementNode;
import parseTree.nodeTypes.DeclarationNode;
import parseTree.nodeTypes.ErrorNode;
import parseTree.nodeTypes.IdentifierNode;
import parseTree.nodeTypes.IfStatementNode;
import parseTree.nodeTypes.IntegerConstantNode;
import parseTree.nodeTypes.LambdaParamTypeNode;
import parseTree.nodeTypes.LambdaTypeNode;
import parseTree.nodeTypes.FloatingConstantNode;
import parseTree.nodeTypes.ForElemStatementNode;
import parseTree.nodeTypes.ForIndexStatementNode;
import parseTree.nodeTypes.FunctionBodyNode;
import parseTree.nodeTypes.FunctionDefinitionNode;
import parseTree.nodeTypes.NewlineNode;
import parseTree.nodeTypes.PrintStatementNode;
import parseTree.nodeTypes.ProgramNode;
import parseTree.nodeTypes.ReleaseStatementNode;
import parseTree.nodeTypes.ReturnStatementNode;
import parseTree.nodeTypes.SpaceNode;
import parseTree.nodeTypes.StringConstantNode;
import parseTree.nodeTypes.TabNode;
import parseTree.nodeTypes.VoidTypeNode;
import parseTree.nodeTypes.WhileStatementNode;
import parseTree.nodeTypes.PrimitiveTypeNode;
import semanticAnalyzer.signatures.FunctionSignature;
import semanticAnalyzer.signatures.FunctionSignatures;
import semanticAnalyzer.types.Array;
import semanticAnalyzer.types.LambdaType;
import semanticAnalyzer.types.PrimitiveType;
import semanticAnalyzer.types.Type;
import semanticAnalyzer.types.VoidType;
import symbolTable.Binding;
import symbolTable.Scope;
import symbolTable.SymbolTable;
import tokens.LextantToken;
import tokens.Token;

public class SemanticAnalysisVisitor extends ParseNodeVisitor.Default {
	
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
		
		if(node.getParent() instanceof ForIndexStatementNode){
			IdentifierNode identifier = (IdentifierNode) node.getParent().child(0);
			identifier.setType(PrimitiveType.INTEGER);
			Scope scope = node.getScope();
			
			Binding binding = scope.createBinding(identifier, PrimitiveType.INTEGER, false);
			identifier.setBinding(binding);
		}
		else if(node.getParent() instanceof ForElemStatementNode){
			if(node.getParent().child(1).getType()==PrimitiveType.STRING){
				IdentifierNode identifier = (IdentifierNode) node.getParent().child(0);
				identifier.setType(PrimitiveType.CHARACTER);
				Scope scope = node.getScope();
				Binding binding = scope.createBinding(identifier, PrimitiveType.CHARACTER, false);
				identifier.setBinding(binding);
			}
			else if(node.getParent().child(1).getType() instanceof Array){
				Array type=(Array)node.getParent().child(1).getType();
				IdentifierNode identifier = (IdentifierNode) node.getParent().child(0);
				identifier.setType(type.getSubtype());
				Scope scope = node.getScope();
				Binding binding = scope.createBinding(identifier, type.getSubtype(), false);
				identifier.setBinding(binding);
			}
		}
	}
	public void visitLeave(BlockStatementNode node) {
		leaveScope(node);
	}
	public void visitEnter(FunctionBodyNode node){
		enterProcedureScope(node);
	}
	public void visitLeave(FunctionBodyNode node){
		leaveScope(node);
	}
	public void visitEnter(LambdaParamTypeNode node){
		enterParameterScope(node);
	}
	
	///////////////////////////////////////////////////////////////////////////
	// helper methods for scoping.
	private void enterProgramScope(ParseNode node) {
		node.getScope().enter();
	}	

	private void enterSubscope(ParseNode node) {
		Scope baseScope = node.getLocalScope();
		Scope scope = baseScope.createSubscope();
		node.setScope(scope);
		node.getScope().enter();
	}		
	private void leaveScope(ParseNode node) {
		node.getScope().leave();
	}
	
	private void enterParameterScope(ParseNode node){
		Scope scope=Scope.createParameterScope();
		node.setScope(scope);
		node.getScope().enter();
	}
	
	private void enterProcedureScope(ParseNode node){
//		SymbolTable oldSymbolTable=node.getParent().child(0).getScope().getSymbolTable();
//		int ParamSize=node.getLocalScope().getAllocatedSize();
		Scope scope = Scope.createProcedureScope();
		node.setScope(scope);
		node.getScope().enter();
	}
	
	///////////////////////////////////////////////////////////////////////////
	// statements and declarations
	@Override
	public void visitLeave(PrintStatementNode node) {
		for(ParseNode child:node.getChildren()){
			if(child.getType() instanceof VoidType){
				typeCheckError(node, Arrays.asList(child.getType()));
				node.setType(PrimitiveType.ERROR);
			}
		}
	}
	@Override
	public void visitLeave(DeclarationNode node) {
		if(node.getParent() instanceof ProgramNode)
			return;
		IdentifierNode identifier = (IdentifierNode) node.child(0);
		ParseNode initializer = node.child(1);
		
		Type declarationType = initializer.getType().getConcreteType();
		if(declarationType instanceof VoidType){
			typeCheckError(node, Arrays.asList(declarationType));
			node.setType(PrimitiveType.ERROR);
			return;
		}
		
		node.setType(declarationType);
		
		identifier.setType(declarationType);
		
		if(node.getType() instanceof LambdaType){
			Labeller labeller = new Labeller("function-definition");
			String funcStartLabel = labeller.newLabel(identifier.getToken().getLexeme()+"-start");
			if(node.getToken().isLextant(Keyword.CONST))
				addFuncBinding(identifier, declarationType, false, funcStartLabel);
			else if(node.getToken().isLextant(Keyword.VAR))
				addFuncBinding(identifier, declarationType, true, funcStartLabel);
			
			return;
		}
		
		if(node.getToken().isLextant(Keyword.CONST)){
				addBinding(identifier, declarationType, false);
		}
		else if(node.getToken().isLextant(Keyword.VAR))
			addBinding(identifier, declarationType, true);
		
	}
	
	///////////////////////////////////////////////////////////////////////////
	// ArrayTypeNode
	@Override
	public void visitLeave(ArrayTypeNode node){
		node.setType(new Array(node.child(0).getType().getConcreteType()));
		
	}
	
	///////////////////////////////////////////////////////////////////////////
	// For index
	public void visitLeave(ForIndexStatementNode node){
		if(!(node.child(1).getType() instanceof Array) && node.child(1).getType()!=PrimitiveType.STRING){
			typeCheckError(node.child(1),Arrays.asList(node.child(1).getType()));
			node.setType(PrimitiveType.ERROR);
			return;
		}
		
	}
	
	///////////////////////////////////////////////////////////////////////////
	// For elem
	public void visitLeave(ForElemStatementNode node){
		if(!(node.child(1).getType() instanceof Array) && node.child(1).getType()!=PrimitiveType.STRING){
			typeCheckError(node.child(1),Arrays.asList(node.child(1).getType()));
			node.setType(PrimitiveType.ERROR);
			return;
		}
		
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
		else if(node.child(0).getToken().isLextant(Punctuator.ARRAY_INDEXING)&&node.child(0).child(0).getType()==PrimitiveType.STRING){
			typeCheckError(node.child(0),Arrays.asList(node.child(0).child(0).getType()));
			node.setType(PrimitiveType.ERROR);
			return;
		}
		else//array indexing no need to do var/const check
			;
		
		ParseNode left = node.child(0);
		ParseNode right = node.child(1);		
		
		if(right.getType() instanceof VoidType){
			typeCheckError(right,Arrays.asList(right.getType()));
			node.setType(PrimitiveType.ERROR);
			return;
		}
		// at least one of them is lambdaType
		if(left.getType() instanceof LambdaType && right.getType() instanceof LambdaType){

			FunctionSignature leftSignature=((LambdaType)left.getType()).getFunctionSignature();
			FunctionSignature rightSignature=((LambdaType)right.getType()).getFunctionSignature();
			Type[] type1=leftSignature.getParamTypes();
			Type[] type2=rightSignature.getParamTypes();
			boolean isSame=true;
			if(type1.length==type2.length){
				for(int i=0;i<type1.length;i++){
					if(!type1[i].equivalent(type2[i])){
						isSame=false;
						break;
					}
				}
				if(!leftSignature.resultType().equivalent(rightSignature.resultType()))
					isSame=false;
			}
			if(isSame==true){
				node.setType(left.getType());
				node.setSignature(leftSignature);
			}
			else{
				typeCheckError(node, Arrays.asList(left.getType().getConcreteType(),right.getType().getConcreteType()));
				node.setType(PrimitiveType.ERROR);
			}
			return;
		}
		else if(left.getType() instanceof LambdaType || right.getType() instanceof LambdaType){
			typeCheckError(node, Arrays.asList(left.getType().getConcreteType(),right.getType().getConcreteType()));
			node.setType(PrimitiveType.ERROR);
			return;
		}
			
		//neither of them is lambdaType
		List<Type> childTypes = Arrays.asList(right.getType().getConcreteType(),left.getType().getConcreteType());
		
		Lextant operator = operatorFor(node);
		FunctionSignatures signatures = FunctionSignatures.signaturesOf(operator);
		FunctionSignature signature = signatures.acceptingSignature(childTypes);
		
//		if(signature.accepts(childTypes)) 
		if(!signature.isNull()){
			if(left.getType().getConcreteType()!=signature.getParamTypes()[1].getConcreteType()&&!(left.getType().getConcreteType() instanceof Array)){
				LextantToken token=LextantToken.make(left.getToken().getLocation(), left.getToken().getLexeme(), Punctuator.BAR);
				CastOperatorNode insertedNode=new CastOperatorNode(token);
				PrimitiveTypeNode type=new PrimitiveTypeNode(left.getToken());
				type.setType(signature.getParamTypes()[1].getConcreteType());
					
				insertedNode.appendChild(left);
				insertedNode.appendChild(type);
				insertedNode.setType(signature.getParamTypes()[1].getConcreteType());
				
				node.getChildren().remove(0);
				node.getChildren().add(0, insertedNode);
				insertedNode.setParent(node);
				visitLeave(insertedNode);
//				node.replaceChild(node.child(0), insertedNode);
			}
			
			if(right.getType().getConcreteType()!=signature.getParamTypes()[0].getConcreteType()&&!(right.getType().getConcreteType() instanceof Array)){
				LextantToken token=LextantToken.make(right.getToken().getLocation(), right.getToken().getLexeme(), Punctuator.BAR);
				CastOperatorNode insertedNode=new CastOperatorNode(token);
				
				PrimitiveTypeNode type=new PrimitiveTypeNode(right.getToken());
				type.setType(signature.getParamTypes()[0].getConcreteType());
					
				insertedNode.appendChild(right);
				insertedNode.appendChild(type);
				insertedNode.setType(signature.getParamTypes()[0].getConcreteType());
				
				node.getChildren().remove(1);
				node.getChildren().add(1, insertedNode);
				insertedNode.setParent(node);
				visitLeave(insertedNode);
//				node.replaceChild(node.child(1), insertedNode);
			}
			node.setType(signature.resultType().getConcreteType());
			node.setSignature(signature);
		}
		else {
			typeCheckError(node, Arrays.asList(left.getType().getConcreteType(),right.getType().getConcreteType()));
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
		if(condition.getType().getConcreteType()!=PrimitiveType.BOOLEAN){
			typeCheckError(node, Arrays.asList(condition.getType().getConcreteType()));
			node.setType(PrimitiveType.ERROR);
		}
	}
	
	///////////////////////////////////////////////////////////////////////////
	// If 
	@Override
	public void visitLeave(IfStatementNode node){
		assert node.nChildren()==2||node.nChildren()==3;
		ParseNode condition=node.child(0);
		if(condition.getType().getConcreteType()!=PrimitiveType.BOOLEAN){
			typeCheckError(node, Arrays.asList(condition.getType().getConcreteType()));
			node.setType(PrimitiveType.ERROR);
		}
	}
	///////////////////////////////////////////////////////////////////////////
	// Release
	@Override
	public void visitLeave(ReleaseStatementNode node){
		assert node.nChildren()==1;
		
		if((node.child(0).getType().getConcreteType()!=PrimitiveType.STRING) && !((node.child(0).getType().getConcreteType() instanceof Array ))){
			typeCheckError(node, Arrays.asList(node.child(0).getType().getConcreteType()));
			node.setType(PrimitiveType.ERROR);
		}
	}

	///////////////////////////////////////////////////////////////////////////
	// Return 
	public void visitLeave(ReturnStatementNode node){
		Type returnType;
		if(node.nChildren()==1){
			returnType=node.getChildren().get(0).getType();
			if(returnType instanceof VoidType){
				typeCheckError(node, Arrays.asList(returnType));
				node.setType(PrimitiveType.ERROR);
				return;
			}
		}
		else
			returnType=new VoidType();
		
		for(ParseNode current : node.pathToRoot()) {
			if(current instanceof OperatorNode && current.getToken().isLextant(Punctuator.LAMBDA)) {
				FunctionSignature signature=((LambdaType)current.getType()).getFunctionSignature();
				if(returnType.equivalent(signature.resultType())){
					node.setType(returnType);
					return;
				}
				break;
			}
		}
		typeCheckError(node, Arrays.asList(returnType));
		node.setType(PrimitiveType.ERROR);
	}
	///////////////////////////////////////////////////////////////////////////
	// expressions
	public void visitLeave(ParamSpecificationNode node){
		addBinding((IdentifierNode)node.child(1),node.child(0).getType(),false);
		node.setType(node.child(0).getType());
		node.child(1).setType(node.child(0).getType());
	}
	
	///////////////////////////////////////////////////////////////////////////
	// functionDefinition
	public void visitLeave(FunctionDefinitionNode node){
		IdentifierNode identifier = (IdentifierNode) node.child(0);
		ParseNode initializer = node.child(1);
		
		Type declarationType = initializer.getType().getConcreteType();
		node.setType(declarationType);
		
		identifier.setType(declarationType);
//		addBinding(identifier, declarationType, false);
//		node.getScope().leave();
	}
	public void visitLeave(LambdaParamTypeNode node){
		int numOfParameter=node.nChildren();
		Type[] parameterList=new Type[numOfParameter];
		for(int i=0;i<numOfParameter;i++){
			parameterList[i]=node.child(i).getType();
		}
		FunctionSignature signature=new FunctionSignature(1,parameterList);
		node.setType(new LambdaType(signature));
		node.getScope().leave();
	}
	public void visitLeave(LambdaTypeNode node){
		int numOfParameter=node.nChildren();
		Type[] parameterList=new Type[numOfParameter];
		for(int i=0;i<numOfParameter;i++){
			parameterList[i]=node.child(i).getType();
		}
		FunctionSignature signature=new FunctionSignature(1,parameterList);
		node.setType(new LambdaType(signature));
	}
	///////////////////////////////////////////////////////////////////////////
	// expressions
	@Override
	public void visitLeave(OperatorNode node) {
		assert (node.nChildren()>=1);
		List<Type> childTypes=new ArrayList<Type>();
		
		//Lambda
		if(node.getToken().isLextant(Punctuator.LAMBDA)){
			node.setType(node.child(0).getType());
//			node.getScope().leave();
			return;
		}
		//FunctionInvocation
		if(node.getToken().isLextant(Punctuator.OPEN_PARENTHESE)){
			ParseNode func=node.child(0);
			
			if(!(func.getType() instanceof LambdaType)){
				typeCheckError(node,Arrays.asList(func.getType()));
				node.setType(PrimitiveType.ERROR);
				return;
			}
			FunctionSignature signature=((LambdaType)func.getType()).getFunctionSignature();
			List<Type> expressionList=new ArrayList<Type>();
			for(int i=0;i<node.child(1).nChildren();i++){
				expressionList.add(node.child(1).child(i).getType());
			}

			if(signature.acceptsStrict(expressionList)){
				node.setType(signature.resultType());
			}
			else{
				typeCheckError(node, expressionList);
				node.setType(PrimitiveType.ERROR);
			}
			return;
		}
		
		
		if(node.getToken().isLextant(Punctuator.OPEN_BRACKET)){//populate array creation type check promotion
			boolean convertable;
			List<Type> finalTypes=new ArrayList<Type>();
			for(ParseNode child1:node.getChildren()){
				if(child1.getType() instanceof VoidType){
					typeCheckError(node, Arrays.asList(child1.getType()));
					node.setType(PrimitiveType.ERROR);
					return;
				}
				convertable=true;
				
				for(ParseNode child2:node.getChildren()){
					if(!FunctionSignature.canConvert(child2.getType().getConcreteType(),child1.getType().getConcreteType())){
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
			childTypes = Arrays.asList(left.getType().getConcreteType(), right.getType().getConcreteType());
			if(node.getToken().isLextant(Keyword.MAP)){
				if(right.getType().getConcreteType() instanceof LambdaType){
					LambdaType type=(LambdaType) right.getType().getConcreteType();
					if(type.getFunctionSignature().resultType() instanceof VoidType){
						typeCheckError(node, Arrays.asList(type));
						node.setType(PrimitiveType.ERROR);
						return;
					}
//					if(type.getFunctionSignature().resultType() instanceof Array){
//						Array a=(Array)(type.getFunctionSignature().resultType());
//						System.out.println(a.getSubtype());
//					}	
				}
				else{
					typeCheckError(node, childTypes);
					node.setType(PrimitiveType.ERROR);
					return;
				}
			}
		}
		else if(node.nChildren()==3){
			ParseNode first  = node.child(0);
			
			ParseNode second = node.child(1);
			ParseNode third = node.child(2);
			childTypes = Arrays.asList(first.getType().getConcreteType(), second.getType().getConcreteType(),third.getType().getConcreteType());
			
			if(node.getToken().isLextant(Keyword.ZIP)){
				if(third.getType().getConcreteType() instanceof LambdaType){
					LambdaType type=(LambdaType) third.getType().getConcreteType();
					if(type.getFunctionSignature().resultType() instanceof VoidType){
						typeCheckError(node, Arrays.asList(type));
						node.setType(PrimitiveType.ERROR);
						return;
					}
				}
				else{
					typeCheckError(node, childTypes);
					node.setType(PrimitiveType.ERROR);
					return;
				}
			}
		}
		else{//unary operator
			ParseNode child=node.child(0);
			childTypes = Arrays.asList(child.getType().getConcreteType());
		}
		Lextant operator = operatorFor(node);
		
		if(operator==Punctuator.EQUAL||operator==Punctuator.NOT_EQUAL){
			if(node.child(0).getType() instanceof LambdaType&& node.child(1).getType() instanceof LambdaType){
				node.setType(PrimitiveType.BOOLEAN);
				return; 
			}
			else if(node.child(0).getType() instanceof LambdaType || node.child(1).getType() instanceof LambdaType){
				typeCheckError(node, childTypes);
				node.setType(PrimitiveType.ERROR);
				return;
			}
		}
		
		FunctionSignatures signatures = FunctionSignatures.signaturesOf(operator);
		FunctionSignature signature = signatures.acceptingSignature(childTypes);

//		if(signature.accepts(childTypes)) {
		if(!signature.isNull()){
			if(node.nChildren()==3&&!node.getToken().isLextant(Punctuator.OPEN_BRACKET)){
				if(node.child(0).getType().getConcreteType()!=signature.getParamTypes()[0].getConcreteType()&&!(node.child(0).getType().getConcreteType() instanceof Array)&&!(node.child(0).getType() instanceof LambdaType)){
					LextantToken token=LextantToken.make(node.child(0).getToken().getLocation(), node.child(0).getToken().getLexeme(), Punctuator.BAR);
					CastOperatorNode insertedNode=new CastOperatorNode(token);
					
					PrimitiveTypeNode type=new PrimitiveTypeNode(node.child(0).getToken());
					type.setType(signature.getParamTypes()[0].getConcreteType());
					
					insertedNode.appendChild(node.child(0));
					insertedNode.appendChild(type);
					insertedNode.setType(signature.getParamTypes()[0].getConcreteType());
					node.getChildren().remove(0);
					node.getChildren().add(0, insertedNode);
					insertedNode.setParent(node);
					visitLeave(insertedNode);
//					node.replaceChild(node.child(0), insertedNode);
				}
				if(node.child(1).getType().getConcreteType()!=signature.getParamTypes()[1].getConcreteType()&&!(node.child(1).getType().getConcreteType() instanceof Array)&&!(node.child(1).getType() instanceof LambdaType)){
					LextantToken token=LextantToken.make(node.child(1).getToken().getLocation(), node.child(1).getToken().getLexeme(), Punctuator.BAR);
					CastOperatorNode insertedNode=new CastOperatorNode(token);
					
					PrimitiveTypeNode type=new PrimitiveTypeNode(node.child(1).getToken());
					type.setType(signature.getParamTypes()[1].getConcreteType());
					
					insertedNode.appendChild(node.child(1));
					insertedNode.appendChild(type);
					insertedNode.setType(signature.getParamTypes()[1].getConcreteType());
					node.getChildren().remove(1);
					node.getChildren().add(1, insertedNode);
					insertedNode.setParent(node);
					visitLeave(insertedNode);
				}
				if(node.child(2).getType().getConcreteType()!=signature.getParamTypes()[2].getConcreteType()&&!(node.child(2).getType().getConcreteType() instanceof Array)&&!(node.child(2).getType() instanceof LambdaType)){
					LextantToken token=LextantToken.make(node.child(2).getToken().getLocation(), node.child(1).getToken().getLexeme(), Punctuator.BAR);
					CastOperatorNode insertedNode=new CastOperatorNode(token);
					
					PrimitiveTypeNode type=new PrimitiveTypeNode(node.child(1).getToken());
					type.setType(signature.getParamTypes()[2].getConcreteType());
					
					insertedNode.appendChild(node.child(2));
					insertedNode.appendChild(type);
					insertedNode.setType(signature.getParamTypes()[2].getConcreteType());
					node.getChildren().remove(2);
					node.getChildren().add(2, insertedNode);
					insertedNode.setParent(node);
					visitLeave(insertedNode);
				}
			}
			else if(node.nChildren()==2&&!node.getToken().isLextant(Punctuator.OPEN_BRACKET)){
				if(node.child(0).getType().getConcreteType()!=signature.getParamTypes()[0].getConcreteType()&&!(node.child(0).getType().getConcreteType() instanceof Array)&&!(node.child(0).getType() instanceof LambdaType)){
					LextantToken token=LextantToken.make(node.child(0).getToken().getLocation(), node.child(0).getToken().getLexeme(), Punctuator.BAR);
					CastOperatorNode insertedNode=new CastOperatorNode(token);
					
					PrimitiveTypeNode type=new PrimitiveTypeNode(node.child(0).getToken());
					type.setType(signature.getParamTypes()[0].getConcreteType());
					
					insertedNode.appendChild(node.child(0));
					insertedNode.appendChild(type);
					insertedNode.setType(signature.getParamTypes()[0].getConcreteType());
					node.getChildren().remove(0);
					node.getChildren().add(0, insertedNode);
					insertedNode.setParent(node);
					visitLeave(insertedNode);
//					node.replaceChild(node.child(0), insertedNode);
				}
				if(node.child(1).getType().getConcreteType()!=signature.getParamTypes()[1].getConcreteType()&&!(node.child(1).getType().getConcreteType() instanceof Array)&&!(node.child(1).getType() instanceof LambdaType)){
					LextantToken token=LextantToken.make(node.child(1).getToken().getLocation(), node.child(1).getToken().getLexeme(), Punctuator.BAR);
					CastOperatorNode insertedNode=new CastOperatorNode(token);
					
					PrimitiveTypeNode type=new PrimitiveTypeNode(node.child(1).getToken());
					type.setType(signature.getParamTypes()[1].getConcreteType());
					
					insertedNode.appendChild(node.child(1));
					insertedNode.appendChild(type);
					insertedNode.setType(signature.getParamTypes()[1].getConcreteType());
					node.getChildren().remove(1);
					node.getChildren().add(1, insertedNode);
					insertedNode.setParent(node);
					visitLeave(insertedNode);
//					node.replaceChild(node.child(1), insertedNode);
				}
			}
			else if(node.nChildren()==1&&!node.getToken().isLextant(Punctuator.OPEN_BRACKET)){
				if(node.child(0).getType().getConcreteType()!=signature.getParamTypes()[0].getConcreteType()&&!(node.child(0).getType().getConcreteType() instanceof Array)&&!(node.child(0).getType() instanceof LambdaType)){
					LextantToken token=LextantToken.make(node.child(0).getToken().getLocation(), node.child(0).getToken().getLexeme(), Punctuator.BAR);
					CastOperatorNode insertedNode=new CastOperatorNode(token);
					
					PrimitiveTypeNode type=new PrimitiveTypeNode(node.child(0).getToken());
					type.setType(signature.getParamTypes()[0].getConcreteType());
					
					insertedNode.appendChild(node.child(0));
					insertedNode.appendChild(type);
					insertedNode.setType(signature.getParamTypes()[0].getConcreteType());
					
					node.getChildren().remove(0);
					node.getChildren().add(0, insertedNode);
					insertedNode.setParent(node);	
					visitLeave(insertedNode);
//					node.replaceChild(node.child(0), insertedNode);
				}
			}
			else {
				for(int i=0;i<node.nChildren();i++){
					if(node.getChildren().get(i).getType().getConcreteType()!=childTypes.get(0).getConcreteType()&&!(node.getChildren().get(i).getType().getConcreteType() instanceof Array)&&!(node.child(i).getType() instanceof LambdaType)){
						ParseNode child=node.getChildren().get(i);
						LextantToken token=LextantToken.make(child.getToken().getLocation(), child.getToken().getLexeme(), Punctuator.BAR);
						CastOperatorNode insertedNode=new CastOperatorNode(token);
						
						PrimitiveTypeNode type=new PrimitiveTypeNode(child.getToken());
						type.setType(childTypes.get(0).getConcreteType());
						
						insertedNode.appendChild(node.child(i));
						insertedNode.appendChild(type);
						insertedNode.setType(childTypes.get(0).getConcreteType());
						
						node.getChildren().remove(i);
						node.getChildren().add(i, insertedNode);
						insertedNode.setParent(node);
						visitLeave(insertedNode);
					}
				}
			}
			node.setType(signature.resultType().getConcreteType());
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
		List<Type> childTypes = Arrays.asList(expression.getType().getConcreteType(), type.getType().getConcreteType());
		
		Lextant operator = operatorFor(node);
		FunctionSignatures signatures = FunctionSignatures.signaturesOf(operator);
		FunctionSignature signature = signatures.acceptingSignatureStrict(childTypes);
		
//		if(signature.accepts(childTypes)) 
		if(!signature.isNull())
		{
			expression.setType(signature.getParamTypes()[0].getConcreteType());
			type.setType(signature.getParamTypes()[1].getConcreteType());
			
			node.setType(signature.resultType().getConcreteType());
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
	
	///////////////////////////////////////////////////////////////////////////
	// VoidTypeNode
	public void visit(VoidTypeNode node){
		if(node.getParent() instanceof LambdaParamTypeNode||node.getParent() instanceof LambdaTypeNode){
			int numOfParentChild=node.getParent().nChildren();
			if(node.getParent().child(numOfParentChild-1).equals(node))
				node.setType(new VoidType());
			else{
				typeCheckError(node, Arrays.asList(new VoidType()));
				node.setType(PrimitiveType.ERROR);
			}
		}
		else{
			typeCheckError(node, Arrays.asList(new VoidType()));
			node.setType(PrimitiveType.ERROR);
		}
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
	// Break
	public void visit(BreakNode node){
		for(ParseNode current : node.pathToRoot()){
			if(current instanceof WhileStatementNode||current instanceof ForIndexStatementNode||current instanceof ForElemStatementNode){
				node.setType(PrimitiveType.NO_TYPE);
				return;
			}	
		}
		typeCheckError(node, Arrays.asList());
		node.setType(PrimitiveType.ERROR);
	}
	///////////////////////////////////////////////////////////////////////////
	// Continue
	public void visit(ContinueNode node){
		for(ParseNode current : node.pathToRoot()){
			if(current instanceof WhileStatementNode||current instanceof ForIndexStatementNode||current instanceof ForElemStatementNode){
				node.setType(PrimitiveType.NO_TYPE);
				return;
			}
		}
		typeCheckError(node, Arrays.asList());
		node.setType(PrimitiveType.ERROR);
	}
	
	///////////////////////////////////////////////////////////////////////////
	// IdentifierNodes, with helper methods
//	@Override
	public void visit(IdentifierNode node) {
		if((node.getParent() instanceof ForIndexStatementNode||node.getParent() instanceof ForElemStatementNode)&&node==node.getParent().child(0))
			return;
		if(!isBeingDeclared(node)) {		
			Binding binding = node.findVariableBinding();
			
			node.setType(binding.getType().getConcreteType());
			node.setBinding(binding);
		}

		// else parent DeclarationNode does the processing.
	}
	public static boolean isBeingDeclared(IdentifierNode node) {
		ParseNode parent = node.getParent();
		return (parent instanceof DeclarationNode) && (node == parent.child(0))
				||parent instanceof ParamSpecificationNode;
	}
	public static void addBinding(IdentifierNode identifierNode, Type type, boolean mutable) {
		Scope scope = identifierNode.getLocalScope();
		Binding binding = scope.createBinding(identifierNode, type, mutable);
		identifierNode.setBinding(binding);
	}
	
	public static void addFuncBinding(IdentifierNode identifierNode, Type type, boolean mutable, String funcStartLabel) {
		Scope scope = identifierNode.getLocalScope();
		Binding binding = scope.createFuncBinding(identifierNode, type, mutable, funcStartLabel);
		identifierNode.setBinding(binding);
	}
	
	///////////////////////////////////////////////////////////////////////////
	// error logging/printing

	public static void typeCheckError(ParseNode node, List<Type> operandTypes) {
		Token token = node.getToken();
		
		logError("operator " + token.getLexeme() + " not defined for types " 
				 + operandTypes  + " at " + token.getLocation());	
	}
	private void ImmutableError(ParseNode node) {
		Token token = node.getToken();
		
		logError("identifier " + token.getLexeme() + " is defined as const(immutable) at " + token.getLocation());	
	}
	public static void logError(String message) {
		PikaLogger log = PikaLogger.getLogger("compiler.semanticAnalyzer");
		log.severe(message);
	}
}
package semanticAnalyzer;

import java.util.Arrays;
import java.util.List;

import asmCodeGenerator.Labeller;
import lexicalAnalyzer.Keyword;
import lexicalAnalyzer.Punctuator;
import logging.PikaLogger;
import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import parseTree.nodeTypes.ArrayTypeNode;
import parseTree.nodeTypes.ForIndexStatementNode;
import parseTree.nodeTypes.FunctionBodyNode;
import parseTree.nodeTypes.FunctionDefinitionNode;
import parseTree.nodeTypes.IdentifierNode;
import parseTree.nodeTypes.LambdaParamTypeNode;
import parseTree.nodeTypes.LambdaTypeNode;
import parseTree.nodeTypes.OperatorNode;
import parseTree.nodeTypes.ParamSpecificationNode;
import parseTree.nodeTypes.PrimitiveTypeNode;
import parseTree.nodeTypes.ProgramNode;
import parseTree.nodeTypes.VoidTypeNode;
import semanticAnalyzer.signatures.FunctionSignature;
import semanticAnalyzer.types.Array;
import semanticAnalyzer.types.LambdaType;
import semanticAnalyzer.types.PrimitiveType;
import semanticAnalyzer.types.Type;
import semanticAnalyzer.types.VoidType;
import symbolTable.Binding;
import symbolTable.Scope;
import tokens.Token;
import static semanticAnalyzer.SemanticAnalysisVisitor.addBinding;
import static semanticAnalyzer.SemanticAnalysisVisitor.addFuncBinding;
import static semanticAnalyzer.SemanticAnalysisVisitor.logError;
import static semanticAnalyzer.SemanticAnalysisVisitor.typeCheckError;

public class FirstSemanticAnalysisVisitor extends ParseNodeVisitor.Default{

	public FirstSemanticAnalysisVisitor() {
		// TODO Auto-generated constructor stub
	}
	@Override
	public void visitLeave(ParseNode node) {
		throw new RuntimeException("Node class unimplemented in SemanticAnalysisVisitor: " + node.getClass());
	}
	public void visitEnter(ProgramNode node){
		createProgramScope(node);
	}
	private void createProgramScope(ParseNode node){
		Scope scope = Scope.createProgramScope();
		node.setScope(scope);
	}
	///////////////////////////////////////////////////////////////////////////
	// functionDefinition
	public void visitLeave(FunctionDefinitionNode node){
		IdentifierNode identifier = (IdentifierNode) node.child(0);
		ParseNode initializer = node.child(1);
		
		Type declarationType = initializer.getType().getConcreteType();
		node.setType(declarationType);
		
		identifier.setType(declarationType);
		Labeller labeller = new Labeller("function-definition");
		String funcStartLabel = labeller.newLabel(identifier.getToken().getLexeme()+"-start");
//		System.out.println(funcStartLabel);
		addFuncBinding(identifier, declarationType, false, funcStartLabel);
	}
	public void visitLeave(LambdaParamTypeNode node){
		int numOfParameter=node.nChildren();
		Type[] parameterList=new Type[numOfParameter];
		for(int i=0;i<numOfParameter;i++){
			parameterList[i]=node.child(i).getType();
		}
		FunctionSignature signature=new FunctionSignature(1,parameterList);
		node.setType(new LambdaType(signature));

	}
	public void visitLeave(FunctionBodyNode node){
		
	}
	public void visitLeave(OperatorNode node){
		//Lambda
		if(node.getToken().isLextant(Punctuator.LAMBDA)){
			node.setType(node.child(0).getType());
			return;
		}		
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
	public void visitLeave(ParamSpecificationNode node){
		node.setType(node.child(0).getType());
	}
	///////////////////////////////////////////////////////////////////////////
	// VoidTypeNode
	public void visit(VoidTypeNode node){
		if(node.getParent() instanceof LambdaTypeNode||node.getParent() instanceof LambdaParamTypeNode){
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
	public void visitLeave(ArrayTypeNode node){
		node.setType(new Array(node.child(0).getType().getConcreteType()));
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
	
//	private void addFuncBinding(IdentifierNode identifierNode, Type type, boolean mutable, String funcStartLabel) {
//		Scope scope = identifierNode.getLocalScope();
//		Binding binding = scope.createFuncBinding(identifierNode, type, mutable, funcStartLabel,false);
//		identifierNode.setBinding(binding);
//	}
//	
//	private void typeCheckError(ParseNode node, List<Type> operandTypes) {
//		Token token = node.getToken();
//		
//		logError("operator " + token.getLexeme() + " not defined for types " 
//				 + operandTypes  + " at " + token.getLocation());	
//	}
//	private void logError(String message) {
//		PikaLogger log = PikaLogger.getLogger("compiler.semanticAnalyzer");
//		log.severe(message);
//	}
}

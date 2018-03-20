package parseTree.nodeTypes;

import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import logging.PikaLogger;
import symbolTable.Binding;
import symbolTable.Scope;
import tokens.IdentifierToken;
import tokens.Token;
import symbolTable.ProcedureMemoryAllocator;

public class IdentifierNode extends ParseNode {
	private Binding binding;
	private Scope declarationScope;
	
	public IdentifierNode(Token token) {
		super(token);
		assert(token instanceof IdentifierToken);
		this.binding = null;
	}
	public IdentifierNode(ParseNode node) {
		super(node);
		
		if(node instanceof IdentifierNode) {
			this.binding = ((IdentifierNode)node).binding;
		}
		else {
			this.binding = null;
		}
	}
	
////////////////////////////////////////////////////////////
// attributes
	
	public IdentifierToken identifierToken() {
		return (IdentifierToken)token;
	}

	public void setBinding(Binding binding) {
		this.binding = binding;
	}
	public Binding getBinding() {
		return binding;
	}
	
////////////////////////////////////////////////////////////
// Speciality functions

	public Binding findVariableBinding() {
		String identifier = token.getLexeme();
		boolean isLambda=false;
		for(ParseNode current : pathToRoot()) {
			if(isLambda==true){
//				System.out.println(identifier);
				if(current instanceof ProgramNode && current.containsBindingOf(identifier)){
					declarationScope = current.getScope();
					return current.bindingOf(identifier);
				}
			}
			else if(current.containsBindingOf(identifier)&&current instanceof FunctionBodyNode) {
				declarationScope = current.getScope();
				return current.bindingOf(identifier);
			}
			else if(current instanceof OperatorNode && current.child(0) instanceof LambdaParamTypeNode){
				if(!(current.getParent() instanceof FunctionDefinitionNode)){
					if(current.child(0).containsBindingOf(identifier)){
						declarationScope = current.child(0).getScope();
						return current.child(0).bindingOf(identifier);
					}
					else
						isLambda=true;
				}
				else if(current.child(0).containsBindingOf(identifier)){
					declarationScope = current.child(0).getScope();
					return current.child(0).bindingOf(identifier);
				}
			}
			else if(current.containsBindingOf(identifier)){
				declarationScope = current.getScope();
				return current.bindingOf(identifier);
			}
		}

		useBeforeDefineError();
		return Binding.nullInstance();
	}

	public Scope getDeclarationScope() {
		findVariableBinding();
		return declarationScope;
	}
	public void useBeforeDefineError() {
		PikaLogger log = PikaLogger.getLogger("compiler.semanticAnalyzer.identifierNode");
		Token token = getToken();
		log.severe("identifier " + token.getLexeme() + " used before defined at " + token.getLocation());
	}
	
///////////////////////////////////////////////////////////
// accept a visitor
		
	public void accept(ParseNodeVisitor visitor) {
		visitor.visit(this);
	}
}

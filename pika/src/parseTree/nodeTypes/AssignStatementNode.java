package parseTree.nodeTypes;

import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import semanticAnalyzer.signatures.FunctionSignature;
import tokens.Token;

public class AssignStatementNode extends ParseNode{
	private FunctionSignature signature = FunctionSignature.nullInstance();
	public AssignStatementNode(Token token) {
		super(token);
	}

	public AssignStatementNode(ParseNode node) {
		super(node);
	}
	
	public final FunctionSignature getSignature() {
		return signature;
	}
	public final void setSignature(FunctionSignature signature) {
		this.signature = signature;
	}
	
	////////////////////////////////////////////////////////////
	// convenience factory
	
	public static AssignStatementNode withChildren(Token token, ParseNode declaredName, ParseNode initializer) {
		AssignStatementNode node = new AssignStatementNode(token);//if no error, token should be :=
		node.appendChild(declaredName);
		node.appendChild(initializer);
		return node;
	}
	
	
	///////////////////////////////////////////////////////////
	// boilerplate for visitors
	
	public void accept(ParseNodeVisitor visitor) {
		visitor.visitEnter(this);
		visitChildren(visitor);
		visitor.visitLeave(this);
	}
}

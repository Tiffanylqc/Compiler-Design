package parseTree.nodeTypes;

import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import tokens.Token;

public class AssignStatementNode extends ParseNode{

	public AssignStatementNode(Token token) {
		super(token);
	}

	public AssignStatementNode(ParseNode node) {
		super(node);
	}
	////////////////////////////////////////////////////////////
	// convenience factory
	
	public static AssignStatementNode withChildren(Token token, ParseNode declaredName, ParseNode initializer) {
		AssignStatementNode node = new AssignStatementNode(token);
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

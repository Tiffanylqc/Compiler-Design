package parseTree.nodeTypes;

import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import tokens.Token;

public class ReleaseStatementNode extends ParseNode {

	public ReleaseStatementNode(Token token) {
		super(token);
		// TODO Auto-generated constructor stub
	}

	public ReleaseStatementNode(ParseNode node) {
		super(node);
		// TODO Auto-generated constructor stub
	}

	///////////////////////////////////////////////////////////
	// boilerplate for visitors
	public void accept(ParseNodeVisitor visitor) {
		visitor.visitEnter(this);
		visitChildren(visitor);
		visitor.visitLeave(this);
	}
}

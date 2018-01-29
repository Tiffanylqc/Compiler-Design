package parseTree.nodeTypes;

import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import tokens.Token;

public class NegateStatementNode extends ParseNode {

	public NegateStatementNode(Token token) {
		super(token);
		// TODO Auto-generated constructor stub
	}

	public NegateStatementNode(ParseNode node) {
		super(node);
		// TODO Auto-generated constructor stub
	}

	public void accept(ParseNodeVisitor visitor) {
		visitor.visitEnter(this);
		visitChildren(visitor);
		visitor.visitLeave(this);
	}
	
}

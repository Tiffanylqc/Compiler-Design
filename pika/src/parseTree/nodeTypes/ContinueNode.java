package parseTree.nodeTypes;

import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import tokens.Token;

public class ContinueNode extends ParseNode {

	public ContinueNode(Token token) {
		super(token);
		// TODO Auto-generated constructor stub
	}

	public ContinueNode(ParseNode node) {
		super(node);
		// TODO Auto-generated constructor stub
	}
	
	///////////////////////////////////////////////////////////
	// boilerplate for visitors
	public void accept(ParseNodeVisitor visitor) {
		visitor.visit(this);
	}
}

package parseTree.nodeTypes;

import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import tokens.Token;

public class NewArrayNode extends ParseNode {

	public NewArrayNode(Token token) {
		super(token);
		// TODO Auto-generated constructor stub
	}

	public NewArrayNode(ParseNode node) {
		super(node);
		// TODO Auto-generated constructor stub
	}
	
	
	public void accept(ParseNodeVisitor visitor) {
		visitor.visitEnter(this);
		visitChildren(visitor);
		visitor.visitLeave(this);
	}
}

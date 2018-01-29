package parseTree.nodeTypes;

import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import tokens.Token;

public class PopulateArrayNode extends ParseNode {

	public PopulateArrayNode(Token token) {
		super(token);
		// TODO Auto-generated constructor stub
	}

	public PopulateArrayNode(ParseNode node) {
		super(node);
		// TODO Auto-generated constructor stub
	}
	
	
	public void accept(ParseNodeVisitor visitor) {
		visitor.visitEnter(this);
		visitChildren(visitor);
		visitor.visitLeave(this);
	}
}

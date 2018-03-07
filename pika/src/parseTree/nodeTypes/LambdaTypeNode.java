package parseTree.nodeTypes;

import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import tokens.Token;

public class LambdaTypeNode extends ParseNode {

	public LambdaTypeNode(Token token) {
		super(token);
		// TODO Auto-generated constructor stub
	}

	public LambdaTypeNode(ParseNode node) {
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

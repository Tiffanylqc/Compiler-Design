package parseTree.nodeTypes;

import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import tokens.Token;

public class ParamSpecificationNode extends ParseNode {

	public ParamSpecificationNode(Token token) {
		super(token);
		// TODO Auto-generated constructor stub
	}

	public ParamSpecificationNode(ParseNode node) {
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

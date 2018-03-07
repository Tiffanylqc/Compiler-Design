package parseTree.nodeTypes;

import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import tokens.Token;

public class FunctionDefinitionNode extends ParseNode {

	public FunctionDefinitionNode(Token token) {
		super(token);
		// TODO Auto-generated constructor stub
	}

	public FunctionDefinitionNode(ParseNode node) {
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

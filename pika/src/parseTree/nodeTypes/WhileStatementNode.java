package parseTree.nodeTypes;

import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import tokens.Token;

public class WhileStatementNode extends ParseNode {

	public WhileStatementNode(Token token) {
		super(token);
		// TODO Auto-generated constructor stub
	}

	public WhileStatementNode(ParseNode node) {
		super(node);
		// TODO Auto-generated constructor stub
	}
	
	////////////////////////////////////////////////////////////
	// convenience factory
	
	public static WhileStatementNode withChildren(Token token, ParseNode condition, ParseNode loopBody) {
		WhileStatementNode node = new WhileStatementNode(token);//if no error, token should be if
		node.appendChild(condition);
		node.appendChild(loopBody);
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

package parseTree.nodeTypes;

import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import tokens.Token;

public class IfStatementNode extends ParseNode {

	public IfStatementNode(Token token) {
		super(token);
		// TODO Auto-generated constructor stub
	}

	public IfStatementNode(ParseNode node) {
		super(node);
		// TODO Auto-generated constructor stub
	}
	
	////////////////////////////////////////////////////////////
	// convenience factory
	
	public static IfStatementNode withIf(Token token, ParseNode condition, ParseNode ifBlockStmt) {
		IfStatementNode node = new IfStatementNode(token);//if no error, token should be if
		node.appendChild(condition);
		node.appendChild(ifBlockStmt);
		return node;
	}
	
	public static IfStatementNode withIfElse(Token token, ParseNode condition, ParseNode ifBlockStmt, ParseNode elseBlockStmt) {
		IfStatementNode node = new IfStatementNode(token);//if no error, token should be if
		node.appendChild(condition);
		node.appendChild(ifBlockStmt);
		node.appendChild(elseBlockStmt);
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

package parseTree.nodeTypes;

import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import tokens.Token;

public class WhileStatementNode extends ParseNode {

	private String breakTarget;
	private String continueTarget;
	
	public WhileStatementNode(Token token) {
		super(token);
		// TODO Auto-generated constructor stub
	}

	public WhileStatementNode(ParseNode node) {
		super(node);
		// TODO Auto-generated constructor stub
	}
	
	public void setBreakTarget(String breakTarget){
		this.breakTarget=breakTarget;
	}
	
	public void setContinueTarget(String continueTarget){
		this.continueTarget=continueTarget;
	}
	
	public String getBreakTarget(){
		return breakTarget;
	}
	
	public String getContinueTarget(){
		return continueTarget;
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

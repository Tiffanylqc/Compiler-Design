package parseTree.nodeTypes;

import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import tokens.Token;

public class ForIndexStatementNode extends ParseNode {
	private String continueTarget;
	private String breakTarget;
	
	public ForIndexStatementNode(Token token) {
		super(token);
		// TODO Auto-generated constructor stub
	}

	public ForIndexStatementNode(ParseNode node) {
		super(node);
		// TODO Auto-generated constructor stub
	}
	public void accept(ParseNodeVisitor visitor) {
		visitor.visitEnter(this);
		visitChildren(visitor);
		visitor.visitLeave(this);
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
}

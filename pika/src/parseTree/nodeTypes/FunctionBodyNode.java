package parseTree.nodeTypes;

import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import tokens.Token;

public class FunctionBodyNode extends ParseNode {

	private String funcExitHandShakeLabel;
	public FunctionBodyNode(Token token) {
		super(token);
		// TODO Auto-generated constructor stub
	}

	public FunctionBodyNode(ParseNode node) {
		super(node);
		// TODO Auto-generated constructor stub
	}
	
	public void setExitHandshake(String funcExitHandShakeLabel){
		this.funcExitHandShakeLabel=funcExitHandShakeLabel;
	}
	public String getExitHandshake(){
		return this.funcExitHandShakeLabel;
	}
	///////////////////////////////////////////////////////////
	// boilerplate for visitors
	
	public void accept(ParseNodeVisitor visitor) {
		visitor.visitEnter(this);
		visitChildren(visitor);
		visitor.visitLeave(this);
	}
}

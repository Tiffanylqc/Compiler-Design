package parseTree.nodeTypes;

import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import tokens.LextantToken;
import tokens.Token;

public class ArrayTypeNode extends ParseNode {

	public ArrayTypeNode(Token token) {
		super(token);
		// TODO Auto-generated constructor stub
	}

	public ArrayTypeNode(ParseNode node) {
		super(node);
		// TODO Auto-generated constructor stub
	}
	////////////////////////////////////////////////////////////
	//attributes
	
	public String getValue() {
		return token.getLexeme();
	}
	
	public LextantToken lextantToken() {
		return (LextantToken)token;
	}	
	
	///////////////////////////////////////////////////////////
	//accept a visitor
	
//	public void accept(ParseNodeVisitor visitor) {
//		visitor.visit(this);
//	}
	
	public void accept(ParseNodeVisitor visitor) {
		visitor.visitEnter(this);
		visitChildren(visitor);
		visitor.visitLeave(this);
	}
}

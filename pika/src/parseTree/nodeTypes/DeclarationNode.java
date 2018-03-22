package parseTree.nodeTypes;

import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import lexicalAnalyzer.Keyword;
import lexicalAnalyzer.Lextant;
import tokens.LextantToken;
import tokens.Token;

public class DeclarationNode extends ParseNode {

	private boolean isStatic;
	public DeclarationNode(Token token) {
		super(token);
		assert(token.isLextant(Keyword.CONST)||token.isLextant(Keyword.VAR));
		isStatic=false;
	}

	public DeclarationNode(ParseNode node) {
		super(node);
		isStatic=false;
	}
	
	////////////////////////////////////////////////////////////
	// attributes
	
	public Lextant getDeclarationType() {
		return lextantToken().getLextant();
	}
	public LextantToken lextantToken() {
		return (LextantToken)token;
	}	
	
	public void setStatic(){
		this.isStatic=true;
	}
	public boolean getStatic(){
		return this.isStatic;
	}
	////////////////////////////////////////////////////////////
	// convenience factory
	
	public static DeclarationNode withChildren(Token token, ParseNode declaredName, ParseNode initializer) {
		DeclarationNode node = new DeclarationNode(token);
		node.appendChild(declaredName);
		node.appendChild(initializer);
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

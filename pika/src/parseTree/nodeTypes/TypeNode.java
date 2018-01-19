package parseTree.nodeTypes;

import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import lexicalAnalyzer.Keyword;
import tokens.LextantToken;
import tokens.Token;

public class TypeNode extends ParseNode {
	public TypeNode(Token token) {
		super(token);
		assert(token.isLextant(Keyword.BOOL, Keyword.INT,Keyword.FLOAT,Keyword.CHAR,Keyword.STRING));
	}
	public TypeNode(ParseNode node) {
		super(node);
	}

////////////////////////////////////////////////////////////
// attributes
	
	public String getValue() {
		return token.getLexeme();
	}

	public LextantToken lextantToken() {
		return (LextantToken)token;
	}	

///////////////////////////////////////////////////////////
// accept a visitor
	
	public void accept(ParseNodeVisitor visitor) {
		visitor.visit(this);
	}

}

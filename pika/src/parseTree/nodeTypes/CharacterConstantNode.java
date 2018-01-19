package parseTree.nodeTypes;

import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import tokens.CharacterConstantToken;
import tokens.Token;

public class CharacterConstantNode extends ParseNode {
	public CharacterConstantNode(Token token) {
		super(token);
		assert(token instanceof CharacterConstantToken);
	}
	public CharacterConstantNode(ParseNode node) {
		super(node);
	}

////////////////////////////////////////////////////////////
// attributes
	
	public String getValue() {
		return charToken().getLexeme();
	}

	public CharacterConstantToken charToken() {
		return (CharacterConstantToken)token;
	}	

///////////////////////////////////////////////////////////
// accept a visitor
	
	public void accept(ParseNodeVisitor visitor) {
		visitor.visit(this);
	}

}

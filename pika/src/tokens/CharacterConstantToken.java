package tokens;

import inputHandler.TextLocation;

public class CharacterConstantToken extends TokenImp {

//	Character c;
	public CharacterConstantToken(TextLocation location, String lexeme) {
		super(location, lexeme);//only one character in string lexeme 
//		c=lexeme.charAt(0);
	}

	public static CharacterConstantToken make(TextLocation location, String lexeme) {
		CharacterConstantToken result = new CharacterConstantToken(location, lexeme);
		return result;
	}
	
	@Override
	protected String rawString() {
		return "characterConstant, " + getLexeme();
	}

}

package tokens;

import inputHandler.TextLocation;

public class StringConstantToken extends TokenImp {	
	protected StringConstantToken(TextLocation location, String lexeme) {
		super(location, lexeme);
	}
	public static StringConstantToken make(TextLocation location, String lexeme) {
		StringConstantToken result = new StringConstantToken(location, lexeme);
		return result;
	}
	
	@Override
	protected String rawString() {
		return "stringConstant, " + getLexeme();
	}

}

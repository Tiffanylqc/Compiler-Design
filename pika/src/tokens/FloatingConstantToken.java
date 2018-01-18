package tokens;
import inputHandler.TextLocation;

public class FloatingConstantToken extends TokenImp {
	protected Double value;
	
	protected FloatingConstantToken(TextLocation location, String lexeme) {
		super(location, lexeme);
	}
	protected void setValue(Double value) {
		this.value = value;
	}
	public Double getValue() {
		return value;
	}
	
	public static FloatingConstantToken make(TextLocation location, String lexeme) {
		FloatingConstantToken result = new FloatingConstantToken(location, lexeme);
		result.setValue(Double.parseDouble(lexeme));
		return result;
	}
	
	@Override
	protected String rawString() {
		return "floatingConst, " + value;
	}
}
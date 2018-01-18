package inputHandler;

/** Value object for holding a character and its location in the input text.
 *  Contains delegates to select character operations.
 *
 */
public class LocatedChar {
	Character character;
	TextLocation location;
	
	public LocatedChar(Character character, TextLocation location) {
		super();
		this.character = character;
		this.location = location;
	}

	
	//////////////////////////////////////////////////////////////////////////////
	// getters
	
	public Character getCharacter() {
		return character;
	}
	public TextLocation getLocation() {
		return location;
	}
	public boolean isChar(char c) {
		return character == c;
	}
	
	
	
	//////////////////////////////////////////////////////////////////////////////
	// toString
	
	public String toString() {
		return "(" + charString() + ", " + location + ")";
	}
	private String charString() {
		if(Character.isWhitespace(character)) {
			int i = character;
			return String.format("'\\%d'", i);
		}
		else {
			return character.toString();
		}
	}

	
	//////////////////////////////////////////////////////////////////////////////
	// delegates
	
	public boolean isLowerCase() {
		return Character.isLowerCase(character);
	}
	public boolean isUnderline() {
		return (character=='_');
	}
	public boolean isDollar() {
		return (character=='$');
	}
	public boolean isUpperCase() {
		return Character.isUpperCase(character);
	}
	public boolean isDigit() {
		return Character.isDigit(character);
	}
	public boolean isDoublequote(){
		return (character=='"');
	}
	public boolean isNewline(){
		return (character=='\n');
	}
	public boolean isCircumflex(){
		return (character=='^');
	}
	public boolean isHashSign(){
		return (character=='#');
	}
	public boolean isSignSymbol(){
		return (character=='+')||(character=='-');
	}
	public boolean isDecimalPoint(){
		return (character=='.');
	}
	public boolean isPlus(){
		return (character=='+');
	}
	public boolean isMinus(){
		return (character=='-');
	}
	public boolean isWhitespace() {
		return Character.isWhitespace(character);
	}
}

package lexicalAnalyzer;


import logging.PikaLogger;

import inputHandler.InputHandler;
import inputHandler.LocatedChar;
import inputHandler.LocatedCharStream;
import inputHandler.PushbackCharStream;
import inputHandler.TextLocation;
import tokens.CharacterConstantToken;
import tokens.CommentToken;
import tokens.FloatingConstantToken;
import tokens.IdentifierToken;
import tokens.LextantToken;
import tokens.NullToken;
import tokens.IntegerConstantToken;
import tokens.StringConstantToken;
import tokens.Token;

import static lexicalAnalyzer.PunctuatorScanningAids.*;

public class LexicalAnalyzer extends ScannerImp implements Scanner {
	public static LexicalAnalyzer make(String filename) {
		InputHandler handler = InputHandler.fromFilename(filename);
		PushbackCharStream charStream = PushbackCharStream.make(handler);
		return new LexicalAnalyzer(charStream);
	}

	public LexicalAnalyzer(PushbackCharStream input) {
		super(input);
	}

	
	//////////////////////////////////////////////////////////////////////////////
	// Token-finding main dispatch	

	@Override
	protected Token findNextToken() {
		LocatedChar ch = nextNonWhitespaceChar();
		
		if(isNumberStart(ch)) {// integerConstant and floatConstant analysis
			return scanNumber(ch);
		}
		else if(isCommentStart(ch)){//comment analysis
			return scanComment(ch);
		}
		else if(isIdentifierStart(ch)) {//check identifier and keywords include the boolean constant
			return scanIdentifier(ch);
		}
		else if(isStringStart(ch)){//stringConstant analysis
			return scanString(ch);
		}
		else if(isCharacterStart(ch)){//characterConstant analysis
			return scanCharacter(ch);
		}
		else if(isPunctuatorStart(ch)) {//punctuator analysis
			return scanPunctuator(ch);
		}
		else if(isEndOfInput(ch)) {
			return NullToken.make(ch.getLocation());
		}
		else {
			lexicalError(ch);
			return findNextToken();
		}
	}


	private LocatedChar nextNonWhitespaceChar() {
		LocatedChar ch = input.next();
		while(ch.isWhitespace()) {
			ch = input.next();
		}
		return ch;
	}
	
	//////////////////////////////////////////////////////////////////////////////
	// Integer and Floating lexical analysis	
	private boolean isNumberStart(LocatedChar lc){
		LocatedChar next=lc;
		LocatedChar secondNext=lc;
		if(input.hasNext())
			next=input.peek();
		if(input.hasSecondNext())
			secondNext=input.peekSecondNext();
		
		if( lc.isDigit()||
			lc.isDecimalPoint()&&input.hasNext()&&next.isDigit()||
			lc.isSignSymbol()&&input.hasNext()&&next.isDigit()||
			lc.isSignSymbol()&&input.hasNext()&&next.isDecimalPoint()&&input.hasSecondNext()&&secondNext.isDigit())
			return true;
		else
			return false;
	}
	
	private Token scanNumber(LocatedChar firstChar) {
		StringBuffer buffer = new StringBuffer();
		if(firstChar.isSignSymbol()||firstChar.isDigit()){
			buffer.append(firstChar.getCharacter());
		}
		else if(firstChar.isDecimalPoint()){
			buffer.append("0.");
			appendSubsequentDecimalDigits(buffer);
			return FloatingConstantToken.make(firstChar.getLocation(), buffer.toString());
		}
		appendSubsequentIntegerDigits(buffer);
		
		LocatedChar c=firstChar, next=firstChar;
		if(input.hasNext())
			c=input.next();
		if(input.hasNext())
			next=input.peek();
		if(c.isDecimalPoint()&&next.isDigit()){
			buffer.append(".");
			appendSubsequentDecimalDigits(buffer);
			return FloatingConstantToken.make(firstChar.getLocation(), buffer.toString());
		}	
		else{
			input.pushback(c);
			return IntegerConstantToken.make(firstChar.getLocation(), buffer.toString());
		}	
	}
	
	private void appendSubsequentIntegerDigits(StringBuffer buffer) {
		LocatedChar c = input.next();
		while(c.isDigit()) {
			buffer.append(c.getCharacter());
			c = input.next();
		}
		input.pushback(c);
	}
	//for float number after '.'
	private void appendSubsequentDecimalDigits(StringBuffer buffer){
		LocatedChar c=input.next();
		while(c.isDigit()){
			buffer.append(c.getCharacter());
			c=input.next();
		}
		LocatedChar next=c,secondNext=c;
		if(c.getCharacter()=='E'){
			if(input.hasNext())
				next=input.peek();
			if(input.hasSecondNext())
				secondNext=input.peekSecondNext();
			if(input.hasNext()&&next.isDigit()){
				buffer.append(c.getCharacter());
				appendSubsequentIntegerDigits(buffer);
			}	
			else if(input.hasNext()&&next.isSignSymbol()&&input.hasSecondNext()&&secondNext.isDigit()){
				buffer.append(c.getCharacter());
				c=input.next();
				buffer.append(c.getCharacter());
				appendSubsequentIntegerDigits(buffer);
			}
			else
				input.pushback(c);
		}
		else
			input.pushback(c);
	}
	
	//////////////////////////////////////////////////////////////////////////////
	// Identifier and keyword lexical analysis	
	private boolean isIdentifierStart(LocatedChar lc){
		return (lc.isUpperCase()||lc.isLowerCase()||lc.isUnderline());
	}
	
	private boolean isIdentifierContinue(LocatedChar lc){
		return (lc.isUnderline()||lc.isUpperCase()||lc.isLowerCase()||lc.isDollar()||lc.isDigit());
	}
	
	private Token scanIdentifier(LocatedChar firstChar) {
		StringBuffer buffer = new StringBuffer();
		buffer.append(firstChar.getCharacter());
		appendSubsequentIdentifier(buffer);

		String lexeme = buffer.toString();
		if(Keyword.isAKeyword(lexeme)) {
			return LextantToken.make(firstChar.getLocation(), lexeme, Keyword.forLexeme(lexeme));
		}
		else {
			if(lexeme.length()<=32)
				return IdentifierToken.make(firstChar.getLocation(), lexeme);
			else{
				IllegalLengthIdentifierError(lexeme,firstChar);
				return findNextToken();
			}
		}
	}
	private void appendSubsequentIdentifier(StringBuffer buffer) {
		LocatedChar c = input.next();
		while(isIdentifierContinue(c)) {
			buffer.append(c.getCharacter());
			c = input.next();
		}
		input.pushback(c);
	}
	
	///////////////////////////////////////////////////////////////////////////////
	// String analysis
	private boolean isStringStart(LocatedChar lc){
		return lc.isDoublequote();
	}
	private boolean isStringContent(LocatedChar lc){
		return !(lc.isNewline()||lc.isDoublequote());
	}
	private Token scanString(LocatedChar firstChar){
		StringBuffer buffer=new StringBuffer();
		
		LocatedChar c=input.next();
		while(isStringContent(c)){
			buffer.append(c.getCharacter());
			c=input.next();
		}
		if(!c.isDoublequote()){//c is newline
			UnterminateStringError(buffer.toString(),firstChar);
			return findNextToken();
		}
		else{
			String lexeme=buffer.toString();
			return StringConstantToken.make(firstChar.getLocation(), lexeme);
		}
	}
	
	///////////////////////////////////////////////////////////////////////////////
	// Character analysis 
	private boolean isCharacterStart(LocatedChar lc){
		return lc.isCircumflex();
	}
	private boolean isValidCharacter(LocatedChar lc){
		int ascii=(int)(lc.getCharacter());
		if(ascii>=32&&ascii<=126)
			return true;
		else 
			return false;
	}
	private Token scanCharacter(LocatedChar firstChar){
		StringBuffer buffer=new StringBuffer();
		LocatedChar c1=input.next();
		
		if(isValidCharacter(c1)){
			buffer.append(c1.getCharacter());
			LocatedChar c2=input.next();
			if(!c2.isCircumflex()){//no end circumflex
				UnterminateCharacterError(c2);
				input.pushback(c2);
				return findNextToken();
			}
			else{
				return CharacterConstantToken.make(firstChar.getLocation(), buffer.toString());
			}
		}
		else{
			IllegalCharacterError(c1);
			return findNextToken();
		}	
	}
	
	///////////////////////////////////////////////////////////////////////////////
	// Comment analysis
	private boolean isCommentStart(LocatedChar lc){
		return lc.isHashSign();
	}
	
	private void appendSubsequentComment(StringBuffer buffer) {
		LocatedChar c = input.next();
		while(!(c.isHashSign()||c.isNewline())) {
			buffer.append(c.getCharacter());
			c = input.next();
		}
	}
	
	private Token scanComment(LocatedChar firstChar){
		StringBuffer buffer=new StringBuffer();
		appendSubsequentComment(buffer);
		String lexeme = buffer.toString();
		return CommentToken.make(firstChar.getLocation(), lexeme);
	}
	
	
	//////////////////////////////////////////////////////////////////////////////
	// Punctuator lexical analysis	
	// old method left in to show a simple scanning method.
	// current method is the algorithm object PunctuatorScanner.java

	@SuppressWarnings("unused")
	private Token oldScanPunctuator(LocatedChar ch) {
		TextLocation location = ch.getLocation();
		
		switch(ch.getCharacter()) {
		case '*':
			return LextantToken.make(location, "*", Punctuator.MULTIPLY);
		case '+':
			return LextantToken.make(location, "+", Punctuator.ADD);
		case '>':
			return LextantToken.make(location, ">", Punctuator.GREATER);
		case ':':
			if(ch.getCharacter()=='=') {
				return LextantToken.make(location, ":=", Punctuator.ASSIGN);
			}
			else {
				throw new IllegalArgumentException("found : not followed by = in scanOperator");
			}
		case ',':
			return LextantToken.make(location, ",", Punctuator.SEPARATOR);
		case ';':
			return LextantToken.make(location, ";", Punctuator.TERMINATOR);
		default:
			throw new IllegalArgumentException("bad LocatedChar " + ch + "in scanOperator");
		}
	}

	

	//////////////////////////////////////////////////////////////////////////////
	// Character-classification routines specific to Pika scanning.	

	private boolean isPunctuatorStart(LocatedChar lc) {
		char c = lc.getCharacter();
		return isPunctuatorStartingCharacter(c);
	}
	
	private Token scanPunctuator(LocatedChar lc){
		Token token=PunctuatorScanner.scan(lc, input);
		if(token instanceof NullToken){
			input.next();
			IllegalPunctuatorError(lc);
			return findNextToken();
		}
		else
			return token;
	}

	private boolean isEndOfInput(LocatedChar lc) {
		return lc == LocatedCharStream.FLAG_END_OF_INPUT;
	}
	
	
	//////////////////////////////////////////////////////////////////////////////
	// Error-reporting	

	private void lexicalError(LocatedChar ch) {
		PikaLogger log = PikaLogger.getLogger("compiler.lexicalAnalyzer");
		log.severe("Lexical error: invalid character " + ch);
	}

	private void UnterminateStringError(String errorString,LocatedChar ch){
		PikaLogger log=PikaLogger.getLogger("compiler.lexicalAnalyzer");
		log.severe("Lexical error: Unterminated String \""+errorString+"\""+ch);
	}
	
	private void UnterminateCharacterError(LocatedChar ch){
		PikaLogger log=PikaLogger.getLogger("compiler.lexicalAnalyzer");
		log.severe("Lexical error: Unterminated Character "+ch);
	}
	private void IllegalCharacterError(LocatedChar ch){
		PikaLogger log=PikaLogger.getLogger("compiler.lexicalAnalyzer");
		log.severe("Lexical error: Illegal Character "+ch);
	}
	private void IllegalPunctuatorError(LocatedChar ch){
		PikaLogger log=PikaLogger.getLogger("compiler.lexicalAnalyzer");
		log.severe("Lexical error: Illegal Punctuator "+ch);
	}
	private void IllegalLengthIdentifierError(String errorString,LocatedChar ch){
		PikaLogger log=PikaLogger.getLogger("compiler.lexicalAnalyzer");
		log.severe("Lexical error: Illegal length identifier \""+errorString+"\""+ch);
	}
}

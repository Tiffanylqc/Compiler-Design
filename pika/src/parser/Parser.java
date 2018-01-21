package parser;

import java.util.Arrays;

import logging.PikaLogger;
import parseTree.*;
import parseTree.nodeTypes.AssignStatementNode;
import parseTree.nodeTypes.BinaryOperatorNode;
import parseTree.nodeTypes.BooleanConstantNode;
import parseTree.nodeTypes.CastOperatorNode;
import parseTree.nodeTypes.CharacterConstantNode;
import parseTree.nodeTypes.MainBlockNode;
import parseTree.nodeTypes.DeclarationNode;
import parseTree.nodeTypes.ErrorNode;
import parseTree.nodeTypes.IdentifierNode;
import parseTree.nodeTypes.IntegerConstantNode;
import parseTree.nodeTypes.NewlineNode;
import parseTree.nodeTypes.PrintStatementNode;
import parseTree.nodeTypes.ProgramNode;
import parseTree.nodeTypes.SpaceNode;
import parseTree.nodeTypes.StringConstantNode;
import parseTree.nodeTypes.TabNode;
import parseTree.nodeTypes.TypeNode;
import parseTree.nodeTypes.FloatingConstantNode;
import tokens.*;
import lexicalAnalyzer.Keyword;
import lexicalAnalyzer.Lextant;
import lexicalAnalyzer.Punctuator;
import lexicalAnalyzer.Scanner;


public class Parser {
	private Scanner scanner;
	private Token nowReading;
	private Token previouslyRead;
	
	public static ParseNode parse(Scanner scanner) {
		Parser parser = new Parser(scanner);
		return parser.parse();
	}
	public Parser(Scanner scanner) {
		super();
		this.scanner = scanner;
	}
	
	public ParseNode parse() {
		readToken();
		return parseProgram();
	}

	////////////////////////////////////////////////////////////
	// "program" is the start symbol S
	// S -> EXEC mainBlock
	
	private ParseNode parseProgram() {
		if(!startsProgram(nowReading)) {
			return syntaxErrorNode("program");
		}
		ParseNode program = new ProgramNode(nowReading);
		
		expect(Keyword.EXEC);
		ParseNode mainBlock = parseMainBlock();
		program.appendChild(mainBlock);
		
		if(!(nowReading instanceof NullToken)) {
			return syntaxErrorNode("end of program");
		}
		
		return program;
	}
	private boolean startsProgram(Token token) {
		while(token instanceof CommentToken){
			readToken();
			token=nowReading;
		}
		return token.isLextant(Keyword.EXEC);
	}
	
	
	///////////////////////////////////////////////////////////
	// mainBlock
	
	// mainBlock -> { statement* }
	private ParseNode parseMainBlock() {
		if(!startsMainBlock(nowReading)) {
			return syntaxErrorNode("mainBlock");
		}
		ParseNode mainBlock = new MainBlockNode(nowReading);
		expect(Punctuator.OPEN_BRACE);
		
		while(startsStatement(nowReading)) {
			ParseNode statement = parseStatement();
			mainBlock.appendChild(statement);
		}
		expect(Punctuator.CLOSE_BRACE);
		return mainBlock;
	}
	private boolean startsMainBlock(Token token) {
		while(token instanceof CommentToken){
			readToken();
			token=nowReading;
		}
		return token.isLextant(Punctuator.OPEN_BRACE);
	}
	
	
	///////////////////////////////////////////////////////////
	// statements
	
	// statement-> declaration | printStmt | blockStmt | assignStmt
	private ParseNode parseStatement() {
		if(!startsStatement(nowReading)) {
			return syntaxErrorNode("statement");
		}
		if(startsDeclaration(nowReading)) {
			return parseDeclaration();
		}
		if(startsPrintStatement(nowReading)) {
			return parsePrintStatement();
		}
		if(startsMainBlock(nowReading)){
			return parseMainBlock();
		}
		if(startsAssignStatement(nowReading)){
			return parseAssignStatement();
		}
		return syntaxErrorNode("statement");
	}
	private boolean startsStatement(Token token) {
		while(token instanceof CommentToken){
			readToken();
			token=nowReading;
		}
		return startsPrintStatement(token) ||
			   startsDeclaration(token)||
			   startsMainBlock(token)||
			   startsAssignStatement(token);
	}
	
	//assignmentStmt -> target:=expression
	private ParseNode parseAssignStatement(){
		if(!startsAssignStatement(nowReading)){
			return syntaxErrorNode("assignmentStatement");
		}
		ParseNode identifier = parseIdentifier();
		Token assignToken=nowReading;
		expect(Punctuator.ASSIGN);
		ParseNode initializer = parseExpression();
		expect(Punctuator.TERMINATOR);
		return AssignStatementNode.withChildren(assignToken,identifier, initializer);
	}
	
	private boolean startsAssignStatement(Token token){
		while(token instanceof CommentToken){
			readToken();
			token=nowReading;
		}
		return startsIdentifier(token);
	}

	
	// printStmt -> PRINT printExpressionList .
	private ParseNode parsePrintStatement() {
		if(!startsPrintStatement(nowReading)) {
			return syntaxErrorNode("print statement");
		}
		PrintStatementNode result = new PrintStatementNode(nowReading);
		
		readToken();
		result = parsePrintExpressionList(result);
		
		expect(Punctuator.TERMINATOR);
		return result;
	}
	private boolean startsPrintStatement(Token token) {
		while(token instanceof CommentToken){
			readToken();
			token=nowReading;
		}
		return token.isLextant(Keyword.PRINT);
	}	

	// This adds the printExpressions it parses to the children of the given parent
	// printExpressionList -> printExpression* bowtie (,|;)  (note that this is nullable)

	private PrintStatementNode parsePrintExpressionList(PrintStatementNode parent) {
		while(startsPrintExpression(nowReading) || startsPrintSeparator(nowReading)) {
			parsePrintExpression(parent);
			parsePrintSeparator(parent);
		}
		return parent;
	}
	

	// This adds the printExpression it parses to the children of the given parent
	// printExpression -> (expr | nl)?     (nullable)
	
	private void parsePrintExpression(PrintStatementNode parent) {
		if(startsExpression(nowReading)) {
			ParseNode child = parseExpression();
			parent.appendChild(child);
		}
		else if(nowReading.isLextant(Keyword.NEWLINE)) {
			readToken();
			ParseNode child = new NewlineNode(previouslyRead);
			parent.appendChild(child);
		}
		else if(nowReading.isLextant(Keyword.TAB)) {
			readToken();
			ParseNode child = new TabNode(previouslyRead);
			parent.appendChild(child);
		}
		// else we interpret the printExpression as epsilon, and do nothing
	}
	private boolean startsPrintExpression(Token token) {
		while(token instanceof CommentToken){
			readToken();
			token=nowReading;
		}
		return startsExpression(token) || token.isLextant(Keyword.NEWLINE) ||token.isLextant(Keyword.TAB);
	}
	
	
	// This adds the printExpression it parses to the children of the given parent
	// printExpression -> expr? ,? nl? 
	
	private void parsePrintSeparator(PrintStatementNode parent) {
		if(!startsPrintSeparator(nowReading) && !nowReading.isLextant(Punctuator.TERMINATOR)) {
			ParseNode child = syntaxErrorNode("print separator");
			parent.appendChild(child);
			return;
		}
		
		if(nowReading.isLextant(Punctuator.SPACE)) {
			readToken();
			ParseNode child = new SpaceNode(previouslyRead);
			parent.appendChild(child);
		}
		else if(nowReading.isLextant(Punctuator.SEPARATOR)) {
			readToken();
		}		
		else if(nowReading.isLextant(Punctuator.TERMINATOR)) {
			// we're at the end of the bowtie and this printSeparator is not required.
			// do nothing.  Terminator is handled in a higher-level nonterminal.
		}
	}
	private boolean startsPrintSeparator(Token token) {
		while(token instanceof CommentToken){
			readToken();
			token=nowReading;
		}
		return token.isLextant(Punctuator.SEPARATOR, Punctuator.SPACE) ;
	}
	
	// declaration -> CONST identifier := expression .
	//				  VAR identifier := expression .
	private ParseNode parseDeclaration() {
		if(!startsDeclaration(nowReading)) {
			return syntaxErrorNode("declaration");
		}
		Token declarationToken = nowReading;
		readToken();
		
		ParseNode identifier = parseIdentifier();
		expect(Punctuator.ASSIGN);
		ParseNode initializer = parseExpression();
		expect(Punctuator.TERMINATOR);
		
		return DeclarationNode.withChildren(declarationToken, identifier, initializer);
	}
	private boolean startsDeclaration(Token token) {
		while(token instanceof CommentToken){
			readToken();
			token=nowReading;
		}
		return token.isLextant(Keyword.CONST)||
				token.isLextant(Keyword.VAR);
	}

	///////////////////////////////////////////////////////////
	// expressions
	// expr                     -> comparisonExpression
	// comparisonExpression     -> additiveExpression [> additiveExpression]?
	// additiveExpression       -> multiplicativeExpression [+ multiplicativeExpression]*  (left-assoc)
	// multiplicativeExpression -> parencastExpression [MULT parencastExpression]*  (left-assoc)
	// parencastExpression		-> (expr) 
	//							-> [expr|type]
	//							-> atomicExpression
	// atomicExpression         -> literal
	// literal                  -> integerConstant | floatingConstant | booleanConstant | characterConstant |stringConstant | identifier

	// expr  -> comparisonExpression
	private ParseNode parseExpression() {		
		if(!startsExpression(nowReading)) {
			return syntaxErrorNode("expression");
		}
		return parseComparisonExpression();
	}
	
	private boolean startsExpression(Token token) {
		while(token instanceof CommentToken){
			readToken();
			token=nowReading;
		}
		return startsComparisonExpression(token);
	}

	// comparisonExpression -> additiveExpression [> additiveExpression]?
	private ParseNode parseComparisonExpression() {
		if(!startsComparisonExpression(nowReading)) {
			return syntaxErrorNode("comparison expression");
		}
		
		ParseNode left = parseAdditiveSubtractiveExpression();
		if(nowReading.isLextant(Punctuator.GREATER,Punctuator.GREATER_EQUAL,Punctuator.LESS,
				Punctuator.LESS_EQUAL,Punctuator.NOT_EQUAL,Punctuator.EQUAL)) {
			Token compareToken = nowReading;
			readToken();
			ParseNode right = parseAdditiveSubtractiveExpression();
			
			return BinaryOperatorNode.withChildren(compareToken, left, right);
		}
		return left;

	}
	private boolean startsComparisonExpression(Token token) {
		while(token instanceof CommentToken){
			readToken();
			token=nowReading;
		}
		return startsAdditiveSubtractiveExpression(token);
	}

	// additivesubtractiveExpression -> multiplicativedividingExpression [+/- multiplicativedividingExpression]*  (left-assoc)
	private ParseNode parseAdditiveSubtractiveExpression() {
		if(!startsAdditiveSubtractiveExpression(nowReading)) {
			return syntaxErrorNode("additive and subtractive Expression");
		}
		
		ParseNode left = parseMultiplicativeDividingExpression();
		while(nowReading.isLextant(Punctuator.ADD,Punctuator.SUBTRACT)) {
			Token additivesubtractiveToken = nowReading;
			readToken();
			ParseNode right = parseMultiplicativeDividingExpression();
			
			left = BinaryOperatorNode.withChildren(additivesubtractiveToken, left, right);
		}
		return left;
	}
	private boolean startsAdditiveSubtractiveExpression(Token token) {
		while(token instanceof CommentToken){
			readToken();
			token=nowReading;
		}
		return startsMultiplicativeDividingExpression(token);
	}	

	// multiplicativedividingExpression -> parencastExpression [MULT/DIVIDE parencastExpression]*  (left-assoc)
	private ParseNode parseMultiplicativeDividingExpression() {
		if(!startsMultiplicativeDividingExpression(nowReading)) {
			return syntaxErrorNode("multiplicative and dividing Expression");
		}

		ParseNode left = parseParenCastExpression();
		while(nowReading.isLextant(Punctuator.MULTIPLY,Punctuator.DIVIDE)) {
			Token multiplicativedividingToken = nowReading;
			readToken();
			ParseNode right = parseParenCastExpression();
			
			left = BinaryOperatorNode.withChildren(multiplicativedividingToken, left, right);
		}
		return left;
	}
	private boolean startsMultiplicativeDividingExpression(Token token) {
		while(token instanceof CommentToken){
			readToken();
			token=nowReading;
		}
		return startsParenCastExpression(token);
	}
	
	//parencastExpression -> (expr) or [expr|type] or atomicExpression
	private ParseNode parseParenCastExpression(){
		if(!startsParenCastExpression(nowReading)) {
			return syntaxErrorNode("parenthese and cast Expression");
		}
		if(nowReading.isLextant(Punctuator.OPEN_PARENTHESE)){
			expect(Punctuator.OPEN_PARENTHESE);
			ParseNode expression=parseExpression();
			expect(Punctuator.CLOSE_PARENTHESE);
			return expression;
		}
		else if(nowReading.isLextant(Punctuator.OPEN_BRACKET))
		{
			expect(Punctuator.OPEN_BRACKET);
			ParseNode expression=parseExpression();
			expect(Punctuator.BAR);
			Token castToken=previouslyRead;
			ParseNode type=parseType();
			expect(Punctuator.CLOSE_BRACKET);
			return CastOperatorNode.withChildren(castToken, expression, type);
		}
		else{
			return parseAtomicExpression();
		}
	}
	private boolean startsParenCastExpression(Token token){
		while(token instanceof CommentToken){
			readToken();
			token=nowReading;
		}
		
		return token.isLextant(Punctuator.OPEN_BRACKET, Punctuator.OPEN_PARENTHESE)||startsAtomicExpression(token);
	}
	
	// atomicExpression -> literal
	private ParseNode parseAtomicExpression() {
		if(!startsAtomicExpression(nowReading)) {
			return syntaxErrorNode("atomic expression");
		}
		return parseLiteral();
	}
	private boolean startsAtomicExpression(Token token) {
		while(token instanceof CommentToken){
			readToken();
			token=nowReading;
		}
		return startsLiteral(token);
	}
	
	//literal-> integerConstant | floatingConstant | booleanConstant characterConstant |stringConstant | identifier in pika-1
	private ParseNode parseLiteral() {
		if(!startsLiteral(nowReading)) {
			return syntaxErrorNode("literal");
		}
		
		if(startsIntNumber(nowReading)) {
			return parseIntNumber();
		}
		if(startsFloatNumber(nowReading)) {
			return parseFloatNumber();
		}
		if(startsIdentifier(nowReading)) {
			return parseIdentifier();
		}
		if(startsBooleanConstant(nowReading)) {
			return parseBooleanConstant();
		}
		if(startsStringConstant(nowReading)){
			return parseStringConstant();
		}
		if(startsCharacterConstant(nowReading)){
			return parseCharacterConstant();
		}

		return syntaxErrorNode("literal");
	}
	private boolean startsLiteral(Token token) {
		while(token instanceof CommentToken){
			readToken();
			token=nowReading;
		}
		return startsIntNumber(token) || startsFloatNumber(token) ||startsIdentifier(token) ||
			   startsBooleanConstant(token) || startsStringConstant(token) || startsCharacterConstant(token);
	}

	// number (terminal)
	private ParseNode parseIntNumber() {
		if(!startsIntNumber(nowReading)) {
			return syntaxErrorNode("integer constant");
		}
		readToken();
		return new IntegerConstantNode(previouslyRead);
	}
	private ParseNode parseFloatNumber() {
		if(!startsFloatNumber(nowReading)) {
			return syntaxErrorNode("Floating constant");
		}
		readToken();
		return new FloatingConstantNode(previouslyRead);
	}
	private boolean startsIntNumber(Token token) {
		while(token instanceof CommentToken){
			readToken();
			token=nowReading;
		}
		return token instanceof IntegerConstantToken;
	}
	private boolean startsFloatNumber(Token token) {
		while(token instanceof CommentToken){
			readToken();
			token=nowReading;
		}
		return token instanceof FloatingConstantToken;
	}
	//string
	private ParseNode parseStringConstant(){
		if(!startsStringConstant(nowReading)){
			return syntaxErrorNode("String constant"); 
		}
		readToken();
		return new StringConstantNode(previouslyRead);
	}
	private boolean startsStringConstant(Token token){
		while(token instanceof CommentToken){
			readToken();
			token=nowReading;
		}
		return token instanceof StringConstantToken;
	}
	
	//character
	private ParseNode parseCharacterConstant(){
		if(!startsCharacterConstant(nowReading)){
			return syntaxErrorNode("Character constant"); 
		}
		readToken();
		return new CharacterConstantNode(previouslyRead);
	}
	private boolean startsCharacterConstant(Token token){
		while(token instanceof CommentToken){
			readToken();
			token=nowReading;
		}
		return token instanceof CharacterConstantToken;
	}
	
	// identifier (terminal)
	private ParseNode parseIdentifier() {
		if(!startsIdentifier(nowReading)) {
			return syntaxErrorNode("identifier");
		}
		readToken();
		return new IdentifierNode(previouslyRead);
	}
	private boolean startsIdentifier(Token token) {
		while(token instanceof CommentToken){
			readToken();
			token=nowReading;
		}
		return token instanceof IdentifierToken;
	}

	// boolean constant (terminal)
	private ParseNode parseBooleanConstant() {
		if(!startsBooleanConstant(nowReading)) {
			return syntaxErrorNode("boolean constant");
		}
		readToken();
		return new BooleanConstantNode(previouslyRead);
	}
	private boolean startsBooleanConstant(Token token) {
		while(token instanceof CommentToken){
			readToken();
			token=nowReading;
		}
		return token.isLextant(Keyword.TRUE, Keyword.FALSE);
	}
	
	// type 
	private ParseNode parseType(){
		if(!startsType(nowReading)) {
			return syntaxErrorNode("type constant");
		}
		readToken();
		return new TypeNode(previouslyRead);
	}
	private boolean startsType(Token token) {
		while(token instanceof CommentToken){
			readToken();
			token=nowReading;
		}
		return token.isLextant(Keyword.BOOL, Keyword.INT,Keyword.FLOAT,Keyword.CHAR,Keyword.STRING);
	}

	private void readToken() {
		previouslyRead = nowReading;
		nowReading = scanner.next();
	}	
	
	// if the current token is one of the given lextants, read the next token.
	// otherwise, give a syntax error and read next token (to avoid endless looping).
	private void expect(Lextant ...lextants ) {
		if(!nowReading.isLextant(lextants)) {
			syntaxError(nowReading, "expecting " + Arrays.toString(lextants));
		}
		readToken();
	}	
	private ErrorNode syntaxErrorNode(String expectedSymbol) {
		syntaxError(nowReading, "expecting " + expectedSymbol);
		ErrorNode errorNode = new ErrorNode(nowReading);
		readToken();
		return errorNode;
	}
	private void syntaxError(Token token, String errorDescription) {
		String message = "" + token.getLocation() + " " + errorDescription;
		error(message);
	}
	private void error(String message) {
		PikaLogger log = PikaLogger.getLogger("compiler.Parser");
		log.severe("syntax error: " + message);
	}	
}


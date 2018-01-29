package parser;

import java.util.Arrays;

import logging.PikaLogger;
import parseTree.*;
import parseTree.nodeTypes.PopulateArrayNode;
import parseTree.nodeTypes.ArrayTypeNode;
import parseTree.nodeTypes.AssignStatementNode;
import parseTree.nodeTypes.BinaryOperatorNode;
import parseTree.nodeTypes.BooleanConstantNode;
import parseTree.nodeTypes.CastOperatorNode;
import parseTree.nodeTypes.CharacterConstantNode;
import parseTree.nodeTypes.CloneStatementNode;
import parseTree.nodeTypes.BlockStatementNode;
import parseTree.nodeTypes.DeclarationNode;
import parseTree.nodeTypes.ErrorNode;
import parseTree.nodeTypes.IdentifierNode;
import parseTree.nodeTypes.IfStatementNode;
import parseTree.nodeTypes.IntegerConstantNode;
import parseTree.nodeTypes.LengthStatementNode;
import parseTree.nodeTypes.NegateStatementNode;
import parseTree.nodeTypes.NewArrayNode;
import parseTree.nodeTypes.NewlineNode;
import parseTree.nodeTypes.PrintStatementNode;
import parseTree.nodeTypes.ProgramNode;
import parseTree.nodeTypes.ReleaseStatementNode;
import parseTree.nodeTypes.SpaceNode;
import parseTree.nodeTypes.StringConstantNode;
import parseTree.nodeTypes.TabNode;
import parseTree.nodeTypes.PrimitiveTypeNode;
import parseTree.nodeTypes.WhileStatementNode;
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
		ParseNode mainBlock = parseBlockStatement();
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
	// Block Statement
	
	// blockStatement -> { statement* }
	private ParseNode parseBlockStatement() {
		if(!startsBlockStatement(nowReading)) {
			return syntaxErrorNode("block statement");
		}
		ParseNode mainBlock = new BlockStatementNode(nowReading);
		expect(Punctuator.OPEN_BRACE);
		
		while(startsStatement(nowReading)) {
			ParseNode statement = parseStatement();
			mainBlock.appendChild(statement);
		}
		expect(Punctuator.CLOSE_BRACE);
		return mainBlock;
	}
	private boolean startsBlockStatement(Token token) {
		return token.isLextant(Punctuator.OPEN_BRACE);
	}
	
	
	///////////////////////////////////////////////////////////
	// statements
	
	// statement-> declaration | printStmt | blockStmt | assignStmt |ifStmt |whileStmt | releaseStmt
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
		if(startsBlockStatement(nowReading)){
			return parseBlockStatement();
		}
		if(startsAssignStatement(nowReading)){
			return parseAssignStatement();
		}
		if(startsIfStatement(nowReading)){
			return parseIfStatement();
		}
		if(startsWhileStatement(nowReading)){
			return parseWhileStatement();
		}
		if(startsReleaseStatement(nowReading)){
			return parseReleaseStatement();
		}
		return syntaxErrorNode("statement");
	}
	private boolean startsStatement(Token token) {
		return startsPrintStatement(token) ||
			   startsDeclaration(token)||
			   startsBlockStatement(token)||
			   startsAssignStatement(token)||
			   startsIfStatement(token)||
			   startsWhileStatement(token)||
			   startsReleaseStatement(token);
	}
	
	// releaseStmt -> release expression.
	private ParseNode parseReleaseStatement(){
		if(!startsReleaseStatement(nowReading)){
			return syntaxErrorNode("release statement");
		}
		Token releaseToken=nowReading;
		ParseNode releaseNode=new ReleaseStatementNode(releaseToken);
		readToken();
		
		ParseNode expr=parseExpression();
		releaseNode.appendChild(expr);
		expect(Punctuator.TERMINATOR);
		
		return releaseNode;
	}
	private boolean startsReleaseStatement(Token token){
		return token.isLextant(Keyword.RELEASE);
	}
	
	//whileStmt -> while(expression) blockStmt
	private ParseNode parseWhileStatement(){
		if(!startsWhileStatement(nowReading)){
			return syntaxErrorNode("while statement");
		}
		Token whileToken=nowReading;
		readToken();
		
		expect(Punctuator.OPEN_PARENTHESE);
		ParseNode condition=parseExpression();
		expect(Punctuator.CLOSE_PARENTHESE);
		
		ParseNode loopBody=parseBlockStatement();
		
		return WhileStatementNode.withChildren(whileToken, condition, loopBody);
	}
	private boolean startsWhileStatement(Token token){
		return token.isLextant(Keyword.WHILE);
	}
	
	// IfStmt -> if(expression) blockStmt (else blockStmt)?
	private ParseNode parseIfStatement(){
		if(!startsIfStatement(nowReading)){
			return syntaxErrorNode("if statement");
		}
		Token ifToken=nowReading;
		readToken();
		
		expect(Punctuator.OPEN_PARENTHESE);
		ParseNode condition=parseExpression();
		expect(Punctuator.CLOSE_PARENTHESE);
		
		ParseNode ifBlockStmt=parseBlockStatement();
		
		if(nowReading.isLextant(Keyword.ELSE)){
			readToken();
			ParseNode elseBlockStmt=parseBlockStatement();
			return IfStatementNode.withIfElse(ifToken, condition, ifBlockStmt, elseBlockStmt);
		}
		else{
			return IfStatementNode.withIf(ifToken, condition, ifBlockStmt);
		}
	}
	
	private boolean startsIfStatement(Token token){
		return token.isLextant(Keyword.IF);
	}
	
	//assignmentStmt -> target:=expression 
	//target		->	expression
	private ParseNode parseAssignStatement(){
		if(!startsAssignStatement(nowReading)){
			return syntaxErrorNode("assignmentStatement");
		}
		ParseNode target = parseExpression();
		Token assignToken=nowReading;
		expect(Punctuator.ASSIGN);
		ParseNode initializer = parseExpression();
		expect(Punctuator.TERMINATOR);
		return AssignStatementNode.withChildren(assignToken,target, initializer);
	}
	
	private boolean startsAssignStatement(Token token){
		return startsExpression(token);
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
		return parseOrExpression();
	}
	
	private boolean startsExpression(Token token) {
		return startsOrExpression(token);
	}
	// boolean OR -> andExpression [|| andExpression]?
	private ParseNode parseOrExpression(){
		if(!startsOrExpression(nowReading)){
			return syntaxErrorNode("boolean OR expression");
		}
		ParseNode left=parseAndExpression();
		while(nowReading.isLextant(Punctuator.BOOL_OR)){
			Token orToken=nowReading;
			readToken();
			ParseNode right=parseAndExpression();
			left=BinaryOperatorNode.withChildren(orToken, left, right);
		}
		return left;
	}
	private boolean startsOrExpression(Token token){
		return startsAndExpression(token);
	}
	
	//boolean AND -> comparisonExpression [&& comparisonExpression]?
	private ParseNode parseAndExpression(){
		if(!startsAndExpression(nowReading)){
			return syntaxErrorNode("boolean OR expression");
		}
		ParseNode left=parseComparisonExpression();
		while(nowReading.isLextant(Punctuator.BOOL_OR)){
			Token andToken=nowReading;
			readToken();
			ParseNode right=parseComparisonExpression();
			left=BinaryOperatorNode.withChildren(andToken, left, right);
		}
		return left;
	}
	private boolean startsAndExpression(Token token){
		return startsComparisonExpression(token);
	}
	
	// comparisonExpression -> additiveExpression [> additiveExpression]?
	private ParseNode parseComparisonExpression() {
		if(!startsComparisonExpression(nowReading)) {
			return syntaxErrorNode("comparison expression");
		}
		
		ParseNode left = parseAdditiveExpression();
		while(nowReading.isLextant(Punctuator.GREATER,Punctuator.GREATER_EQUAL,Punctuator.LESS,
				Punctuator.LESS_EQUAL,Punctuator.NOT_EQUAL,Punctuator.EQUAL)) {
			Token compareToken = nowReading;
			readToken();
			ParseNode right = parseAdditiveExpression();
			
			left= BinaryOperatorNode.withChildren(compareToken, left, right);
		}
		return left;

	}
	private boolean startsComparisonExpression(Token token) {
		return startsAdditiveExpression(token);
	}

	// additiveExpression -> multiplicativeExpression [+/- multiplicativeExpression]*  (left-assoc)
	private ParseNode parseAdditiveExpression() {
		if(!startsAdditiveExpression(nowReading)) {
			return syntaxErrorNode("additive and subtractive Expression");
		}
		
		ParseNode left = parseMultiplicativeExpression();
		while(nowReading.isLextant(Punctuator.ADD,Punctuator.SUBTRACT)) {
			Token additivesubtractiveToken = nowReading;
			readToken();
			ParseNode right = parseMultiplicativeExpression();
			
			left = BinaryOperatorNode.withChildren(additivesubtractiveToken, left, right);
		}
		return left;
	}
	private boolean startsAdditiveExpression(Token token) {
		return startsMultiplicativeExpression(token);
	}	

	// multiplicativeExpression -> parencastExpression [MULT/DIVIDE parencastExpression]*  (left-assoc)
	private ParseNode parseMultiplicativeExpression() {
		if(!startsMultiplicativeExpression(nowReading)) {
			return syntaxErrorNode("multiplicative and dividing Expression");
		}

		ParseNode left = parseParenCastExpression();
		while(nowReading.isLextant(Punctuator.MULTIPLY,Punctuator.DIVIDE,Punctuator.OVER,Punctuator.EXPRESS_OVER,Punctuator.RATIONALIZE)) {
			Token multiplicativedividingToken = nowReading;
			readToken();
			ParseNode right = parseParenCastExpression();
			
			left = BinaryOperatorNode.withChildren(multiplicativedividingToken, left, right);
		}
		return left;
	}
	private boolean startsMultiplicativeExpression(Token token) {
		return startsParenCastExpression(token);
	}
	
	//parencastExpression -> (expr) or [expr|type] or atomicExpression
	private ParseNode parseParenCastExpression(){
		if(!startsParenCastExpression(nowReading)) {
			return syntaxErrorNode("parenthese and cast and array create Expression");
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
			//cast
			if(nowReading.isLextant(Punctuator.BAR)){
				expect(Punctuator.BAR);
				Token castToken=previouslyRead;
				ParseNode type=parseType();
				expect(Punctuator.CLOSE_BRACKET);
				return CastOperatorNode.withChildren(castToken, expression, type);
			}//populate array creation
			else{
				PopulateArrayNode exprList=new PopulateArrayNode(nowReading);
				exprList.appendChild(expression);
				parseExpressionList(exprList);
				return exprList;
			}
		}
		else if(startsNewArrayExpression(nowReading)){
			return parseNewArrayExpression();
		}
		else{
			return parseAtomicExpression();
		}
	}
	private boolean startsParenCastExpression(Token token){
		return token.isLextant(Punctuator.OPEN_BRACKET, Punctuator.OPEN_PARENTHESE)||
			   startsAtomicExpression(token)||
			   startsNewArrayExpression(token);
	}
	
	//[ expressionList ] 
	private void parseExpressionList(ParseNode parent){
		
		while(startsExpression(nowReading)||startsExpressionSeparator(nowReading)){
			parseExpressionSeparator(parent);
			ParseNode child=parseExpression();
			parent.appendChild(child);
		}
		
		expect(Punctuator.CLOSE_BRACKET);
	}
	
	private void parseExpressionSeparator(ParseNode parent){
		if(!startsExpressionSeparator(nowReading)&&!nowReading.isLextant(Punctuator.CLOSE_BRACKET)){
			ParseNode child=syntaxErrorNode("expression list separator");
			parent.appendChild(child);
			return;
		}
		else if(nowReading.isLextant(Punctuator.SEPARATOR))
			readToken();
		
	}
	
	private boolean startsExpressionSeparator(Token token){
		return token.isLextant(Punctuator.SEPARATOR);
	}
	// new arrayType ( expression )
	private ParseNode parseNewArrayExpression(){
		if(!startsNewArrayExpression(nowReading)){
			return syntaxErrorNode("new array");
		}
		ParseNode newNode=new NewArrayNode(nowReading);
		readToken();
		ParseNode type=parseArrayType();
		expect(Punctuator.OPEN_PARENTHESE);
		ParseNode expr=parseExpression();
		expect(Punctuator.CLOSE_PARENTHESE);
		
		newNode.appendChild(type);
		newNode.appendChild(expr);
		return newNode;
	}
	
	private boolean startsNewArrayExpression(Token token){
		return token.isLextant(Keyword.NEW);
	}
	//clone expression
	private ParseNode parseCloneExpression(){
		if(!startsCloneExpression(nowReading)){
			return syntaxErrorNode("clone expression");
		}
		ParseNode cloneExpr=new CloneStatementNode(nowReading);
		readToken();
		ParseNode expr=parseExpression();
		cloneExpr.appendChild(expr);
		
		return cloneExpr;
	}
	private boolean startsCloneExpression(Token token){
		return token.isLextant(Keyword.CLONE);
	}
	//negate! expression
	private ParseNode parseNegateExpression(){
		if(!startsNegateExpression(nowReading)){
			return syntaxErrorNode("boolean not expression");
		}
		ParseNode notExpr=new NegateStatementNode(nowReading);
		readToken();
		ParseNode expr=parseExpression();
		notExpr.appendChild(expr);
		
		return notExpr;
	}
	private boolean startsNegateExpression(Token token){
		return token.isLextant(Punctuator.BOOL_NOT);
	}
	
	//length expression
	private ParseNode parseLengthExpression(){
		if(!startsLengthExpression(nowReading)){
			return syntaxErrorNode("length expression");
		}
		ParseNode lengthExpr=new LengthStatementNode(nowReading);
		readToken();
		ParseNode expr=parseExpression();
		lengthExpr.appendChild(expr);
		
		return lengthExpr;
	}
	private boolean startsLengthExpression(Token token){
		return token.isLextant(Keyword.LENGTH);
	}
	
	// atomicExpression -> literal
	private ParseNode parseAtomicExpression() {
		if(!startsAtomicExpression(nowReading)) {
			return syntaxErrorNode("atomic expression");
		}
		return parseLiteral();
	}
	private boolean startsAtomicExpression(Token token) {
		return startsLiteral(token);
	}
	
	//literal-> integerConstant | floatingConstant | booleanConstant|characterConstant |stringConstant | identifier
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
		return token instanceof IntegerConstantToken;
	}
	private boolean startsFloatNumber(Token token) {
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
		return token.isLextant(Keyword.TRUE, Keyword.FALSE);
	}
	
	// type 
	private ParseNode parseType(){
		if(!startsType(nowReading)) {
			return syntaxErrorNode("type constant");
		}
		if(startsPrimitiveType(nowReading)){
			readToken();
			return new PrimitiveTypeNode(previouslyRead);
		}
		else{
			return parseArrayType();//TODO: may need to change
		}
	}
	// ArrayTypeNode
	private ParseNode parseArrayType(){
		if(!startsArrayType(nowReading)){
			return syntaxErrorNode("array type");
		}
		expect(Punctuator.OPEN_BRACKET);
		ArrayTypeNode result=new ArrayTypeNode(previouslyRead);
		
		ParseNode node=parseType();
		result.appendChild(node);
		
		expect(Punctuator.CLOSE_BRACKET);
		return result;
	}
	
	private boolean startsType(Token token){
		return startsArrayType(token)||startsPrimitiveType(token);
	}
	private boolean startsArrayType(Token token){
		return token.isLextant(Punctuator.OPEN_BRACKET);
	}
	private boolean startsPrimitiveType(Token token) {
		return token.isLextant(Keyword.BOOL, Keyword.INT,Keyword.FLOAT,Keyword.CHAR,Keyword.STRING,Keyword.RAT);
	}
	
	////////////////////////////////////////////////////////////////////
	private void readToken() {
		previouslyRead = nowReading;
		nowReading = scanner.next();
		while(nowReading instanceof CommentToken)
			nowReading=scanner.next();
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


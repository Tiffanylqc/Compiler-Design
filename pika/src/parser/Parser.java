package parser;

import java.util.Arrays;

import logging.PikaLogger;
import parseTree.*;
import parseTree.nodeTypes.ArrayTypeNode;
import parseTree.nodeTypes.AssignStatementNode;
import parseTree.nodeTypes.OperatorNode;
import parseTree.nodeTypes.ParamSpecificationNode;
import parseTree.nodeTypes.BooleanConstantNode;
import parseTree.nodeTypes.BreakNode;
import parseTree.nodeTypes.CallStatementNode;
import parseTree.nodeTypes.CastOperatorNode;
import parseTree.nodeTypes.CharacterConstantNode;
import parseTree.nodeTypes.ContinueNode;
import parseTree.nodeTypes.BlockStatementNode;
import parseTree.nodeTypes.DeclarationNode;
import parseTree.nodeTypes.ErrorNode;
import parseTree.nodeTypes.ExpressionListNode;
import parseTree.nodeTypes.IdentifierNode;
import parseTree.nodeTypes.IfStatementNode;
import parseTree.nodeTypes.IntegerConstantNode;
import parseTree.nodeTypes.LambdaParamTypeNode;
import parseTree.nodeTypes.LambdaTypeNode;
import parseTree.nodeTypes.NewlineNode;
import parseTree.nodeTypes.PrintStatementNode;
import parseTree.nodeTypes.ProgramNode;
import parseTree.nodeTypes.ReleaseStatementNode;
import parseTree.nodeTypes.ReturnStatementNode;
import parseTree.nodeTypes.SpaceNode;
import parseTree.nodeTypes.StringConstantNode;
import parseTree.nodeTypes.TabNode;
import parseTree.nodeTypes.VoidTypeNode;
import parseTree.nodeTypes.PrimitiveTypeNode;
import parseTree.nodeTypes.WhileStatementNode;
import parseTree.nodeTypes.FloatingConstantNode;
import parseTree.nodeTypes.FunctionBodyNode;
import parseTree.nodeTypes.FunctionDefinitionNode;
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
	// S -> EXEC blockStmt
	
	private ParseNode parseProgram() {
		if(!startsProgram(nowReading)) {
			return syntaxErrorNode("program");
		}
		ParseNode program = new ProgramNode(nowReading);
		
		while(startsFunctionDefinition(nowReading)){
			ParseNode funcDefinition=parseFunctionDefinition();
			program.appendChild(funcDefinition);
		}
		expect(Keyword.EXEC);
		ParseNode mainBlock = parseBlockStatement();
		program.appendChild(mainBlock);
		
		if(!(nowReading instanceof NullToken)) {
			return syntaxErrorNode("end of program");
		}
		
		return program;
	}
	private boolean startsProgram(Token token) {
		return token.isLextant(Keyword.EXEC)||token.isLextant(Keyword.FUNC);
	}
	
	// functionDefinition
	private ParseNode parseFunctionDefinition(){
		if(!startsFunctionDefinition(nowReading)){
			return syntaxErrorNode("function definition");
		}
		ParseNode functionDefinition=new FunctionDefinitionNode(nowReading);
		readToken();
		ParseNode identifier=parseIdentifier();
		ParseNode lambda=parseLambda();
		functionDefinition.appendChild(identifier);
		functionDefinition.appendChild(lambda);
		
		return functionDefinition;
	}
	private boolean startsFunctionDefinition(Token token){
		return token.isLextant(Keyword.FUNC);
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
	// FunctionBody -> { statement* }
	private ParseNode parseFunctionBody() {
		if(!startsFunctionBody(nowReading)) {
			return syntaxErrorNode("function body");
		}
		
		ParseNode mainBlock = new FunctionBodyNode(nowReading);
		expect(Punctuator.OPEN_BRACE);
		
		while(startsStatement(nowReading)) {
			ParseNode statement = parseStatement();
			mainBlock.appendChild(statement);
		}
		expect(Punctuator.CLOSE_BRACE);
		return mainBlock;
	}
	private boolean startsFunctionBody(Token token) {
		return token.isLextant(Punctuator.OPEN_BRACE);
	}	
	
	
	///////////////////////////////////////////////////////////
	// statements
	
	// statement-> declaration | printStmt | blockStmt | assignStmt |ifStmt |whileStmt | releaseStmt
	//				breakStmt | continueStmt
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
		if(startsBreakStatement(nowReading)){
			return parseBreakStatement();
		}
		if(startsContinueStatement(nowReading)){
			return parseContinueStatement();
		}
		if(startsReturnStatement(nowReading)){
			return parseReturnStatement();
		}
		if(startsCallStatement(nowReading)){
			return parseCallStatement();
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
			   startsReleaseStatement(token)||
			   startsBreakStatement(token)||
			   startsContinueStatement(token)||
			   startsReturnStatement(token)||
			   startsCallStatement(token);
	}
	// callStmt -> call functionInvocation
	private ParseNode parseCallStatement(){
		if(!startsCallStatement(nowReading)){
			return syntaxErrorNode("call statement");
		}
		Token callToken=nowReading;
		ParseNode callNode=new CallStatementNode(callToken);
		readToken();
		ParseNode funInvoNode=parseFunctionInvocation();
		callNode.appendChild(funInvoNode);
		
		expect(Punctuator.TERMINATOR);
		return callNode;
	}
	private boolean startsCallStatement(Token token){
		return token.isLextant(Keyword.CALL);
	}
	
	// functionInvocation -> expr ( exprList )
	private ParseNode parseFunctionInvocation(){
		if(!startsFunctionInvocation(nowReading)){
			return syntaxErrorNode("function invocation");
		}
		ParseNode node=parseParenCastExpression();
		
		while(nowReading.isLextant(Punctuator.OPEN_BRACKET,Punctuator.OPEN_PARENTHESE)){
			Token realToken=nowReading;
			if(nowReading.isLextant(Punctuator.OPEN_BRACKET)){
				Token indexToken=LextantToken.artificial(realToken.getLocation(),Punctuator.ARRAY_INDEXING);
				readToken();
				ParseNode index=parseExpression();
				expect(Punctuator.CLOSE_BRACKET);
				node=OperatorNode.withChildren(indexToken, node, index);
			}
			else{
				Token funcToken=nowReading;
				readToken();
				
				if(!nowReading.isLextant(Punctuator.CLOSE_PARENTHESE)){
					ParseNode exprList=new ExpressionListNode(funcToken);
					ParseNode exprList1=parseExpression();
					exprList.appendChild(exprList1);
					parseExpressionList(exprList);
					node=OperatorNode.withChildren(funcToken, node, exprList);
				}
				else{
					ParseNode exprList=new ExpressionListNode(funcToken);
					node=OperatorNode.withChildren(funcToken, node, exprList);
				}
					
				expect(Punctuator.CLOSE_PARENTHESE);
			}
		}
		if(!previouslyRead.isLextant(Punctuator.CLOSE_PARENTHESE))
			return syntaxErrorNode("function invocation");
		
		return node;
	}
	private boolean startsFunctionInvocation(Token token){
		return startsParenCastExpression(token);
	}
	
	private ParseNode parseArrayIndexingExpression(){
		if(!startsArrayIndexingExpression(nowReading)){
			return syntaxErrorNode("array indexing expression");
		}
		ParseNode node=parseParenCastExpression();
		
		while(nowReading.isLextant(Punctuator.OPEN_BRACKET,Punctuator.OPEN_PARENTHESE)){
			Token realToken=nowReading;
			if(nowReading.isLextant(Punctuator.OPEN_BRACKET)){
				
				Token indexToken=LextantToken.artificial(realToken.getLocation(),Punctuator.ARRAY_INDEXING);
				readToken();
				ParseNode index=parseExpression();
				expect(Punctuator.CLOSE_BRACKET);
				node=OperatorNode.withChildren(indexToken, node, index);
			}
			else{
				
				Token funcToken=nowReading;
				readToken();
				
				if(!nowReading.isLextant(Punctuator.CLOSE_PARENTHESE)){
					ParseNode exprList=new ExpressionListNode(funcToken);
					ParseNode exprList1=parseExpression();
					exprList.appendChild(exprList1);
					parseExpressionList(exprList);
					node=OperatorNode.withChildren(funcToken, node, exprList);
				}
				else{
					ParseNode exprList=new ExpressionListNode(funcToken);
					node=OperatorNode.withChildren(funcToken, node, exprList);
				}
					
				expect(Punctuator.CLOSE_PARENTHESE);
			}
		}
		
		return node;
	}
	private boolean startsArrayIndexingExpression(Token token){
		return startsParenCastExpression(token);
	}
	
	// returnStmt -> return expression?.
	private ParseNode parseReturnStatement(){
		if(!startsReturnStatement(nowReading)){
			return syntaxErrorNode("return statement");
		}
		Token returnToken=nowReading;
		ParseNode returnNode=new ReturnStatementNode(returnToken);
		readToken();
		
		if(startsExpression(nowReading)){
			ParseNode expr=parseExpression();
			returnNode.appendChild(expr);
		}
		expect(Punctuator.TERMINATOR);
		return returnNode;
	}
	private boolean startsReturnStatement(Token token){
		return token.isLextant(Keyword.RETURN);
	}
	
	// continueStmt -> continue .
	private ParseNode parseContinueStatement(){
		if(!startsContinueStatement(nowReading)){
			return syntaxErrorNode("continue statement");
		}
		Token continueToken=nowReading;
		ParseNode continueNode=new ContinueNode(continueToken);
		readToken();
		expect(Punctuator.TERMINATOR);
		
		return continueNode;
	}
	private boolean startsContinueStatement(Token token){
		return token.isLextant(Keyword.CONTINUE);
	}
	
	// breakStmt -> break.
	private ParseNode parseBreakStatement(){
		if(!startsBreakStatement(nowReading)){
			return syntaxErrorNode("break statement");
		}
		Token breakToken=nowReading;
		ParseNode breakNode=new BreakNode(breakToken);
		readToken();
		expect(Punctuator.TERMINATOR);
		
		return breakNode;
	}
	private boolean startsBreakStatement(Token token){
		return token.isLextant(Keyword.BREAK);
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
		if((target instanceof OperatorNode) && (target.getToken().isLextant(Punctuator.ARRAY_INDEXING)) || target instanceof IdentifierNode){
			Token assignToken=nowReading;
			expect(Punctuator.ASSIGN);
			ParseNode initializer = parseExpression();
			expect(Punctuator.TERMINATOR);
			return AssignStatementNode.withChildren(assignToken,target, initializer);
		}
		else{
			return syntaxErrorNode("targetable expression");
		}
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
	
	
	// lambda -> lambdaParamType blockStmt
	private ParseNode parseLambda(){
		if(!startsLambda(nowReading)){
			return syntaxErrorNode("lambda");
		}
		Token lambdaToken=LextantToken.artificial(nowReading.getLocation(), Punctuator.LAMBDA);
		ParseNode lambda=new OperatorNode(lambdaToken);
		ParseNode lambdaParam=parseLambdaParamType();
		ParseNode block=parseFunctionBody();
		lambda.appendChild(lambdaParam);
		lambda.appendChild(block);
		
		return lambda;
	}
	private boolean startsLambda(Token token){
		return startsLambdaParamType(token);
	}
	
	// lambdaParamType
	private ParseNode parseLambdaParamType(){
		if(!startsLambdaType(nowReading)){
			return syntaxErrorNode("lambda type");
		}
		
		expect(Punctuator.LESS);
		ParseNode lambdaParamNode=new LambdaParamTypeNode(previouslyRead);
		
		if(!nowReading.isLextant(Punctuator.GREATER)){
			ParseNode paramSpec=parseParamSpecification();
			lambdaParamNode.appendChild(paramSpec);
			parseParamList(lambdaParamNode);
		}
		expect(Punctuator.GREATER);
		expect(Punctuator.ARROW);
		
		ParseNode resultType=parseType();
		lambdaParamNode.appendChild(resultType);
		
		return lambdaParamNode;
	}
	private boolean startsLambdaParamType(Token token){
		return token.isLextant(Punctuator.LESS);
	}
	// paramList
	private void parseParamList(ParseNode parent){
		while(startsParamSpecification(nowReading)||startsParamSeparator(nowReading)){
			parseParamSeparator(parent);
			ParseNode child=parseParamSpecification();
			parent.appendChild(child);
		}
	}
	private void parseParamSeparator(ParseNode parent){
		if(!startsParamSeparator(nowReading)&&!nowReading.isLextant(Punctuator.GREATER)){
			ParseNode child=syntaxErrorNode("parameter list separator");
			parent.appendChild(child);
			return;
		}
		else if(nowReading.isLextant(Punctuator.SEPARATOR))
			readToken();
	}
	private boolean startsParamSeparator(Token token){
		return token.isLextant(Punctuator.SEPARATOR);
	}
	// parameter specification -> type identifier
	private ParseNode parseParamSpecification(){
		if(!startsParamSpecification(nowReading)){
			return syntaxErrorNode("parameter specification");
		}
		ParseNode paramSpec=new ParamSpecificationNode(nowReading);
		ParseNode type=parseType();
		ParseNode identifer=parseIdentifier();
		paramSpec.appendChild(type);
		paramSpec.appendChild(identifer);
		
		return paramSpec;
	}
	private boolean startsParamSpecification(Token token){
		return startsType(token);
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
			left=OperatorNode.withChildren(orToken, left, right);
		}
		return left;
	}
	private boolean startsOrExpression(Token token){
		return startsAndExpression(token);
	}
	
	//boolean AND -> comparisonExpression [&& comparisonExpression]?
	private ParseNode parseAndExpression(){
		if(!startsAndExpression(nowReading)){
			return syntaxErrorNode("boolean AND expression");
		}
		ParseNode left=parseComparisonExpression();
		while(nowReading.isLextant(Punctuator.BOOL_AND)){
			Token andToken=nowReading;
			readToken();
			ParseNode right=parseComparisonExpression();
			left=OperatorNode.withChildren(andToken, left, right);
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
			
			left= OperatorNode.withChildren(compareToken, left, right);
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
			
			left = OperatorNode.withChildren(additivesubtractiveToken, left, right);
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

		ParseNode left = parseUnaryExpression();
		while(nowReading.isLextant(Punctuator.MULTIPLY,Punctuator.DIVIDE,Punctuator.OVER,Punctuator.EXPRESS_OVER,Punctuator.RATIONALIZE)) {
			Token multiplicativeToken = nowReading;
			readToken();
			ParseNode right = parseUnaryExpression();
			
			left = OperatorNode.withChildren(multiplicativeToken, left, right);
		}
		return left;
	}
	private boolean startsMultiplicativeExpression(Token token) {
		return startsUnaryExpression(token);
	}
	
	// unary expression (right-assoc)
	private ParseNode parseUnaryExpression(){
		if(!startsUnaryExpression(nowReading)){
			return syntaxErrorNode("unary expression");
		}	
		if(startsArrayIndexingExpression(nowReading)){
			return parseArrayIndexingExpression();
		}
		ParseNode result=new OperatorNode(nowReading);
		
		while(nowReading.isLextant(Keyword.CLONE)||nowReading.isLextant(Punctuator.BOOL_NOT)||nowReading.isLextant(Keyword.LENGTH)){
			Token unaryToken=nowReading;
			readToken();
			ParseNode right=parseUnaryExpression();
			result=OperatorNode.withChild(unaryToken, right);
		}
		
		return result;
	}
	
	private boolean startsUnaryExpression(Token token){
		return nowReading.isLextant(Keyword.CLONE)||nowReading.isLextant(Punctuator.BOOL_NOT)||
			   nowReading.isLextant(Keyword.LENGTH)||startsArrayIndexingExpression(token);
	}
	

	
	//parencastExpression -> (expr) or [expr|type] or atomicExpression or populate array creation or empty array creation
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
			Token populateToken=previouslyRead;
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
				OperatorNode exprList=new OperatorNode(populateToken);
				exprList.appendChild(expression);
				parseExpressionList(exprList);//parse starts from the first , or ]
				expect(Punctuator.CLOSE_BRACKET);
				return exprList;
			}
		}
		else if(startsLambda(nowReading)){
			return parseLambda();
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
			   startsNewArrayExpression(token)||startsLambda(token);
	}
	
	//expressionList 
	private void parseExpressionList(ParseNode parent){
		while(startsExpression(nowReading)||startsExpressionSeparator(nowReading)){
			parseExpressionSeparator(parent);
			ParseNode child=parseExpression();
			parent.appendChild(child);
		}
	}
	
	private void parseExpressionSeparator(ParseNode parent){
		if(!startsExpressionSeparator(nowReading)&&!nowReading.isLextant(Punctuator.CLOSE_BRACKET)&&!nowReading.isLextant((Punctuator.CLOSE_PARENTHESE))){
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
			return syntaxErrorNode("empty array creation(new)");
		}
		ParseNode newNode=new OperatorNode(nowReading);
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
		if(startsVoidType(nowReading)){
			readToken();
			return new VoidTypeNode(previouslyRead);
		}
		if(startsLambdaType(nowReading)){
			return parseLambdaType();
		}
		else{
			return parseArrayType();
		}
	}
	private boolean startsType(Token token){
		return startsArrayType(token)||startsPrimitiveType(token)
			   ||startsVoidType(token)||startsLambdaType(token);
	}
	// void type
	private boolean startsVoidType(Token token){
		return token.isLextant(Keyword.VOID);
	}
	// lambdaType
	private ParseNode parseLambdaType(){
		if(!startsLambdaType(nowReading)){
			return syntaxErrorNode("lambda type");
		}
		
//		expect(Punctuator.LESS);
		ParseNode lambdaNode=new LambdaTypeNode(previouslyRead);
		ParseNode left=parseType();
		lambdaNode.appendChild(left);
		
		if(!nowReading.isLextant(Punctuator.GREATER)){
			ParseNode type1=parseType();
			lambdaNode.appendChild(type1);
			parseTypeList(lambdaNode);
		}
		expect(Punctuator.GREATER);
		expect(Punctuator.ARROW);
		
		ParseNode resultType=parseType();
		lambdaNode.appendChild(resultType);
		
		return lambdaNode;
	}
	private boolean startsLambdaType(Token token){
		return token.isLextant(Punctuator.LESS);
	}
	// typeList
	private void parseTypeList(ParseNode parent){
		while(startsType(nowReading)||startsTypeSeparator(nowReading)){
			parseTypeSeparator(parent);
			ParseNode child=parseType();
			parent.appendChild(child);
		}
	}
	private void parseTypeSeparator(ParseNode parent){
		if(!startsTypeSeparator(nowReading)&&!nowReading.isLextant(Punctuator.GREATER)){
			ParseNode child=syntaxErrorNode("type list separator");
			parent.appendChild(child);
			return;
		}
		else if(nowReading.isLextant(Punctuator.SEPARATOR))
			readToken();
	}
	private boolean startsTypeSeparator(Token token){
		return token.isLextant(Punctuator.SEPARATOR);
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


package parseTree.nodeTypes;

import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import lexicalAnalyzer.Keyword;
import lexicalAnalyzer.Lextant;
import tokens.LextantToken;
import tokens.Token;

public class AssignStatementNode extends ParseNode{

	public AssignStatementNode(Token token) {
		super(token);
	}

	public AssignStatementNode(ParseNode node) {
		super(node);
	}
}

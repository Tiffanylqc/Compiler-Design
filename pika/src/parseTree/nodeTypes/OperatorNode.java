package parseTree.nodeTypes;

import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import semanticAnalyzer.signatures.FunctionSignature;
import lexicalAnalyzer.Lextant;
import tokens.LextantToken;
import tokens.Token;

public class OperatorNode extends ParseNode {
	private FunctionSignature signature = FunctionSignature.nullInstance();
	public OperatorNode(Token token) {
		super(token);
		assert(token instanceof LextantToken);
	}

	public OperatorNode(ParseNode node) {
		super(node);
	}
	
	public final FunctionSignature getSignature() {
		return signature;
	}
	public final void setSignature(FunctionSignature signature) {
		this.signature = signature;
	}
	////////////////////////////////////////////////////////////
	// attributes
	
	public Lextant getOperator() {
		return lextantToken().getLextant();
	}
	public LextantToken lextantToken() {
		return (LextantToken)token;
	}	
	
	////////////////////////////////////////////////////////////
	// convenience factory
	
	public static OperatorNode withChildren(Token token, ParseNode left, ParseNode right) {
		OperatorNode node = new OperatorNode(token);
		node.appendChild(left);
		node.appendChild(right);
		return node;
	}
	
	public static OperatorNode withChildren(Token token, ParseNode expr1, ParseNode expr2, ParseNode expr3){
		OperatorNode node = new OperatorNode(token);
		node.appendChild(expr1);
		node.appendChild(expr2);
		node.appendChild(expr3);
		return node;
	}
	
	public static OperatorNode withChild(Token token,ParseNode right) {
		OperatorNode node = new OperatorNode(token);
		node.appendChild(right);
		return node;
	}
	
	///////////////////////////////////////////////////////////
	// boilerplate for visitors
			
	public void accept(ParseNodeVisitor visitor) {
		visitor.visitEnter(this);
		visitChildren(visitor);
		visitor.visitLeave(this);
	}
}

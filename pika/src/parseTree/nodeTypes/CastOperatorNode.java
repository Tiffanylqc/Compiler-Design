package parseTree.nodeTypes;

import parseTree.ParseNode;
import parseTree.ParseNodeVisitor;
import semanticAnalyzer.signatures.FunctionSignature;
import tokens.Token;

public class CastOperatorNode extends ParseNode {
	private FunctionSignature signature = FunctionSignature.nullInstance();
	public CastOperatorNode(Token token) {
		super(token);//if correct, token shoule be bar
//		assert(token instanceof LextantToken);
	}

	public CastOperatorNode(ParseNode node) {
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
	
	public ParseNode getExpression(){
		return super.child(0);
	}
	public ParseNode getCastType(){
		return super.child(1);
	}
	
	////////////////////////////////////////////////////////////
	// convenience factory
	
	public static CastOperatorNode withChildren(Token token, ParseNode expression, ParseNode type) {
		CastOperatorNode node = new CastOperatorNode(token);
		node.appendChild(expression);
		node.appendChild(type);
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

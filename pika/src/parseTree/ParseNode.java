package parseTree;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import lexicalAnalyzer.Punctuator;
import parseTree.nodeTypes.CallStatementNode;
import parseTree.nodeTypes.DeclarationNode;
import parseTree.nodeTypes.LambdaParamTypeNode;
import parseTree.nodeTypes.LambdaTypeNode;
import parseTree.nodeTypes.OperatorNode;
import parseTree.nodeTypes.ReturnStatementNode;
import semanticAnalyzer.types.LambdaType;
import semanticAnalyzer.types.PrimitiveType;
import semanticAnalyzer.types.Type;
import semanticAnalyzer.types.VoidType;
import semanticAnalyzer.SemanticAnalysisVisitor;
import symbolTable.Binding;
import symbolTable.Scope;
import symbolTable.SymbolTable;
import tokens.Token;

public class ParseNode {
	public static final ParseNode NO_PARENT = null;
	
	List<ParseNode>	children;
	ParseNode parent;

	protected Token token;
	Type type;					// used for expressions
	private Scope scope;		// the scope created by this node, if any.
	private boolean mutable=true;
	
	public ParseNode(Token token) {
		this.token = token;
		this.type = PrimitiveType.NO_TYPE;
		this.scope = null;
		this.parent = NO_PARENT;
		initChildren();
	}
	// "detached" copy constructor.  Copies all info except tree info (parent and children)
	public ParseNode(ParseNode node) {
		this.token = node.token;
		this.type = node.type;
		this.scope = node.scope;
		this.mutable=node.mutable;
	}
	public Token getToken() {
		return token;
	}
	
	
////////////////////////////////////////////////////////////////////////////////////
// attributes
	private boolean isVoidValid(){
		if(this instanceof ReturnStatementNode || this.getParent() instanceof CallStatementNode)
			return true;
		else if(this.getParent() instanceof LambdaParamTypeNode||this.getParent() instanceof LambdaTypeNode){
			int numOfParentChild=this.getParent().nChildren();
			if(this.getParent().child(numOfParentChild-1).equals(this))
				return true;
			else{
				return false;
			}
		}
		return false;
	}
	public void setType(Type type) {
		if(type instanceof VoidType){
			if(isVoidValid()){
				this.type = type;
			}
			else{
				this.type=PrimitiveType.ERROR;
				SemanticAnalysisVisitor.typeCheckError(this,Arrays.asList(type));
			}
		}
		else
			this.type=type;
	}
	public Type getType() {
		return type;
	}
	public void setMutable(boolean mutable){
		this.mutable=mutable;
		
	}
	public boolean getMutable(){
		return this.mutable;
	}
	
////////////////////////////////////////////////////////////////////////////////////
// scopes and bindings 
	public Scope getScope() {
		return scope;
	}
	public void setScope(Scope scope) {
		this.scope = scope;
	}
	public boolean hasScope() {
		return scope != null;
	}
	public Scope getLocalScope() {
		for(ParseNode current : pathToRoot()) {
			if(current.hasScope()) {
				return current.getScope();
			}
		}
		return Scope.nullInstance();
	}
	public boolean containsBindingOf(String identifier) {
		if(!hasScope()) {
			return false;
		}
		SymbolTable symbolTable = scope.getSymbolTable();
		return symbolTable.containsKey(identifier);
	}
	public Binding bindingOf(String identifier) {
		if(!hasScope()) {
			return Binding.nullInstance();
		}
		SymbolTable symbolTable = scope.getSymbolTable();
		return symbolTable.lookup(identifier);
	}
	
////////////////////////////////////////////////////////////////////////////////////
// dealing with children and parent
//
// note: there is no provision as of yet for removal of children.  Be sure to update
// the removed child's parent pointer if you do implement it.
	
	public ParseNode getParent() {
		return parent;
	}
	public void setParent(ParseNode parent) {
		this.parent = parent;
	}
	public List<ParseNode> getChildren() {
		return children;
	}
	public ParseNode child(int i) {
		return children.get(i);
	}
	public void initChildren() {
		children = new ArrayList<ParseNode>();
	}
	// adds a new child to this node (as first child) and sets its parent link.
	public void insertChild(ParseNode childNode) {
		int index;
		if(childNode instanceof DeclarationNode && childNode.child(1) instanceof OperatorNode && childNode.child(1).getToken().isLextant(Punctuator.LAMBDA)){
			for(index=0;index<nChildren();index++){
				if(child(index) instanceof DeclarationNode)
					continue;
				else 
					break;
			}
			children.add(index,childNode);
			childNode.setParent(this);
		}
		else{
			for(index=0;index<nChildren();index++){
				if(child(index) instanceof DeclarationNode && !(child(index).child(1) instanceof OperatorNode && child(index).child(1).getToken().isLextant(Punctuator.LAMBDA)))
					continue;
				else 
					break;
			}
			children.add(index,childNode);
			childNode.setParent(this);
		}
//		children.add(0, child);
//		children.add(index,childNode);
//		childNode.setParent(this);
	}
	// adds a new child to this node (as last child) and sets its parent link.
	public void appendChild(ParseNode child) {
		children.add(child);
		child.setParent(this);
	}
	// do not do this in the middle of a visit; the children list traversal may be zapped if you do.
	// (throws a ConcurrentModificationException.)
	public void replaceChild(ParseNode oldChild, ParseNode newChild) {
		for(int index = 0; index < nChildren(); index++) {
			if(child(index) == oldChild) {
				children.remove(index);
				children.add(index, newChild);
				newChild.setParent(this);
				break;
			}
		}	
	}
	public int nChildren() {
		return children.size();
	}
	
////////////////////////////////////////////////////////////////////////////////////
//Iterable<ParseNode> pathToRoot

	public Iterable<ParseNode> pathToRoot() {
		return new PathToRootIterable(this);
	}
	
////////////////////////////////////////////////////////////////////////////////////
// toString() 

	public String toString() {
		return ParseTreePrinter.print(this);
	}

	
////////////////////////////////////////////////////////////////////////////////////
// for visitors
			
	public void accept(ParseNodeVisitor visitor) {
		visitor.visitEnter(this);
		visitChildren(visitor);
		visitor.visitLeave(this);
	}
	protected void visitChildren(ParseNodeVisitor visitor) {
		for(ParseNode child : children) {
			child.accept(visitor);
		}
	}

}

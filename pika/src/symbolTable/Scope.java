package symbolTable;

import inputHandler.TextLocation;
import logging.PikaLogger;
import parseTree.nodeTypes.IdentifierNode;
import semanticAnalyzer.types.PrimitiveType;
import semanticAnalyzer.types.Type;
import tokens.Token;

public class Scope {
	private Scope baseScope;
	private MemoryAllocator allocator;
	private SymbolTable symbolTable;
	private int ParamSize;
	private static int globalSequenceNum=0;
//////////////////////////////////////////////////////////////////////
// factories

	public static Scope createProgramScope() {
		return new Scope(programScopeAllocator(), nullInstance());
	}
	public Scope createSubscope() {
		return new Scope(allocator, this);
	}
	
	private static MemoryAllocator programScopeAllocator() {
		return new PositiveMemoryAllocator(
				MemoryAccessMethod.DIRECT_ACCESS_BASE, 
				MemoryLocation.GLOBAL_VARIABLE_BLOCK);
	}
	
	public static Scope createParameterScope(){
		return new Scope(parameterScopeAllocator(), nullInstance());
	}
	private static MemoryAllocator parameterScopeAllocator(){
		return new ParameterMemoryAllocator(
				MemoryAccessMethod.INDIRECT_ACCESS_BASE,
				MemoryLocation.FRAME_POINTER);
	}
	
	public static Scope createProcedureScope(){
		return new Scope(procedureScopeAllocator(),nullInstance());
	}
	public static MemoryAllocator procedureScopeAllocator(){
		return new ProcedureMemoryAllocator(
				MemoryAccessMethod.INDIRECT_ACCESS_BASE,
				MemoryLocation.FRAME_POINTER);
				
	}
//////////////////////////////////////////////////////////////////////
// private constructor.	
	private Scope(MemoryAllocator allocator, Scope baseScope) {
		super();
		this.baseScope = (baseScope == null) ? this : baseScope;
		this.symbolTable = new SymbolTable();
		
		this.allocator = allocator;
//		allocator.saveState();//TODO:comment this line
		this.ParamSize=0;
	}
	private Scope(MemoryAllocator allocator, Scope baseScope, SymbolTable symbolTable, int ParamSize) {
		super();
		this.baseScope = (baseScope == null) ? this : baseScope;
		this.symbolTable = symbolTable;
		
		this.allocator = allocator;
		this.ParamSize=ParamSize;
	}
	public void enter(){
		allocator.saveState();
	}
	
///////////////////////////////////////////////////////////////////////
//  basic queries	
	public Scope getBaseScope() {
		return baseScope;
	}
	public MemoryAllocator getAllocationStrategy() {
		return allocator;
	}
	public SymbolTable getSymbolTable() {
		return symbolTable;
	}
	
///////////////////////////////////////////////////////////////////////
//memory allocation
	// must call leave() when destroying/leaving a scope.
	public void leave() {
		allocator.restoreState();
//		if(allocator instanceof ProcedureMemoryAllocator)
//			System.out.println(this.toString());
	}
	public int getAllocatedSize() {
		return allocator.getMaxAllocatedSize();
	}

///////////////////////////////////////////////////////////////////////
//bindings
	public Binding createBinding(IdentifierNode identifierNode, Type type, boolean mutable) {
		Token token = identifierNode.getToken();
		symbolTable.errorIfAlreadyDefined(token,type);

		String lexeme = token.getLexeme();
		Binding binding;
		if(identifierNode.getStatic()){
//			System.out.println(identifierNode.getParent().child(1).getToken().getLexeme());
//			System.out.println(symbolTable);
			Scope globalScope=identifierNode.getGlobalScope();
			Binding globalBinding=globalScope.allocateNewBinding(type, token.getLocation(), "#"+lexeme+globalSequenceNum,mutable,identifierNode.getStatic());
			Binding isSetBinding=allocateNewBinding(type, token.getLocation(), "#"+lexeme, mutable, identifierNode.getStatic());
			symbolTable.install("#"+lexeme, isSetBinding);
			globalSequenceNum++;
			binding = allocateStaticBinding(globalBinding.getMemoryLocation(),type, token.getLocation(), lexeme,mutable,identifierNode.getStatic());	
		}
		else{
			binding = allocateNewBinding(type, token.getLocation(), lexeme,mutable,identifierNode.getStatic());	
		}
		symbolTable.install(lexeme, binding);

		return binding;
	}
	public Binding createFuncBinding(IdentifierNode identifierNode, Type type, boolean mutable, String funcStartLabel) {
		Token token = identifierNode.getToken();
		symbolTable.errorIfAlreadyDefined(token,type);

		String lexeme = token.getLexeme();
		
		Binding binding;
		if(identifierNode.getStatic()){
			Scope globalScope=identifierNode.getGlobalScope();
			Binding globalBinding=globalScope.allocateNewBinding(type, token.getLocation(), "#"+lexeme+globalSequenceNum,mutable,identifierNode.getStatic());
			Binding isSetBinding=allocateNewFuncBinding(type, token.getLocation(), "#"+lexeme, mutable,funcStartLabel, identifierNode.getStatic());
			symbolTable.install("#"+lexeme, isSetBinding);
			globalSequenceNum++;
			binding = allocateFuncStaticBinding(globalBinding.getMemoryLocation(),type, token.getLocation(), lexeme,mutable,funcStartLabel,identifierNode.getStatic());	
		}
		else{
			binding = allocateNewFuncBinding(type, token.getLocation(), lexeme,mutable,funcStartLabel,identifierNode.getStatic());	
		}
		
		symbolTable.install(lexeme, binding);

		return binding;
	}
	private Binding allocateStaticBinding(MemoryLocation globalMemoryLocation,Type type,TextLocation textLocation, String lexeme,boolean mutable,boolean isStatic) {
//		MemoryLocation memoryLocation = allocator.allocate(0);
		return new Binding(type, textLocation, globalMemoryLocation, lexeme, mutable,isStatic);
	}
	private Binding allocateFuncStaticBinding(MemoryLocation globalMemoryLocation,Type type,TextLocation textLocation, String lexeme,boolean mutable,String funcStartLabel,boolean isStatic) {
//		MemoryLocation memoryLocation = allocator.allocate(0);
		return new Binding(type, textLocation, globalMemoryLocation, lexeme, mutable,funcStartLabel,isStatic);
	}
	private Binding allocateNewBinding(Type type, TextLocation textLocation, String lexeme,boolean mutable,boolean isStatic) {
		MemoryLocation memoryLocation = allocator.allocate(type.getSize());
		return new Binding(type, textLocation, memoryLocation, lexeme, mutable,isStatic);
	}
	private Binding allocateNewFuncBinding(Type type, TextLocation textLocation, String lexeme,boolean mutable, String funcStartLabel,boolean isStatic) {
		MemoryLocation memoryLocation = allocator.allocate(type.getSize());
		return new Binding(type, textLocation, memoryLocation, lexeme, mutable,funcStartLabel,isStatic);
	}
	
///////////////////////////////////////////////////////////////////////
//toString
	public String toString() {
		String result = "scope: ";
		result += " hash "+ hashCode() + "\n";
		result += symbolTable;
		return result;
	}

////////////////////////////////////////////////////////////////////////////////////
//Null Scope object - lazy singleton (Lazy Holder) implementation pattern
	public static Scope nullInstance() {
		return NullScope.instance;
	}
	private static class NullScope extends Scope {
		private static NullScope instance = new NullScope();

		private NullScope() {
			super(	new PositiveMemoryAllocator(MemoryAccessMethod.NULL_ACCESS, "", 0),
					null);
		}
		public String toString() {
			return "scope: the-null-scope";
		}
		@Override
		public Binding createBinding(IdentifierNode identifierNode, Type type, boolean mutable) {
			unscopedIdentifierError(identifierNode.getToken());
			return super.createBinding(identifierNode, type, true);
		}
		// subscopes of null scope need their own strategy.  Assumes global block is static.
		public Scope createSubscope() {
			return new Scope(programScopeAllocator(), this);
		}
	}


///////////////////////////////////////////////////////////////////////
//error reporting
	private static void unscopedIdentifierError(Token token) {
		PikaLogger log = PikaLogger.getLogger("compiler.scope");
		log.severe("variable " + token.getLexeme() + 
				" used outside of any scope at " + token.getLocation());
	}

}

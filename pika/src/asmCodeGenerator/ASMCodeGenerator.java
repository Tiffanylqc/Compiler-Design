package asmCodeGenerator;

import java.util.HashMap;
import java.util.Map;

import asmCodeGenerator.codeStorage.ASMCodeFragment;
import asmCodeGenerator.codeStorage.ASMOpcode;
import asmCodeGenerator.runtime.MemoryManager;
import asmCodeGenerator.runtime.Record;
import asmCodeGenerator.runtime.RunTime;
import lexicalAnalyzer.Keyword;
import lexicalAnalyzer.Lextant;
import lexicalAnalyzer.Punctuator;
import parseTree.*;
import parseTree.nodeTypes.ArrayTypeNode;
import parseTree.nodeTypes.AssignStatementNode;
import parseTree.nodeTypes.OperatorNode;
import parseTree.nodeTypes.BooleanConstantNode;
import parseTree.nodeTypes.BreakNode;
import parseTree.nodeTypes.CallStatementNode;
import parseTree.nodeTypes.CastOperatorNode;
import parseTree.nodeTypes.CharacterConstantNode;
import parseTree.nodeTypes.ContinueNode;
import parseTree.nodeTypes.BlockStatementNode;
import parseTree.nodeTypes.DeclarationNode;
import parseTree.nodeTypes.ExpressionListNode;
import parseTree.nodeTypes.IdentifierNode;
import parseTree.nodeTypes.IfStatementNode;
import parseTree.nodeTypes.IntegerConstantNode;
import parseTree.nodeTypes.LambdaParamTypeNode;
import parseTree.nodeTypes.FloatingConstantNode;
import parseTree.nodeTypes.ForElemStatementNode;
import parseTree.nodeTypes.ForIndexStatementNode;
import parseTree.nodeTypes.FunctionBodyNode;
import parseTree.nodeTypes.FunctionDefinitionNode;
import parseTree.nodeTypes.NewlineNode;
import parseTree.nodeTypes.PrintStatementNode;
import parseTree.nodeTypes.ProgramNode;
import parseTree.nodeTypes.ReleaseStatementNode;
import parseTree.nodeTypes.ReturnStatementNode;
import parseTree.nodeTypes.SpaceNode;
import parseTree.nodeTypes.StringConstantNode;
import parseTree.nodeTypes.TabNode;
import parseTree.nodeTypes.WhileStatementNode;
import parseTree.nodeTypes.PrimitiveTypeNode;
import semanticAnalyzer.types.Array;
import semanticAnalyzer.types.LambdaType;
import semanticAnalyzer.types.PrimitiveType;
import semanticAnalyzer.types.Type;
import semanticAnalyzer.types.VoidType;
import symbolTable.Binding;
import symbolTable.ProcedureMemoryAllocator;
import symbolTable.Scope;
import static asmCodeGenerator.codeStorage.ASMCodeFragment.CodeType.*;
import static asmCodeGenerator.codeStorage.ASMOpcode.*;
import static asmCodeGenerator.Macros.*;

// do not call the code generator if any errors have occurred during analysis.
public class ASMCodeGenerator {
	ParseNode root;

	public static ASMCodeFragment generate(ParseNode syntaxTree) {
		ASMCodeGenerator codeGenerator = new ASMCodeGenerator(syntaxTree);
		return codeGenerator.makeASM();
	}
	public ASMCodeGenerator(ParseNode root) {
		super();
		this.root = root;
	}
	
	public ASMCodeFragment makeASM() {
		ASMCodeFragment code = new ASMCodeFragment(GENERATES_VOID);
		
		code.append( MemoryManager.codeForInitialization());///////////add
		code.append( RunTime.getEnvironment() );
		code.append( globalVariableBlockASM() );
		code.append( programASM() );
		code.append( MemoryManager.codeForAfterApplication() );///////////uncomment
		
		return code;
	}
	private ASMCodeFragment globalVariableBlockASM() {
		assert root.hasScope();
		Scope scope = root.getScope();
		int globalBlockSize = scope.getAllocatedSize();
		
		ASMCodeFragment code = new ASMCodeFragment(GENERATES_VOID);
		code.add(DLabel, RunTime.GLOBAL_MEMORY_BLOCK);
		code.add(DataZ, globalBlockSize);
		return code;
	}
	private ASMCodeFragment programASM() {
		ASMCodeFragment code = new ASMCodeFragment(GENERATES_VOID);
		
		code.add(    Label, RunTime.MAIN_PROGRAM_LABEL);
		
		code.add(Memtop);
		Macros.storeITo(code, RunTime.STACK_POINTER);
		code.add(Memtop);
		Macros.storeITo(code, RunTime.FRAME_POINTER);
		
		code.append( programCode());
		code.add(    Halt );
		
		return code;
	}
	private ASMCodeFragment programCode() {
		CodeVisitor visitor = new CodeVisitor();
		root.accept(visitor);
		return visitor.removeRootCode(root);
	}


	protected class CodeVisitor extends ParseNodeVisitor.Default {
		private Map<ParseNode, ASMCodeFragment> codeMap;
		ASMCodeFragment code;
		
		public CodeVisitor() {
			codeMap = new HashMap<ParseNode, ASMCodeFragment>();
		}


		////////////////////////////////////////////////////////////////////
        // Make the field "code" refer to a new fragment of different sorts.
		private void newAddressCode(ParseNode node) {
			code = new ASMCodeFragment(GENERATES_ADDRESS);
			codeMap.put(node, code);
		}
		private void newValueCode(ParseNode node) {
			code = new ASMCodeFragment(GENERATES_VALUE);
			codeMap.put(node, code);
		}
		private void newVoidCode(ParseNode node) {
			code = new ASMCodeFragment(GENERATES_VOID);
			codeMap.put(node, code);
		}

	    ////////////////////////////////////////////////////////////////////
        // Get code from the map.
		private ASMCodeFragment getAndRemoveCode(ParseNode node) {
			ASMCodeFragment result = codeMap.get(node);
			codeMap.remove(result);
			return result;
		}
	    public  ASMCodeFragment removeRootCode(ParseNode tree) {
			return getAndRemoveCode(tree);
		}		
		ASMCodeFragment removeValueCode(ParseNode node) {
			ASMCodeFragment frag = getAndRemoveCode(node);
			makeFragmentValueCode(frag, node);
			return frag;
		}		
		private ASMCodeFragment removeAddressCode(ParseNode node) {
			ASMCodeFragment frag = getAndRemoveCode(node);
			assert frag.isAddress();
			return frag;
		}		
		ASMCodeFragment removeVoidCode(ParseNode node) {
			ASMCodeFragment frag = getAndRemoveCode(node);
			assert frag.isVoid();
			return frag;
		}
		
	    ////////////////////////////////////////////////////////////////////
        // convert code to value-generating code.
		private void makeFragmentValueCode(ASMCodeFragment code, ParseNode node) {
			assert !code.isVoid();
			
			if(code.isAddress()) {
				turnAddressIntoValue(code, node);
			}	
		}
		private void turnAddressIntoValue(ASMCodeFragment code, ParseNode node) {
			if(node.getType() == PrimitiveType.INTEGER) {
				code.add(LoadI);
			}
			else if(node.getType() == PrimitiveType.FLOATING) {
				code.add(LoadF);
			}
			else if(node.getType() == PrimitiveType.BOOLEAN) {
				code.add(LoadC);
			}	
			else if(node.getType()==PrimitiveType.CHARACTER){
				code.add(LoadC);
			}
			else if(node.getType() == PrimitiveType.STRING) {
				code.add(LoadI);
//				code.add(PStack);
			}
			else if(node.getType()==PrimitiveType.RATIONAL){
				code.add(Nop);
				Labeller labeller = new Labeller("rational-load");
				String baseAddrLabel = labeller.newLabel("baseAddr");
				declareI(code,baseAddrLabel);
				storeITo(code,baseAddrLabel);
				loadIFrom(code,baseAddrLabel);	// [... a]
				code.add(LoadI);				// [... a]-> [... IMEM(a..a+3)(numerator)]
				loadIFrom(code,baseAddrLabel);	// [... numerator a]
				code.add(PushI,4);				// [... numerator a 4]
				code.add(Add);					// [... numerator a+4]
				code.add(LoadI);				// [... numerator a+4]-> [... numerator IMEM(a+4..a+7)(denominator)]
				
				//check the denominator != 0
				code.add(Duplicate);
				code.add(JumpFalse,RunTime.OVER_ZERO_DENOMINATOR_RUNTIME_ERROR);
			}
			else if(node.getType() instanceof Array){
				code.add(LoadI);
			}
			else if(node.getType() instanceof LambdaType){
				code.add(LoadI);
			}
			else {
				assert false : "node " + node;
			}
			code.markAsValue();
		}
		
	    ////////////////////////////////////////////////////////////////////
        // ensures all types of ParseNode in given AST have at least a visitLeave	
		public void visitLeave(ParseNode node) {
			assert false : "node " + node + " not handled in ASMCodeGenerator";
		}
		
		
		
		///////////////////////////////////////////////////////////////////////////
		// constructs larger than statements
		public void visitLeave(ProgramNode node) {
			newVoidCode(node);
			for(ParseNode child : node.getChildren()) {
				ASMCodeFragment childCode = removeVoidCode(child);
				code.append(childCode);
			}
		}
		public void visitLeave(BlockStatementNode node) {
			newVoidCode(node);
			for(ParseNode child : node.getChildren()) {
				ASMCodeFragment childCode = removeVoidCode(child);
				code.append(childCode);
			}
		}

		///////////////////////////////////////////////////////////////////////////
		// statements and declarations

		public void visitLeave(PrintStatementNode node) {
			newVoidCode(node);
			new PrintStatementGenerator(code, this).generate(node);	
		}
		public void visit(NewlineNode node) {
			newVoidCode(node);
			code.add(PushD, RunTime.NEWLINE_PRINT_FORMAT);
			code.add(Printf);
		}
		public void visit(SpaceNode node) {
			newVoidCode(node);
			code.add(PushD, RunTime.SPACE_PRINT_FORMAT);
			code.add(Printf);
		}
		public void visit(TabNode node) {
			newVoidCode(node);
			code.add(PushD, RunTime.TAB_PRINT_FORMAT);
			code.add(Printf);
		}
		
		public void visitLeave(AssignStatementNode node) {
			newVoidCode(node);
			ASMCodeFragment lvalue = removeAddressCode(node.child(0));	
			ASMCodeFragment rvalue = removeValueCode(node.child(1));
			Type type = node.getType();

			if(type==PrimitiveType.RATIONAL){
				Labeller labeller = new Labeller("rational-storage");
				String baseAddrLabel = labeller.newLabel("baseAddr");
				//store numerator from lvalue to lvalue+4
				//store denominator from lvalue+4 to lvalue+8
				code.append(rvalue);//[...numerator denominator]
				code.append(lvalue);//[...numerator denominator &lvalue]
				
				declareI(code,baseAddrLabel);
				storeITo(code,baseAddrLabel);
				loadIFrom(code,baseAddrLabel);//[...numerator denominator &lvalue]
				
				code.add(PushI,4);//[...numerator denominator &lvalue 4]
				code.add(Add);//[...numerator denominator &lvalue+4]
				
				code.add(Exchange);//[...numerator &lvalue+4 denominator]
				code.add(StoreI);//[...numerator]
				loadIFrom(code,baseAddrLabel);//[...numerator &lvalue]

				code.add(Exchange);//[... &lvalue numerator]
				code.add(StoreI);//[...]
			}
			else{
				code.append(lvalue);
				code.append(rvalue);
			
				code.add(opcodeForStore(type));
			}
		}
		
		public void visitLeave(FunctionDefinitionNode node){
			newVoidCode(node);
			ASMCodeFragment lvalue = removeAddressCode(node.child(0));	
			ASMCodeFragment rvalue = removeValueCode(node.child(1));
			code.append(lvalue);
			code.append(rvalue);

			code.add(StoreI);
		}
		
		public void visitLeave(DeclarationNode node) {
			newVoidCode(node);
			ASMCodeFragment lvalue = removeAddressCode(node.child(0));	
			ASMCodeFragment rvalue = removeValueCode(node.child(1));
			
//			Macros.loadIFrom(code, RunTime.FRAME_POINTER);
//			code.add(PStack);
//			code.add(Pop);
			
			Type type = node.getType();
			if(type==PrimitiveType.RATIONAL){
				Labeller labeller = new Labeller("rational-storage");
				String baseAddrLabel = labeller.newLabel("baseAddr");
				//store numerator from lvalue to lvalue+4
				//store denominator from lvalue+4 to lvalue+8
				code.append(rvalue);//[...numerator denominator]
				code.append(lvalue);//[...numerator denominator &lvalue]
				declareI(code,baseAddrLabel);
				storeITo(code,baseAddrLabel);
				loadIFrom(code,baseAddrLabel);//[...numerator denominator &lvalue]
				
				code.add(PushI,4);//[...numerator denominator &lvalue 4]
				code.add(Add);//[...numerator denominator &lvalue+4]
				code.add(Exchange);//[...numerator &lvalue+4 denominator]
				code.add(StoreI);//[...numerator]
				loadIFrom(code,baseAddrLabel);//[...numerator &lvalue]
				code.add(Exchange);//[... &lvalue numerator]
				code.add(StoreI);//[...]
			}
			else{
				
				code.append(lvalue);
				code.append(rvalue);
				
				code.add(opcodeForStore(type));
			}
		}
		
		private ASMOpcode opcodeForStore(Type type) {
			if(type == PrimitiveType.INTEGER) {
				return StoreI;
			}
			if(type == PrimitiveType.FLOATING) {
				return StoreF;
			}
			if(type == PrimitiveType.BOOLEAN) {
				return StoreC;
			}
			if(type==PrimitiveType.CHARACTER){
				return StoreC;
			}
			if(type==PrimitiveType.STRING){
				return StoreI;
			}
			if(type==PrimitiveType.RATIONAL){
				return Nop;
			}
			if(type instanceof Array){
				return StoreI;
			}
			if(type instanceof LambdaType){
				return StoreI;
			}

			assert false: "Type " + type + " unimplemented in opcodeForStore()";
			return null;
		}

		///////////////////////////////////////////////////////////////////////////
		// for index 
		public void visitEnter(ForIndexStatementNode node){
			Labeller labeller = new Labeller("for-index-enter");
			String breakLabel = labeller.newLabel("break-target");
			String continueLabel = labeller.newLabel("continue-target");
			((ForIndexStatementNode) node).setBreakTarget(breakLabel);
			((ForIndexStatementNode) node).setContinueTarget(continueLabel);
		}
		public void visitLeave(ForIndexStatementNode node){
			newVoidCode(node);
			ASMCodeFragment index = removeAddressCode(node.child(0));
			ASMCodeFragment record = removeValueCode(node.child(1));
			ASMCodeFragment blocStmt = removeVoidCode(node.child(2));
			FullCodeGenerator generator = new ForIndexCodeGenerator();
			ASMCodeFragment fragment = generator.generate(node,index, record, blocStmt);
			code.append(fragment);
		}
		
		///////////////////////////////////////////////////////////////////////////
		// for elem
		public void visitEnter(ForElemStatementNode node){
			Labeller labeller = new Labeller("for-elem-enter");
			String breakLabel = labeller.newLabel("break-target");
			String continueLabel = labeller.newLabel("continue-target");
			((ForElemStatementNode) node).setBreakTarget(breakLabel);
			((ForElemStatementNode) node).setContinueTarget(continueLabel);
		}
		public void visitLeave(ForElemStatementNode node){
			newVoidCode(node);
			ASMCodeFragment index = removeAddressCode(node.child(0));
			ASMCodeFragment record = removeValueCode(node.child(1));
			ASMCodeFragment blocStmt = removeVoidCode(node.child(2));
			FullCodeGenerator generator = new ForElemCodeGenerator();
			ASMCodeFragment fragment = generator.generate(node,index, record, blocStmt);
			code.append(fragment);
		}
		
		///////////////////////////////////////////////////////////////////////////
		// FunctionInvocation in ExpressionListNode		
		public void visitLeave(ExpressionListNode node){
			Type returnType=((LambdaType)node.getParent().child(0).getType()).getFunctionSignature().resultType();
			if(returnType instanceof VoidType)
				newVoidCode(node);
			else
				newValueCode(node);
			
			for(ParseNode child:node.getChildren()){
				ASMCodeFragment paramCode=removeValueCode(child);
				code.append(paramCode);
				int size=child.getType().getSize();
				code.add(PushI,(-1)*size);
				Macros.addITo(code, RunTime.STACK_POINTER);
				if(size==1){
					Macros.storeCToIndirect(code, RunTime.STACK_POINTER);
				}
				else if(size==4){
					Macros.storeIToIndirect(code, RunTime.STACK_POINTER);
				}
				else if(size==8 && (child.getType() == PrimitiveType.FLOATING))
					Macros.storeFToIndirect(code, RunTime.STACK_POINTER);
				else{
					
					Macros.loadIFrom(code, RunTime.STACK_POINTER);
					code.add(PushI,4);
					code.add(Add);
					code.add(Exchange);
					code.add(StoreI);
					Macros.storeIToIndirect(code, RunTime.STACK_POINTER);
				}
			}

			//CALL the function
			ASMCodeFragment funcAddr=removeValueCode(node.getParent().child(0));
			code.append(funcAddr);
			RunTime.callFunction(code, returnType);
//			code.add(CallV);
//			
//			
//			//return from subroutine
//			
//			if(returnType instanceof VoidType){
//				;//do nothing
//			}
//			else{
//				int returnSize=returnType.getSize();
//				if(returnSize==1){
//					Macros.loadIFrom(code, RunTime.STACK_POINTER);
//					code.add(LoadC);
//				}
//				else if(returnSize==4){
//					Macros.loadIFrom(code, RunTime.STACK_POINTER);
//					code.add(LoadI);
//				}
//					
//				else if(returnSize==8 && returnType==PrimitiveType.FLOATING){
//					Macros.loadIFrom(code,RunTime.STACK_POINTER);
//					code.add(LoadF);
//				}
//				else{
//					Macros.loadIFrom(code, RunTime.STACK_POINTER);
//					code.add(PushI,4);
//					code.add(Add);
//					code.add(LoadI);
//					Macros.loadIFrom(code, RunTime.STACK_POINTER);
//					code.add(LoadI);
//				}
//					
//				code.add(PushI,returnSize);
//				Macros.addITo(code, RunTime.STACK_POINTER);
//			}
		}
		
		public void visitLeave(CallStatementNode node){
			newVoidCode(node);
			
			Type returnType=((LambdaType)node.child(0).child(0).getType()).getFunctionSignature().resultType();
			if(returnType instanceof VoidType){	
				ASMCodeFragment funcCode=removeVoidCode(node.child(0));
				code.append(funcCode);
			}
			else{
				ASMCodeFragment funcCode=removeValueCode(node.child(0));
				code.append(funcCode);
				code.add(Pop);
				if(node.child(0).getType() == PrimitiveType.RATIONAL)
					code.add(Pop);
			}
		}
		
		///////////////////////////////////////////////////////////////////////////
		// FunctionDefinition in FunctionBodyNode
		public void visitEnter(FunctionBodyNode node){
			Labeller labeller = new Labeller("function-body");
			String funcExitHandShakeLabel=labeller.newLabel("-exit-handshake");
			node.setExitHandshake(funcExitHandShakeLabel);
		}
		public void visitLeave(FunctionBodyNode node){
			newValueCode(node);
			
			Labeller labeller = new Labeller("function-body");
			String funcEndLabel=labeller.newLabel("-end");
			String funcExitHandShakeLabel=node.getExitHandshake();
			String returnAddr=labeller.newLabel("return-addr");
			Macros.declareI(code, returnAddr);
			
			String funcStartLabel;
//			if(node.getParent().getParent().child(0) instanceof IdentifierNode){
//				IdentifierNode identifier=(IdentifierNode)(node.getParent().getParent().child(0));
//				Binding binding=identifier.findVariableBinding();
//				funcStartLabel=binding.getFuncStartLabel();
//			}
//			else{
				funcStartLabel=labeller.newLabel("-anonymous-start");
//			}
			
			
			code.add(Jump,funcEndLabel);
			code.add(Label,funcStartLabel);
			
			//frame stack maintenance
			////store frame pointer and return address below current stack pointer
			Macros.loadIFrom(code, RunTime.FRAME_POINTER);//[...returnAddr FP]
//			code.add(PStack);
			Macros.storeIToSPNegOffset(code, 4);//[...returnAddr]
			Macros.storeIToSPNegOffset(code, 8);//[...]
			
			////set frame pointer equal to stack pointer
			Macros.loadIFrom(code, RunTime.STACK_POINTER);//[...SP]
			Macros.storeITo(code, RunTime.FRAME_POINTER);//[...]
			
			////subtract frame size from stack pointer
			int frameSize=node.getScope().getAllocatedSize();
			code.add(PushI,(-1)*frameSize);
			Macros.addITo(code, RunTime.STACK_POINTER);

			////
			for(ParseNode child:node.getChildren()){
				ASMCodeFragment childCode = removeVoidCode(child);
				code.append(childCode);
				
//				if(child instanceof ReturnStatementNode){
//					code.add(Jump,funcExitHandShakeLabel);
//				}
			}
			//if not jump to exit hand shake, means no return statements
			code.add(Jump, RunTime.NO_RETURN_RUNTIME_ERROR);
			
			code.add(Label,funcExitHandShakeLabel);

			//[...returnValue]
//			code.add(PStack);
			//// push return address(FP-8) on accumulator stack 
			Macros.loadIFrom(code, RunTime.FRAME_POINTER);
			code.add(PushI,8);
			code.add(Subtract);
			code.add(LoadI);//[...returnValue Mem(FP-8)]
			Macros.storeITo(code, returnAddr);
			
			////replace frame pointer with dynamic link
			Macros.loadIFrom(code, RunTime.FRAME_POINTER);
			code.add(PushI,4);
			code.add(Subtract);
			code.add(LoadI);//[...returnValue Mem(FP-4)]
			Macros.storeITo(code, RunTime.FRAME_POINTER);//[...returnValue ]
			
			int paraScopeSize=node.getParent().child(0).getScope().getAllocatedSize();
			int bodyScopeSize=node.getScope().getAllocatedSize();
			//increase stack pointer by paraScopeSize+bodyScopeSize
			code.add(PushI,paraScopeSize+bodyScopeSize);
			Macros.addITo(code, RunTime.STACK_POINTER);
			
			//decrease SP by return value size
			//[...returnValue]
			Type returnType=((LambdaType)(node.getParent().getType())).getFunctionSignature().resultType();
			if(returnType instanceof VoidType){
//				code.add(DataD,funcStartLabel);
//				code.add(Exchange);
				Macros.loadIFrom(code, returnAddr);
				code.add(Return);
			}
			else{
				int returnSize=returnType.getSize();
				//[...returnValue]
				code.add(PushI,(-1)*returnSize);
				Macros.addITo(code, RunTime.STACK_POINTER);
				if(returnSize==4)
					Macros.storeIToIndirect(code, RunTime.STACK_POINTER);
				else if(returnSize==1)
					Macros.storeCToIndirect(code, RunTime.STACK_POINTER);
				else if(returnSize==8&&returnType==PrimitiveType.FLOATING)
					Macros.storeFToIndirect(code, RunTime.STACK_POINTER);
				else{
					code.add(Exchange);
					Macros.loadIFrom(code, RunTime.STACK_POINTER);
					code.add(PushI,4);
					code.add(Add);
					code.add(Exchange);
					code.add(StoreI);
					Macros.storeIToIndirect(code, RunTime.STACK_POINTER);
				}
				Macros.loadIFrom(code, returnAddr);
				code.add(Return);
			}
			
			code.add(Label,funcEndLabel);
			
			code.add(PushD,funcStartLabel);
		}
		///////////////////////////////////////////////////////////////////////////
		// return
		public void visitLeave(ReturnStatementNode node){
			newVoidCode(node);
			if(node.nChildren()==1){
				ASMCodeFragment returnCode=removeValueCode(node.child(0));	
				code.append(returnCode);
			}
			
			for(ParseNode current:node.pathToRoot()){
				if(current instanceof FunctionBodyNode){
					code.add(Jump,((FunctionBodyNode)current).getExitHandshake());
					break;
				}
			}
		}
		
		///////////////////////////////////////////////////////////////////////////
		// expressions
		public void visitLeave(OperatorNode node) {
			Lextant operator = node.getOperator();
			if(operator == Punctuator.GREATER) {
				visitGreaterOperatorNode(node, operator);
			}
			else if(operator==Punctuator.LESS){
				visitLessOperatorNode(node, operator);
			}
			else if(operator==Punctuator.GREATER_EQUAL){
				visitGreaterEqualOperatorNode(node,operator);
			}
			else if(operator==Punctuator.LESS_EQUAL){
				visitLessEqualOperatorNode(node,operator);
			}
			else if(operator==Punctuator.EQUAL){
				visitEqualOperatorNode(node,operator);
			}
			else if(operator==Punctuator.NOT_EQUAL){
				visitNotEqualOperatorNode(node,operator);
			}
			else if(operator==Punctuator.BOOL_NOT){
				visitBoolNotOperatorNode(node,operator);
			}
			else if(operator==Keyword.NEW){
				visitNewOperatorNode(node);
			}
			else if(operator==Punctuator.ARRAY_INDEXING){
				visitArrayIndexingOperatorNode(node);
			}
			else if(operator==Keyword.CLONE){
				visitCloneOperatorNode(node);
			}
			else if(operator==Keyword.LENGTH){
				visitLengthOperatorNode(node);
			}
			else if(operator==Keyword.REVERSE){
				visitReverseOperatorNode(node);
			}
			else if(operator==Punctuator.OPEN_BRACKET){
				visitArrayPopulateCreationNode(node);
			}
			else if(operator==Punctuator.LAMBDA){
				visitLambdaOperatorNode(node);
			}
			else if(operator==Punctuator.OPEN_PARENTHESE){
				visitFunctionInvocationOperatorNode(node);
			}
			else if(operator==Punctuator.STRING_SLICE){
				visitStringSliceOperatorNode(node);
			}
			else if(operator==Keyword.ZIP){
				visitZipOperatorNode(node);
			}
			else if(operator==Keyword.FOLD){
				visitFoldOperatorNode(node);
			}
			else {
				visitNormalBinaryOperatorNode(node);
			}
		}
		
		private void visitFunctionInvocationOperatorNode(OperatorNode node){
			if(node.getType() instanceof VoidType){
				newVoidCode(node);
			}
			else{
				newValueCode(node);
			}
//			removeAddressCode(node.child(0));//throw away the address generated by identifier node
			Type returnType=node.getType();
			ASMCodeFragment exprList;
			if(returnType instanceof VoidType)
				exprList=removeVoidCode(node.child(1));
			else 
				exprList=removeValueCode(node.child(1));
			code.append(exprList);
			
		}
		
		private void visitLambdaOperatorNode(OperatorNode node){
			newValueCode(node);
			ASMCodeFragment lambdaParam=removeVoidCode(node.child(0));
			ASMCodeFragment bodyNode=removeValueCode(node.child(1));
			code.append(lambdaParam);
			code.append(bodyNode);
			
		}
		
		public void visitLeave(LambdaParamTypeNode node){
			newVoidCode(node);
//			do nothing
		}
		
		private void visitBoolNotOperatorNode(OperatorNode node, Lextant operator){
			ASMCodeFragment arg1 = removeValueCode(node.child(0));
			Labeller labeller = new Labeller("compare-boolNot");
			String startLabel = labeller.newLabel("arg1");
			String notLabel   = labeller.newLabel("not");
			String trueLabel  = labeller.newLabel("true");
			String falseLabel = labeller.newLabel("false");
			String joinLabel  = labeller.newLabel("join");
			
			newValueCode(node);
			code.add(Label, startLabel);
			code.append(arg1);//[...arg1]
			code.add(Label, notLabel);
			code.add(BNegate);//[...(NOT arg1)]
			
			code.add(JumpTrue, trueLabel);//if (NOT arg1) is true
			code.add(Jump, falseLabel);

			code.add(Label, trueLabel);
			code.add(PushI, 1);
			code.add(Jump, joinLabel);
			code.add(Label, falseLabel);
			code.add(PushI, 0);
			code.add(Jump, joinLabel);
			code.add(Label, joinLabel);
		}
		
		private void visitGreaterOperatorNode(OperatorNode node, Lextant operator) {
			ASMCodeFragment arg1 = removeValueCode(node.child(0));
			ASMCodeFragment arg2 = removeValueCode(node.child(1));
			
			Labeller labeller = new Labeller("compare-greater");
			
			String startLabel = labeller.newLabel("arg1");
			String arg2Label  = labeller.newLabel("arg2");
			String subLabel   = labeller.newLabel("sub");
			String trueLabel  = labeller.newLabel("true");
			String falseLabel = labeller.newLabel("false");
			String joinLabel  = labeller.newLabel("join");
			
//			code.add(PStack);
			if(node.child(0).getType()==PrimitiveType.FLOATING){
				newValueCode(node);
				code.add(Label, startLabel);
				code.append(arg1);//[...arg1]
				code.add(Label, arg2Label);
				code.append(arg2);//[...arg1,arg2]
				code.add(Label, subLabel);
				code.add(FSubtract);//[...arg1-arg2]
				
				code.add(JumpFPos, trueLabel);//if arg1-arg2>0
				code.add(Jump, falseLabel);
	
				code.add(Label, trueLabel);
				code.add(PushI, 1);
				code.add(Jump, joinLabel);
				code.add(Label, falseLabel);
				code.add(PushI, 0);
				code.add(Jump, joinLabel);
				code.add(Label, joinLabel);
			}
			else if(node.child(0).getType()==PrimitiveType.RATIONAL){
				String negDenominator=labeller.newLabel("neg-denominator");
				
				newValueCode(node);
				code.append(arg1);
				code.append(arg2);
				code.add(Call,RunTime.SUBTRACT_RATIONAL);
				//[...num deno]
				code.add(JumpNeg,negDenominator);
				code.add(JumpPos,trueLabel);
				code.add(Jump,falseLabel);
				code.add(Label,negDenominator);
				code.add(JumpNeg,trueLabel);
				code.add(Jump,falseLabel);
				
				code.add(Label, trueLabel);
				code.add(PushI, 1);
				code.add(Jump, joinLabel);
				code.add(Label, falseLabel);
				code.add(PushI, 0);
				code.add(Jump, joinLabel);
				code.add(Label,joinLabel);
			}
			else//if(node.child(0).getType()==PrimitiveType.INTEGER||node.child(0).getType()==PrimitiveType.CHARACTER)
			{
				newValueCode(node);
				code.add(Label, startLabel);
				code.append(arg1);//[...arg1]
				code.add(Label, arg2Label);
				code.append(arg2);//[...arg1,arg2]
				code.add(Label, subLabel);
				code.add(Subtract);//[...arg1-arg2]
				
				code.add(JumpPos, trueLabel);//if arg1-arg2>0
				code.add(Jump, falseLabel);
	
				code.add(Label, trueLabel);
				code.add(PushI, 1);
				code.add(Jump, joinLabel);
				code.add(Label, falseLabel);
				code.add(PushI, 0);
				code.add(Jump, joinLabel);
				code.add(Label, joinLabel);
			}		
		}
		private void visitLessOperatorNode(OperatorNode node, Lextant operator) {

			ASMCodeFragment arg1 = removeValueCode(node.child(0));
			ASMCodeFragment arg2 = removeValueCode(node.child(1));
			
			Labeller labeller = new Labeller("compare-less");
			
			String startLabel = labeller.newLabel("arg1");
			String arg2Label  = labeller.newLabel("arg2");
			String subLabel   = labeller.newLabel("sub");
			String trueLabel  = labeller.newLabel("true");
			String falseLabel = labeller.newLabel("false");
			String joinLabel  = labeller.newLabel("join");
			
			
			if(node.child(0).getType()==PrimitiveType.FLOATING){
				newValueCode(node);
				code.add(Label, startLabel);
				code.append(arg1);//[...arg1]
				code.add(Label, arg2Label);
				code.append(arg2);//[...arg1,arg2]
				code.add(Label, subLabel);
				code.add(FSubtract);//[...arg1-arg2]
				
				code.add(JumpFNeg, trueLabel);//if arg1-arg2<0
				code.add(Jump, falseLabel);
	
				code.add(Label, trueLabel);
				code.add(PushI, 1);
				code.add(Jump, joinLabel);
				code.add(Label, falseLabel);
				code.add(PushI, 0);
				code.add(Jump, joinLabel);
				code.add(Label, joinLabel);
			}
			else if(node.child(0).getType()==PrimitiveType.RATIONAL){
				String negDenominator=labeller.newLabel("neg-denominator");
				
				newValueCode(node);
				code.append(arg1);
				code.append(arg2);
				code.add(Call,RunTime.SUBTRACT_RATIONAL);
				//[...num deno]
				code.add(JumpNeg,negDenominator);
				code.add(JumpNeg,trueLabel);
				code.add(Jump,falseLabel);
				code.add(Label,negDenominator);
				code.add(JumpPos,trueLabel);
				code.add(Jump,falseLabel);
				
				code.add(Label, trueLabel);
				code.add(PushI, 1);
				code.add(Jump, joinLabel);
				code.add(Label, falseLabel);
				code.add(PushI, 0);
				code.add(Jump, joinLabel);
				code.add(Label,joinLabel);
			}
			else//if(node.child(0).getType()==PrimitiveType.INTEGER||node.child(0).getType()==PrimitiveType.CHARACTER)
			{
				newValueCode(node);
				code.add(Label, startLabel);
				code.append(arg1);//[...arg1]
				code.add(Label, arg2Label);
				code.append(arg2);//[...arg1,arg2]
				code.add(Label, subLabel);
				code.add(Subtract);//[...arg1-arg2]
				
				code.add(JumpNeg, trueLabel);//if arg1-arg2<0
				code.add(Jump, falseLabel);
	
				code.add(Label, trueLabel);
				code.add(PushI, 1);
				code.add(Jump, joinLabel);
				code.add(Label, falseLabel);
				code.add(PushI, 0);
				code.add(Jump, joinLabel);
				code.add(Label, joinLabel);
			}	
		}
		
		private void visitGreaterEqualOperatorNode(OperatorNode node, Lextant operator) {

			ASMCodeFragment arg1 = removeValueCode(node.child(0));
			ASMCodeFragment arg2 = removeValueCode(node.child(1));
			
			Labeller labeller = new Labeller("compare-greaterequal");
			
			String startLabel = labeller.newLabel("arg1");
			String arg2Label  = labeller.newLabel("arg2");
			String subLabel   = labeller.newLabel("sub");
			String trueLabel  = labeller.newLabel("true");
			String falseLabel = labeller.newLabel("false");
			String joinLabel  = labeller.newLabel("join");
			
			
			if(node.child(0).getType()==PrimitiveType.FLOATING){
				newValueCode(node);
				code.add(Label, startLabel);
				code.append(arg1);//[...arg1]
				code.add(Label, arg2Label);
				code.append(arg2);//[...arg1,arg2]
				code.add(Label, subLabel);
				code.add(FSubtract);//[...arg1-arg2]
				
				code.add(JumpFNeg, falseLabel);//if arg1-arg2<0
				code.add(Jump, trueLabel);
	
				code.add(Label, trueLabel);
				code.add(PushI, 1);
				code.add(Jump, joinLabel);
				code.add(Label, falseLabel);
				code.add(PushI, 0);
				code.add(Jump, joinLabel);
				code.add(Label, joinLabel);
			}
			else if(node.child(0).getType()==PrimitiveType.RATIONAL){
				String negDenominator=labeller.newLabel("neg-denominator");
				
				newValueCode(node);
				code.append(arg1);
				code.append(arg2);
				code.add(Call,RunTime.SUBTRACT_RATIONAL);
				//[...num deno]
				code.add(JumpNeg,negDenominator);
				code.add(JumpNeg,falseLabel);
				code.add(Jump,trueLabel);
				code.add(Label,negDenominator);
				code.add(JumpPos,falseLabel);
				code.add(Jump,trueLabel);
				
				code.add(Label, trueLabel);
				code.add(PushI, 1);
				code.add(Jump, joinLabel);
				code.add(Label, falseLabel);
				code.add(PushI, 0);
				code.add(Jump, joinLabel);
				code.add(Label,joinLabel);
			}
			else//if(node.child(0).getType()==PrimitiveType.INTEGER||node.child(0).getType()==PrimitiveType.CHARACTER)
			{
				newValueCode(node);
				code.add(Label, startLabel);
				code.append(arg1);//[...arg1]
				code.add(Label, arg2Label);
				code.append(arg2);//[...arg1,arg2]
				code.add(Label, subLabel);
				code.add(Subtract);//[...arg1-arg2]
				
				code.add(JumpNeg, falseLabel);//if arg1-arg2<0
				code.add(Jump,trueLabel);
	
				code.add(Label, trueLabel);
				code.add(PushI, 1);
				code.add(Jump, joinLabel);
				code.add(Label, falseLabel);
				code.add(PushI, 0);
				code.add(Jump, joinLabel);
				code.add(Label, joinLabel);
			}
		}
		
		private void visitLessEqualOperatorNode(OperatorNode node, Lextant operator) {

			ASMCodeFragment arg1 = removeValueCode(node.child(0));
			ASMCodeFragment arg2 = removeValueCode(node.child(1));
			
			Labeller labeller = new Labeller("compare-lessequal");
			
			String startLabel = labeller.newLabel("arg1");
			String arg2Label  = labeller.newLabel("arg2");
			String subLabel   = labeller.newLabel("sub");
			String trueLabel  = labeller.newLabel("true");
			String falseLabel = labeller.newLabel("false");
			String joinLabel  = labeller.newLabel("join");
			
			
			if(node.child(0).getType()==PrimitiveType.FLOATING){
				newValueCode(node);
				code.add(Label, startLabel);
				code.append(arg1);//[...arg1]
				code.add(Label, arg2Label);
				code.append(arg2);//[...arg1,arg2]
				code.add(Label, subLabel);
				code.add(FSubtract);//[...arg1-arg2]
				
				code.add(JumpFPos, falseLabel);//if arg1-arg2>0 then false
				code.add(Jump, trueLabel);
	
				code.add(Label, trueLabel);
				code.add(PushI, 1);
				code.add(Jump, joinLabel);
				code.add(Label, falseLabel);
				code.add(PushI, 0);
				code.add(Jump, joinLabel);
				code.add(Label, joinLabel);
			}
			else if(node.child(0).getType()==PrimitiveType.RATIONAL){
				String negDenominator=labeller.newLabel("neg-denominator");
				
				newValueCode(node);
				code.append(arg1);
				code.append(arg2);
				code.add(Call,RunTime.SUBTRACT_RATIONAL);
				//[...num deno]
				code.add(JumpNeg,negDenominator);
				code.add(JumpPos,falseLabel);
				code.add(Jump,trueLabel);
				code.add(Label,negDenominator);
				code.add(JumpNeg,falseLabel);
				code.add(Jump,trueLabel);
				
				code.add(Label, trueLabel);
				code.add(PushI, 1);
				code.add(Jump, joinLabel);
				code.add(Label, falseLabel);
				code.add(PushI, 0);
				code.add(Jump, joinLabel);
				code.add(Label,joinLabel);
			}
			else//if(node.child(0).getType()==PrimitiveType.INTEGER||node.child(0).getType()==PrimitiveType.CHARACTER)
			{
				newValueCode(node);
				code.add(Label, startLabel);
				code.append(arg1);//[...arg1]
				code.add(Label, arg2Label);
				code.append(arg2);//[...arg1,arg2]
				code.add(Label, subLabel);
				code.add(Subtract);//[...arg1-arg2]
				
				code.add(JumpPos, falseLabel);//if arg1-arg2>0 then false
				code.add(Jump, trueLabel);
	
				code.add(Label, trueLabel);
				code.add(PushI, 1);
				code.add(Jump, joinLabel);
				code.add(Label, falseLabel);
				code.add(PushI, 0);
				code.add(Jump, joinLabel);
				code.add(Label, joinLabel);
			}	
		}
		
		private void visitEqualOperatorNode(OperatorNode node, Lextant operator) {

			ASMCodeFragment arg1 = removeValueCode(node.child(0));
			ASMCodeFragment arg2 = removeValueCode(node.child(1));
			
			Labeller labeller = new Labeller("compare-equal");
			
			String startLabel = labeller.newLabel("arg1");
			String arg2Label  = labeller.newLabel("arg2");
			String subLabel   = labeller.newLabel("sub");
			String trueLabel  = labeller.newLabel("true");
			String falseLabel = labeller.newLabel("false");
			String joinLabel  = labeller.newLabel("join");
			
			
			if(node.child(0).getType()==PrimitiveType.FLOATING){
				newValueCode(node);
				code.add(Label, startLabel);
				code.append(arg1);//[...arg1]
				code.add(Label, arg2Label);
				code.append(arg2);//[...arg1,arg2]
				code.add(Label, subLabel);
				code.add(FSubtract);//[...arg1-arg2]
				
				code.add(JumpFZero, trueLabel);//if arg1-arg2==0 then true
				code.add(Jump, falseLabel);
	
				code.add(Label, trueLabel);
				code.add(PushI, 1);
				code.add(Jump, joinLabel);
				code.add(Label, falseLabel);
				code.add(PushI, 0);
				code.add(Jump, joinLabel);
				code.add(Label, joinLabel);
			}
			else if(node.child(0).getType()==PrimitiveType.RATIONAL){
				newValueCode(node);
				code.append(arg1);
				code.append(arg2);
				code.add(Call,RunTime.SUBTRACT_RATIONAL);
				code.add(Pop);
				code.add(JumpFalse,trueLabel);
				code.add(Jump,falseLabel);
				
				code.add(Label, trueLabel);
				code.add(PushI, 1);
				code.add(Jump, joinLabel);
				code.add(Label, falseLabel);
				code.add(PushI, 0);
				code.add(Jump, joinLabel);
				code.add(Label, joinLabel);
			}
			else//if(node.child(0).getType()==PrimitiveType.INTEGER||node.child(0).getType()==PrimitiveType.CHARACTER
				//node.child(0).getType()==PrimitiveType.STRING||node.child(0).getType()==PrimitiveType.BOOLEAN)
			{
				newValueCode(node);
				code.add(Label, startLabel);
				code.append(arg1);//[...arg1]
				code.add(Label, arg2Label);
				code.append(arg2);//[...arg1,arg2]
				code.add(Label, subLabel);
				code.add(Subtract);//[...arg1-arg2]
				
				code.add(JumpFalse, trueLabel);//if arg1-arg2==0 then true
				code.add(Jump, falseLabel);
	
				code.add(Label, trueLabel);
				code.add(PushI, 1);
				code.add(Jump, joinLabel);
				code.add(Label, falseLabel);
				code.add(PushI, 0);
				code.add(Jump, joinLabel);
				code.add(Label, joinLabel);
			}	
		}
		
		private void visitNotEqualOperatorNode(OperatorNode node, Lextant operator) {

			ASMCodeFragment arg1 = removeValueCode(node.child(0));
			ASMCodeFragment arg2 = removeValueCode(node.child(1));
			
			Labeller labeller = new Labeller("compare-notequal");
			
			String startLabel = labeller.newLabel("arg1");
			String arg2Label  = labeller.newLabel("arg2");
			String subLabel   = labeller.newLabel("sub");
			String trueLabel  = labeller.newLabel("true");
			String falseLabel = labeller.newLabel("false");
			String joinLabel  = labeller.newLabel("join");
			
			
			if(node.child(0).getType()==PrimitiveType.FLOATING){
				newValueCode(node);
				code.add(Label, startLabel);
				code.append(arg1);//[...arg1]
				code.add(Label, arg2Label);
				code.append(arg2);//[...arg1,arg2]
				code.add(Label, subLabel);
				code.add(FSubtract);//[...arg1-arg2]
				
				code.add(JumpFZero, falseLabel);//if arg1-arg2==0 then false
				code.add(Jump, trueLabel);
	
				code.add(Label, falseLabel);
				code.add(PushI, 0);
				code.add(Jump, joinLabel);
				code.add(Label, trueLabel);
				code.add(PushI, 1);
				code.add(Jump, joinLabel);
				code.add(Label, joinLabel);
			}
			else if(node.child(0).getType()==PrimitiveType.RATIONAL){
				newValueCode(node);
				code.append(arg1);
				code.append(arg2);
				code.add(Call,RunTime.SUBTRACT_RATIONAL);
				code.add(Pop);
				code.add(JumpFalse,falseLabel);
				code.add(Jump,trueLabel);
				
				code.add(Label, trueLabel);
				code.add(PushI, 1);
				code.add(Jump, joinLabel);
				code.add(Label, falseLabel);
				code.add(PushI, 0);
				code.add(Jump, joinLabel);
				code.add(Label, joinLabel);
			}
			else//if(node.child(0).getType()==PrimitiveType.INTEGER||node.child(0).getType()==PrimitiveType.CHARACTER
				//node.child(0).getType()==PrimitiveType.STRING||node.child(0).getType()==PrimitiveType.BOOLEAN)
			{
				newValueCode(node);
				code.add(Label, startLabel);
				code.append(arg1);//[...arg1]
				code.add(Label, arg2Label);
				code.append(arg2);//[...arg1,arg2]
				code.add(Label, subLabel);
				code.add(Subtract);//[...arg1-arg2]
				
				code.add(JumpTrue, trueLabel);//if arg1-arg2!=0 then true
				code.add(Jump, falseLabel);
	
				code.add(Label, trueLabel);
				code.add(PushI, 1);
				code.add(Jump, joinLabel);
				code.add(Label, falseLabel);
				code.add(PushI, 0);
				code.add(Jump, joinLabel);
				code.add(Label, joinLabel);
			}
		}
		
		private void visitNormalBinaryOperatorNode(OperatorNode node) {
			newValueCode(node);
			ASMCodeFragment arg1 = removeValueCode(node.child(0));
			ASMCodeFragment arg2 = removeValueCode(node.child(1));

			Object variant = node.getSignature().getVariant();
			if(variant instanceof ASMOpcode) {
				code.append(arg1);
				code.append(arg2);
				ASMOpcode opcode = (ASMOpcode)variant;
				code.add(opcode);
			}
			else if(variant instanceof SimpleCodeGenerator) {// division over expressover rationalize
				code.append(arg1);
				code.append(arg2);
				SimpleCodeGenerator generator =(SimpleCodeGenerator)variant;
				ASMCodeFragment fragment = generator.generate(node);
				code.append(fragment);
				if(fragment.isAddress()) {
					code.markAsAddress();
				}
			}
			else if(variant instanceof FullCodeGenerator){
				FullCodeGenerator generator = (FullCodeGenerator)variant;
				ASMCodeFragment fragment = generator.generate(node,arg1, arg2);
				code.append(fragment);
				if(fragment.isAddress()) {
					code.markAsAddress();
				}
			}
			else {
			// throw exception
			}
//			ASMOpcode opcode = opcodeForOperator(node.getOperator());
//			code.add(opcode);							// type-dependent! (opcode is different for floats and for ints)
		}
		
		private void visitLengthOperatorNode(OperatorNode node){
			newValueCode(node);
			ASMCodeFragment arg = removeValueCode(node.child(0));
			code.append(arg);
			
			if(node.child(0).getType()==PrimitiveType.STRING){
				code.add(Duplicate);
				code.add(JumpFalse,RunTime.NULL_STRING_RUNTIME_ERROR);
				readIOffset(code,Record.STRING_LENGTH_OFFSET);
			}
			else{
				//check null array
				code.add(Duplicate);
				code.add(JumpFalse,RunTime.NULL_ARRAY_RUNTIME_ERROR);
//				code.add(PStack);
				readIOffset(code,Record.ARRAY_LENGTH_OFFSET);
			}
			
		}
		
		private void visitReverseOperatorNode(OperatorNode node){
			newValueCode(node);
			ASMCodeFragment arg=removeValueCode(node.child(0));//get the starting address of the array to be cloned
			code.append(arg);
			Object variant = node.getSignature().getVariant();
			SimpleCodeGenerator generator =(SimpleCodeGenerator)variant;
			ASMCodeFragment fragment = generator.generate(node);
			code.append(fragment);
			if(fragment.isAddress()) {
				code.markAsAddress();
			}
		}
		
		private void visitArrayPopulateCreationNode(OperatorNode node){
			newValueCode(node);
			ASMCodeFragment[] args=new ASMCodeFragment[node.nChildren()];
			for(int i=0;i<node.nChildren();i++){
				args[i]=removeValueCode(node.child(i));
			}
			Object variant = node.getSignature().getVariant();
			FullCodeGenerator generator = (FullCodeGenerator)variant;
			ASMCodeFragment fragment = generator.generate(node,args);
			code.append(fragment);
			if(fragment.isAddress()) {
				code.markAsAddress();
			}
			
		}
		
		//////////////////////////////////////////////////////////////////////////
		// array indexing or String indexing
		private void visitArrayIndexingOperatorNode(OperatorNode node){
			newAddressCode(node);
			ASMCodeFragment arg1 = removeValueCode(node.child(0));
			ASMCodeFragment arg2 = removeValueCode(node.child(1));
			code.append(arg1);
			code.append(arg2);
			
			//[...arrPtr index]
			Object variant = node.getSignature().getVariant();
			SimpleCodeGenerator generator =(SimpleCodeGenerator)variant;
			ASMCodeFragment fragment = generator.generate(node);
			code.append(fragment);
			
			//[...(arrPtr+index)]
			if(fragment.isAddress()) {
				code.markAsAddress();
			}
		}
		//////////////////////////////////////////////////////////////////////////
		// zip
		private void visitZipOperatorNode(OperatorNode node){
			newValueCode(node);
			ASMCodeFragment frag1 = removeValueCode(node.child(0));
			ASMCodeFragment frag2 = removeValueCode(node.child(1));
			ASMCodeFragment frag3 = removeValueCode(node.child(2));
			code.append(frag1);
			code.append(frag2);
			code.append(frag3);
			Object variant = node.getSignature().getVariant();
			SimpleCodeGenerator generator=(SimpleCodeGenerator)variant;
			ASMCodeFragment fragment=generator.generate(node);
			code.append(fragment);
			
			if(fragment.isAddress()) {
				code.markAsAddress();
			}
		}
		//////////////////////////////////////////////////////////////////////////
		// fold
		private void visitFoldOperatorNode(OperatorNode node){
			newValueCode(node);
			
			ASMCodeFragment frag1=removeValueCode(node.child(0));
			ASMCodeFragment frag2 = removeValueCode(node.child(1));
			
			if(node.nChildren()==3){
				ASMCodeFragment frag3 = removeValueCode(node.child(2));
				code.append(frag2);
				code.append(frag1);
				code.append(frag3);
			}
			else{
				code.append(frag1);
				code.append(frag2);
			}
			Object variant = node.getSignature().getVariant();
			SimpleCodeGenerator generator=(SimpleCodeGenerator)variant;
			ASMCodeFragment fragment=generator.generate(node);
			code.append(fragment);
			
			if(fragment.isAddress()) {
				code.markAsAddress();
			}
		}
		//////////////////////////////////////////////////////////////////////////
		// string slicing
		private void visitStringSliceOperatorNode(OperatorNode node){
			newValueCode(node);
			ASMCodeFragment str = removeValueCode(node.child(0));
			ASMCodeFragment index1 = removeValueCode(node.child(1));
			ASMCodeFragment index2 = removeValueCode(node.child(2));
			code.append(str);
			code.append(index1);
			code.append(index2);
			
			//[...strAddr index1 index2]
			Object variant = node.getSignature().getVariant();
			SimpleCodeGenerator generator=(SimpleCodeGenerator)variant;
			ASMCodeFragment fragment=generator.generate(node);
			code.append(fragment);
			
			if(fragment.isAddress()) {
				code.markAsAddress();
			}
		}
		
		//////////////////////////////////////////////////////////////////////////
		// NEW empty array creation
		private void visitNewOperatorNode(OperatorNode node){
			newValueCode(node);
			ASMCodeFragment arg = removeValueCode(node.child(1));
			code.append(arg);//[...arrSize]
			Object variant = node.getSignature().getVariant();
			SimpleCodeGenerator generator =(SimpleCodeGenerator)variant;
			ASMCodeFragment fragment = generator.generate(node);
			code.append(fragment);
			//[...arrPtr]
			if(fragment.isAddress()) {
				code.markAsAddress();
			}
		}
		
		//////////////////////////////////////////////////////////////////////////
		//clone
		private void visitCloneOperatorNode(OperatorNode node){
			newValueCode(node);
			ASMCodeFragment arg=removeValueCode(node.child(0));//get the starting address of the array to be cloned
			code.append(arg);
			Object variant = node.getSignature().getVariant();
			SimpleCodeGenerator generator =(SimpleCodeGenerator)variant;
			ASMCodeFragment fragment = generator.generate(node);
			code.append(fragment);
			if(fragment.isAddress()) {
				code.markAsAddress();
			}
		}
		
		//////////////////////////////////////////////////////////////////////////
		// While
		public void visitEnter(WhileStatementNode node){
			Labeller labeller = new Labeller("while-enter");
			String breakLabel = labeller.newLabel("break-target");
			String continueLabel = labeller.newLabel("continue-target");
			((WhileStatementNode) node).setBreakTarget(breakLabel);
			((WhileStatementNode) node).setContinueTarget(continueLabel);
		}
		public void visitLeave(WhileStatementNode node){
			newVoidCode(node);
			new WhileCodeGenerator(code, this).generate(node);
		}
		//////////////////////////////////////////////////////////////////////////
		// break
		public void visit(BreakNode node){
			newVoidCode(node);
			String target;
			for(ParseNode current : node.pathToRoot()){
				if(current instanceof WhileStatementNode){
					target=((WhileStatementNode) current).getBreakTarget();
					code.add(Jump,target);
				}
				else if(current instanceof ForIndexStatementNode){
					target=((ForIndexStatementNode) current).getBreakTarget();
					code.add(Jump,target);
				}
				else if(current instanceof ForElemStatementNode){
					target=((ForElemStatementNode) current).getBreakTarget();
					code.add(Jump,target);
				}
			}
		}
		
		//////////////////////////////////////////////////////////////////////////
		// continue
		public void visit(ContinueNode node){
			newVoidCode(node);
			String target;
			for(ParseNode current : node.pathToRoot()){
				if(current instanceof WhileStatementNode){
					target=((WhileStatementNode) current).getContinueTarget();
					code.add(Jump,target);
				}
				else if(current instanceof ForIndexStatementNode){
					target=((ForIndexStatementNode) current).getContinueTarget();
					code.add(Jump,target);
				}
				else if(current instanceof ForElemStatementNode){
					target=((ForElemStatementNode) current).getContinueTarget();
					code.add(Jump,target);
				}
			}
		}		
		
		//////////////////////////////////////////////////////////////////////////
		// If
		public void visitLeave(IfStatementNode node){
			newVoidCode(node);
			new IfCodeGenerator(code, this).generate(node);
		}
		
		//////////////////////////////////////////////////////////////////////////
		// Cast 
		public void visitLeave(CastOperatorNode node){
			newValueCode(node);
			
			ASMCodeFragment arg1 = removeValueCode(node.child(0));
			
			code.append(arg1);
			
			Object variant = node.getSignature().getVariant();
			
			if(variant instanceof ASMOpcode) {
				ASMOpcode opcode = (ASMOpcode)variant;
				code.add(opcode);
			}
			else if(variant instanceof SimpleCodeGenerator) {
				SimpleCodeGenerator generator =(SimpleCodeGenerator)variant;
				ASMCodeFragment fragment = generator.generate(node);
				code.append(fragment);
				if(fragment.isAddress()) {
					code.markAsAddress();
				}
			}
			else {
			// throw exception
			}
		}
		
		//////////////////////////////////////////////////////////////////////////
		// release Stmt
		public void visitLeave(ReleaseStatementNode node){
			newVoidCode(node);
			ASMCodeFragment arg=removeValueCode(node.child(0));
			code.append(arg);
			//[...recordPtr]
			code.append(new ReleaseCodeGenerator().generate(node));	
		}
		
		///////////////////////////////////////////////////////////////////////////
		// leaf nodes (ErrorNode not necessary)
		public void visit(BooleanConstantNode node) {
			newValueCode(node);
			code.add(PushI, node.getValue() ? 1 : 0);
		}
		public void visit(IdentifierNode node) {
			newAddressCode(node);
			Binding binding = node.getBinding();
			binding.generateAddress(code);
		}		
		public void visit(IntegerConstantNode node) {
			newValueCode(node);	
			code.add(PushI, node.getValue());
		}
		public void visit(FloatingConstantNode node) {
			newValueCode(node);		
			code.add(PushF, node.getValue());
		}
		public void visit(CharacterConstantNode node){
			int ascii=(int)node.getToken().getLexeme().charAt(0);
			newValueCode(node);
			code.add(PushI, ascii);
		}
		public void visit(StringConstantNode node) {
			newValueCode(node);
			StringCreationCodeGenerator generator=new StringCreationCodeGenerator();
			ASMCodeFragment fragment = generator.generate(node);
			code.append(fragment);
//			Labeller labeller=new Labeller("string");
//			String label=labeller.newLabel(node.getValue());
//			
//			newValueCode(node);
//			code.add(DLabel,label);
//			code.add(DataS,node.getValue());
//			code.add(PushD,label);
		}
		public void visit(PrimitiveTypeNode node){
			
		}
	}

}

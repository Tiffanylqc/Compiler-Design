package asmCodeGenerator;

import java.util.HashMap;
import java.util.Map;

import asmCodeGenerator.codeStorage.ASMCodeFragment;
import asmCodeGenerator.codeStorage.ASMOpcode;
import asmCodeGenerator.runtime.MemoryManager;
import asmCodeGenerator.runtime.RunTime;
import lexicalAnalyzer.Keyword;
import lexicalAnalyzer.Lextant;
import lexicalAnalyzer.Punctuator;
import parseTree.*;
import parseTree.nodeTypes.AssignStatementNode;
import parseTree.nodeTypes.OperatorNode;
import parseTree.nodeTypes.BooleanConstantNode;
import parseTree.nodeTypes.CastOperatorNode;
import parseTree.nodeTypes.CharacterConstantNode;
import parseTree.nodeTypes.BlockStatementNode;
import parseTree.nodeTypes.DeclarationNode;
import parseTree.nodeTypes.IdentifierNode;
import parseTree.nodeTypes.IfStatementNode;
import parseTree.nodeTypes.IntegerConstantNode;
import parseTree.nodeTypes.FloatingConstantNode;
import parseTree.nodeTypes.NewlineNode;
import parseTree.nodeTypes.PrintStatementNode;
import parseTree.nodeTypes.ProgramNode;
import parseTree.nodeTypes.SpaceNode;
import parseTree.nodeTypes.StringConstantNode;
import parseTree.nodeTypes.TabNode;
import parseTree.nodeTypes.WhileStatementNode;
import parseTree.nodeTypes.PrimitiveTypeNode;
import semanticAnalyzer.types.PrimitiveType;
import semanticAnalyzer.types.Type;
import symbolTable.Binding;
import symbolTable.Scope;
import static asmCodeGenerator.codeStorage.ASMCodeFragment.CodeType.*;
import static asmCodeGenerator.codeStorage.ASMOpcode.*;

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
			
			code.append(lvalue);
			code.append(rvalue);
			
			Type type = node.getType();
			code.add(opcodeForStore(type));
		}
		
		public void visitLeave(DeclarationNode node) {
			newVoidCode(node);
			ASMCodeFragment lvalue = removeAddressCode(node.child(0));	
			ASMCodeFragment rvalue = removeValueCode(node.child(1));
			
			code.append(lvalue);
			code.append(rvalue);
			
			Type type = node.getType();
			code.add(opcodeForStore(type));
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
			assert false: "Type " + type + " unimplemented in opcodeForStore()";
			return null;
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
			else if(operator==Punctuator.BOOL_AND){
				visitBoolAndOperatorNode(node,operator);
			}
			else if(operator==Punctuator.BOOL_OR){
				visitBoolOrOperatorNode(node,operator);
			}
			else if(operator==Punctuator.BOOL_NOT){
				visitBoolNotOperatorNode(node,operator);
			}
//			else if(operator==Keyword.CLONE){
//				visitCloneOperatorNode(node,operator);
//			}
//			else if(operator==Keyword.LENGTH){
//				visitLengthOperatorNode(node,operator);
//			}
			else if(operator==Keyword.NEW){
				visitEmptyArrayCreationNode(node,operator);
			}
//			else if(operator==Punctuator.OPEN_BRACKET){
//				visitArrayPopulateCreationNode(node,operator);
//			}
			else {
				visitNormalBinaryOperatorNode(node);
			}
		}
		private void visitEmptyArrayCreationNode(OperatorNode node,Lextant operator){
			newVoidCode(node);
			new ArrayEmptyCreationCodeGenerator(code, this).generate(node);
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
		
		private void visitBoolAndOperatorNode(OperatorNode node, Lextant operator){
			ASMCodeFragment arg1=removeValueCode(node.child(0));
			ASMCodeFragment arg2 = removeValueCode(node.child(1));
			
			Labeller labeller = new Labeller("compare-boolAnd");
			
			String startLabel = labeller.newLabel("arg1");
			String arg2Label  = labeller.newLabel("arg2");
			String andLabel   = labeller.newLabel("and");
			String trueLabel  = labeller.newLabel("true");
			String falseLabel = labeller.newLabel("false");
			String joinLabel  = labeller.newLabel("join");
			
			newValueCode(node);
			code.add(Label, startLabel);
			code.append(arg1);//[...arg1]
			code.add(JumpFalse,falseLabel);
			code.append(arg1);//[...arg1]
			code.add(Label, arg2Label);
			code.append(arg2);//[...arg1,arg2]
			code.add(Label, andLabel);
			code.add(And);//[...(arg1&arg2)]
			
			code.add(JumpTrue, trueLabel);//if arg1&arg2 is true
			code.add(Jump, falseLabel);

			code.add(Label, trueLabel);
			code.add(PushI, 1);
			code.add(Jump, joinLabel);
			code.add(Label, falseLabel);
			code.add(PushI, 0);
			code.add(Jump, joinLabel);
			code.add(Label, joinLabel);
		}
		
		private void visitBoolOrOperatorNode(OperatorNode node, Lextant operator){
			ASMCodeFragment arg1 = removeValueCode(node.child(0));
			ASMCodeFragment arg2 = removeValueCode(node.child(1));
			
			Labeller labeller = new Labeller("compare-boolOr");
			
			String startLabel = labeller.newLabel("arg1");
			String arg2Label  = labeller.newLabel("arg2");
			String orLabel   = labeller.newLabel("or");
			String trueLabel  = labeller.newLabel("true");
			String falseLabel = labeller.newLabel("false");
			String joinLabel  = labeller.newLabel("join");
			
			newValueCode(node);
			code.add(Label, startLabel);
			code.append(arg1);//[...arg1]
			code.add(JumpTrue,trueLabel);//[...]
			code.append(arg1);//[...arg1]
			code.add(Label, arg2Label);
			code.append(arg2);//[...arg1,arg2]
			code.add(Label, orLabel);
			code.add(Or);//[...(arg1||arg2)]
			
			code.add(JumpTrue, trueLabel);//if arg1||arg2 is true
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
			
			code.append(arg1);
			code.append(arg2);
			Object variant = node.getSignature().getVariant();
			if(variant instanceof ASMOpcode) {//+ - *
				ASMOpcode opcode = (ASMOpcode)variant;
				code.add(opcode);
			}
			else if(variant instanceof SimpleCodeGenerator) {// division
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
//			ASMOpcode opcode = opcodeForOperator(node.getOperator());
//			code.add(opcode);							// type-dependent! (opcode is different for floats and for ints)
		}
		
//		private ASMOpcode opcodeForOperator(Lextant lextant) {
//			assert(lextant instanceof Punctuator);
//			Punctuator punctuator = (Punctuator)lextant;
//			switch(punctuator) {
//			case ADD: 	   		return Add;				// type-dependent!
//			case MULTIPLY: 		return Multiply;		// type-dependent!
//			default:
//				assert false : "unimplemented operator in opcodeForOperator";
//			}
//			return null;
//		}
		
		//////////////////////////////////////////////////////////////////////////
		// While
		public void visitLeave(WhileStatementNode node){
			newVoidCode(node);
			new WhileCodeGenerator(code, this).generate(node);
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
			Type expressionType=node.getExpression().getType();
			Type targetType=node.getCastType().getType();
			
			ASMCodeFragment arg1 = removeValueCode(node.child(0));
			code.append(arg1);
			
			if(expressionType==targetType){
				code.add(Nop);
			}
				
			else if(expressionType==PrimitiveType.INTEGER && targetType==PrimitiveType.FLOATING)
				code.add(ConvertF);
			else if(expressionType==PrimitiveType.FLOATING && targetType==PrimitiveType.INTEGER)
				code.add(ConvertI);
			else if(expressionType==PrimitiveType.CHARACTER && targetType==PrimitiveType.INTEGER){
				CharToIntCodeGenerator generator=new CharToIntCodeGenerator();
				ASMCodeFragment fragment=generator.generate(node);
				code.append(fragment);
			}
			else if(expressionType==PrimitiveType.INTEGER && targetType==PrimitiveType.CHARACTER){
				IntToCharCodeGenerator generator=new IntToCharCodeGenerator();
				ASMCodeFragment fragment=generator.generate(node);
				code.append(fragment);
			}
			else if(expressionType==PrimitiveType.INTEGER && targetType==PrimitiveType.BOOLEAN){
				IntToBoolCodeGenerator generator=new IntToBoolCodeGenerator();
				ASMCodeFragment fragment=generator.generate(node);
				code.append(fragment);
			}
			else if(expressionType==PrimitiveType.CHARACTER && targetType==PrimitiveType.BOOLEAN){
				CharToBoolCodeGenerator generator=new CharToBoolCodeGenerator();
				ASMCodeFragment fragment=generator.generate(node);
				code.append(fragment);
			}
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
//			code.add(PStack);
		}
		public void visit(CharacterConstantNode node){
			int ascii=(int)node.getToken().getLexeme().charAt(0);
			newValueCode(node);
			code.add(PushI, ascii);
		}
		public void visit(StringConstantNode node) {
			Labeller labeller=new Labeller("string");
			String label=labeller.newLabel(node.getValue());
			
			newValueCode(node);
			code.add(DLabel,label);
			code.add(DataS,node.getValue());
			code.add(PushD,label);
		}
		public void visit(PrimitiveTypeNode node){
			
		}
	}

}

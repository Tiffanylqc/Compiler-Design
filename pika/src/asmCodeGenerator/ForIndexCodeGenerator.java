package asmCodeGenerator;

import asmCodeGenerator.codeStorage.ASMCodeFragment;
import asmCodeGenerator.codeStorage.ASMCodeFragment.CodeType;
import asmCodeGenerator.runtime.Record;
import asmCodeGenerator.runtime.RunTime;
import parseTree.ParseNode;
import parseTree.nodeTypes.ForIndexStatementNode;
import parseTree.nodeTypes.WhileStatementNode;
import semanticAnalyzer.types.PrimitiveType;
import static asmCodeGenerator.codeStorage.ASMOpcode.*;

public class ForIndexCodeGenerator implements FullCodeGenerator {

	public ForIndexCodeGenerator() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public ASMCodeFragment generate(ParseNode node, ASMCodeFragment... operandCode) {
		ASMCodeFragment frag = new ASMCodeFragment(CodeType.GENERATES_VOID);
		
		ASMCodeFragment index = operandCode[0];
		ASMCodeFragment record = operandCode[1];
		ASMCodeFragment blocStmt = operandCode[2];
		
		Labeller labeller=new Labeller("for-index");
		String loopLabel = labeller.newLabel("loop-start");
		String exitLabel = labeller.newLabel("exit");
		String inLabel = labeller.newLabel("in-label");
		String breakLabel = ((ForIndexStatementNode) node).getBreakTarget();
		String continueLabel = ((ForIndexStatementNode) node).getContinueTarget();
		
		String forLength=labeller.newLabel("for-length");
		String forIndex=labeller.newLabel("for-index");
		String forExpr=labeller.newLabel("for-expr");
		String forSubsize=labeller.newLabel("for-subsize");
		String forIden=labeller.newLabel("for-indentifier");
		Macros.declareI(frag, forLength);
		Macros.declareI(frag, forIndex);
		Macros.declareI(frag, forExpr);
		Macros.declareI(frag, forSubsize);
		Macros.declareI(frag, forIden);
		
		frag.append(record);
		frag.add(Duplicate);
		if(node.child(1).getType() ==PrimitiveType.STRING)
			frag.add(JumpFalse, RunTime.NULL_STRING_RUNTIME_ERROR);
		else
			frag.add(JumpFalse, RunTime.NULL_ARRAY_RUNTIME_ERROR);
		frag.add(Duplicate);
		Macros.storeITo(frag, forExpr);
		//store length
		if(node.child(1).getType() ==PrimitiveType.STRING)
			Macros.readIOffset(frag, Record.STRING_LENGTH_OFFSET);
		else
			Macros.readIOffset(frag, Record.ARRAY_LENGTH_OFFSET);
		Macros.storeITo(frag, forLength);
			
		//zero out the index
		frag.add(PushI,0);
		Macros.storeITo(frag, forIndex);
			
		frag.add(Label,loopLabel);
		Macros.loadIFrom(frag, forLength);
		Macros.loadIFrom(frag, forIndex);
		frag.add(Subtract);
		frag.add(JumpPos, inLabel);
		frag.add(Jump, exitLabel);
		frag.add(Label, inLabel);
			
		frag.append(index);
		Macros.loadIFrom(frag, forIndex);
			
		frag.add(StoreI);
		
//		Macros.loadIFrom(frag, RunTime.FOR_LENGTH);
//		Macros.loadIFrom(frag, RunTime.FOR_INDEX);
//		Macros.loadIFrom(frag, RunTime.FOR_EXPR);
//		frag.add(PStack);
		frag.append(blocStmt);
//		frag.add(PStack);
//		Macros.storeITo(frag, RunTime.FOR_EXPR);
//		Macros.storeITo(frag, RunTime.FOR_INDEX);
//		Macros.storeITo(frag, RunTime.FOR_LENGTH);
		
		Macros.incrementInteger(frag, forIndex);
		frag.add(Jump, loopLabel);
//		frag.add(Label, breakLabel);
		frag.add(Label, breakLabel);
//		Macros.storeITo(frag, RunTime.FOR_EXPR);
//		Macros.storeITo(frag, RunTime.FOR_INDEX);
//		Macros.storeITo(frag, RunTime.FOR_LENGTH);
		frag.add(Jump, exitLabel);
		
		frag.add(Label,continueLabel);
//		Macros.storeITo(frag, RunTime.FOR_EXPR);
//		Macros.storeITo(frag, RunTime.FOR_INDEX);
//		Macros.storeITo(frag, RunTime.FOR_LENGTH);
		Macros.incrementInteger(frag, forIndex);
		frag.add(Jump, loopLabel);
		
		frag.add(Label,exitLabel);
		return frag;
	}

}

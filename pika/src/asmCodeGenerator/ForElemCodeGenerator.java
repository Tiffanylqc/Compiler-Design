package asmCodeGenerator;

import static asmCodeGenerator.codeStorage.ASMOpcode.*;

import asmCodeGenerator.codeStorage.ASMCodeFragment;
import asmCodeGenerator.codeStorage.ASMCodeFragment.CodeType;
import asmCodeGenerator.runtime.Record;
import asmCodeGenerator.runtime.RunTime;
import parseTree.ParseNode;
import parseTree.nodeTypes.ForElemStatementNode;
import semanticAnalyzer.types.Array;
import semanticAnalyzer.types.PrimitiveType;

public class ForElemCodeGenerator implements FullCodeGenerator {

	public ForElemCodeGenerator() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public ASMCodeFragment generate(ParseNode node, ASMCodeFragment... operandCode) {
		ASMCodeFragment frag = new ASMCodeFragment(CodeType.GENERATES_VOID);
		
		ASMCodeFragment index = operandCode[0];
		ASMCodeFragment record = operandCode[1];
		ASMCodeFragment blocStmt = operandCode[2];
		
		Labeller labeller=new Labeller("for-expr");
		String loopLabel = labeller.newLabel("loop-start");
		String exitLabel = labeller.newLabel("exit");
		String inLabel = labeller.newLabel("in-label");
		String ifEnd = labeller.newLabel("if-end");
		String sizeFour = labeller.newLabel("subsize-four");
		String sizeEight = labeller.newLabel("subsize-eight");
		String breakLabel = ((ForElemStatementNode) node).getBreakTarget();
		String continueLabel = ((ForElemStatementNode) node).getContinueTarget();
		
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
		
		frag.add(Duplicate);
		if(node.child(1).getType() ==PrimitiveType.STRING)
			frag.add(JumpFalse, RunTime.NULL_STRING_RUNTIME_ERROR);
		else
			frag.add(JumpFalse, RunTime.NULL_ARRAY_RUNTIME_ERROR);
		
		if(node.child(1).getType()==PrimitiveType.STRING){
//			frag.add(PStack);
			Macros.storeITo(frag, forExpr);
			//store length
			Macros.readIOffset(frag, Record.STRING_LENGTH_OFFSET);
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
			Macros.loadIFrom(frag, forExpr);
			frag.add(PushI, Record.STRING_HEADER_SIZE);
			frag.add(Add);
			Macros.loadIFrom(frag, forIndex);
			frag.add(Add);
			frag.add(LoadC);
			frag.add(StoreC);
				
//			Macros.loadIFrom(frag, RunTime.FOR_LENGTH);
//			Macros.loadIFrom(frag, RunTime.FOR_INDEX);
//			Macros.loadIFrom(frag, RunTime.FOR_EXPR);
//			Macros.loadIFrom(frag, RunTime.FOR_SUBSIZE);
//			Macros.loadIFrom(frag, RunTime.FOR_IDEN);
			
			frag.append(blocStmt);
				
//			Macros.storeITo(frag, RunTime.FOR_IDEN);
//			Macros.storeITo(frag, RunTime.FOR_SUBSIZE);
//			Macros.storeITo(frag, RunTime.FOR_EXPR);
//			Macros.storeITo(frag, RunTime.FOR_INDEX);
//			Macros.storeITo(frag, RunTime.FOR_LENGTH);
			
			Macros.incrementInteger(frag, forIndex);
			frag.add(Jump, loopLabel);
			
			frag.add(Label, breakLabel);
//			Macros.storeITo(frag, RunTime.FOR_IDEN);
//			Macros.storeITo(frag, RunTime.FOR_SUBSIZE);
//			Macros.storeITo(frag, RunTime.FOR_EXPR);
//			Macros.storeITo(frag, RunTime.FOR_INDEX);
//			Macros.storeITo(frag, RunTime.FOR_LENGTH);
			frag.add(Jump, exitLabel);
			
			frag.add(Label,continueLabel);
//			Macros.storeITo(frag, RunTime.FOR_IDEN);
//			Macros.storeITo(frag, RunTime.FOR_SUBSIZE);
//			Macros.storeITo(frag, RunTime.FOR_EXPR);
//			Macros.storeITo(frag, RunTime.FOR_INDEX);
//			Macros.storeITo(frag, RunTime.FOR_LENGTH);
			Macros.incrementInteger(frag, forIndex);
			frag.add(Jump, loopLabel);
			
			frag.add(Label,exitLabel);
		}
		else{
			Macros.storeITo(frag, forExpr);
			//store length
			Macros.readIOffset(frag, Record.ARRAY_LENGTH_OFFSET);
			Macros.storeITo(frag, forLength);
			
			Macros.loadIFrom(frag, forExpr);
			Macros.readIOffset(frag, Record.ARRAY_SUBTYPE_SIZE_OFFSET);
			Macros.storeITo(frag, forSubsize);
			
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
			frag.add(Duplicate);
			Macros.storeITo(frag, forIden);
			Macros.loadIFrom(frag, forExpr);
			frag.add(PushI, Record.ARRAY_HEADER_SIZE);
			frag.add(Add);
			Macros.loadIFrom(frag, forIndex);
			Macros.loadIFrom(frag, forSubsize);
			frag.add(Multiply);
			frag.add(Add);
			
			////
			Macros.loadIFrom(frag, forSubsize);
			frag.add(PushI,1);
			frag.add(Subtract);
			frag.add(JumpTrue, sizeFour);
			frag.add(LoadC);
			frag.add(StoreC);
			frag.add(Jump,ifEnd);
				
			frag.add(Label, sizeFour);
			Macros.loadIFrom(frag, forSubsize);
			frag.add(PushI,4);
			frag.add(Subtract);
			frag.add(JumpTrue, sizeEight);
			frag.add(LoadI);
			frag.add(StoreI);
			frag.add(Jump,ifEnd);
			
			frag.add(Label,sizeEight);
			Array type = (Array)node.child(1).getType();
			if(type.getSubtype()==PrimitiveType.RATIONAL){
				frag.add(LoadI);
				frag.add(StoreI);
				
				Macros.loadIFrom(frag, forIden);
				frag.add(PushI, 4);
				frag.add(Add);
				Macros.loadIFrom(frag, forExpr);
				frag.add(PushI, Record.ARRAY_HEADER_SIZE);
				frag.add(Add);
				Macros.loadIFrom(frag, forIndex);
				Macros.loadIFrom(frag, forSubsize);
				frag.add(Multiply);
				frag.add(Add);
				frag.add(PushI, 4);
				frag.add(Add);
				
				frag.add(LoadI);
				frag.add(StoreI);
			}
			else{
				frag.add(LoadF);
				frag.add(StoreF);
			}
			
			frag.add(Label,ifEnd);
			///
//			Macros.loadIFrom(frag, RunTime.FOR_LENGTH);
//			Macros.loadIFrom(frag, RunTime.FOR_INDEX);
//			Macros.loadIFrom(frag, RunTime.FOR_EXPR);
//			Macros.loadIFrom(frag, RunTime.FOR_SUBSIZE);
//			Macros.loadIFrom(frag, RunTime.FOR_IDEN);
			
			frag.append(blocStmt);
			
//			Macros.storeITo(frag, RunTime.FOR_IDEN);
//			Macros.storeITo(frag, RunTime.FOR_SUBSIZE);
//			Macros.storeITo(frag, RunTime.FOR_EXPR);
//			Macros.storeITo(frag, RunTime.FOR_INDEX);
//			Macros.storeITo(frag, RunTime.FOR_LENGTH);
			
//			frag.add(PStack);
			
			Macros.incrementInteger(frag, forIndex);
			frag.add(Jump, loopLabel);
			
			frag.add(Label, breakLabel);
//			Macros.storeITo(frag, RunTime.FOR_IDEN);
//			Macros.storeITo(frag, RunTime.FOR_SUBSIZE);
//			Macros.storeITo(frag, RunTime.FOR_EXPR);
//			Macros.storeITo(frag, RunTime.FOR_INDEX);
//			Macros.storeITo(frag, RunTime.FOR_LENGTH);
			frag.add(Jump, exitLabel);
			
			frag.add(Label,continueLabel);
//			Macros.storeITo(frag, RunTime.FOR_IDEN);
//			Macros.storeITo(frag, RunTime.FOR_SUBSIZE);
//			Macros.storeITo(frag, RunTime.FOR_EXPR);
//			Macros.storeITo(frag, RunTime.FOR_INDEX);
//			Macros.storeITo(frag, RunTime.FOR_LENGTH);
			Macros.incrementInteger(frag, forIndex);
			frag.add(Jump, loopLabel);
			
			frag.add(Label,exitLabel);
		}
			
		return frag;
	}

}

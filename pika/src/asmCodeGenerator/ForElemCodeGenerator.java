package asmCodeGenerator;

import static asmCodeGenerator.codeStorage.ASMOpcode.*;

import asmCodeGenerator.codeStorage.ASMCodeFragment;
import asmCodeGenerator.codeStorage.ASMCodeFragment.CodeType;
import asmCodeGenerator.runtime.Record;
import asmCodeGenerator.runtime.RunTime;
import parseTree.ParseNode;
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
		
		frag.append(record);
		frag.add(Duplicate);
		
		if(node.child(1).getType()==PrimitiveType.STRING){
			Macros.storeITo(frag, RunTime.FOR_EXPR);
			//store length
			Macros.readIOffset(frag, Record.STRING_LENGTH_OFFSET);
			Macros.storeITo(frag, RunTime.FOR_LENGTH);
				
			//zero out the index
			frag.add(PushI,0);
			Macros.storeITo(frag, RunTime.FOR_INDEX);
				
			frag.add(Label,loopLabel);
			Macros.loadIFrom(frag, RunTime.FOR_LENGTH);
			Macros.loadIFrom(frag, RunTime.FOR_INDEX);
			frag.add(Subtract);
			frag.add(JumpPos, inLabel);
			frag.add(Jump, exitLabel);
			frag.add(Label, inLabel);
				
			frag.append(index);
			Macros.loadIFrom(frag, RunTime.FOR_EXPR);
			frag.add(PushI, Record.STRING_HEADER_SIZE);
			frag.add(Add);
			Macros.loadIFrom(frag, RunTime.FOR_INDEX);
			frag.add(Add);
			frag.add(LoadC);
			frag.add(StoreC);
				
			frag.append(blocStmt);
				
			Macros.incrementInteger(frag, RunTime.FOR_INDEX);
			frag.add(Jump, loopLabel);
			frag.add(Label,exitLabel);
		}
		else{
			Macros.storeITo(frag, RunTime.FOR_EXPR);
			//store length
			Macros.readIOffset(frag, Record.ARRAY_LENGTH_OFFSET);
			Macros.storeITo(frag, RunTime.FOR_LENGTH);
			
			Macros.loadIFrom(frag, RunTime.FOR_EXPR);
			Macros.readIOffset(frag, Record.ARRAY_SUBTYPE_SIZE_OFFSET);
			Macros.storeITo(frag, RunTime.FOR_SUBSIZE);
			
			//zero out the index
			frag.add(PushI,0);
			Macros.storeITo(frag, RunTime.FOR_INDEX);
				
			frag.add(Label,loopLabel);
			Macros.loadIFrom(frag, RunTime.FOR_LENGTH);
			Macros.loadIFrom(frag, RunTime.FOR_INDEX);
			frag.add(Subtract);
			frag.add(JumpPos, inLabel);
			frag.add(Jump, exitLabel);
			frag.add(Label, inLabel);
				
			frag.append(index);
			frag.add(Duplicate);
			Macros.storeITo(frag, RunTime.FOR_IDEN);
			Macros.loadIFrom(frag, RunTime.FOR_EXPR);
			frag.add(PushI, Record.ARRAY_HEADER_SIZE);
			frag.add(Add);
			Macros.loadIFrom(frag, RunTime.FOR_INDEX);
			Macros.loadIFrom(frag, RunTime.FOR_SUBSIZE);
			frag.add(Multiply);
			frag.add(Add);
			
			////
			Macros.loadIFrom(frag, RunTime.FOR_SUBSIZE);
			frag.add(PushI,1);
			frag.add(Subtract);
			frag.add(JumpTrue, sizeFour);
			frag.add(LoadC);
			frag.add(StoreC);
			frag.add(Jump,ifEnd);
				
			frag.add(Label, sizeFour);
			Macros.loadIFrom(frag, RunTime.FOR_SUBSIZE);
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
				
				Macros.loadIFrom(frag, RunTime.FOR_IDEN);
				frag.add(PushI, 4);
				frag.add(Add);
				Macros.loadIFrom(frag, RunTime.FOR_EXPR);
				frag.add(PushI, Record.ARRAY_HEADER_SIZE);
				frag.add(Add);
				Macros.loadIFrom(frag, RunTime.FOR_INDEX);
				Macros.loadIFrom(frag, RunTime.FOR_SUBSIZE);
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
			frag.append(blocStmt);
			
			Macros.incrementInteger(frag, RunTime.FOR_INDEX);
			frag.add(Jump, loopLabel);
			frag.add(Label,exitLabel);
		}
			
		return frag;
	}

}

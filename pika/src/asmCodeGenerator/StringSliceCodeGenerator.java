package asmCodeGenerator;

import asmCodeGenerator.codeStorage.ASMCodeFragment;
import asmCodeGenerator.codeStorage.ASMCodeFragment.CodeType;
import asmCodeGenerator.runtime.Record;
import asmCodeGenerator.runtime.RunTime;
import parseTree.ParseNode;

import static asmCodeGenerator.Macros.loadIFrom;
import static asmCodeGenerator.codeStorage.ASMOpcode.*;
import static asmCodeGenerator.runtime.Record.STRING_HEADER_SIZE;
import static asmCodeGenerator.runtime.Record.STRING_STATUS;
import static asmCodeGenerator.runtime.Record.STRING_TYPE_ID;
import static asmCodeGenerator.runtime.RunTime.ARRAY_INDEXING_ARRAY;
import static asmCodeGenerator.runtime.RunTime.NULL_ARRAY_RUNTIME_ERROR;
import static asmCodeGenerator.runtime.RunTime.RECORD_CREATION_TEMP;
import static asmCodeGenerator.runtime.RunTime.createRecord;

public class StringSliceCodeGenerator implements SimpleCodeGenerator {

	public StringSliceCodeGenerator() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public ASMCodeFragment generate(ParseNode node) {
		ASMCodeFragment frag = new ASMCodeFragment(CodeType.GENERATES_VALUE);
		Labeller labeller=new Labeller("string-slice");
		String label = labeller.newLabel("in-bounds");
		String loopLabel = labeller.newLabel("loop-start");
		String bodyLabel = labeller.newLabel("loop-body");
		String exitLabel = labeller.newLabel("exit");
		
		//[...strAddr index1 index2]
		Macros.storeITo(frag, RunTime.STRING_SLICE_INDEX2);
		Macros.storeITo(frag, RunTime.STRING_SLICE_INDEX1);
		Macros.storeITo(frag, RunTime.STRING_SLICE_STRADDR);
		
		Macros.loadIFrom(frag, RunTime.STRING_SLICE_STRADDR);
		frag.add(JumpFalse, RunTime.NULL_STRING_RUNTIME_ERROR);
		
		//[...]
		//compare 0<=index1<index2<=length s
		Macros.loadIFrom(frag, RunTime.STRING_SLICE_STRADDR);
		Macros.readIOffset(frag, Record.STRING_LENGTH_OFFSET);
		//[...length]
		Macros.loadIFrom(frag, RunTime.STRING_SLICE_INDEX2);
		//[...length index2]
		//check length>=index2
		frag.add(Subtract);
		frag.add(JumpNeg,RunTime.STRING_SLICE_INDEX_RUNTIME_ERROR);
		
		//check index1<index2
		Macros.loadIFrom(frag, RunTime.STRING_SLICE_INDEX2);
		Macros.loadIFrom(frag, RunTime.STRING_SLICE_INDEX1);
		frag.add(Subtract);
		frag.add(JumpPos, label);
		frag.add(Jump, RunTime.STRING_SLICE_INDEX_RUNTIME_ERROR);
		frag.add(Label, label);
		
		//check 0<=index1
		Macros.loadIFrom(frag, RunTime.STRING_SLICE_INDEX1);
		frag.add(JumpNeg, RunTime.STRING_SLICE_INDEX_RUNTIME_ERROR);
		
		//calculate total size of string record
		Macros.loadIFrom(frag, RunTime.STRING_SLICE_INDEX2);
		Macros.loadIFrom(frag, RunTime.STRING_SLICE_INDEX1);
		frag.add(Subtract);
		frag.add(PushI,1);
		frag.add(Add);
		frag.add(PushI,STRING_HEADER_SIZE);
		frag.add(Add);
		//[..totSize]
		createRecord(frag, STRING_TYPE_ID, STRING_STATUS);
		
		//store length in record
		Macros.loadIFrom(frag, RunTime.STRING_SLICE_INDEX2);
		Macros.loadIFrom(frag, RunTime.STRING_SLICE_INDEX1);
		frag.add(Subtract);
		Macros.loadIFrom(frag, RECORD_CREATION_TEMP);
		Macros.writeIOffset(frag, Record.STRING_LENGTH_OFFSET);
		
		//store null char
		Macros.loadIFrom(frag, RunTime.STRING_SLICE_INDEX2);
		Macros.loadIFrom(frag, RunTime.STRING_SLICE_INDEX1);
		frag.add(Subtract);
		frag.add(PushI,Record.STRING_HEADER_SIZE);
		frag.add(Add);
		Macros.loadIFrom(frag, RECORD_CREATION_TEMP);
		frag.add(Add);
		frag.add(PushI,0);
		frag.add(StoreC);
		
		Macros.loadIFrom(frag, RunTime.STRING_SLICE_STRADDR);
		frag.add(PushI,Record.STRING_HEADER_SIZE);
		frag.add(Add);
		Macros.loadIFrom(frag, RunTime.STRING_SLICE_INDEX1);
		frag.add(Add);
		Macros.storeITo(frag, RunTime.STRING_ELEM_TEMP1);
		
		Macros.loadIFrom(frag, RECORD_CREATION_TEMP);
		frag.add(PushI,Record.STRING_HEADER_SIZE);
		frag.add(Add);
		Macros.storeITo(frag, RunTime.STRING_ELEM_TEMP2);
		//store character
		frag.add(Label,loopLabel);
		Macros.loadIFrom(frag, RunTime.STRING_SLICE_INDEX2);
		Macros.loadIFrom(frag, RunTime.STRING_SLICE_INDEX1);
		frag.add(Subtract);
		frag.add(JumpPos,bodyLabel);
		frag.add(Jump,exitLabel);
		frag.add(Label,bodyLabel);
		
		Macros.loadIFrom(frag, RunTime.STRING_ELEM_TEMP1);
		frag.add(LoadC);
		Macros.loadIFrom(frag, RunTime.STRING_ELEM_TEMP2);
		frag.add(Exchange);
		frag.add(StoreC);
		
		Macros.incrementInteger(frag, RunTime.STRING_SLICE_INDEX1);
		Macros.incrementInteger(frag, RunTime.STRING_ELEM_TEMP1);
		Macros.incrementInteger(frag, RunTime.STRING_ELEM_TEMP2);
		frag.add(Jump, loopLabel);
		
		frag.add(Label,exitLabel);
		
		loadIFrom(frag, RECORD_CREATION_TEMP);
		return frag;
	}

}

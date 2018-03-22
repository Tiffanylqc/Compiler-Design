package asmCodeGenerator;

import asmCodeGenerator.codeStorage.ASMCodeFragment;
import asmCodeGenerator.codeStorage.ASMCodeFragment.CodeType;
import asmCodeGenerator.runtime.Record;
import asmCodeGenerator.runtime.RunTime;

import static asmCodeGenerator.Macros.loadIFrom;
import static asmCodeGenerator.codeStorage.ASMOpcode.*;
import static asmCodeGenerator.runtime.Record.STRING_HEADER_SIZE;
import static asmCodeGenerator.runtime.Record.STRING_STATUS;
import static asmCodeGenerator.runtime.Record.STRING_TYPE_ID;
import static asmCodeGenerator.runtime.RunTime.RECORD_CREATION_TEMP;
import static asmCodeGenerator.runtime.RunTime.createRecord;

import parseTree.ParseNode;

public class StringCharAddCodeGenerator implements SimpleCodeGenerator {

	public StringCharAddCodeGenerator() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public ASMCodeFragment generate(ParseNode node) {
		ASMCodeFragment frag=new ASMCodeFragment(CodeType.GENERATES_VALUE);
		Labeller labeller=new Labeller("string-char-add");
		String loopLabel = labeller.newLabel("loop-start");
		String exitLabel = labeller.newLabel("exit");
		
		//[...str char]
		Macros.storeCTo(frag,RunTime.CHAR_TEMP);
		
		frag.add(Duplicate);
		frag.add(JumpFalse, RunTime.NULL_STRING_RUNTIME_ERROR);
		Macros.storeITo(frag, RunTime.STRING_SLICE_STRADDR);
		
		Macros.loadIFrom(frag, RunTime.STRING_SLICE_STRADDR);
		Macros.readIOffset(frag, Record.STRING_LENGTH_OFFSET);
		frag.add(Duplicate);
		Macros.storeITo(frag, RunTime.STRING_LENGTH_TEMP);
		frag.add(PushI,STRING_HEADER_SIZE);
		frag.add(Add);
		frag.add(PushI,2);
		frag.add(Add);
		//[...totSize]
		createRecord(frag, STRING_TYPE_ID, STRING_STATUS);
		
		//store length
		Macros.loadIFrom(frag, RunTime.STRING_LENGTH_TEMP);
		frag.add(PushI,1);
		frag.add(Add);
		Macros.loadIFrom(frag, RECORD_CREATION_TEMP);
		Macros.writeIOffset(frag, Record.STRING_LENGTH_OFFSET);
		
		//store null char
		Macros.loadIFrom(frag, RunTime.STRING_LENGTH_TEMP);
		frag.add(PushI,1);
		frag.add(Add);
		frag.add(PushI,Record.STRING_HEADER_SIZE);
		frag.add(Add);
		Macros.loadIFrom(frag, RECORD_CREATION_TEMP);
		frag.add(Add);
		frag.add(PushI,0);
		frag.add(StoreC);
		
		//store elements
		Macros.loadIFrom(frag, RunTime.STRING_SLICE_STRADDR);
		frag.add(PushI,Record.STRING_HEADER_SIZE);
		frag.add(Add);
		Macros.storeITo(frag, RunTime.STRING_ELEM_TEMP1);
		
		Macros.loadIFrom(frag, RECORD_CREATION_TEMP);
		frag.add(PushI,Record.STRING_HEADER_SIZE);
		frag.add(Add);
		Macros.storeITo(frag, RunTime.STRING_ELEM_TEMP2);
		
		frag.add(Label,loopLabel);
		Macros.loadIFrom(frag, RunTime.STRING_LENGTH_TEMP);
		frag.add(JumpFalse, exitLabel);
		
		Macros.loadIFrom(frag, RunTime.STRING_ELEM_TEMP2);
		Macros.loadIFrom(frag, RunTime.STRING_ELEM_TEMP1);
		frag.add(LoadC);
		frag.add(StoreC);
		
		Macros.incrementInteger(frag, RunTime.STRING_ELEM_TEMP1);
		Macros.incrementInteger(frag, RunTime.STRING_ELEM_TEMP2);
		Macros.decrementInteger(frag, RunTime.STRING_LENGTH_TEMP);
		frag.add(Jump,loopLabel);
		
		frag.add(Label, exitLabel);
		
		Macros.loadIFrom(frag, RunTime.STRING_ELEM_TEMP2);
		Macros.loadCFrom(frag, RunTime.CHAR_TEMP);
		frag.add(StoreC);
		
		loadIFrom(frag, RECORD_CREATION_TEMP);
		return frag;
		
	}

}

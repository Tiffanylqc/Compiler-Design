package asmCodeGenerator;

import static asmCodeGenerator.Macros.loadIFrom;
import static asmCodeGenerator.codeStorage.ASMOpcode.Add;
import static asmCodeGenerator.codeStorage.ASMOpcode.Duplicate;
import static asmCodeGenerator.codeStorage.ASMOpcode.Jump;
import static asmCodeGenerator.codeStorage.ASMOpcode.JumpFalse;
import static asmCodeGenerator.codeStorage.ASMOpcode.Label;
import static asmCodeGenerator.codeStorage.ASMOpcode.LoadC;
import static asmCodeGenerator.codeStorage.ASMOpcode.PushI;
import static asmCodeGenerator.codeStorage.ASMOpcode.StoreC;
import static asmCodeGenerator.runtime.Record.STRING_HEADER_SIZE;
import static asmCodeGenerator.runtime.Record.STRING_STATUS;
import static asmCodeGenerator.runtime.Record.STRING_TYPE_ID;
import static asmCodeGenerator.runtime.RunTime.RECORD_CREATION_TEMP;
import static asmCodeGenerator.runtime.RunTime.createRecord;

import asmCodeGenerator.codeStorage.ASMCodeFragment;
import asmCodeGenerator.codeStorage.ASMCodeFragment.CodeType;
import asmCodeGenerator.runtime.Record;
import asmCodeGenerator.runtime.RunTime;
import parseTree.ParseNode;

public class StringStringAddCodeGenerator implements SimpleCodeGenerator {

	public StringStringAddCodeGenerator() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public ASMCodeFragment generate(ParseNode node) {
		ASMCodeFragment frag=new ASMCodeFragment(CodeType.GENERATES_VALUE);
		Labeller labeller=new Labeller("string-string-add");
		String label = labeller.newLabel("in-bounds");
		String loop1Label = labeller.newLabel("loop-start1");
		String bodyLabel = labeller.newLabel("loop-body");
		String exit1Label = labeller.newLabel("exit1");
		String loop2Label = labeller.newLabel("loop-start2");
		String exit2Label = labeller.newLabel("exit2");
		
		//[...str1 str2]
		frag.add(Duplicate);
		frag.add(JumpFalse, RunTime.NULL_STRING_RUNTIME_ERROR);
		Macros.storeITo(frag, RunTime.STRING_ADDR_TEMP2);
		frag.add(Duplicate);
		frag.add(JumpFalse, RunTime.NULL_STRING_RUNTIME_ERROR);
		Macros.storeITo(frag, RunTime.STRING_ADDR_TEMP1);
		
		Macros.loadIFrom(frag, RunTime.STRING_ADDR_TEMP1);
		Macros.readIOffset(frag, Record.STRING_LENGTH_OFFSET);
		frag.add(PushI,STRING_HEADER_SIZE);
		frag.add(Add);
		Macros.loadIFrom(frag, RunTime.STRING_ADDR_TEMP2);
		Macros.readIOffset(frag, Record.STRING_LENGTH_OFFSET);
		frag.add(PushI,STRING_HEADER_SIZE);
		frag.add(Add);
		frag.add(Add);
		frag.add(PushI,1);
		frag.add(Add);
		//[...totSize]
		createRecord(frag, STRING_TYPE_ID, STRING_STATUS);
		
		//store length
		Macros.loadIFrom(frag, RunTime.STRING_ADDR_TEMP1);
		Macros.readIOffset(frag, Record.STRING_LENGTH_OFFSET);
		Macros.loadIFrom(frag, RunTime.STRING_ADDR_TEMP2);
		Macros.readIOffset(frag, Record.STRING_LENGTH_OFFSET);
		frag.add(Add);
		Macros.loadIFrom(frag, RECORD_CREATION_TEMP);
		Macros.writeIOffset(frag, Record.STRING_LENGTH_OFFSET);
		
		//store null char
		Macros.loadIFrom(frag, RunTime.STRING_ADDR_TEMP1);
		Macros.readIOffset(frag, Record.STRING_LENGTH_OFFSET);
		Macros.loadIFrom(frag, RunTime.STRING_ADDR_TEMP2);
		Macros.readIOffset(frag, Record.STRING_LENGTH_OFFSET);
		frag.add(Add);
		frag.add(PushI,1);
		frag.add(Add);
		frag.add(PushI,Record.STRING_HEADER_SIZE);
		frag.add(Add);
		Macros.loadIFrom(frag, RECORD_CREATION_TEMP);
		frag.add(Add);
		frag.add(PushI,0);
		frag.add(StoreC);
		
		//store first string
		Macros.loadIFrom(frag, RunTime.STRING_ADDR_TEMP1);
		Macros.readIOffset(frag, Record.STRING_LENGTH_OFFSET);
		Macros.storeITo(frag, RunTime.STRING_LENGTH_TEMP);
		Macros.loadIFrom(frag, RunTime.STRING_ADDR_TEMP1);
		frag.add(PushI,Record.STRING_HEADER_SIZE);
		frag.add(Add);
		Macros.storeITo(frag, RunTime.STRING_ELEM_TEMP1);
		
		Macros.loadIFrom(frag, RECORD_CREATION_TEMP);
		frag.add(PushI,Record.STRING_HEADER_SIZE);
		frag.add(Add);
		Macros.storeITo(frag, RunTime.STRING_ELEM_TEMP2);
		
		frag.add(Label,loop1Label);
		Macros.loadIFrom(frag, RunTime.STRING_LENGTH_TEMP);
		frag.add(JumpFalse, exit1Label);
		
		Macros.loadIFrom(frag, RunTime.STRING_ELEM_TEMP2);
		Macros.loadIFrom(frag, RunTime.STRING_ELEM_TEMP1);
		frag.add(LoadC);
		frag.add(StoreC);
		
		Macros.incrementInteger(frag, RunTime.STRING_ELEM_TEMP1);
		Macros.incrementInteger(frag, RunTime.STRING_ELEM_TEMP2);
		Macros.decrementInteger(frag, RunTime.STRING_LENGTH_TEMP);
		frag.add(Jump,loop1Label);
		frag.add(Label, exit1Label);
		
		//store second string
		Macros.loadIFrom(frag, RunTime.STRING_ADDR_TEMP2);
		Macros.readIOffset(frag, Record.STRING_LENGTH_OFFSET);
		Macros.storeITo(frag, RunTime.STRING_LENGTH_TEMP);
		Macros.loadIFrom(frag, RunTime.STRING_ADDR_TEMP2);
		frag.add(PushI,Record.STRING_HEADER_SIZE);
		frag.add(Add);
		Macros.storeITo(frag, RunTime.STRING_ELEM_TEMP1);
		
		frag.add(Label,loop2Label);
		Macros.loadIFrom(frag, RunTime.STRING_LENGTH_TEMP);
		frag.add(JumpFalse, exit2Label);
		
		Macros.loadIFrom(frag, RunTime.STRING_ELEM_TEMP2);
		Macros.loadIFrom(frag, RunTime.STRING_ELEM_TEMP1);
		frag.add(LoadC);
		frag.add(StoreC);
		
		Macros.incrementInteger(frag, RunTime.STRING_ELEM_TEMP1);
		Macros.incrementInteger(frag, RunTime.STRING_ELEM_TEMP2);
		Macros.decrementInteger(frag, RunTime.STRING_LENGTH_TEMP);
		frag.add(Jump,loop2Label);
		frag.add(Label, exit2Label);
		
		loadIFrom(frag, RECORD_CREATION_TEMP);
		return frag;
	}

}

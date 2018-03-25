package asmCodeGenerator;

import static asmCodeGenerator.Macros.loadIFrom;
import static asmCodeGenerator.codeStorage.ASMOpcode.*;
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
import semanticAnalyzer.types.Array;
import semanticAnalyzer.types.PrimitiveType;

public class ReverseArrayCodeGenerator implements SimpleCodeGenerator {

	public ReverseArrayCodeGenerator() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public ASMCodeFragment generate(ParseNode node) {
		ASMCodeFragment frag=new ASMCodeFragment(CodeType.GENERATES_VALUE);
		Labeller labeller=new Labeller("array-reverse");
		String loopLabel = labeller.newLabel("loop-start");
		String exitLabel = labeller.newLabel("exit");
		
		Array type=(Array) node.child(0).getType();
		//[...str]
		frag.add(Duplicate);
		frag.add(JumpFalse, RunTime.NULL_ARRAY_RUNTIME_ERROR);
		Macros.storeITo(frag, RunTime.ARRAY_ADDR);
		
		Macros.loadIFrom(frag, RunTime.ARRAY_ADDR);
		Macros.readIOffset(frag, Record.ARRAY_SUBTYPE_SIZE_OFFSET);
		Macros.storeITo(frag, RunTime.ARRAY_SUBTYPE_SIZE_TEMP);
		
		Macros.loadIFrom(frag, RunTime.ARRAY_ADDR);
		Macros.readIOffset(frag, Record.RECORD_STATUS_OFFSET);
		Macros.storeITo(frag, RunTime.ARRAY_STATUS_TEMP);
		
		Macros.loadIFrom(frag, RunTime.ARRAY_ADDR);
		Macros.readIOffset(frag, Record.ARRAY_LENGTH_OFFSET);
		frag.add(Duplicate);
		Macros.storeITo(frag, RunTime.ARRAY_LENGTH_TEMP);
		Macros.loadIFrom(frag, RunTime.ARRAY_SUBTYPE_SIZE_TEMP);
		frag.add(Multiply);
		frag.add(PushI,Record.ARRAY_HEADER_SIZE);
		frag.add(Add);
		
		int statusFlags=0;
		if(type.getSubtype() instanceof Array||type.getSubtype() ==PrimitiveType.STRING){
			statusFlags+=2;
		}
		//[...totSize]
		createRecord(frag, Record.ARRAY_TYPE_ID, statusFlags);
		
		//store subsize
		Macros.loadIFrom(frag, RunTime.ARRAY_SUBTYPE_SIZE_TEMP);
		Macros.loadIFrom(frag, RECORD_CREATION_TEMP);
		Macros.writeIOffset(frag, Record.ARRAY_SUBTYPE_SIZE_OFFSET);
		
		//store length
		Macros.loadIFrom(frag, RunTime.ARRAY_LENGTH_TEMP);
		Macros.loadIFrom(frag, RECORD_CREATION_TEMP);
		Macros.writeIOffset(frag, Record.ARRAY_LENGTH_OFFSET);
		
		//store elements
		Macros.loadIFrom(frag, RunTime.ARRAY_ADDR);
		frag.add(PushI,Record.ARRAY_HEADER_SIZE);
		frag.add(Add);
		Macros.storeITo(frag, RunTime.ARRAY_ELEMENT_TEMP);
		
		Macros.loadIFrom(frag, RECORD_CREATION_TEMP);
		frag.add(PushI, Record.ARRAY_HEADER_SIZE);
		frag.add(Add);
		Macros.loadIFrom(frag, RunTime.ARRAY_LENGTH_TEMP);
		frag.add(PushI,1);
		frag.add(Subtract);
		Macros.loadIFrom(frag, RunTime.ARRAY_SUBTYPE_SIZE_TEMP);
		frag.add(Multiply);
		frag.add(Add);
		Macros.storeITo(frag, RunTime.ARRAY_ELEMENT_TEMP2);
		
		frag.add(Label,loopLabel);
		Macros.loadIFrom(frag, RunTime.ARRAY_LENGTH_TEMP);
		frag.add(JumpFalse, exitLabel);
		
		
		Macros.loadIFrom(frag, RunTime.ARRAY_ELEMENT_TEMP);
//		frag.add(PStack);
		int size=type.getSubtype().getSize();
		if(size==1){
			frag.add(LoadC);
		}
		else if(size==4){
			frag.add(LoadI);
//			frag.add(PStack);
		}
		else if(size==8&&type.getSubtype()==PrimitiveType.FLOATING){
			frag.add(LoadF);
		}
		else{
			frag.add(LoadI);
			Macros.loadIFrom(frag, RunTime.ARRAY_ELEMENT_TEMP);
			frag.add(PushI,4);
			frag.add(Add);
			frag.add(LoadI);
		}
		
		Macros.loadIFrom(frag, RunTime.ARRAY_ELEMENT_TEMP2);
//		frag.add(PStack);
		if(size==1){
			frag.add(Exchange);
			frag.add(StoreC);
		}
		else if(size==4){
			frag.add(Exchange);
			frag.add(StoreI);
		}
		else if(size==8&&type.getSubtype()==PrimitiveType.FLOATING){
			frag.add(Exchange);
			frag.add(StoreF);
		}
		else{
			frag.add(PushI,4);
			frag.add(Add);
			frag.add(Exchange);
			frag.add(StoreI);
			Macros.loadIFrom(frag, RunTime.ARRAY_ELEMENT_TEMP2);
			frag.add(Exchange);
			frag.add(StoreI);
		}
		
		Macros.loadIFrom(frag, RunTime.ARRAY_SUBTYPE_SIZE_TEMP);
		Macros.addITo(frag, RunTime.ARRAY_ELEMENT_TEMP);
		Macros.loadIFrom(frag, RunTime.ARRAY_ELEMENT_TEMP2);
		Macros.loadIFrom(frag, RunTime.ARRAY_SUBTYPE_SIZE_TEMP);
		frag.add(Subtract);
		Macros.storeITo(frag, RunTime.ARRAY_ELEMENT_TEMP2);
		Macros.decrementInteger(frag, RunTime.ARRAY_LENGTH_TEMP);
		frag.add(Jump,loopLabel);
		
		
		frag.add(Label, exitLabel);
		loadIFrom(frag, RECORD_CREATION_TEMP);
		return frag;
	}

}

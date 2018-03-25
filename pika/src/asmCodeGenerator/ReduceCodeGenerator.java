package asmCodeGenerator;

import static asmCodeGenerator.codeStorage.ASMOpcode.*;
import asmCodeGenerator.codeStorage.ASMCodeFragment;
import asmCodeGenerator.codeStorage.ASMCodeFragment.CodeType;
import asmCodeGenerator.runtime.Record;
import asmCodeGenerator.runtime.RunTime;
import parseTree.ParseNode;
import semanticAnalyzer.types.Array;
import semanticAnalyzer.types.LambdaType;
import semanticAnalyzer.types.PrimitiveType;

public class ReduceCodeGenerator implements SimpleCodeGenerator {

	public ReduceCodeGenerator() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public ASMCodeFragment generate(ParseNode node) {
		ASMCodeFragment frag=new ASMCodeFragment(CodeType.GENERATES_VALUE);
		Labeller labeller=new Labeller("reduce");
		String loopLabel = labeller.newLabel("loop-start");
		String loop2Label = labeller.newLabel("loop-start2");
		String exitLabel = labeller.newLabel("exit");
		String exit2Label = labeller.newLabel("exit-2");
		String falseLabel = labeller.newLabel("false");
		//[...arrayT, lambda]
		Macros.storeITo(frag, RunTime.LAMBDA_ADDR);
		frag.add(Duplicate);
		frag.add(JumpFalse, RunTime.NULL_ARRAY_RUNTIME_ERROR);
		Macros.storeITo(frag, RunTime.ARRAY_ADDR);
		
		LambdaType lambda=(LambdaType) node.child(1).getType();
		int statusFlags=0;
		int size=lambda.getFunctionSignature().getParamTypes()[0].getSize();
		
		Macros.loadIFrom(frag, RunTime.ARRAY_ADDR);
		Macros.readIOffset(frag, Record.ARRAY_LENGTH_OFFSET);
		Macros.storeITo(frag, RunTime.ARRAY_LENGTH_TEMP);
		//clear out count
		frag.add(PushI, 0);
		Macros.storeITo(frag, RunTime.REDUCE_COUNT);
		//start function
		Macros.loadIFrom(frag, RunTime.ARRAY_ADDR);
		frag.add(PushI, Record.ARRAY_HEADER_SIZE);
		frag.add(Add);
		Macros.storeITo(frag, RunTime.ARRAY_ELEMENT_TEMP);
		
		frag.add(Label, loopLabel);
		Macros.loadIFrom(frag, RunTime.ARRAY_LENGTH_TEMP);
		frag.add(JumpFalse, exitLabel);
		
		Macros.loadIFrom(frag, RunTime.ARRAY_ELEMENT_TEMP);
		if(size==1){
			frag.add(LoadC);
		}
		else if(size==4){
			frag.add(LoadI);
		}
		else if(size==8&&lambda.getFunctionSignature().getParamTypes()[0]==PrimitiveType.FLOATING){
			frag.add(LoadF);
		}
		else{
			frag.add(LoadI);
			Macros.loadIFrom(frag, RunTime.ARRAY_ELEMENT_TEMP);
			frag.add(PushI,4);
			frag.add(Add);
			frag.add(LoadI);
		}
		RunTime.beforeCallSP(frag, lambda.getFunctionSignature().getParamTypes()[0], size);
//		frag.add(PushI,(-1)*size);
//		Macros.addITo(frag, RunTime.STACK_POINTER);
//		if(size==1){
//			Macros.storeCToIndirect(frag, RunTime.STACK_POINTER);
//		}
//		else if(size==4){
//			Macros.storeIToIndirect(frag, RunTime.STACK_POINTER);
//		}
//		else if(size==8 && (lambda.getFunctionSignature().getParamTypes()[0]==PrimitiveType.FLOATING))
//			Macros.storeFToIndirect(frag, RunTime.STACK_POINTER);
//		else{
//			
//			Macros.loadIFrom(frag, RunTime.STACK_POINTER);
//			frag.add(PushI,4);
//			frag.add(Add);
//			frag.add(Exchange);
//			frag.add(StoreI);
//			Macros.storeIToIndirect(frag, RunTime.STACK_POINTER);
//		}
		Macros.loadIFrom(frag, RunTime.LAMBDA_ADDR);
		RunTime.callFunction(frag, lambda.getFunctionSignature().resultType());
		frag.add(JumpFalse,falseLabel);
		Macros.incrementInteger(frag, RunTime.REDUCE_COUNT);
		Macros.loadIFrom(frag, RunTime.ARRAY_ELEMENT_TEMP);
		if(size==1){
			frag.add(LoadC);
		}
		else if(size==4){
			frag.add(LoadI);
		}
		else if(size==8&&lambda.getFunctionSignature().getParamTypes()[0]==PrimitiveType.FLOATING){
			frag.add(LoadF);
		}
		else{
			frag.add(LoadI);
			Macros.loadIFrom(frag, RunTime.ARRAY_ELEMENT_TEMP);
			frag.add(PushI,4);
			frag.add(Add);
			frag.add(LoadI);
		}
		frag.add(Label, falseLabel);
		
		frag.add(PushI, size);
		Macros.addITo(frag, RunTime.ARRAY_ELEMENT_TEMP);
		Macros.decrementInteger(frag, RunTime.ARRAY_LENGTH_TEMP);
		frag.add(Jump, loopLabel);
		frag.add(Label,exitLabel);
		////////////////////////////////////////
		Macros.loadIFrom(frag, RunTime.REDUCE_COUNT);
		//[..nElem]
		RunTime.createEmptyArrayRecord(frag,statusFlags,size);
		Macros.loadIFrom(frag, RunTime.RECORD_CREATION_TEMP);
		frag.add(PushI, Record.ARRAY_HEADER_SIZE);
		frag.add(Add);
		frag.add(PushI, size-1);
		Macros.loadIFrom(frag, RunTime.REDUCE_COUNT);
		frag.add(Multiply);
		frag.add(Add);
		Macros.storeITo(frag, RunTime.ARRAY_ELEMENT_TEMP2);
		
		frag.add(Label,loop2Label);
		
		Macros.loadIFrom(frag, RunTime.REDUCE_COUNT);
		frag.add(JumpFalse,exit2Label);
		Macros.loadIFrom(frag, RunTime.ARRAY_ELEMENT_TEMP2);
		if(size==1){
			frag.add(Exchange);
			frag.add(StoreC);
		}
		else if(size==4){
			frag.add(Exchange);
			frag.add(StoreI);
		}
		else if(size==8&&lambda.getFunctionSignature().resultType()==PrimitiveType.FLOATING){
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
		Macros.decrementInteger(frag, RunTime.REDUCE_COUNT);
		frag.add(PushI, (-1)*size);
		Macros.addITo(frag, RunTime.ARRAY_ELEMENT_TEMP2);
		frag.add(Jump,loop2Label);
		frag.add(Label,exit2Label);
		
		Macros.loadIFrom(frag, RunTime.RECORD_CREATION_TEMP);
		return frag;
	}

}

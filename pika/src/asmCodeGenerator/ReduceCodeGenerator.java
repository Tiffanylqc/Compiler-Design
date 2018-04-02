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
		
		String lambdaAddr= labeller.newLabel("lambda-addr");
		String arrayAddr = labeller.newLabel("array-addr");
		String arrayLengthTemp=labeller.newLabel("array-length-temp");
		String recordCreationTemp=labeller.newLabel("record-creation-temp");
		String arrayElementTemp=labeller.newLabel("array-element-temp");
		String arrayElementTemp2=labeller.newLabel("array-element-temp2");
		String reduceCount=labeller.newLabel("reduce-count");
		Macros.declareI(frag, lambdaAddr);
		Macros.declareI(frag, arrayAddr);
		Macros.declareI(frag, arrayLengthTemp);
		Macros.declareI(frag, recordCreationTemp);
		Macros.declareI(frag, arrayElementTemp);
		Macros.declareI(frag, arrayElementTemp2);
		Macros.declareI(frag, reduceCount);
		
		//[...arrayT, lambda]
		Macros.storeITo(frag, lambdaAddr);
		frag.add(Duplicate);
		frag.add(JumpFalse, RunTime.NULL_ARRAY_RUNTIME_ERROR);
		Macros.storeITo(frag, arrayAddr);
		
		LambdaType lambda=(LambdaType) node.child(1).getType();
		int statusFlags=0;
		int size=lambda.getFunctionSignature().getParamTypes()[0].getSize();
		if(lambda.getFunctionSignature().getParamTypes()[0] instanceof Array || lambda.getFunctionSignature().getParamTypes()[0] ==PrimitiveType.STRING)
			statusFlags+=2;
		Macros.loadIFrom(frag, arrayAddr);
		Macros.readIOffset(frag, Record.ARRAY_LENGTH_OFFSET);
		Macros.storeITo(frag, arrayLengthTemp);
		//clear out count
		frag.add(PushI, 0);
		Macros.storeITo(frag, reduceCount);
		//start function
		Macros.loadIFrom(frag, arrayAddr);
		frag.add(PushI, Record.ARRAY_HEADER_SIZE);
		frag.add(Add);
		Macros.storeITo(frag, arrayElementTemp);
		
		frag.add(Label, loopLabel);
		Macros.loadIFrom(frag, arrayLengthTemp);
		frag.add(JumpFalse, exitLabel);
		
		Macros.loadIFrom(frag, arrayElementTemp);
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
			Macros.loadIFrom(frag, arrayElementTemp);
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
		Macros.loadIFrom(frag, lambdaAddr);
		RunTime.callFunction(frag, lambda.getFunctionSignature().resultType());
		frag.add(JumpFalse,falseLabel);
		Macros.incrementInteger(frag, reduceCount);
		Macros.loadIFrom(frag, arrayElementTemp);
		if(size==1){
			frag.add(LoadC);
		}
		else if(size==4){
//			System.out.println("yes");
			frag.add(LoadI);
		}
		else if(size==8&&lambda.getFunctionSignature().getParamTypes()[0]==PrimitiveType.FLOATING){
			frag.add(LoadF);
		}
		else{
			frag.add(LoadI);
			Macros.loadIFrom(frag, arrayElementTemp);
			frag.add(PushI,4);
			frag.add(Add);
			frag.add(LoadI);
		}
		frag.add(Label, falseLabel);
		
		frag.add(PushI, size);
		Macros.addITo(frag, arrayElementTemp);
		Macros.decrementInteger(frag, arrayLengthTemp);
		frag.add(Jump, loopLabel);
		frag.add(Label,exitLabel);
		////////////////////////////////////////
		Macros.loadIFrom(frag, reduceCount);
		//[..nElem]
		RunTime.createEmptyArrayRecord(frag,statusFlags,size);
		Macros.loadIFrom(frag, RunTime.RECORD_CREATION_TEMP);
		Macros.storeITo(frag, recordCreationTemp);
		Macros.loadIFrom(frag, recordCreationTemp);
		
		frag.add(PushI, Record.ARRAY_HEADER_SIZE);
		frag.add(Add);
		frag.add(PushI, size);
		Macros.loadIFrom(frag, reduceCount);
		frag.add(PushI,1);
		frag.add(Subtract);
		frag.add(Multiply);
		frag.add(Add);
		Macros.storeITo(frag, arrayElementTemp2);
		
		frag.add(Label,loop2Label);
		
		Macros.loadIFrom(frag, reduceCount);
		frag.add(JumpFalse,exit2Label);
		Macros.loadIFrom(frag, arrayElementTemp2);
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
			Macros.loadIFrom(frag, arrayElementTemp2);
			frag.add(Exchange);
			frag.add(StoreI);
		}
		Macros.decrementInteger(frag, reduceCount);
		frag.add(PushI, (-1)*size);
		Macros.addITo(frag, arrayElementTemp2);
		frag.add(Jump,loop2Label);
		frag.add(Label,exit2Label);
		
		Macros.loadIFrom(frag, recordCreationTemp);
		return frag;
	}

}

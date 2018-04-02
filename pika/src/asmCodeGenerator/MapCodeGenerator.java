package asmCodeGenerator;

import asmCodeGenerator.codeStorage.ASMCodeFragment;
import asmCodeGenerator.codeStorage.ASMCodeFragment.CodeType;
import asmCodeGenerator.runtime.Record;
import asmCodeGenerator.runtime.RunTime;
import parseTree.ParseNode;
import semanticAnalyzer.types.Array;
import semanticAnalyzer.types.LambdaType;
import semanticAnalyzer.types.PrimitiveType;

import static asmCodeGenerator.Macros.loadIFrom;
import static asmCodeGenerator.codeStorage.ASMOpcode.*;

public class MapCodeGenerator implements SimpleCodeGenerator {

	public MapCodeGenerator() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public ASMCodeFragment generate(ParseNode node) {
		ASMCodeFragment frag=new ASMCodeFragment(CodeType.GENERATES_VALUE);
		Labeller labeller=new Labeller("map");
		String loopLabel = labeller.newLabel("loop-start");
		String exitLabel = labeller.newLabel("exit");
		
		String lambdaAddr= labeller.newLabel("lambda-addr");
		String arrayAddr = labeller.newLabel("array-addr");
		String arrayLengthTemp=labeller.newLabel("array-length-temp");
		String recordCreationTemp=labeller.newLabel("record-creation-temp");
		String arrayElementTemp=labeller.newLabel("array-element-temp");
		String arrayElementTemp2=labeller.newLabel("array-element-temp2");
		Macros.declareI(frag, lambdaAddr);
		Macros.declareI(frag, arrayAddr);
		Macros.declareI(frag, arrayLengthTemp);
		Macros.declareI(frag, recordCreationTemp);
		Macros.declareI(frag, arrayElementTemp);
		Macros.declareI(frag, arrayElementTemp2);
		
		//[...arrayT, lambda]
		Macros.storeITo(frag, lambdaAddr);
		frag.add(Duplicate);
		frag.add(JumpFalse, RunTime.NULL_ARRAY_RUNTIME_ERROR);
		Macros.storeITo(frag, arrayAddr);
		
		LambdaType lambda=(LambdaType) node.child(1).getType();
		int statusFlags=0;
		if(lambda.getFunctionSignature().resultType() instanceof Array||lambda.getFunctionSignature().resultType() == PrimitiveType.STRING){//set the subtype-is-reference status
			statusFlags+=2;
		}
		int oldSize=lambda.getFunctionSignature().getParamTypes()[0].getSize();
		int newSize=lambda.getFunctionSignature().resultType().getSize();
		Macros.loadIFrom(frag, arrayAddr);
		Macros.readIOffset(frag, Record.ARRAY_LENGTH_OFFSET);
		Macros.storeITo(frag, arrayLengthTemp);
		Macros.loadIFrom(frag, arrayLengthTemp);
		//[..nElem]
		RunTime.createEmptyArrayRecord(frag,statusFlags,newSize);
		Macros.loadIFrom(frag, RunTime.RECORD_CREATION_TEMP);
		Macros.storeITo(frag, recordCreationTemp);
		
		Macros.loadIFrom(frag, arrayAddr);
		frag.add(PushI, Record.ARRAY_HEADER_SIZE);
		frag.add(Add);
		Macros.storeITo(frag, arrayElementTemp);
		Macros.loadIFrom(frag, recordCreationTemp);
		frag.add(PushI, Record.ARRAY_HEADER_SIZE);
		frag.add(Add);
		Macros.storeITo(frag, arrayElementTemp2);
		
		frag.add(Label, loopLabel);
		Macros.loadIFrom(frag, arrayLengthTemp);
		frag.add(JumpFalse, exitLabel);
		
		Macros.loadIFrom(frag, arrayElementTemp);
//		RunTime.loadArrayElement(frag, lambda.getFunctionSignature().getParamTypes()[0], oldSize);
		if(oldSize==1){
			frag.add(LoadC);
		}
		else if(oldSize==4){
			frag.add(LoadI);
		}
		else if(oldSize==8&&lambda.getFunctionSignature().getParamTypes()[0]==PrimitiveType.FLOATING){
			frag.add(LoadF);
		}
		else{
			frag.add(LoadI);
			Macros.loadIFrom(frag, arrayElementTemp);
			frag.add(PushI,4);
			frag.add(Add);
			frag.add(LoadI);
		}
		RunTime.beforeCallSP(frag, lambda.getFunctionSignature().getParamTypes()[0], oldSize);
//		frag.add(PushI,(-1)*oldSize);
//		Macros.addITo(frag, RunTime.STACK_POINTER);
//		if(oldSize==1){
//			Macros.storeCToIndirect(frag, RunTime.STACK_POINTER);
//		}
//		else if(oldSize==4){
//			Macros.storeIToIndirect(frag, RunTime.STACK_POINTER);
//		}
//		else if(oldSize==8 && (lambda.getFunctionSignature().getParamTypes()[0]==PrimitiveType.FLOATING))
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
//		Macros.loadIFrom(frag, RunTime.LAMBDA_ADDR);
//		Macros.loadIFrom(frag, RunTime.ARRAY_ADDR);
//		Macros.loadIFrom(frag, RunTime.ARRAY_LENGTH_TEMP);
//		Macros.loadIFrom(frag, RunTime.RECORD_CREATION_TEMP);
//		Macros.loadIFrom(frag, RunTime.ARRAY_ELEMENT_TEMP);
//		Macros.loadIFrom(frag, RunTime.ARRAY_ELEMENT_TEMP2);
		
		Macros.loadIFrom(frag, lambdaAddr);
		RunTime.callFunction(frag, lambda.getFunctionSignature().resultType());
//		frag.add(PStack);
//		Macros.storeITo(frag, RunTime.CALL_RESULT);
		
//		Macros.storeITo(frag, RunTime.ARRAY_ELEMENT_TEMP2);
//		Macros.storeITo(frag, RunTime.ARRAY_ELEMENT_TEMP);
//		Macros.storeITo(frag, RunTime.RECORD_CREATION_TEMP);
//		Macros.storeITo(frag, RunTime.ARRAY_LENGTH_TEMP);
//		Macros.storeITo(frag, RunTime.ARRAY_ADDR);
//		Macros.storeITo(frag, RunTime.LAMBDA_ADDR);
		
//		Macros.loadIFrom(frag, RunTime.CALL_RESULT);
		Macros.loadIFrom(frag, arrayElementTemp2);
		if(newSize==1){
			frag.add(Exchange);
			frag.add(StoreC);
		}
		else if(newSize==4){
			frag.add(Exchange);
			frag.add(StoreI);
		}
		else if(newSize==8&&lambda.getFunctionSignature().resultType()==PrimitiveType.FLOATING){
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
		
		frag.add(PushI, oldSize);
		Macros.addITo(frag, arrayElementTemp);
		frag.add(PushI, newSize);
		Macros.addITo(frag, arrayElementTemp2);
		Macros.decrementInteger(frag, arrayLengthTemp);
//		frag.add(PStack);
		frag.add(Jump, loopLabel);
		frag.add(Label,exitLabel);
		
		Macros.loadIFrom(frag, recordCreationTemp);
		return frag;
	}

}

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
		
		//[...arrayT, lambda]
		Macros.storeITo(frag, RunTime.LAMBDA_ADDR);
		frag.add(Duplicate);
		frag.add(JumpFalse, RunTime.NULL_ARRAY_RUNTIME_ERROR);
		Macros.storeITo(frag, RunTime.ARRAY_ADDR);
		
		LambdaType lambda=(LambdaType) node.child(1).getType();
		int statusFlags=0;
		if(lambda.getFunctionSignature().resultType() instanceof Array||lambda.getFunctionSignature().resultType() == PrimitiveType.STRING){//set the subtype-is-reference status
			statusFlags+=2;
		}
		int oldSize=lambda.getFunctionSignature().getParamTypes()[0].getSize();
		int newSize=lambda.getFunctionSignature().resultType().getSize();
		Macros.loadIFrom(frag, RunTime.ARRAY_ADDR);
		Macros.readIOffset(frag, Record.ARRAY_LENGTH_OFFSET);
		Macros.storeITo(frag, RunTime.ARRAY_LENGTH_TEMP);
		Macros.loadIFrom(frag, RunTime.ARRAY_LENGTH_TEMP);
		//[..nElem]
		RunTime.createEmptyArrayRecord(frag,statusFlags,newSize);
		Macros.loadIFrom(frag, RunTime.RECORD_CREATION_TEMP);
		Macros.loadIFrom(frag, RunTime.ARRAY_ADDR);
		frag.add(PushI, Record.ARRAY_HEADER_SIZE);
		frag.add(Add);
		Macros.storeITo(frag, RunTime.ARRAY_ELEMENT_TEMP);
		Macros.loadIFrom(frag, RunTime.RECORD_CREATION_TEMP);
		frag.add(PushI, Record.ARRAY_HEADER_SIZE);
		frag.add(Add);
		Macros.storeITo(frag, RunTime.ARRAY_ELEMENT_TEMP2);
		
		frag.add(Label, loopLabel);
		Macros.loadIFrom(frag, RunTime.ARRAY_LENGTH_TEMP);
		frag.add(JumpFalse, exitLabel);
		
		Macros.loadIFrom(frag, RunTime.ARRAY_ELEMENT_TEMP);
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
			Macros.loadIFrom(frag, RunTime.ARRAY_ELEMENT_TEMP);
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
		Macros.loadIFrom(frag, RunTime.LAMBDA_ADDR);
		RunTime.callFunction(frag, lambda.getFunctionSignature().resultType());

		Macros.loadIFrom(frag, RunTime.ARRAY_ELEMENT_TEMP2);
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
			Macros.loadIFrom(frag, RunTime.ARRAY_ELEMENT_TEMP2);
			frag.add(Exchange);
			frag.add(StoreI);
		}
		
		frag.add(PushI, oldSize);
		Macros.addITo(frag, RunTime.ARRAY_ELEMENT_TEMP);
		frag.add(PushI, newSize);
		Macros.addITo(frag, RunTime.ARRAY_ELEMENT_TEMP2);
		Macros.decrementInteger(frag, RunTime.ARRAY_LENGTH_TEMP);
		frag.add(Jump, loopLabel);
		frag.add(Label,exitLabel);
		
//		Macros.loadIFrom(frag, RunTime.RECORD_CREATION_TEMP);
		return frag;
	}

}

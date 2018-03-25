package asmCodeGenerator;

import static asmCodeGenerator.codeStorage.ASMOpcode.*;

import asmCodeGenerator.codeStorage.ASMCodeFragment;
import asmCodeGenerator.codeStorage.ASMCodeFragment.CodeType;
import asmCodeGenerator.runtime.Record;
import asmCodeGenerator.runtime.RunTime;
import parseTree.ParseNode;
import semanticAnalyzer.types.*;

public class ZipCodeGenerator implements SimpleCodeGenerator {

	public ZipCodeGenerator() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public ASMCodeFragment generate(ParseNode node) {
		ASMCodeFragment frag=new ASMCodeFragment(CodeType.GENERATES_VALUE);
		
		Labeller labeller=new Labeller("zip");
		String loopLabel = labeller.newLabel("loop-start");
		String exitLabel = labeller.newLabel("exit");
		
		LambdaType lambda=(LambdaType) node.child(2).getType();
		Type paraType1=lambda.getFunctionSignature().getParamTypes()[0];
		int paraSize1=paraType1.getSize();
		Type paraType2=lambda.getFunctionSignature().getParamTypes()[1];
		int paraSize2=paraType2.getSize();
		Type resultType=lambda.getFunctionSignature().resultType();
		int resultSize=resultType.getSize();
		
		int statusFlags=0;
		if(resultType instanceof Array||resultType == PrimitiveType.STRING){//set the subtype-is-reference status
			statusFlags+=2;
		}
		//[..arrS arrT lambda]
		Macros.storeITo(frag, RunTime.LAMBDA_ADDR);
		frag.add(Duplicate);
		frag.add(JumpFalse, RunTime.NULL_ARRAY_RUNTIME_ERROR);
		Macros.storeITo(frag, RunTime.ARRAY_ADDRT);
		frag.add(Duplicate);
		frag.add(JumpFalse, RunTime.NULL_ARRAY_RUNTIME_ERROR);
		Macros.storeITo(frag, RunTime.ARRAY_ADDRS);
		
		//compare the length
		Macros.loadIFrom(frag, RunTime.ARRAY_ADDRS);
		Macros.readIOffset(frag, Record.ARRAY_LENGTH_OFFSET);
		Macros.loadIFrom(frag, RunTime.ARRAY_ADDRT);
		Macros.readIOffset(frag, Record.ARRAY_LENGTH_OFFSET);
		frag.add(Subtract);
		frag.add(JumpTrue, RunTime.ZIP_LENGTH_DIFF_RUNTIME_ERROR);
		
		//store length
		Macros.loadIFrom(frag, RunTime.ARRAY_ADDRS);
		Macros.readIOffset(frag, Record.ARRAY_LENGTH_OFFSET);
		Macros.storeITo(frag, RunTime.ARRAY_LENGTH_TEMP);
		
		Macros.loadIFrom(frag, RunTime.ARRAY_LENGTH_TEMP);
		//[...nELem]
		RunTime.createEmptyArrayRecord(frag,statusFlags,resultSize);
		Macros.loadIFrom(frag, RunTime.RECORD_CREATION_TEMP);
		
		Macros.loadIFrom(frag, RunTime.ARRAY_ADDRS);
		frag.add(PushI, Record.ARRAY_HEADER_SIZE);
		frag.add(Add);
		Macros.storeITo(frag, RunTime.ARRAY_ELEMENT_TEMP);
		Macros.loadIFrom(frag, RunTime.ARRAY_ADDRT);
		frag.add(PushI, Record.ARRAY_HEADER_SIZE);
		frag.add(Add);
		Macros.storeITo(frag, RunTime.ARRAY_ELEMENT_TEMP2);
		Macros.loadIFrom(frag, RunTime.RECORD_CREATION_TEMP);
		frag.add(PushI, Record.ARRAY_HEADER_SIZE);
		frag.add(Add);
		Macros.storeITo(frag, RunTime.ARRAY_ELEMENT_TEMP3);
		
		frag.add(Label, loopLabel);
		Macros.loadIFrom(frag, RunTime.ARRAY_LENGTH_TEMP);
		frag.add(JumpFalse, exitLabel);
		//first parameter
		Macros.loadIFrom(frag, RunTime.ARRAY_ELEMENT_TEMP);
		if(paraSize1==1){
			frag.add(LoadC);
		}
		else if(paraSize1==4){
			frag.add(LoadI);
		}
		else if(paraSize1==8&&paraType1==PrimitiveType.FLOATING){
			frag.add(LoadF);
		}
		else{
			frag.add(LoadI);
			Macros.loadIFrom(frag, RunTime.ARRAY_ELEMENT_TEMP);
			frag.add(PushI,4);
			frag.add(Add);
			frag.add(LoadI);
		}
		RunTime.beforeCallSP(frag, paraType1, paraSize1);
		
		//second parameter
		Macros.loadIFrom(frag, RunTime.ARRAY_ELEMENT_TEMP2);
		if(paraSize2==1){
			frag.add(LoadC);
		}
		else if(paraSize2==4){
			frag.add(LoadI);
		}
		else if(paraSize2==8&&paraType2==PrimitiveType.FLOATING){
			frag.add(LoadF);
		}
		else{
			frag.add(LoadI);
			Macros.loadIFrom(frag, RunTime.ARRAY_ELEMENT_TEMP2);
			frag.add(PushI,4);
			frag.add(Add);
			frag.add(LoadI);
		}
		RunTime.beforeCallSP(frag, paraType2, paraSize2);
		Macros.loadIFrom(frag, RunTime.LAMBDA_ADDR);
		RunTime.callFunction(frag, resultType);
		
		Macros.loadIFrom(frag, RunTime.ARRAY_ELEMENT_TEMP3);
		if(resultSize==1){
			frag.add(Exchange);
			frag.add(StoreC);
		}
		else if(resultSize==4){
			frag.add(Exchange);
			frag.add(StoreI);
		}
		else if(resultSize==8&&resultType==PrimitiveType.FLOATING){
			frag.add(Exchange);
			frag.add(StoreF);
		}
		else{
			frag.add(PushI,4);
			frag.add(Add);
			frag.add(Exchange);
			frag.add(StoreI);
			Macros.loadIFrom(frag, RunTime.ARRAY_ELEMENT_TEMP3);
			frag.add(Exchange);
			frag.add(StoreI);
		}
		
		frag.add(PushI, paraSize1);
		Macros.addITo(frag, RunTime.ARRAY_ELEMENT_TEMP);
		frag.add(PushI, paraSize2);
		Macros.addITo(frag, RunTime.ARRAY_ELEMENT_TEMP2);
		frag.add(PushI, resultSize);
		Macros.addITo(frag, RunTime.ARRAY_ELEMENT_TEMP3);
		Macros.decrementInteger(frag, RunTime.ARRAY_LENGTH_TEMP);
		frag.add(Jump, loopLabel);
		frag.add(Label,exitLabel);
		
		return frag;
	}

}

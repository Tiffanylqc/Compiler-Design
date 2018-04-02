package asmCodeGenerator;

import asmCodeGenerator.codeStorage.ASMCodeFragment;
import asmCodeGenerator.codeStorage.ASMCodeFragment.CodeType;
import asmCodeGenerator.runtime.Record;
import asmCodeGenerator.runtime.RunTime;
import parseTree.ParseNode;
import semanticAnalyzer.types.LambdaType;
import semanticAnalyzer.types.PrimitiveType;
import semanticAnalyzer.types.Type;

import static asmCodeGenerator.codeStorage.ASMOpcode.*;


public class FoldCodeGenerator implements SimpleCodeGenerator {

	public FoldCodeGenerator() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public ASMCodeFragment generate(ParseNode node) {
		ASMCodeFragment frag=new ASMCodeFragment(CodeType.GENERATES_VALUE);
		Labeller labeller=new Labeller("zip");
		String loopLabel = labeller.newLabel("loop-start");
		String exitLabel = labeller.newLabel("exit");
		
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
		
		LambdaType lambda;
		
		if(node.nChildren()==3)
			lambda=(LambdaType) node.child(2).getType();
		else
			lambda=(LambdaType) node.child(1).getType();
		
		Type paraTypeU=lambda.getFunctionSignature().getParamTypes()[0];
		int paraSizeU=paraTypeU.getSize();
		Type paraTypeT=lambda.getFunctionSignature().getParamTypes()[1];
		int paraSizeT=paraTypeT.getSize();
		// [... U arrT lambda]
		Macros.storeITo(frag, lambdaAddr);
		frag.add(Duplicate);
		frag.add(JumpFalse, RunTime.NULL_ARRAY_RUNTIME_ERROR);
		Macros.storeITo(frag, arrayAddr);
		//store length
		Macros.loadIFrom(frag, arrayAddr);
		Macros.readIOffset(frag, Record.ARRAY_LENGTH_OFFSET);
		if(node.nChildren()==2){
			frag.add(Duplicate);
			frag.add(JumpFalse, RunTime.FOLD_ZERO_LENGTH);
		}
		Macros.storeITo(frag, arrayLengthTemp);
		
		Macros.loadIFrom(frag, arrayAddr);
		frag.add(PushI, Record.ARRAY_HEADER_SIZE);
		frag.add(Add);
		Macros.storeITo(frag, arrayElementTemp);
		
		if(node.nChildren()==3){
//			RunTime.beforeCallSP(frag, paraTypeU, paraSizeU);
		}
		else{			
			Macros.loadIFrom(frag, arrayElementTemp);
			if(paraSizeT==1){
				frag.add(LoadC);
			}
			else if(paraSizeT==4){
				frag.add(LoadI);
			}
			else if(paraSizeT==8&&paraTypeT==PrimitiveType.FLOATING){
				frag.add(LoadF);
			}
			else{
				frag.add(LoadI);
				Macros.loadIFrom(frag, arrayElementTemp);
				frag.add(PushI,4);
				frag.add(Add);
				frag.add(LoadI);
			}
			frag.add(PushI, paraSizeT);
			Macros.addITo(frag, arrayElementTemp);
			Macros.decrementInteger(frag, arrayLengthTemp);
//			RunTime.beforeCallSP(frag, paraTypeT, paraSizeT);
		}
//		Macros.loadIFrom(frag, arrayLengthTemp);
//		frag.add(JumpFalse, exitLabel);
//		if(node.nChildren()==3){
//			RunTime.beforeCallSP(frag, paraTypeU, paraSizeU);
//		}
//		else{
//			RunTime.beforeCallSP(frag, paraTypeT, paraSizeT);
//		}
		
		frag.add(Label, loopLabel);
		Macros.loadIFrom(frag, arrayLengthTemp);
		frag.add(JumpFalse, exitLabel);
		
		RunTime.beforeCallSP(frag, paraTypeU, paraSizeU);
		Macros.loadIFrom(frag, arrayElementTemp);
		if(paraSizeT==1){
			frag.add(LoadC);
		}
		else if(paraSizeT==4){
			frag.add(LoadI);
		}
		else if(paraSizeT==8&&paraTypeT==PrimitiveType.FLOATING){
			frag.add(LoadF);
		}
		else{
			frag.add(LoadI);
			Macros.loadIFrom(frag, arrayElementTemp);
			frag.add(PushI,4);
			frag.add(Add);
			frag.add(LoadI);
		}
		RunTime.beforeCallSP(frag, paraTypeT, paraSizeT);
		Macros.loadIFrom(frag, lambdaAddr);
		RunTime.callFunction(frag, paraTypeU);
				
		frag.add(PushI, paraSizeT);
		Macros.addITo(frag, arrayElementTemp);
		Macros.decrementInteger(frag, arrayLengthTemp);
//		Macros.loadIFrom(frag, arrayLengthTemp);
//		frag.add(JumpFalse, exitLabel);
//		RunTime.beforeCallSP(frag, paraTypeU, paraSizeU);
		frag.add(Jump, loopLabel);
		frag.add(Label,exitLabel);
		
		return frag;
	}

}

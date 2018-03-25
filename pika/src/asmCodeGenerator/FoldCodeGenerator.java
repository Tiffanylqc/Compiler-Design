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
		Macros.storeITo(frag, RunTime.LAMBDA_ADDR);
		frag.add(Duplicate);
		frag.add(JumpFalse, RunTime.NULL_ARRAY_RUNTIME_ERROR);
		Macros.storeITo(frag, RunTime.ARRAY_ADDR);
		//store length
		Macros.loadIFrom(frag, RunTime.ARRAY_ADDR);
		Macros.readIOffset(frag, Record.ARRAY_LENGTH_OFFSET);
		Macros.storeITo(frag, RunTime.ARRAY_LENGTH_TEMP);
		
		Macros.loadIFrom(frag, RunTime.ARRAY_ADDR);
		frag.add(PushI, Record.ARRAY_HEADER_SIZE);
		frag.add(Add);
		Macros.storeITo(frag, RunTime.ARRAY_ELEMENT_TEMP);
		
		if(node.nChildren()==3){
//			RunTime.beforeCallSP(frag, paraTypeU, paraSizeU);
		}
		else{			
			Macros.loadIFrom(frag, RunTime.ARRAY_ELEMENT_TEMP);
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
				Macros.loadIFrom(frag, RunTime.ARRAY_ELEMENT_TEMP);
				frag.add(PushI,4);
				frag.add(Add);
				frag.add(LoadI);
			}
			frag.add(PushI, paraSizeT);
			Macros.addITo(frag, RunTime.ARRAY_ELEMENT_TEMP);
			Macros.decrementInteger(frag, RunTime.ARRAY_LENGTH_TEMP);
//			RunTime.beforeCallSP(frag, paraTypeT, paraSizeT);
		}
		
		frag.add(Label, loopLabel);
		Macros.loadIFrom(frag, RunTime.ARRAY_LENGTH_TEMP);
		frag.add(JumpFalse, exitLabel);
		
		RunTime.beforeCallSP(frag, paraTypeT, paraSizeT);
		Macros.loadIFrom(frag, RunTime.ARRAY_ELEMENT_TEMP);
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
			Macros.loadIFrom(frag, RunTime.ARRAY_ELEMENT_TEMP);
			frag.add(PushI,4);
			frag.add(Add);
			frag.add(LoadI);
		}
		RunTime.beforeCallSP(frag, paraTypeT, paraSizeT);
		Macros.loadIFrom(frag, RunTime.LAMBDA_ADDR);
		RunTime.callFunction(frag, paraTypeU);
				
		frag.add(PushI, paraSizeT);
		Macros.addITo(frag, RunTime.ARRAY_ELEMENT_TEMP);
		Macros.decrementInteger(frag, RunTime.ARRAY_LENGTH_TEMP);
		frag.add(Jump, loopLabel);
		frag.add(Label,exitLabel);
		
		return frag;
	}

}

package asmCodeGenerator;

import static asmCodeGenerator.Macros.loadIFrom;
import static asmCodeGenerator.Macros.storeITo;
import static asmCodeGenerator.codeStorage.ASMOpcode.Call;
import static asmCodeGenerator.codeStorage.ASMOpcode.ConvertF;
import static asmCodeGenerator.codeStorage.ASMOpcode.ConvertI;
import static asmCodeGenerator.codeStorage.ASMOpcode.Duplicate;
import static asmCodeGenerator.codeStorage.ASMOpcode.FMultiply;
import static asmCodeGenerator.codeStorage.ASMOpcode.JumpFalse;

import asmCodeGenerator.codeStorage.ASMCodeFragment;
import asmCodeGenerator.codeStorage.ASMCodeFragment.CodeType;
import asmCodeGenerator.runtime.RunTime;
import parseTree.ParseNode;

public class FloatingRationalizeCodeGenerator implements SimpleCodeGenerator {

	public FloatingRationalizeCodeGenerator() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public ASMCodeFragment generate(ParseNode node) {
		ASMCodeFragment frag=new ASMCodeFragment(CodeType.GENERATES_VALUE);
		frag.add(Duplicate);
		frag.add(JumpFalse, RunTime.RATIONALIZE_DIVIDE_BY_ZERO_RUNTIME_ERROR);
		frag.add(Duplicate);
		storeITo(frag, RunTime.EXPRESS_OVER_DENOMINATOR);
		frag.add(ConvertF);
		frag.add(FMultiply);
		frag.add(ConvertI);
		
		loadIFrom(frag,RunTime.EXPRESS_OVER_DENOMINATOR);
		frag.add(Call, RunTime.LOWEST_TERMS);
		
		return frag;
	}

}

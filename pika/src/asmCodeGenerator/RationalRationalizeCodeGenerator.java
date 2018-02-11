package asmCodeGenerator;

import static asmCodeGenerator.Macros.loadIFrom;
import static asmCodeGenerator.Macros.storeITo;
import static asmCodeGenerator.codeStorage.ASMOpcode.*;
import asmCodeGenerator.codeStorage.ASMCodeFragment;
import asmCodeGenerator.codeStorage.ASMCodeFragment.CodeType;
import asmCodeGenerator.runtime.RunTime;
import parseTree.ParseNode;

public class RationalRationalizeCodeGenerator implements SimpleCodeGenerator {

	public RationalRationalizeCodeGenerator() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public ASMCodeFragment generate(ParseNode node) {
		ASMCodeFragment frag=new ASMCodeFragment(CodeType.GENERATES_VALUE);
		frag.add(Duplicate);
		frag.add(JumpFalse, RunTime.RATIONALIZE_DIVIDE_BY_ZERO_RUNTIME_ERROR);
		storeITo(frag, RunTime.EXPRESS_OVER_DENOMINATOR);
		storeITo(frag, RunTime.RATIONAL_DENOMINATOR_TEMP);
		storeITo(frag, RunTime.RATIONAL_NUMERATOR_TEMP);
		loadIFrom(frag, RunTime.RATIONAL_NUMERATOR_TEMP);
		loadIFrom(frag, RunTime.EXPRESS_OVER_DENOMINATOR);
		frag.add(Multiply);
		loadIFrom(frag, RunTime.RATIONAL_DENOMINATOR_TEMP);
		frag.add(Divide);
		loadIFrom(frag,RunTime.EXPRESS_OVER_DENOMINATOR);
		frag.add(Call, RunTime.LOWEST_TERMS);
		
		return frag;
	}

}

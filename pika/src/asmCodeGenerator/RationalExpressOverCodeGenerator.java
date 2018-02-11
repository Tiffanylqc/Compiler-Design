package asmCodeGenerator;

import asmCodeGenerator.codeStorage.ASMCodeFragment;
import asmCodeGenerator.codeStorage.ASMCodeFragment.CodeType;
import parseTree.ParseNode;
import asmCodeGenerator.runtime.RunTime;
import static asmCodeGenerator.codeStorage.ASMOpcode.*;
import static asmCodeGenerator.Macros.*;

public class RationalExpressOverCodeGenerator implements SimpleCodeGenerator {

	public RationalExpressOverCodeGenerator() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public ASMCodeFragment generate(ParseNode node) {
		ASMCodeFragment frag=new ASMCodeFragment(CodeType.GENERATES_VALUE);
		frag.add(Duplicate);
		frag.add(JumpFalse, RunTime.EXPRESSOVER_DIVIDE_BY_ZERO_RUNTIME_ERROR);
		storeITo(frag, RunTime.EXPRESS_OVER_DENOMINATOR);
		storeITo(frag, RunTime.RATIONAL_DENOMINATOR_TEMP);
		storeITo(frag, RunTime.RATIONAL_NUMERATOR_TEMP);
		loadIFrom(frag, RunTime.RATIONAL_NUMERATOR_TEMP);
		loadIFrom(frag, RunTime.EXPRESS_OVER_DENOMINATOR);
		frag.add(Multiply);
		loadIFrom(frag, RunTime.RATIONAL_DENOMINATOR_TEMP);
		frag.add(Divide);
		
		return frag;
	}

}

package asmCodeGenerator;

import static asmCodeGenerator.codeStorage.ASMOpcode.*;
import asmCodeGenerator.codeStorage.ASMCodeFragment;
import asmCodeGenerator.codeStorage.ASMCodeFragment.CodeType;
import asmCodeGenerator.runtime.RunTime;
import parseTree.ParseNode;

public class FloatingExpressOverCodeGenerator implements SimpleCodeGenerator {

	public FloatingExpressOverCodeGenerator() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public ASMCodeFragment generate(ParseNode node) {
		ASMCodeFragment frag=new ASMCodeFragment(CodeType.GENERATES_VALUE);
		frag.add(Duplicate);
		frag.add(JumpFalse, RunTime.EXPRESSOVER_DIVIDE_BY_ZERO_RUNTIME_ERROR);
		frag.add(ConvertF);
		frag.add(FMultiply);
		frag.add(ConvertI);
				
		return frag;
	}

}

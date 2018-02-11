package asmCodeGenerator;

import asmCodeGenerator.codeStorage.ASMCodeFragment;
import asmCodeGenerator.codeStorage.ASMCodeFragment.CodeType;
import asmCodeGenerator.runtime.RunTime;
import parseTree.ParseNode;
import static asmCodeGenerator.codeStorage.ASMOpcode.*;

public class FormRationalCodeGenerator implements SimpleCodeGenerator {

	public FormRationalCodeGenerator() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public ASMCodeFragment generate(ParseNode node) {
		ASMCodeFragment frag=new ASMCodeFragment(CodeType.GENERATES_VALUE);
		frag.add(Call, RunTime.LOWEST_TERMS);
//		frag.add(PStack);
		return frag;
	}

}

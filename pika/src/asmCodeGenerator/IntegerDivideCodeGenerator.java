package asmCodeGenerator;

import static asmCodeGenerator.codeStorage.ASMOpcode.Divide;
import static asmCodeGenerator.codeStorage.ASMOpcode.Duplicate;
import static asmCodeGenerator.codeStorage.ASMOpcode.JumpFalse;
import parseTree.ParseNode;
import asmCodeGenerator.codeStorage.ASMCodeFragment;
import asmCodeGenerator.codeStorage.ASMCodeFragment.CodeType;
import asmCodeGenerator.runtime.RunTime;

public class IntegerDivideCodeGenerator implements SimpleCodeGenerator {
	public ASMCodeFragment generate(ParseNode node) {
		ASMCodeFragment fragment = new ASMCodeFragment(CodeType.GENERATES_VALUE);
		fragment.add(Duplicate);
		fragment.add(JumpFalse, RunTime.INTEGER_DIVIDE_BY_ZERO_RUNTIME_ERROR);
		fragment.add(Divide);
		return fragment;
	}
}

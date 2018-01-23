package asmCodeGenerator;

import static asmCodeGenerator.codeStorage.ASMOpcode.*;
import parseTree.ParseNode;
import asmCodeGenerator.codeStorage.ASMCodeFragment;
import asmCodeGenerator.codeStorage.ASMCodeFragment.CodeType;
import asmCodeGenerator.runtime.RunTime;

public class FloatDivideCodeGenerator implements SimpleCodeGenerator {
	public ASMCodeFragment generate(ParseNode node) {
		ASMCodeFragment fragment = new ASMCodeFragment(CodeType.GENERATES_VALUE);
		//suppose a/b
		//[...a b]    b(f)->b is float number b(i)->b is converted to int
		fragment.add(Duplicate);//[...a b(f) b(f)]
		fragment.add(JumpFZero, RunTime.FLOAT_DIVIDE_BY_ZERO_RUNTIME_ERROR);
		fragment.add(FDivide);
		return fragment;
	}
}


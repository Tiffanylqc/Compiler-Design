package asmCodeGenerator;

import static asmCodeGenerator.codeStorage.ASMOpcode.BTAnd;
import static asmCodeGenerator.codeStorage.ASMOpcode.PushI;

import asmCodeGenerator.codeStorage.ASMCodeFragment;
import asmCodeGenerator.codeStorage.ASMCodeFragment.CodeType;
import parseTree.ParseNode;

public class IfCodeGenerator implements SimpleCodeGenerator {


	@Override
	public ASMCodeFragment generate(ParseNode node) {
		ASMCodeFragment fragment = new ASMCodeFragment(CodeType.GENERATES_VOID);
		
		return fragment;
	}

}

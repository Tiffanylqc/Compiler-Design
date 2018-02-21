package asmCodeGenerator;

import asmCodeGenerator.codeStorage.ASMCodeFragment;
import asmCodeGenerator.codeStorage.ASMCodeFragment.CodeType;
import parseTree.ParseNode;
import static asmCodeGenerator.codeStorage.ASMOpcode.*;
import static asmCodeGenerator.runtime.Record.*;
import static asmCodeGenerator.Macros.*;
import static asmCodeGenerator.runtime.RunTime.*;

public class ReleaseCodeGenerator implements SimpleCodeGenerator {

	public ReleaseCodeGenerator() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public ASMCodeFragment generate(ParseNode node) {
		ASMCodeFragment frag=new ASMCodeFragment(CodeType.GENERATES_VOID);
		//[...recordPtr]
//		frag.add(Memtop);
//		frag.add(PStack);
		frag.add(Call,RELEASE_RECORD);
//		frag.add(Memtop);
//		frag.add(PStack);
		return frag;
	}

}

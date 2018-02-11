package asmCodeGenerator;

import asmCodeGenerator.codeStorage.ASMCodeFragment;
import asmCodeGenerator.codeStorage.ASMCodeFragment.CodeType;
import asmCodeGenerator.runtime.Record;
import asmCodeGenerator.runtime.RunTime;
import parseTree.ParseNode;
import static asmCodeGenerator.runtime.RunTime.*;
import static asmCodeGenerator.Macros.*;
import static asmCodeGenerator.codeStorage.ASMOpcode.*;

public class CloneCodeGenerator implements SimpleCodeGenerator {

	public CloneCodeGenerator() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public ASMCodeFragment generate(ParseNode node) {
		ASMCodeFragment frag=new ASMCodeFragment(CodeType.GENERATES_VALUE);
		//[...clonedArrPtr]
		cloneArrayRecord(frag);

		return frag;
	}

}

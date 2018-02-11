package asmCodeGenerator;

import static asmCodeGenerator.Macros.loadIFrom;
import static asmCodeGenerator.Macros.storeITo;
import static asmCodeGenerator.codeStorage.ASMOpcode.*;

import asmCodeGenerator.codeStorage.ASMCodeFragment;
import asmCodeGenerator.codeStorage.ASMCodeFragment.CodeType;
import asmCodeGenerator.runtime.RunTime;
import parseTree.ParseNode;

public class FloatingToRationalCodeGenerator implements SimpleCodeGenerator {

	public FloatingToRationalCodeGenerator() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public ASMCodeFragment generate(ParseNode node) {
		ASMCodeFragment frag = new ASMCodeFragment(CodeType.GENERATES_VALUE);
		frag.add(PushI,223092870);
		
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

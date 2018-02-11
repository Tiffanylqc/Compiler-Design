package asmCodeGenerator;

import static asmCodeGenerator.Macros.loadIFrom;
import static asmCodeGenerator.Macros.storeITo;
import static asmCodeGenerator.codeStorage.ASMOpcode.Call;
import static asmCodeGenerator.codeStorage.ASMOpcode.Multiply;
import static asmCodeGenerator.codeStorage.ASMOpcode.Divide;
import asmCodeGenerator.codeStorage.ASMCodeFragment;
import asmCodeGenerator.codeStorage.ASMCodeFragment.CodeType;
import asmCodeGenerator.runtime.RunTime;
import parseTree.ParseNode;

public class RationalDivideCodeGenerator implements SimpleCodeGenerator {

	public RationalDivideCodeGenerator() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public ASMCodeFragment generate(ParseNode node) {
		ASMCodeFragment frag=new ASMCodeFragment(CodeType.GENERATES_VALUE);
		//[...num1 deno1 num2 deno2]
		storeITo(frag,RunTime.RATIONAL_DENOMINATOR_TEMP2);
		storeITo(frag,RunTime.RATIONAL_NUMERATOR_TEMP2);
		storeITo(frag,RunTime.RATIONAL_DENOMINATOR_TEMP);
		storeITo(frag,RunTime.RATIONAL_NUMERATOR_TEMP);
		
		
		loadIFrom(frag,RunTime.RATIONAL_NUMERATOR_TEMP);
		loadIFrom(frag,RunTime.RATIONAL_DENOMINATOR_TEMP2);
		frag.add(Multiply);
		
		loadIFrom(frag,RunTime.RATIONAL_NUMERATOR_TEMP2);
		loadIFrom(frag,RunTime.RATIONAL_DENOMINATOR_TEMP);
		frag.add(Multiply);
		
		frag.add(Call,RunTime.LOWEST_TERMS);
		return frag;
	}

}

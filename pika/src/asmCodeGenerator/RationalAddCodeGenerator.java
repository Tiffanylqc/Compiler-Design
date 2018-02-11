package asmCodeGenerator;

import asmCodeGenerator.codeStorage.ASMCodeFragment;
import asmCodeGenerator.codeStorage.ASMCodeFragment.CodeType;
import parseTree.ParseNode;
import static asmCodeGenerator.codeStorage.ASMOpcode.*;
import static asmCodeGenerator.Macros.*;
import asmCodeGenerator.runtime.RunTime;

public class RationalAddCodeGenerator implements SimpleCodeGenerator {

	public RationalAddCodeGenerator() {
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
		
		
		loadIFrom(frag,RunTime.RATIONAL_DENOMINATOR_TEMP);
		loadIFrom(frag,RunTime.RATIONAL_DENOMINATOR_TEMP2);
		frag.add(Multiply);
		//[...deno1*deno2]
		loadIFrom(frag,RunTime.RATIONAL_DENOMINATOR_TEMP);
		loadIFrom(frag,RunTime.RATIONAL_NUMERATOR_TEMP2);
		frag.add(Multiply);
		loadIFrom(frag,RunTime.RATIONAL_DENOMINATOR_TEMP2);
		loadIFrom(frag,RunTime.RATIONAL_NUMERATOR_TEMP);
		frag.add(Multiply);
		frag.add(Add);
		//[...deno1*deno2 deno1*num2+deno2*num1]
		frag.add(Exchange);
		frag.add(Call,RunTime.LOWEST_TERMS);
		
		return frag;
	}

}

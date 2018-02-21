package asmCodeGenerator;

import static asmCodeGenerator.Macros.loadIFrom;
import static asmCodeGenerator.Macros.storeITo;
import static asmCodeGenerator.codeStorage.ASMOpcode.*;

import asmCodeGenerator.codeStorage.ASMCodeFragment;
import asmCodeGenerator.codeStorage.ASMCodeFragment.CodeType;
import asmCodeGenerator.runtime.RunTime;
import parseTree.ParseNode;

public class RationalSubtractCodeGenerator implements SimpleCodeGenerator {

	public RationalSubtractCodeGenerator() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public ASMCodeFragment generate(ParseNode node) {
		ASMCodeFragment frag=new ASMCodeFragment(CodeType.GENERATES_VALUE);
//		//[...num1 deno1 num2 deno2]
//		storeITo(frag,RunTime.RATIONAL_DENOMINATOR_TEMP2);
//		storeITo(frag,RunTime.RATIONAL_NUMERATOR_TEMP2);
//		storeITo(frag,RunTime.RATIONAL_DENOMINATOR_TEMP);
//		storeITo(frag,RunTime.RATIONAL_NUMERATOR_TEMP);
//		
//		
//		loadIFrom(frag,RunTime.RATIONAL_DENOMINATOR_TEMP);
//		loadIFrom(frag,RunTime.RATIONAL_DENOMINATOR_TEMP2);
//		frag.add(Multiply);
//		//[...deno1*deno2]
//		loadIFrom(frag,RunTime.RATIONAL_DENOMINATOR_TEMP2);
//		loadIFrom(frag,RunTime.RATIONAL_NUMERATOR_TEMP);
//		frag.add(Multiply);
//		loadIFrom(frag,RunTime.RATIONAL_DENOMINATOR_TEMP);
//		loadIFrom(frag,RunTime.RATIONAL_NUMERATOR_TEMP2);
//		frag.add(Multiply);
//		
//		frag.add(Subtract);
//		//[...deno1*deno2 deno2*num1-deno1*num2]
//		frag.add(Exchange);
//		frag.add(Call,RunTime.LOWEST_TERMS);
		frag.add(Call,RunTime.SUBTRACT_RATIONAL);
		return frag;
	}

}

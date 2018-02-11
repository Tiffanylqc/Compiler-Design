package asmCodeGenerator;

import asmCodeGenerator.codeStorage.ASMCodeFragment;
import asmCodeGenerator.codeStorage.ASMCodeFragment.CodeType;
import parseTree.ParseNode;
import static asmCodeGenerator.codeStorage.ASMOpcode.*;

public class RationalToFloatCodeGenerator implements SimpleCodeGenerator {

	public RationalToFloatCodeGenerator() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public ASMCodeFragment generate(ParseNode node) {
		ASMCodeFragment frag = new ASMCodeFragment(CodeType.GENERATES_VALUE);
		
		frag.add(Exchange);
		//[..deno(int) num(int)]
		frag.add(ConvertF);
		//[..deno(int) num(float)]
		frag.add(Exchange);
		//[.. num(float) deno(int)]
		frag.add(ConvertF);
		//[.. num(float) deno(float)]
		frag.add(FDivide);
		//[.. num(float)/deno(float)]
		
		return frag;
	}

}

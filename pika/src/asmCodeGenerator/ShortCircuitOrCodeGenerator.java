package asmCodeGenerator;

import asmCodeGenerator.codeStorage.ASMCodeFragment;
import asmCodeGenerator.codeStorage.ASMCodeFragment.CodeType;
import parseTree.ParseNode;
import static asmCodeGenerator.codeStorage.ASMOpcode.*;

public class ShortCircuitOrCodeGenerator implements FullCodeGenerator {

	public ShortCircuitOrCodeGenerator() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public ASMCodeFragment  generate (ParseNode node, ASMCodeFragment... args) {
		ASMCodeFragment frag = new ASMCodeFragment(CodeType.GENERATES_VALUE);
		Labeller labeller = new Labeller("SC-Or");
		final String trueLabel = labeller.newLabel("short-circuit-true");
		final String endLabel = labeller.newLabel("end");
		// compute arg 1
		frag.append(args[0]); // [... bool]
		// short circuiting test
		frag.add(Duplicate); // [... bool bool]
		frag.add(JumpTrue, trueLabel); // [... bool]
		frag.add(Pop); // [... 0] -> [...]
		// compute arg 2
		frag.append(args[1]); // [... bool]
		frag.add(Jump, endLabel);
		// the end
		frag.add(Label, trueLabel); // [... 1]
		frag.add(Label, endLabel);
		return frag;
	}
		
}

package asmCodeGenerator;

import static asmCodeGenerator.codeStorage.ASMOpcode.*;

import asmCodeGenerator.codeStorage.ASMCodeFragment;
import asmCodeGenerator.codeStorage.ASMCodeFragment.CodeType;
import parseTree.ParseNode;

public class ShortCircuitAndCodeGenerator implements FullCodeGenerator {

	public ShortCircuitAndCodeGenerator() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public ASMCodeFragment generate(ParseNode node, ASMCodeFragment... args) {
		ASMCodeFragment frag = new ASMCodeFragment(CodeType.GENERATES_VALUE);
		Labeller labeller = new Labeller("compare-boolAnd");
		String startLabel = labeller.newLabel("arg1");
		String trueLabel  = labeller.newLabel("true");
		String falseLabel = labeller.newLabel("false");
		String joinLabel  = labeller.newLabel("join");
		
		frag.add(Label, startLabel);
		frag.append(args[0]);//[...arg1]
		frag.add(Duplicate);
		frag.add(JumpFalse,falseLabel);//[...arg1]
		frag.add(Pop);
		frag.append(args[1]);//[...arg2]
		
		frag.add(JumpTrue, trueLabel);//if arg2 is true
		frag.add(Jump, falseLabel);

		frag.add(Label, trueLabel);
		frag.add(PushI, 1);
		frag.add(Jump, joinLabel);
		
		frag.add(Label, falseLabel);
		frag.add(PushI, 0);
		frag.add(Jump, joinLabel);
		frag.add(Label, joinLabel);
		
		return frag;
	}

}

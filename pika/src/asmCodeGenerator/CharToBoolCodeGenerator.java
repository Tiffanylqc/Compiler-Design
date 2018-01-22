package asmCodeGenerator;

import static asmCodeGenerator.codeStorage.ASMOpcode.Jump;
import static asmCodeGenerator.codeStorage.ASMOpcode.JumpTrue;
import static asmCodeGenerator.codeStorage.ASMOpcode.Label;
import static asmCodeGenerator.codeStorage.ASMOpcode.PushI;
import static asmCodeGenerator.codeStorage.ASMOpcode.Subtract;

import asmCodeGenerator.codeStorage.ASMCodeFragment;
import asmCodeGenerator.codeStorage.ASMCodeFragment.CodeType;
import parseTree.ParseNode;

public class CharToBoolCodeGenerator implements SimpleCodeGenerator {

	@Override
	public ASMCodeFragment generate(ParseNode node) {
		ASMCodeFragment fragment = new ASMCodeFragment(CodeType.GENERATES_VALUE);
		
		Labeller labeller = new Labeller("castCharToBool");
		String trueLabel  = labeller.newLabel("true");
		String falseLabel = labeller.newLabel("false");
		String joinLabel  = labeller.newLabel("join");
		
		fragment.add(PushI,0);//[...num,0]
		fragment.add(Subtract);//[...num-0]

		fragment.add(JumpTrue, trueLabel);//if arg1-arg2!=0 then true
		fragment.add(Jump, falseLabel);
		fragment.add(Label, trueLabel);
		fragment.add(PushI, 1);
		fragment.add(Jump, joinLabel);
		fragment.add(Label, falseLabel);
		fragment.add(PushI, 0);
		fragment.add(Jump, joinLabel);
		fragment.add(Label, joinLabel);
		
		return fragment;
	}

}

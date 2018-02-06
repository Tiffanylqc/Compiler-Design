package asmCodeGenerator;

import static asmCodeGenerator.codeStorage.ASMOpcode.Jump;
import static asmCodeGenerator.codeStorage.ASMOpcode.JumpTrue;
import static asmCodeGenerator.codeStorage.ASMOpcode.Label;

import asmCodeGenerator.ASMCodeGenerator.CodeVisitor;
import asmCodeGenerator.codeStorage.ASMCodeFragment;
import asmCodeGenerator.codeStorage.ASMCodeFragment.CodeType;
import parseTree.ParseNode;

public class WhileCodeGenerator implements SimpleCodeGenerator {
	ASMCodeFragment code;
	CodeVisitor visitor;
	
	public WhileCodeGenerator(ASMCodeFragment code, CodeVisitor visitor) {
		super();
		this.code = code;
		this.visitor = visitor;
	}

	@Override
	public ASMCodeFragment generate(ParseNode node) {
		ASMCodeFragment fragment = new ASMCodeFragment(CodeType.GENERATES_VOID);
		ASMCodeFragment condition = visitor.removeValueCode(node.child(0));
		ASMCodeFragment loopBody = visitor.removeVoidCode(node.child(1));
		
		Labeller labeller = new Labeller("while");
		
		String startLabel = labeller.newLabel("condition");
		String loopLabel  = labeller.newLabel("loopBody");
		String trueLabel  = labeller.newLabel("true");
		String falseLabel = labeller.newLabel("false");
		String joinLabel  = labeller.newLabel("join");
		
		code.add(Label, startLabel);
		code.append(condition);
		code.add(JumpTrue,trueLabel);
		code.add(Jump,falseLabel);
		code.add(Label, trueLabel);
		code.append(loopBody);
		code.add(Jump,startLabel);
		code.add(Label, falseLabel);
		code.add(Jump, joinLabel);
		code.add(Label,joinLabel);
		return fragment;
	}

}

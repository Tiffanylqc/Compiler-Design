package asmCodeGenerator;

import static asmCodeGenerator.codeStorage.ASMOpcode.BTAnd;
import static asmCodeGenerator.codeStorage.ASMOpcode.Jump;
import static asmCodeGenerator.codeStorage.ASMOpcode.JumpTrue;
import static asmCodeGenerator.codeStorage.ASMOpcode.Label;
import static asmCodeGenerator.codeStorage.ASMOpcode.PushI;
import asmCodeGenerator.ASMCodeGenerator.CodeVisitor;
import asmCodeGenerator.codeStorage.ASMCodeFragment;
import asmCodeGenerator.codeStorage.ASMCodeFragment.CodeType;
import parseTree.ParseNode;

public class IfCodeGenerator implements SimpleCodeGenerator {
	ASMCodeFragment code;
	CodeVisitor visitor;

	public IfCodeGenerator(ASMCodeFragment code, CodeVisitor visitor) {
		super();
		this.code = code;
		this.visitor = visitor;
	}
	
	@Override
	public ASMCodeFragment generate(ParseNode node) {
		ASMCodeFragment fragment = new ASMCodeFragment(CodeType.GENERATES_VOID);
		
		ASMCodeFragment condition = visitor.removeValueCode(node.child(0));
		ASMCodeFragment ifBody = visitor.removeVoidCode(node.child(1));
		
		Labeller labeller = new Labeller("if");
		String startLabel = labeller.newLabel("condition");
		String ifLabel = labeller.newLabel("ifBody");
		String elseLabel = labeller.newLabel("elseBody");
		String joinLabel  = labeller.newLabel("join");
		
		code.add(Label,startLabel);
		code.append(condition);
		code.add(JumpTrue,ifLabel);
		code.add(Jump,elseLabel);
		code.add(Label,ifLabel);
		code.append(ifBody);
		code.add(Jump, joinLabel);
		code.add(Label,elseLabel);
		if(node.nChildren()==3){
			code.append(visitor.removeVoidCode(node.child(2)));
		}
		code.add(Label,joinLabel);
		return fragment;
	}

}

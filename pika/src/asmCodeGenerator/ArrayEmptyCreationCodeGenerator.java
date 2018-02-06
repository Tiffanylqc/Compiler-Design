package asmCodeGenerator;

import asmCodeGenerator.ASMCodeGenerator.CodeVisitor;
import asmCodeGenerator.codeStorage.ASMCodeFragment;
import asmCodeGenerator.codeStorage.ASMCodeFragment.CodeType;
import parseTree.ParseNode;

public class ArrayEmptyCreationCodeGenerator implements SimpleCodeGenerator {

	ASMCodeFragment code;
	CodeVisitor visitor;
	public ArrayEmptyCreationCodeGenerator(ASMCodeFragment code, CodeVisitor visitor) {
		super();
		this.code = code;
		this.visitor = visitor;
	}

	@Override
	public ASMCodeFragment generate(ParseNode node) {
		ASMCodeFragment fragment = new ASMCodeFragment(CodeType.GENERATES_VOID);
		
		ASMCodeFragment condition = visitor.removeValueCode(node.child(0));
		ASMCodeFragment ifBody = visitor.removeVoidCode(node.child(1));
		
		return fragment;
	}

}

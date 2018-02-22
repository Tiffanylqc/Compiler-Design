package asmCodeGenerator;

import static asmCodeGenerator.Macros.loadIFrom;
import static asmCodeGenerator.codeStorage.ASMOpcode.*;
import asmCodeGenerator.ASMCodeGenerator.CodeVisitor;
import asmCodeGenerator.codeStorage.ASMCodeFragment;
import asmCodeGenerator.codeStorage.ASMCodeFragment.CodeType;
import asmCodeGenerator.runtime.Record;
import asmCodeGenerator.runtime.RunTime;
import parseTree.ParseNode;
import parseTree.nodeTypes.ArrayTypeNode;
import semanticAnalyzer.types.*;
public class ArrayEmptyCreationCodeGenerator implements SimpleCodeGenerator {


	public ArrayEmptyCreationCodeGenerator() {

	}

	@Override
	public ASMCodeFragment generate(ParseNode node) {
		ASMCodeFragment fragment = new ASMCodeFragment(CodeType.GENERATES_VALUE);
		Array type=(Array)(((ArrayTypeNode)node.child(0)).getType());
		int subtypeSize=type.getSubtype().getSize();
		
		int statusFlags=0;
		if(type.getSubtype() instanceof Array||type.getSubtype() == PrimitiveType.STRING){//set the subtype-is-reference status
			statusFlags+=2;
		}
		//[...nElems]
		RunTime.createEmptyArrayRecord(fragment,statusFlags,subtypeSize);
		//[...]
		loadIFrom(fragment, RunTime.RECORD_CREATION_TEMP);
		//[...arrPtr]
		
		return fragment;
	}

}

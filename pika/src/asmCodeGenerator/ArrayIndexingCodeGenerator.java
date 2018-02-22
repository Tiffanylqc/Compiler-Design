package asmCodeGenerator;

import asmCodeGenerator.codeStorage.ASMCodeFragment;
import asmCodeGenerator.codeStorage.ASMCodeFragment.CodeType;
import asmCodeGenerator.runtime.RunTime;

import static asmCodeGenerator.codeStorage.ASMOpcode.*;
import parseTree.ParseNode;
import semanticAnalyzer.types.Array;
import semanticAnalyzer.types.*;
import static asmCodeGenerator.runtime.RunTime.*;
import static asmCodeGenerator.runtime.Record.*;

public class ArrayIndexingCodeGenerator implements SimpleCodeGenerator {
	
	public ArrayIndexingCodeGenerator() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public ASMCodeFragment generate(ParseNode node) {
		ASMCodeFragment frag=new ASMCodeFragment(CodeType.GENERATES_ADDRESS);
		
		// [… arr index]
		
		Macros.storeITo(frag, ARRAY_INDEXING_INDEX);// [… arr]
		Macros.storeITo(frag, ARRAY_INDEXING_ARRAY);// [… ]
		
		Macros.loadIFrom(frag, ARRAY_INDEXING_ARRAY);// [… arr]
		frag.add(JumpFalse, NULL_ARRAY_RUNTIME_ERROR);// [… ]
		
		Macros.loadIFrom(frag, ARRAY_INDEXING_INDEX);// [… index]
		
		frag.add(JumpNeg, INDEX_OUT_OF_BOUNDS_RUNTIME_ERROR);// [… ]
		
		Macros.loadIFrom(frag, ARRAY_INDEXING_INDEX);
		Macros.loadIFrom(frag, ARRAY_INDEXING_ARRAY);
//		frag.add(PStack);
		Macros.readIOffset(frag, ARRAY_LENGTH_OFFSET);
//		frag.add(PStack);
		frag.add(Subtract);
		
		Labeller labeller=new Labeller("array-indexing");
		String label = labeller.newLabel("in-bounds");
//		frag.add(PStack);
		frag.add(JumpNeg,label);
		frag.add(Jump,INDEX_OUT_OF_BOUNDS_RUNTIME_ERROR);
		frag.add(Label,label);
		frag.add(Nop);
		
		Macros.loadIFrom(frag, ARRAY_INDEXING_ARRAY);
		frag.add(PushI, ARRAY_HEADER_SIZE);
		frag.add(Add);
		Macros.loadIFrom(frag, ARRAY_INDEXING_INDEX);
		Array arrayType = (Array)(node.child(0).getType());
		Type subtype = arrayType.getSubtype();
		frag.add(PushI, subtype.getSize());
		frag.add(Multiply);
		frag.add(Add);
		
		
		return frag;
	}

}

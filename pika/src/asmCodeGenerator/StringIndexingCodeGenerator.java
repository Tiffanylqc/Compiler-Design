package asmCodeGenerator;

import static asmCodeGenerator.codeStorage.ASMOpcode.Add;
import static asmCodeGenerator.codeStorage.ASMOpcode.Jump;
import static asmCodeGenerator.codeStorage.ASMOpcode.JumpFalse;
import static asmCodeGenerator.codeStorage.ASMOpcode.JumpNeg;
import static asmCodeGenerator.codeStorage.ASMOpcode.Label;
import static asmCodeGenerator.codeStorage.ASMOpcode.Multiply;
import static asmCodeGenerator.codeStorage.ASMOpcode.Nop;
import static asmCodeGenerator.codeStorage.ASMOpcode.PushI;
import static asmCodeGenerator.codeStorage.ASMOpcode.Subtract;
import static asmCodeGenerator.runtime.Record.STRING_HEADER_SIZE;
import static asmCodeGenerator.runtime.Record.STRING_LENGTH_OFFSET;
import static asmCodeGenerator.runtime.RunTime.ARRAY_INDEXING_ARRAY;
import static asmCodeGenerator.runtime.RunTime.ARRAY_INDEXING_INDEX;
import static asmCodeGenerator.runtime.RunTime.INDEX_OUT_OF_BOUNDS_RUNTIME_ERROR;
import static asmCodeGenerator.runtime.RunTime.NULL_ARRAY_RUNTIME_ERROR;

import asmCodeGenerator.codeStorage.ASMCodeFragment;
import asmCodeGenerator.codeStorage.ASMCodeFragment.CodeType;
import parseTree.ParseNode;
import semanticAnalyzer.types.Array;
import semanticAnalyzer.types.Type;

public class StringIndexingCodeGenerator implements SimpleCodeGenerator {

	public StringIndexingCodeGenerator() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public ASMCodeFragment generate(ParseNode node) {
		ASMCodeFragment frag=new ASMCodeFragment(CodeType.GENERATES_ADDRESS);
		
		// [… strAddr index]
		
		Macros.storeITo(frag, ARRAY_INDEXING_INDEX);// [… arr]
		Macros.storeITo(frag, ARRAY_INDEXING_ARRAY);// [… ]
		
		Macros.loadIFrom(frag, ARRAY_INDEXING_ARRAY);// [… arr]
		frag.add(JumpFalse, NULL_ARRAY_RUNTIME_ERROR);// [… ]
		
		Macros.loadIFrom(frag, ARRAY_INDEXING_INDEX);// [… index]
		
		frag.add(JumpNeg, INDEX_OUT_OF_BOUNDS_RUNTIME_ERROR);// [… ]
		
		Macros.loadIFrom(frag, ARRAY_INDEXING_INDEX);
		Macros.loadIFrom(frag, ARRAY_INDEXING_ARRAY);
//		frag.add(PStack);
		Macros.readIOffset(frag, STRING_LENGTH_OFFSET);
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
		frag.add(PushI, STRING_HEADER_SIZE);
		frag.add(Add);
		Macros.loadIFrom(frag, ARRAY_INDEXING_INDEX);
		frag.add(PushI, 1);
		frag.add(Multiply);
		frag.add(Add);
		
		
		return frag;
	}

}

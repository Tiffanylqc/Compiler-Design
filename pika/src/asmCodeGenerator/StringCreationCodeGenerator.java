package asmCodeGenerator;

import asmCodeGenerator.codeStorage.ASMCodeFragment;
import asmCodeGenerator.codeStorage.ASMCodeFragment.CodeType;
import asmCodeGenerator.runtime.Record;
import static asmCodeGenerator.runtime.RunTime.*;
import parseTree.ParseNode;
import parseTree.nodeTypes.StringConstantNode;
import static asmCodeGenerator.codeStorage.ASMOpcode.*;
import static asmCodeGenerator.Macros.*;
import static asmCodeGenerator.runtime.Record.*;

public class StringCreationCodeGenerator implements SimpleCodeGenerator {

	public StringCreationCodeGenerator() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public ASMCodeFragment generate(ParseNode node) {
		StringConstantNode strNode=(StringConstantNode)node;
		String strValue=strNode.getValue();
		
		int length=strValue.length();
		ASMCodeFragment frag = new ASMCodeFragment(CodeType.GENERATES_VALUE);
		//[...]
		frag.add(PushI,length);
		frag.add(PushI,1);
		frag.add(Add);
		frag.add(PushI,STRING_HEADER_SIZE);
		frag.add(Add);
		//[...totSize]
		createRecord(frag, STRING_TYPE_ID, STRING_STATUS);
		
		// store the length
		writeIPBaseOffset(frag,RECORD_CREATION_TEMP, STRING_LENGTH_OFFSET, length);
		//store the nullChar
		int nullOffset=length+STRING_HEADER_SIZE;
		writeCPBaseOffset(frag,RECORD_CREATION_TEMP,nullOffset,0);
		
		//store characters
		for(int i=0;i<length;i++){
			writeCPBaseOffset(frag,RECORD_CREATION_TEMP,STRING_HEADER_SIZE+i,(int)strValue.charAt(i));
		}
		
//		loadIFrom(frag, RECORD_CREATION_TEMP);
//		readCOffset(frag,15);
//		frag.add(PStack);
//		frag.add(Pop);
		
		loadIFrom(frag, RECORD_CREATION_TEMP);
		return frag;
	}

}

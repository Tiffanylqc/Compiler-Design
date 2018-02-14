package asmCodeGenerator;

import asmCodeGenerator.codeStorage.ASMCodeFragment;
import asmCodeGenerator.codeStorage.ASMOpcode;
import asmCodeGenerator.codeStorage.ASMCodeFragment.CodeType;
import asmCodeGenerator.runtime.Record;
import parseTree.ParseNode;
import parseTree.nodeTypes.ArrayTypeNode;
import semanticAnalyzer.types.*;
import static asmCodeGenerator.Macros.*;
import static asmCodeGenerator.runtime.RunTime.*;
import static asmCodeGenerator.codeStorage.ASMOpcode.*;

public class ArrayPopulateCreationCodeGenerator implements FullCodeGenerator {

	public ArrayPopulateCreationCodeGenerator() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public ASMCodeFragment generate(ParseNode node, ASMCodeFragment... args) {
		ASMCodeFragment frag = new ASMCodeFragment(CodeType.GENERATES_VALUE);
		
		Type type=node.child(0).getType();
		int subtypeSize=type.getSize();
		
		int statusFlags=0;
		if(type instanceof Array){//set the subtype-is-reference status
			statusFlags+=2;
		}
		
		frag.add(PushI,subtypeSize);
		frag.add(PushI,node.nChildren());
		
		frag.add(Multiply);
		frag.add(PushI,Record.ARRAY_HEADER_SIZE);
		frag.add(Add);
		//[...totSize]
		createRecord(frag,Record.ARRAY_TYPE_ID,statusFlags);
		writeIPBaseOffset(frag,RECORD_CREATION_TEMP,Record.ARRAY_LENGTH_OFFSET,node.nChildren());
		writeIPBaseOffset(frag,RECORD_CREATION_TEMP,Record.ARRAY_SUBTYPE_SIZE_OFFSET,subtypeSize);
		
		//[...]->[...arrAddr]
		Labeller labeller = new Labeller("populate-creation");
		String elemAddrLabel = labeller.newLabel("elemAddr");
		declareI(frag,elemAddrLabel);
		
		loadIFrom(frag, RECORD_CREATION_TEMP);
		
		frag.add(Duplicate);
		frag.add(PushI,Record.ARRAY_HEADER_SIZE);
		frag.add(Add);
//		frag.add(PStack);
		storeITo(frag, elemAddrLabel);
//		frag.add(PStack);
		for(int i=0;i<node.nChildren();i++){
			if(type==PrimitiveType.RATIONAL){
				Labeller rlabeller = new Labeller("rational-storage");
				String baseAddrLabel = rlabeller.newLabel("baseAddr");
				//store numerator from lvalue to lvalue+4
				//store denominator from lvalue+4 to lvalue+8
				frag.append(args[i]);//[...numerator denominator]
				
				loadIFrom(frag, elemAddrLabel);//[...numerator denominator &lvalue]
				declareI(frag,baseAddrLabel);
				storeITo(frag,baseAddrLabel);
				loadIFrom(frag,baseAddrLabel);//[...numerator denominator &lvalue]
				
				frag.add(PushI,4);//[...numerator denominator &lvalue 4]
				frag.add(Add);//[...numerator denominator &lvalue+4]
				
				frag.add(Exchange);//[...numerator &lvalue+4 denominator]
				frag.add(StoreI);//[...numerator]
				loadIFrom(frag,baseAddrLabel);//[...numerator &lvalue]

				frag.add(Exchange);//[... &lvalue numerator]
				frag.add(StoreI);//[...]
			}
			else{
				loadIFrom(frag, elemAddrLabel);
				frag.append(args[i]);
//				frag.add(PStack);
				frag.add(this.opcodeForStore(type));
			}
			frag.add(PushI,subtypeSize);
//			frag.add(PStack);
			addITo(frag,elemAddrLabel);
		}
		return frag;
	}
	
	
	private ASMOpcode opcodeForStore(Type type) {
		if(type == PrimitiveType.INTEGER) {
			return StoreI;
		}
		if(type == PrimitiveType.FLOATING) {
			return StoreF;
		}
		if(type == PrimitiveType.BOOLEAN) {
			return StoreC;
		}
		if(type==PrimitiveType.CHARACTER){
			return StoreC;
		}
		if(type==PrimitiveType.STRING){
			return StoreI;
		}
		if(type==PrimitiveType.RATIONAL){
			return Nop;
		}
		if(type instanceof Array){
			return StoreI;
		}
		assert false: "Type " + type + " unimplemented in opcodeForStore()";
		return null;
	}

}

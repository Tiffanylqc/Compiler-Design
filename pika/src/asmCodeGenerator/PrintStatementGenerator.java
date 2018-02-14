package asmCodeGenerator;

import static asmCodeGenerator.codeStorage.ASMOpcode.*;
import static asmCodeGenerator.runtime.Record.*;
import parseTree.ParseNode;
import parseTree.nodeTypes.NewlineNode;
import parseTree.nodeTypes.PrintStatementNode;
import parseTree.nodeTypes.SpaceNode;
import parseTree.nodeTypes.TabNode;
import semanticAnalyzer.types.Array;
import semanticAnalyzer.types.PrimitiveType;
import semanticAnalyzer.types.Type;
import asmCodeGenerator.ASMCodeGenerator.CodeVisitor;
import asmCodeGenerator.codeStorage.ASMCodeFragment;
import asmCodeGenerator.codeStorage.ASMCodeFragment.CodeType;
import asmCodeGenerator.runtime.Record;
import asmCodeGenerator.runtime.RunTime;
import static asmCodeGenerator.Macros.*;

public class PrintStatementGenerator {
	ASMCodeFragment code;
	ASMCodeGenerator.CodeVisitor visitor;
	
	
	public PrintStatementGenerator(ASMCodeFragment code, CodeVisitor visitor) {
		super();
		this.code = code;
		this.visitor = visitor;
	}

	public void generate(PrintStatementNode node) {
		for(ParseNode child : node.getChildren()) {
			if(child instanceof NewlineNode || child instanceof SpaceNode ||child instanceof TabNode) {
				ASMCodeFragment childCode = visitor.removeVoidCode(child);
				code.append(childCode);
			}
			else {
				appendPrintCode(child);
			}
		}
	}

	private void appendPrintCode(ParseNode node) {
		code.append(visitor.removeValueCode(node));
		if(node.getType()==PrimitiveType.RATIONAL){
			printRational(node);
		}
		else if(node.getType()==PrimitiveType.STRING){
			printString(node);
		}
		else if(node.getType() instanceof Array){
			printArray(node);
		}
		else{
			String format = printFormat(node.getType());
			if(node.getType() == PrimitiveType.BOOLEAN)
				convertToStringIfBoolean(node);
			code.add(PushD, format);
			code.add(Printf);
		}	
	}
	
	private void printArray(ParseNode node){
		Array type=(Array)node.getType();
		while(type.getSubtype() instanceof Array){
			type=(Array) type.getSubtype();
		}
		Type oneDimType=type.getSubtype();
		if(oneDimType==PrimitiveType.INTEGER)
			code.add(PushI,1);
		else if(oneDimType==PrimitiveType.FLOATING)
			code.add(PushI,2);
		else if(oneDimType==PrimitiveType.CHARACTER)
			code.add(PushI,3);
		else if(oneDimType==PrimitiveType.STRING)
			code.add(PushI,4);
		else if(oneDimType==PrimitiveType.RATIONAL)
			code.add(PushI,5);
		else if(oneDimType==PrimitiveType.BOOLEAN)
			code.add(PushI,6);
		
		//[...arrAddr typeNum]
		code.add(Call,RunTime.PRINT_ARRAY);
	}
	
	private void printString(ParseNode node){
		code.add(Call,RunTime.PRINT_STRING);
	}
	private void printRational(ParseNode node){
		code.add(Call,RunTime.PRINT_RATIONAL);
	}
	
	private void convertToStringIfBoolean(ParseNode node) {
		code.add(Call,RunTime.CONVERT_TO_STRING_IF_BOOL);
	}

	private static String printFormat(Type type) {
		
		assert type instanceof PrimitiveType;
		
		switch((PrimitiveType)type) {
		case INTEGER:	return RunTime.INTEGER_PRINT_FORMAT;
		case FLOATING: return RunTime.FLOATING_PRINT_FORMAT;
		case BOOLEAN:	return RunTime.BOOLEAN_PRINT_FORMAT;
		case CHARACTER: return RunTime.CHARACTER_PRINT_FORMAT;
//		case STRING: return RunTime.STRING_PRINT_FORMAT;
		default:		
			assert false : "Type " + type + " unimplemented in PrintStatementGenerator.printFormat()";
			return "";
		}
	}
}

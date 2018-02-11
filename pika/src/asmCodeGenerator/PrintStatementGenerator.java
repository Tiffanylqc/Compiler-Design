package asmCodeGenerator;

import static asmCodeGenerator.codeStorage.ASMOpcode.*;
import static asmCodeGenerator.runtime.Record.*;
import parseTree.ParseNode;
import parseTree.nodeTypes.NewlineNode;
import parseTree.nodeTypes.PrintStatementNode;
import parseTree.nodeTypes.SpaceNode;
import parseTree.nodeTypes.TabNode;
import semanticAnalyzer.types.PrimitiveType;
import semanticAnalyzer.types.Type;
import asmCodeGenerator.ASMCodeGenerator.CodeVisitor;
import asmCodeGenerator.codeStorage.ASMCodeFragment;
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
		else{
			String format = printFormat(node.getType());
			convertToStringIfBoolean(node);
			code.add(PushD, format);
			code.add(Printf);
		}
		
	}
	
	private void printString(ParseNode node){
		if(node.getType()!=PrimitiveType.STRING)
			return;
		
		Labeller labeller = new Labeller("print-string");
		String loopLabel=labeller.newLabel("loop-start");
		String endLabel=labeller.newLabel("end");
		
		//[..strAddr]
		code.add(Duplicate);
		code.add(PushI,STRING_HEADER_SIZE);
		code.add(Add);
		storeITo(code,RunTime.PRINT_STRING_TEMP);
		readIOffset(code,STRING_LENGTH_OFFSET);
		storeITo(code,RunTime.PRINT_STRING_LENGTH);
		
		code.add(Label,loopLabel);
		loadIFrom(code,RunTime.PRINT_STRING_LENGTH);
		code.add(JumpFalse,endLabel);
		loadIFrom(code,RunTime.PRINT_STRING_TEMP);
		code.add(LoadC);
		code.add(PushD,RunTime.CHARACTER_PRINT_FORMAT);
		code.add(Printf);
		incrementInteger(code,RunTime.PRINT_STRING_TEMP);
		
		decrementInteger(code,RunTime.PRINT_STRING_LENGTH);
		code.add(Jump,loopLabel);
		code.add(Label,endLabel);
		
	}
	
	private void printRational(ParseNode node){
		if(node.getType()!=PrimitiveType.RATIONAL)
			return;
		
		Labeller labeller = new Labeller("print-rational");
		String numeratorPos = labeller.newLabel("numerator-pos");
		String denominatorPos = labeller.newLabel("denominator-pos");
		String rationalPos=labeller.newLabel("rational-pos");
		String endLabel=labeller.newLabel("end");
		String fracLabel=labeller.newLabel("fraction");
		String zeroNumerator=labeller.newLabel("zero-numerator");
		code.add(PushI,1);
		storeITo(code,RunTime.RATIONAL_PRINT_SIGN);//sign=1
		//[...numerator denominator]
		
		code.add(Duplicate);
		code.add(JumpPos,denominatorPos);
		loadIFrom(code, RunTime.RATIONAL_PRINT_SIGN);
		code.add(Negate);
		storeITo(code,RunTime.RATIONAL_PRINT_SIGN);
		code.add(Negate);
		code.add(Label,denominatorPos);
		storeITo(code, RunTime.RATIONAL_DENOMINATOR_TEMP);
		
		code.add(Duplicate);
		code.add(Duplicate);
		code.add(JumpFalse,zeroNumerator);
		code.add(JumpPos,numeratorPos);
		loadIFrom(code, RunTime.RATIONAL_PRINT_SIGN);
		code.add(Negate);
		storeITo(code,RunTime.RATIONAL_PRINT_SIGN);
		code.add(Negate);
		code.add(Label,numeratorPos);
		storeITo(code, RunTime.RATIONAL_NUMERATOR_TEMP);
		
		loadIFrom(code, RunTime.RATIONAL_NUMERATOR_TEMP);
		loadIFrom(code, RunTime.RATIONAL_DENOMINATOR_TEMP);
		
		//[...abs(numerator) abs(denominator)]
		code.add(Remainder);//[...numerator%denominator]
		loadIFrom(code, RunTime.RATIONAL_NUMERATOR_TEMP);
		loadIFrom(code, RunTime.RATIONAL_DENOMINATOR_TEMP);
		//[...numerator/denominator numerator denominator]
		code.add(Divide);//[...numerator%denominator numerator/denominator]
		storeITo(code,RunTime.RATIONAL_PRINT_INT_PART);
		storeITo(code,RunTime.RATIONAL_PRINT_REMAINDER);
		
		loadIFrom(code,RunTime.RATIONAL_PRINT_REMAINDER);
		loadIFrom(code,RunTime.RATIONAL_PRINT_INT_PART);
		
		loadIFrom(code, RunTime.RATIONAL_PRINT_SIGN);
		code.add(JumpPos,rationalPos);
		code.add(PushD,RunTime.MINUS_SIGN_STRING);
		code.add(PushD,RunTime.STRING_PRINT_FORMAT);
		code.add(Printf);
		code.add(Label,rationalPos);
		
		code.add(JumpFalse,fracLabel);
		loadIFrom(code,RunTime.RATIONAL_PRINT_INT_PART);
		code.add(PushD,RunTime.INTEGER_PRINT_FORMAT);
		code.add(Printf);
		
		code.add(Label,fracLabel);
		code.add(JumpFalse,endLabel);
		code.add(PushD,RunTime.DASH_PRINT_STRING);
		code.add(PushD,RunTime.STRING_PRINT_FORMAT);
		code.add(Printf);
		
		loadIFrom(code,RunTime.RATIONAL_PRINT_REMAINDER);
		code.add(PushD,RunTime.INTEGER_PRINT_FORMAT);
		code.add(Printf);
		
		code.add(PushD,RunTime.DIVIDE_SIGN_STRING);
		code.add(PushD,RunTime.STRING_PRINT_FORMAT);
		code.add(Printf);
		
		loadIFrom(code, RunTime.RATIONAL_DENOMINATOR_TEMP);
		code.add(PushD,RunTime.INTEGER_PRINT_FORMAT);
		code.add(Printf);
		code.add(Jump,endLabel);
		
		code.add(Label,zeroNumerator);
		code.add(PushD,RunTime.INTEGER_PRINT_FORMAT);
		code.add(Printf);
		code.add(Pop);
		
		code.add(Label,endLabel);
	}
	private void convertToStringIfBoolean(ParseNode node) {
		if(node.getType() != PrimitiveType.BOOLEAN) {
			return;
		}
		
		Labeller labeller = new Labeller("print-boolean");
		String trueLabel = labeller.newLabel("true");
		String endLabel = labeller.newLabel("join");

		code.add(JumpTrue, trueLabel);
		code.add(PushD, RunTime.BOOLEAN_FALSE_STRING);
		code.add(Jump, endLabel);
		code.add(Label, trueLabel);
		code.add(PushD, RunTime.BOOLEAN_TRUE_STRING);
		code.add(Label, endLabel);
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

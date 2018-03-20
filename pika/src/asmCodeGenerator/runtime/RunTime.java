package asmCodeGenerator.runtime;
import asmCodeGenerator.PrintStatementGenerator.*;
import static asmCodeGenerator.codeStorage.ASMCodeFragment.CodeType.*;
import static asmCodeGenerator.codeStorage.ASMOpcode.*;
import static asmCodeGenerator.runtime.Record.ARRAY_HEADER_SIZE;
import static asmCodeGenerator.runtime.Record.STRING_HEADER_SIZE;
import static asmCodeGenerator.runtime.Record.STRING_LENGTH_OFFSET;
import static asmCodeGenerator.runtime.RunTime.ARRAY_INDEXING_ARRAY;
import static asmCodeGenerator.runtime.RunTime.NULL_ARRAY_RUNTIME_ERROR;

import com.sun.org.apache.bcel.internal.classfile.Code;

import asmCodeGenerator.Labeller;
import asmCodeGenerator.Macros;
import static asmCodeGenerator.Macros.*;
import asmCodeGenerator.codeStorage.ASMCodeFragment;
import asmCodeGenerator.codeStorage.ASMCodeFragment.CodeType;
import parseTree.ParseNode;
import semanticAnalyzer.types.Array;
import semanticAnalyzer.types.PrimitiveType;
import semanticAnalyzer.types.Type;
public class RunTime {
	public static final String EAT_LOCATION_ZERO      = "$eat-location-zero";		// helps us distinguish null pointers from real ones.
	public static final String INTEGER_PRINT_FORMAT   = "$print-format-integer";
	public static final String FLOATING_PRINT_FORMAT  = "$print-format-floating";
	public static final String BOOLEAN_PRINT_FORMAT   = "$print-format-boolean";
	public static final String CHARACTER_PRINT_FORMAT   = "$print-format-character";
	public static final String STRING_PRINT_FORMAT   	= "$print-format-string";
	public static final String TAB_PRINT_FORMAT   		= "$print-format-tab";
	public static final String NEWLINE_PRINT_FORMAT   = "$print-format-newline";
	public static final String SPACE_PRINT_FORMAT     = "$print-format-space";
	public static final String BOOLEAN_TRUE_STRING    = "$boolean-true-string";
	public static final String BOOLEAN_FALSE_STRING   = "$boolean-false-string";
	public static final String DASH_PRINT_STRING	="$dash-string";
	public static final String DIVIDE_SIGN_STRING	="$divide-sign-string";
	public static final String MINUS_SIGN_STRING="$minus-sign-string";
	public static final String OPEN_BRACKET_STRING = "$open-bracket-string";
	public static final String CLOSE_BRACKET_STRING = "$close-bracket-string";
	public static final String COMMA_STRING = "$comma-string";
	
	public static final String GLOBAL_MEMORY_BLOCK    = "$global-memory-block";
	public static final String USABLE_MEMORY_START    = "$usable-memory-start";
	public static final String MAIN_PROGRAM_LABEL     = "$$main";
	public static final String FRAME_POINTER		  = "$frame-pointer";
	public static final String STACK_POINTER		  = "$stack-pointer";
	
	public static final String GENERAL_RUNTIME_ERROR = "$$general-runtime-error";
	public static final String INTEGER_DIVIDE_BY_ZERO_RUNTIME_ERROR = "$$i-divide-by-zero";
	public static final String FLOAT_DIVIDE_BY_ZERO_RUNTIME_ERROR = "$$f-divide-by-zero";
	public static final String NULL_ARRAY_RUNTIME_ERROR = "$$null-array";
	public static final String NULL_STRING_RUNTIME_ERROR = "$$null-string";
	public static final String INDEX_OUT_OF_BOUNDS_RUNTIME_ERROR = "$$index-out-of-bound";
	public static final String OVER_ZERO_DENOMINATOR_RUNTIME_ERROR="$$over-zero-denominator";
	public static final String EXPRESSOVER_DIVIDE_BY_ZERO_RUNTIME_ERROR="$$rational-expressover-divide-by-zero";
	public static final String RATIONALIZE_DIVIDE_BY_ZERO_RUNTIME_ERROR="$$rationalize-divide-by-zero";
	public static final String NEGATIVE_LENGTH_ARRAY_RUNTIME_ERROR="$$negative-length-array";
	public static final String NO_RETURN_RUNTIME_ERROR="$$no return";
	public static final String ARRAY_INDEXING_ARRAY	= "$a-indexing-array";
	public static final String ARRAY_INDEXING_INDEX = "$a-indexing-index";
	
	public static final String LOWEST_TERMS="$lowest-term-subroutine";
	public static final String LOWEST_TERMS_RETURN_ADDRESS="$lowest-term-return";
	public static final String LOWEST_TERMS_DENOMINATOR="$lowest-term-denominator";
	public static final String LOWEST_TERMS_NUMERATOR="$lowest-term-numerator";
	public static final String LOWEST_TERMS_GCD="$lowest-term-gcd";
	public static final String LOWEST_TERMS_TEMP_A="$lowest-term-tmpa";
	public static final String LOWEST_TERMS_TEMP_B="$lowest-term-tmpb";
	
	public static final String CLEAR_N_BYTES="$clear-n-bytes-subroutine";
	public static final String CLEAR_N_BYTES_RETURN_ADDRESS="$clear-n-bytes-return-address";
	public static final String CLEAR_N_BYTES_ELEMENT_SIZE="$clear-n-bytes-element-size";
	public static final String CLEAR_N_BYTES_ELEMENT_ADDR="$clear-n-bytes-element-addr";
	
	public static final String EXPRESS_OVER_DENOMINATOR="$express-over-denominator";
	public static final String RATIONAL_DENOMINATOR_TEMP="$rational-denominator-temp";
	public static final String RATIONAL_NUMERATOR_TEMP="$rational-numerator-temp";
	public static final String RATIONAL_DENOMINATOR_TEMP2="$rational-denominator-temp2";
	public static final String RATIONAL_NUMERATOR_TEMP2="$rational-numerator-temp2";
	public static final String RATIONAL_DENOMINATOR_MULTIPLY="$rational-denominator-multiply";
	public static final String RATIONAL_PRINT_INT_PART="$rational-print-integer-part";
	public static final String RATIONAL_PRINT_REMAINDER="$rational-print-remainder";
	public static final String RATIONAL_PRINT_SIGN	="$rational-print-sign";
	
	public static final String RECORD_CREATION_TEMP = "$record-creation-temp";
	public static final String ARRAY_DATASIZE_TEMP = "$array-datasize-temp";
	public static final String ARRAY_IDENTIFIER_TEMP = "$array-identifier-temp";
	public static final String ARRAY_STATUS_TEMP = "$array-status-temp";
	public static final String ARRAY_SUBTYPE_SIZE_TEMP = "$array-subtype-size-temp";
	public static final String ARRAY_LENGTH_TEMP = "$array-length-temp";
	public static final String ARRAY_ELEMENT_TEMP = "$array-element-temp";
	public static final String CLONED_ARRAY_TEMP = "$cloned-array-temp";
	
	public static final String PRINT_STRING_TEMP = "$print-string-temp";
	public static final String PRINT_STRING_LENGTH = "$print-string-length";
		
	public static final String PRINT_RATIONAL = "$print-rational";
	public static final String PRINT_RATIONAL_RETURN_ADDRESS = "$print-rational-return-address";
	
	public static final String PRINT_STRING = "$print-string";
	public static final String PRINT_STRING_RETURN_ADDRESS = "$print-string-return-address";
	
	public static final String PRINT_ARRAY_RETURN_ADDRESS = "$print-array-return-address";
	public static final String PRINT_ARRAY = "$print-array-subroutine";
	
	public static final String CONVERT_TO_STRING_IF_BOOL_RETURN_ADDRESS = "$convert-to-string-if-bool-return-address";
	public static final String CONVERT_TO_STRING_IF_BOOL = "$convert-to-string-if-bool-subroutine";
	
	public static final String RELEASE_RECORD = "$release-record";
	public static final String RELEASE_RECORD_RETURN_ADDRESS = "$release-record-return-address";
	
	public static final String SUBTRACT_RATIONAL = "$subtract-rational";
	public static final String SUBTRACT_RATIONAL_RETURN_ADDRESS = "$subtract-rational-return-address";
	
	public static final String FUNCTION_INVOCATION_PARAM_TEMP = "$function-invocation-parameter-temp";
	private ASMCodeFragment environmentASM() {
		ASMCodeFragment result = new ASMCodeFragment(GENERATES_VOID);
		result.append(jumpToMain());
		result.append(stringsForPrintf());
		result.append(runtimeErrors());
		result.append(temporaryVariables());
		result.append(gcdSubroutine());
		result.append(clearNBytes());
		result.append(printArrayRecursive());
		result.append(printRational());
		result.append(printString());
		result.append(convertToStringIfBoolean());
		result.append(releaseRecordRecursive());
		result.append(subtractRational());
		
		result.add(DLabel, USABLE_MEMORY_START);
		return result;
	}
	
	private ASMCodeFragment jumpToMain() {
		ASMCodeFragment frag = new ASMCodeFragment(GENERATES_VOID);
		frag.add(Jump, MAIN_PROGRAM_LABEL);
		return frag;
	}
	
	private ASMCodeFragment temporaryVariables(){
		ASMCodeFragment frag=new ASMCodeFragment(GENERATES_VOID);
		Macros.declareI(frag, ARRAY_INDEXING_ARRAY);
		Macros.declareI(frag, ARRAY_INDEXING_INDEX);
		Macros.declareI(frag, EXPRESS_OVER_DENOMINATOR);
		Macros.declareI(frag, RATIONAL_DENOMINATOR_TEMP);
		Macros.declareI(frag, RATIONAL_NUMERATOR_TEMP);
		Macros.declareI(frag, RATIONAL_DENOMINATOR_TEMP2);
		Macros.declareI(frag, RATIONAL_NUMERATOR_TEMP2);
		Macros.declareI(frag, RATIONAL_PRINT_INT_PART);
		Macros.declareI(frag, RATIONAL_PRINT_REMAINDER);
		Macros.declareI(frag, RATIONAL_PRINT_SIGN);
		Macros.declareI(frag, RECORD_CREATION_TEMP);
		Macros.declareI(frag, ARRAY_DATASIZE_TEMP);
		Macros.declareI(frag, ARRAY_IDENTIFIER_TEMP);
		Macros.declareI(frag, ARRAY_STATUS_TEMP);
		Macros.declareI(frag, ARRAY_SUBTYPE_SIZE_TEMP);
		Macros.declareI(frag, ARRAY_LENGTH_TEMP);
		Macros.declareI(frag, ARRAY_ELEMENT_TEMP);
		Macros.declareI(frag, CLONED_ARRAY_TEMP);
		Macros.declareI(frag, PRINT_STRING_TEMP);
		Macros.declareI(frag, PRINT_STRING_LENGTH);
		Macros.declareI(frag, FRAME_POINTER);
		Macros.declareI(frag, STACK_POINTER);
		
		return frag;
	}

	private ASMCodeFragment stringsForPrintf() {
		ASMCodeFragment frag = new ASMCodeFragment(GENERATES_VOID);
		frag.add(DLabel, EAT_LOCATION_ZERO);
		frag.add(DataZ, 8);
		frag.add(DLabel, INTEGER_PRINT_FORMAT);
		frag.add(DataS, "%d");
		frag.add(DLabel, FLOATING_PRINT_FORMAT);
		frag.add(DataS, "%g");
		frag.add(DLabel, BOOLEAN_PRINT_FORMAT);
		frag.add(DataS, "%s");
		frag.add(DLabel, CHARACTER_PRINT_FORMAT);
		frag.add(DataS, "%c");
		frag.add(DLabel, STRING_PRINT_FORMAT);
		frag.add(DataS, "%s");
		frag.add(DLabel, TAB_PRINT_FORMAT);
		frag.add(DataS, "\t");
		frag.add(DLabel, NEWLINE_PRINT_FORMAT);
		frag.add(DataS, "\n");
		frag.add(DLabel, SPACE_PRINT_FORMAT);
		frag.add(DataS, " ");
		frag.add(DLabel, BOOLEAN_TRUE_STRING);
		frag.add(DataS, "true");
		frag.add(DLabel, BOOLEAN_FALSE_STRING);
		frag.add(DataS, "false");
		frag.add(DLabel, DASH_PRINT_STRING);
		frag.add(DataS, "_");
		frag.add(DLabel,DIVIDE_SIGN_STRING);
		frag.add(DataS,"/");
		frag.add(DLabel,MINUS_SIGN_STRING);
		frag.add(DataS,"-");
		frag.add(DLabel,OPEN_BRACKET_STRING);
		frag.add(DataS,"[");
		frag.add(DLabel,CLOSE_BRACKET_STRING);
		frag.add(DataS,"]");
		frag.add(DLabel,COMMA_STRING);
		frag.add(DataS,",");
		
		return frag;
	}
	
	
	private ASMCodeFragment runtimeErrors() {
		ASMCodeFragment frag = new ASMCodeFragment(GENERATES_VOID);
		
		generalRuntimeError(frag);
		integerDivideByZeroError(frag);
		floatDivideByZeroError(frag);
		nullArrayError(frag);
		indexOutOfBoundError(frag);
		zeroDenominatorError(frag);
		expressoverDivideByZeroError(frag);
		rationalizeDivideByZeroError(frag);
		negativeArrayLengthError(frag);
		nullStringError(frag);
		noReturnError(frag);
		
		return frag;
	}
	
	private ASMCodeFragment generalRuntimeError(ASMCodeFragment frag) {
		String generalErrorMessage = "$errors-general-message";

		frag.add(DLabel, generalErrorMessage);
		frag.add(DataS, "Runtime error: %s\n");
		
		frag.add(Label, GENERAL_RUNTIME_ERROR);
		frag.add(PushD, generalErrorMessage);
		frag.add(Printf);
		frag.add(Halt);
		return frag;
	}
	private void noReturnError(ASMCodeFragment frag){
		String noReturnMessage = "$no-return";
		frag.add(DLabel,noReturnMessage);
		frag.add(DataS, "no return");
		
		frag.add(Label, NO_RETURN_RUNTIME_ERROR);
		frag.add(PushD, noReturnMessage);
		frag.add(Jump, GENERAL_RUNTIME_ERROR);
	}
	private void negativeArrayLengthError(ASMCodeFragment frag){
		String negativeArrayLengthMessage = "$negative-array-length";
		frag.add(DLabel,negativeArrayLengthMessage);
		frag.add(DataS, "negative array length");
		
		frag.add(Label, NEGATIVE_LENGTH_ARRAY_RUNTIME_ERROR);
		frag.add(PushD, negativeArrayLengthMessage);
		frag.add(Jump, GENERAL_RUNTIME_ERROR);
	}
	private void rationalizeDivideByZeroError(ASMCodeFragment frag){
		String rationalizeDivideByZeroMessage = "$rationalize-divide-by-zero";
		frag.add(DLabel,rationalizeDivideByZeroMessage);
		frag.add(DataS, "rationalize divide by zero");
		
		frag.add(Label, RATIONALIZE_DIVIDE_BY_ZERO_RUNTIME_ERROR);
		frag.add(PushD, rationalizeDivideByZeroMessage);
		frag.add(Jump, GENERAL_RUNTIME_ERROR);
	}
	private void expressoverDivideByZeroError(ASMCodeFragment frag){
		String expressoverDivideByZeroMessage = "$expressover-divide-by-zero";
		frag.add(DLabel,expressoverDivideByZeroMessage);
		frag.add(DataS, "expressover divide by zero");
		
		frag.add(Label, EXPRESSOVER_DIVIDE_BY_ZERO_RUNTIME_ERROR);
		frag.add(PushD, expressoverDivideByZeroMessage);
		frag.add(Jump, GENERAL_RUNTIME_ERROR);
	}
	
	private void zeroDenominatorError(ASMCodeFragment frag){
		String zeroDenominatorMessage="$zero-denominator-error";
		frag.add(DLabel,zeroDenominatorMessage);
		frag.add(DataS, "over zero denominator");
		
		frag.add(Label, OVER_ZERO_DENOMINATOR_RUNTIME_ERROR);
		frag.add(PushD, zeroDenominatorMessage);
		frag.add(Jump, GENERAL_RUNTIME_ERROR);
	}
	private void indexOutOfBoundError(ASMCodeFragment frag){
		String indexOutOfBoundMessage="$index-out-of-bound-error";
		frag.add(DLabel,indexOutOfBoundMessage);
		frag.add(DataS, "array index out of bound");
		
		frag.add(Label, INDEX_OUT_OF_BOUNDS_RUNTIME_ERROR);
		frag.add(PushD, indexOutOfBoundMessage);
		frag.add(Jump, GENERAL_RUNTIME_ERROR);
	}
	private void nullArrayError(ASMCodeFragment frag){
		String nullArrayMessage="$null-array-runtime-error";
		frag.add(DLabel,nullArrayMessage);
		frag.add(DataS,"null array");
		
		frag.add(Label,NULL_ARRAY_RUNTIME_ERROR);
		frag.add(PushD,nullArrayMessage);
		frag.add(Jump,GENERAL_RUNTIME_ERROR);
	}
	private void nullStringError(ASMCodeFragment frag){
		String nullStringMessage="$null-string-runtime-error";
		frag.add(DLabel,nullStringMessage);
		frag.add(DataS,"null string");
		
		frag.add(Label,NULL_STRING_RUNTIME_ERROR);
		frag.add(PushD,nullStringMessage);
		frag.add(Jump,GENERAL_RUNTIME_ERROR);
	}
	private void integerDivideByZeroError(ASMCodeFragment frag) {
		String intDivideByZeroMessage = "$errors-int-divide-by-zero";
		
		frag.add(DLabel, intDivideByZeroMessage);
		frag.add(DataS, "integer divide by zero");
		
		frag.add(Label, INTEGER_DIVIDE_BY_ZERO_RUNTIME_ERROR);
		frag.add(PushD, intDivideByZeroMessage);
		frag.add(Jump, GENERAL_RUNTIME_ERROR);
	}
	
	private void floatDivideByZeroError(ASMCodeFragment frag) {
		String floatDivideByZeroMessage = "$errors-float-divide-by-zero";
		
		frag.add(DLabel, floatDivideByZeroMessage);
		frag.add(DataS, "float divide by zero");
		
		frag.add(Label, FLOAT_DIVIDE_BY_ZERO_RUNTIME_ERROR);
		frag.add(PushD, floatDivideByZeroMessage);
		frag.add(Jump, GENERAL_RUNTIME_ERROR);
	}
	
	// leaves new record in RECORD_CREATION_TEMPORARY
	// [... size] -> [...]
	public static void createRecord(ASMCodeFragment code, int typecode, int statusFlags){
		code.add(Call, MemoryManager.MEM_MANAGER_ALLOCATE);
		Macros.storeITo(code, RECORD_CREATION_TEMP);
		writeIPBaseOffset(code,RECORD_CREATION_TEMP, Record.RECORD_TYPEID_OFFSET, typecode);
		writeIPBaseOffset(code,RECORD_CREATION_TEMP, Record.RECORD_STATUS_OFFSET, statusFlags);
	}
	// leaves new record in RECORD_CREATION_TEMPORARY
	// [... size] -> [...]
	public static void createPlainRecord(ASMCodeFragment code){
		code.add(Call, MemoryManager.MEM_MANAGER_ALLOCATE);
		Macros.storeITo(code, RECORD_CREATION_TEMP);
	}
	
	// leaves new record in RECORD_CREATION_TEMPORARY
	// [... nElems] -> [...]
	public static void createEmptyArrayRecord(ASMCodeFragment code, int statusFlags,int subtypeSize){
		final int typecode = Record.ARRAY_TYPE_ID;
		code.add(Duplicate); // [... nElems nElems]
		code.add(JumpNeg, RunTime.NEGATIVE_LENGTH_ARRAY_RUNTIME_ERROR);// [... nElems]
		
		code.add(Duplicate); // [... nElems nElems]
		code.add(PushI, subtypeSize);
		// [... nElems nElems subSize]
		code.add(Multiply); // [... nElems elemsSize]
		code.add(Duplicate);
		// [... nElems elemsSize elemsSize]
		storeITo(code, ARRAY_DATASIZE_TEMP);
		// [... nElems elemsSize]
		code.add(PushI, Record.ARRAY_HEADER_SIZE);
		// [... nElems elemsSize AHS]
		code.add(Add); // [... nElems totalRecordSize]
		
		createRecord(code, typecode, statusFlags);
		
		// [... nElems]
		loadIFrom(code, RECORD_CREATION_TEMP);
		// [... nElems ptr]
		code.add(PushI, Record.ARRAY_HEADER_SIZE);
		// [... nElems ptr AHS]
		code.add(Add); // [... nElems elemsPtr]
		loadIFrom(code, ARRAY_DATASIZE_TEMP);
		// [... nElems elemsPtr elemSize]
		code.add(Call, CLEAR_N_BYTES);
		
		writeIPBaseOffset(code,RECORD_CREATION_TEMP,Record.ARRAY_SUBTYPE_SIZE_OFFSET,subtypeSize);
		// [... nElems]
		writeIPtrOffset(code,RECORD_CREATION_TEMP,Record.ARRAY_LENGTH_OFFSET); // [...]
	}
	
	// leaves new record in RECORD_CREATION_TEMPORARY
	//[...clonedArrPtr]->[...newArrPtr]
	public static void cloneArrayRecord(ASMCodeFragment code){
		//[...clonedArrPtr]
		storeITo(code,CLONED_ARRAY_TEMP);
		loadIFrom(code,CLONED_ARRAY_TEMP);
		//[...clonedArrPtr]
		readIOffset(code,Record.RECORD_TYPEID_OFFSET);
		storeITo(code,ARRAY_IDENTIFIER_TEMP);
		loadIFrom(code,CLONED_ARRAY_TEMP);
		//[...clonedArrPtr]
		readIOffset(code,Record.RECORD_STATUS_OFFSET);
		storeITo(code,ARRAY_STATUS_TEMP);
		
		loadIFrom(code,CLONED_ARRAY_TEMP);
		readIOffset(code,Record.ARRAY_LENGTH_OFFSET);
		code.add(Duplicate);
		storeITo(code,ARRAY_LENGTH_TEMP);
		//[...nElems]
		loadIFrom(code,CLONED_ARRAY_TEMP);
		readIOffset(code,Record.ARRAY_SUBTYPE_SIZE_OFFSET);
		//[...nElems subSize]
		code.add(Duplicate);
		storeITo(code,ARRAY_SUBTYPE_SIZE_TEMP);
		code.add(Multiply);
		code.add(Duplicate);
		// [... elemsSize elemsSize]
		storeITo(code, ARRAY_DATASIZE_TEMP);
		code.add(PushI, Record.ARRAY_HEADER_SIZE);
		// [... elemsSize AHS]
		code.add(Add); // [... totalRecordSize]
		createPlainRecord(code);
		
		//copy identifier/status/subtype size/length to new array
		loadIFrom(code, ARRAY_IDENTIFIER_TEMP);
		writeIPtrOffset(code,RECORD_CREATION_TEMP,Record.RECORD_TYPEID_OFFSET);
		loadIFrom(code, ARRAY_STATUS_TEMP);
		writeIPtrOffset(code,RECORD_CREATION_TEMP,Record.RECORD_STATUS_OFFSET);
		loadIFrom(code, ARRAY_SUBTYPE_SIZE_TEMP);
		writeIPtrOffset(code,RECORD_CREATION_TEMP,Record.ARRAY_SUBTYPE_SIZE_OFFSET);
		loadIFrom(code, ARRAY_LENGTH_TEMP);
		writeIPtrOffset(code,RECORD_CREATION_TEMP,Record.ARRAY_LENGTH_OFFSET);

		//copy the elements
		//[...]
		code.add(PushI,0);
		storeITo(code,ARRAY_ELEMENT_TEMP);
		
		Labeller labeller = new Labeller("clone-element");
		String loopLabel = labeller.newLabel("loop-start");
		String endLabel = labeller.newLabel("end");
		
		code.add(Label,loopLabel);
		loadIFrom(code,ARRAY_DATASIZE_TEMP);
		loadIFrom(code,ARRAY_ELEMENT_TEMP);
		code.add(Subtract);
		code.add(JumpFalse,endLabel);
		
		loadIFrom(code,RECORD_CREATION_TEMP);
		code.add(PushI, Record.ARRAY_HEADER_SIZE);
		code.add(Add);
		loadIFrom(code,ARRAY_ELEMENT_TEMP);	
		code.add(Add);
		
		loadIFrom(code,CLONED_ARRAY_TEMP);		
		code.add(PushI, Record.ARRAY_HEADER_SIZE);
		code.add(Add);
		loadIFrom(code,ARRAY_ELEMENT_TEMP);
		code.add(Add);
		code.add(LoadC);
		code.add(StoreC);
		
		incrementInteger(code,ARRAY_ELEMENT_TEMP);
		code.add(Jump,loopLabel);
		
		code.add(Label,endLabel);
		
		loadIFrom(code,RECORD_CREATION_TEMP);
	}
	
	private ASMCodeFragment printArrayRecursive(){
		ASMCodeFragment frag=new ASMCodeFragment(CodeType.GENERATES_VOID);
		
		frag.add(Label, RunTime.PRINT_ARRAY);
		
		Labeller labeller=new Labeller("print-array-recursive");
		String lengthLabel=labeller.newLabel("length");
		String elemLabel=labeller.newLabel("element");
		String oneDimArrayLabel=labeller.newLabel("one-dim");
		String endLabel=labeller.newLabel("end");
		String loopLabel=labeller.newLabel("loop-start");
		String loop2Label=labeller.newLabel("loop-start-2");
		String returnAddressLabel=labeller.newLabel("return-address");
		String elemSizeLabel=labeller.newLabel("elem-size");
		String typeLabel=labeller.newLabel("type");
		String joinLabel=labeller.newLabel("join-label");
		String intLabel=labeller.newLabel("int-label");
		String floatLabel=labeller.newLabel("float-label");
		String boolLabel=labeller.newLabel("bool-label");
		String charLabel=labeller.newLabel("char-label");
		String ratLabel=labeller.newLabel("rat-label");
		String strLabel=labeller.newLabel("string-label");
		
		declareI(frag,returnAddressLabel);
		storeITo(frag,returnAddressLabel);
		declareI(frag,typeLabel);
		storeITo(frag,typeLabel);
		declareI(frag,elemLabel);
		declareI(frag,lengthLabel);
		declareI(frag,elemSizeLabel);
		
		//[...arrAddr]->[...arrAddr]
		//store the length of array and start address of elements
		frag.add(Duplicate);// [… arr]
		frag.add(JumpFalse, NULL_ARRAY_RUNTIME_ERROR);// [… ]
		
		frag.add(Duplicate);
		frag.add(Duplicate);
		frag.add(Duplicate);
		frag.add(PushI,ARRAY_HEADER_SIZE);
		frag.add(Add);
		storeITo(frag,elemLabel);
		readIOffset(frag,Record.ARRAY_LENGTH_OFFSET);
		storeITo(frag,lengthLabel);
		readIOffset(frag,Record.ARRAY_SUBTYPE_SIZE_OFFSET);
		storeITo(frag,elemSizeLabel);
		
		frag.add(PushD,RunTime.OPEN_BRACKET_STRING);
		frag.add(PushD,STRING_PRINT_FORMAT);
		frag.add(Printf);
		
		//[...arrAddr]
//		frag.add(Duplicate);
		readIOffset(frag,Record.RECORD_STATUS_OFFSET);//[...status]
		frag.add(PushI,2);
		frag.add(BTAnd);//[...status&0x0010]
		frag.add(JumpFalse,oneDimArrayLabel);
		
		//subtype is reference type for each element call PRINT_ARRAY again
		frag.add(Label,loopLabel);
		loadIFrom(frag,lengthLabel);
		frag.add(JumpFalse,endLabel);
		
		
		loadIFrom(frag,returnAddressLabel);
		loadIFrom(frag,typeLabel);
		loadIFrom(frag,elemLabel);
		loadIFrom(frag,lengthLabel);
		loadIFrom(frag,elemSizeLabel);
		
		loadIFrom(frag,elemLabel);
		frag.add(LoadI);
		
		//if it is string jump to oneDimArray
		frag.add(Duplicate);
		readIOffset(frag, Record.RECORD_TYPEID_OFFSET);
		frag.add(PushI,6);
		frag.add(Subtract);
		frag.add(JumpFalse,oneDimArrayLabel);
		
		loadIFrom(frag,typeLabel);
		frag.add(Call,PRINT_ARRAY);
		
		storeITo(frag,elemSizeLabel);
		storeITo(frag,lengthLabel);
		storeITo(frag,elemLabel);
		storeITo(frag,typeLabel);
		storeITo(frag,returnAddressLabel);
		
		loadIFrom(frag,elemSizeLabel);
		addITo(frag,elemLabel);
		decrementInteger(frag,lengthLabel);
		
		loadIFrom(frag,lengthLabel);
		frag.add(PushI,0);
		frag.add(Subtract);
		frag.add(JumpFalse,loopLabel);
		frag.add(PushD,RunTime.COMMA_STRING);
		frag.add(PushD,STRING_PRINT_FORMAT);
		frag.add(Printf);
		frag.add(PushD,RunTime.SPACE_PRINT_FORMAT);
		frag.add(PushD,STRING_PRINT_FORMAT);
		frag.add(Printf);
		frag.add(Jump,loopLabel);
		
		//print each element
		frag.add(Label,oneDimArrayLabel);
		frag.add(Label,loop2Label);
		loadIFrom(frag,lengthLabel);
//		frag.add(PStack);
		frag.add(JumpFalse,endLabel);
		loadIFrom(frag,elemLabel);//[...arrAddr elemAddr]
		
		loadIFrom(frag,typeLabel);
		frag.add(PushI,1);
		frag.add(Subtract);
		frag.add(JumpFalse,intLabel);
		loadIFrom(frag,typeLabel);
		frag.add(PushI,2);
		frag.add(Subtract);
		frag.add(JumpFalse,floatLabel);
		loadIFrom(frag,typeLabel);
		frag.add(PushI,3);
		frag.add(Subtract);
		frag.add(JumpFalse,charLabel);
		loadIFrom(frag,typeLabel);
		frag.add(PushI,4);
		frag.add(Subtract);
		frag.add(JumpFalse,strLabel);
		loadIFrom(frag,typeLabel);
		frag.add(PushI,5);
		frag.add(Subtract);
		frag.add(JumpFalse,ratLabel);
		loadIFrom(frag,typeLabel);
		frag.add(PushI,6);
		frag.add(Subtract);
		frag.add(JumpFalse,boolLabel);
		
		frag.add(Label,intLabel);
		frag.add(LoadI);
		frag.add(PushD, INTEGER_PRINT_FORMAT);
		frag.add(Printf);
		frag.add(Jump,joinLabel);
		
		frag.add(Label,floatLabel);
		frag.add(LoadF);
		frag.add(PushD, FLOATING_PRINT_FORMAT);
		frag.add(Printf);
		frag.add(Jump,joinLabel);
		
		frag.add(Label,charLabel);
		frag.add(LoadC);
		frag.add(PushD, CHARACTER_PRINT_FORMAT);
		frag.add(Printf);
		frag.add(Jump,joinLabel);
		
		frag.add(Label,ratLabel);
		frag.add(Duplicate);
		frag.add(LoadI);
		frag.add(Exchange);
		frag.add(PushI,4);
		frag.add(Add);
		frag.add(LoadI);
		frag.add(Call,PRINT_RATIONAL);
		frag.add(Jump,joinLabel);
		
		frag.add(Label,boolLabel);
		frag.add(LoadC);
		frag.add(Call,CONVERT_TO_STRING_IF_BOOL);
		frag.add(PushD, BOOLEAN_PRINT_FORMAT);
		frag.add(Printf);
		frag.add(Jump,joinLabel);
		
		frag.add(Label,strLabel);
		frag.add(LoadI);
		frag.add(Call,PRINT_STRING);
		frag.add(Jump,joinLabel);
		
		frag.add(Label,joinLabel);
		
		loadIFrom(frag,elemSizeLabel);
		addITo(frag,elemLabel);
		decrementInteger(frag,lengthLabel);
		loadIFrom(frag,lengthLabel);
		frag.add(PushI,0);
		frag.add(Subtract);
		frag.add(JumpFalse,loop2Label);
		frag.add(PushD,RunTime.COMMA_STRING);
		frag.add(PushD,STRING_PRINT_FORMAT);
		frag.add(Printf);
		frag.add(PushD,RunTime.SPACE_PRINT_FORMAT);
		frag.add(PushD,STRING_PRINT_FORMAT);
		frag.add(Printf);
		frag.add(Jump,loop2Label);
		
		frag.add(Label,endLabel);
		
		frag.add(PushD,RunTime.CLOSE_BRACKET_STRING);
		frag.add(PushD,STRING_PRINT_FORMAT);
		frag.add(Printf);
		
		loadIFrom(frag,returnAddressLabel);
		frag.add(Return);
		
		return frag;
	}

	private ASMCodeFragment releaseRecordRecursive(){
		ASMCodeFragment frag=new ASMCodeFragment(CodeType.GENERATES_VOID);
		
		Labeller labeller = new Labeller("release-record");
		String endLabel=labeller.newLabel("end");
		String releaseLabel=labeller.newLabel("release");
		String lengthLabel=labeller.newLabel("length");
		String elemSizeLabel=labeller.newLabel("element-size");
		String stringLabel=labeller.newLabel("string-record");
		String joinLabel=labeller.newLabel("join");
		String loopLabel=labeller.newLabel("loop-start");
		String elemLabel=labeller.newLabel("element");
		declareI(frag,lengthLabel);
		declareI(frag,elemSizeLabel);
		declareI(frag,elemLabel);
		
		frag.add(Label,RELEASE_RECORD);
		declareI(frag,RELEASE_RECORD_RETURN_ADDRESS);
		storeITo(frag,RELEASE_RECORD_RETURN_ADDRESS);
		//[...recordPtr]
		//check the is-deleted status and permanent status
		frag.add(Duplicate);
		readIOffset(frag,Record.RECORD_STATUS_OFFSET);//[...recordPtr status]
		frag.add(Duplicate);
		frag.add(Duplicate);
		frag.add(PushI,0x00000004);
		frag.add(BTAnd);
		frag.add(JumpTrue,endLabel);
		frag.add(PushI,0x00000008);
		frag.add(BTAnd);
//		frag.add(PStack);
		frag.add(JumpTrue,endLabel);
		//check subtype-is-reference
		frag.add(PushI,0x00000002);
		frag.add(BTAnd);
//		frag.add(PStack);
		frag.add(JumpFalse,releaseLabel);
		//[...recordPtr]
//		frag.add(Duplicate);
//		readIOffset(frag,Record.RECORD_TYPEID_OFFSET);
//		frag.add(PushI,6);
//		frag.add(Subtract);
//		frag.add(JumpFalse,stringLabel);
		
		frag.add(Duplicate);
		frag.add(Duplicate);
//		frag.add(Duplicate);
		readIOffset(frag,Record.ARRAY_LENGTH_OFFSET);
		storeITo(frag,lengthLabel);
		readIOffset(frag,Record.ARRAY_SUBTYPE_SIZE_OFFSET);
		storeITo(frag,elemSizeLabel);
		frag.add(PushI,ARRAY_HEADER_SIZE);
		frag.add(Add);
		storeITo(frag,elemLabel);
		frag.add(Jump,joinLabel);
		
		frag.add(Label,stringLabel);
		frag.add(Duplicate);
//		frag.add(Duplicate);
		readIOffset(frag,Record.STRING_LENGTH_OFFSET);
		storeITo(frag,lengthLabel);
		frag.add(PushI,1);
		storeITo(frag,elemSizeLabel);
		frag.add(PushI,STRING_HEADER_SIZE);
		frag.add(Add);
		storeITo(frag,elemLabel);
		
		frag.add(Label,joinLabel);
		
		frag.add(Label,loopLabel);
		loadIFrom(frag,lengthLabel);
		frag.add(JumpFalse,endLabel);
		
		loadIFrom(frag,elemLabel);
		loadIFrom(frag,lengthLabel);
		loadIFrom(frag,elemSizeLabel);
		loadIFrom(frag,RELEASE_RECORD_RETURN_ADDRESS);
		
		loadIFrom(frag,elemLabel);
		frag.add(LoadI);
		
		frag.add(Duplicate);
		readIOffset(frag, Record.RECORD_TYPEID_OFFSET);
		frag.add(PushI,6);
		frag.add(Subtract);
		frag.add(JumpFalse,releaseLabel);
		
		frag.add(Call,RELEASE_RECORD);
		
		storeITo(frag,RELEASE_RECORD_RETURN_ADDRESS);
		storeITo(frag,elemSizeLabel);
		storeITo(frag,lengthLabel);
		storeITo(frag,elemLabel);
		
		loadIFrom(frag,elemSizeLabel);
		addITo(frag,elemLabel);
		decrementInteger(frag,lengthLabel);
		frag.add(Jump,loopLabel);
		
		frag.add(Label,releaseLabel);
		frag.add(Duplicate);
		frag.add(Duplicate);
//		frag.add(PStack);
		readIOffset(frag, Record.RECORD_STATUS_OFFSET);
		frag.add(PushI,0x00000004);
		frag.add(Add);
		frag.add(Exchange);
		writeIOffset(frag,Record.RECORD_STATUS_OFFSET);
		
		frag.add(Call,MemoryManager.MEM_MANAGER_DEALLOCATE);
		frag.add(Label,endLabel);
		loadIFrom(frag,RELEASE_RECORD_RETURN_ADDRESS);
		frag.add(Return);
		return frag;
	}
	
	private ASMCodeFragment convertToStringIfBoolean(){
		ASMCodeFragment code=new ASMCodeFragment(CodeType.GENERATES_VOID);
		
		Labeller labeller = new Labeller("print-boolean");
		String trueLabel = labeller.newLabel("true");
		String endLabel = labeller.newLabel("join");
		code.add(Label,CONVERT_TO_STRING_IF_BOOL);
		declareI(code,CONVERT_TO_STRING_IF_BOOL_RETURN_ADDRESS);
		storeITo(code,CONVERT_TO_STRING_IF_BOOL_RETURN_ADDRESS);
		
		code.add(JumpTrue, trueLabel);
		code.add(PushD, RunTime.BOOLEAN_FALSE_STRING);
		code.add(Jump, endLabel);
		code.add(Label, trueLabel);
		code.add(PushD, RunTime.BOOLEAN_TRUE_STRING);
		code.add(Label, endLabel);
		
		loadIFrom(code,CONVERT_TO_STRING_IF_BOOL_RETURN_ADDRESS);
		code.add(Return);
		return code;
	}
	
	private ASMCodeFragment printString(){
		ASMCodeFragment code=new ASMCodeFragment(CodeType.GENERATES_VOID);
		Labeller labeller = new Labeller("print-string");
		String loopLabel=labeller.newLabel("loop-start");
		String endLabel=labeller.newLabel("end");
		code.add(Label,PRINT_STRING);
		
		declareI(code,PRINT_STRING_RETURN_ADDRESS);
		storeITo(code,PRINT_STRING_RETURN_ADDRESS);
		//[..strAddr]
		code.add(Duplicate);// [… arr]
		code.add(JumpFalse, NULL_STRING_RUNTIME_ERROR);// [… ]
		
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
		
		loadIFrom(code,PRINT_STRING_RETURN_ADDRESS);
		code.add(Return);
		return code;
	}

	private ASMCodeFragment subtractRational(){
		ASMCodeFragment code=new ASMCodeFragment(CodeType.GENERATES_VALUE);
		
		code.add(Label,SUBTRACT_RATIONAL);
		
		declareI(code,SUBTRACT_RATIONAL_RETURN_ADDRESS);
		storeITo(code,SUBTRACT_RATIONAL_RETURN_ADDRESS);
		
		storeITo(code,RunTime.RATIONAL_DENOMINATOR_TEMP2);
		storeITo(code,RunTime.RATIONAL_NUMERATOR_TEMP2);
		storeITo(code,RunTime.RATIONAL_DENOMINATOR_TEMP);
		storeITo(code,RunTime.RATIONAL_NUMERATOR_TEMP);
		
		
		loadIFrom(code,RunTime.RATIONAL_DENOMINATOR_TEMP);
		loadIFrom(code,RunTime.RATIONAL_DENOMINATOR_TEMP2);
		code.add(Multiply);
		//[...deno1*deno2]
		loadIFrom(code,RunTime.RATIONAL_DENOMINATOR_TEMP2);
		loadIFrom(code,RunTime.RATIONAL_NUMERATOR_TEMP);
		code.add(Multiply);
		loadIFrom(code,RunTime.RATIONAL_DENOMINATOR_TEMP);
		loadIFrom(code,RunTime.RATIONAL_NUMERATOR_TEMP2);
		code.add(Multiply);
		
		code.add(Subtract);
		//[...deno1*deno2 deno2*num1-deno1*num2]
		code.add(Exchange);
		code.add(Call,RunTime.LOWEST_TERMS);
		loadIFrom(code,SUBTRACT_RATIONAL_RETURN_ADDRESS);
		code.add(Return);
		return code;
	}
	
	private ASMCodeFragment printRational(){
		ASMCodeFragment code=new ASMCodeFragment(CodeType.GENERATES_VOID);
		
		Labeller labeller = new Labeller("print-rational");
		String numeratorPos = labeller.newLabel("numerator-pos");
		String denominatorPos = labeller.newLabel("denominator-pos");
		String rationalPos=labeller.newLabel("rational-pos");
		String endLabel=labeller.newLabel("end");
		String fracLabel=labeller.newLabel("fraction");
		String zeroNumerator=labeller.newLabel("zero-numerator");
		
		code.add(Label,PRINT_RATIONAL);
		declareI(code,PRINT_RATIONAL_RETURN_ADDRESS);
		storeITo(code,PRINT_RATIONAL_RETURN_ADDRESS);
		
		code.add(PushI,1);
		storeITo(code,RunTime.RATIONAL_PRINT_SIGN);//sign=1
		//[...numerator denominator]
//		code.add(PStack);
		code.add(Duplicate);
		code.add(JumpFalse,RunTime.OVER_ZERO_DENOMINATOR_RUNTIME_ERROR);
		
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
//		code.add(PStack);
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
		loadIFrom(code,PRINT_RATIONAL_RETURN_ADDRESS);
		code.add(Return);
		
		return code;
	}
	private ASMCodeFragment clearNBytes(){
		ASMCodeFragment frag=new ASMCodeFragment(CodeType.GENERATES_VOID);
		
		Labeller labeller = new Labeller("clear-n-bytes-subroutine");
		String loopLabel=labeller.newLabel("loop-start");
		String endLabel=labeller.newLabel("end");
		
		// [... elemsPtr elemSize returnAddr]
		frag.add(Label,CLEAR_N_BYTES);
		declareI(frag,CLEAR_N_BYTES_RETURN_ADDRESS);
		storeITo(frag,CLEAR_N_BYTES_RETURN_ADDRESS);
		// [... elemsPtr elemSize]
		declareI(frag,CLEAR_N_BYTES_ELEMENT_SIZE);
		storeITo(frag,CLEAR_N_BYTES_ELEMENT_SIZE);
		declareI(frag,CLEAR_N_BYTES_ELEMENT_ADDR);
		storeITo(frag,CLEAR_N_BYTES_ELEMENT_ADDR);
		
		frag.add(Label,loopLabel);
		loadIFrom(frag,CLEAR_N_BYTES_ELEMENT_SIZE);//[... elemSize]
		frag.add(JumpFalse,endLabel);
		frag.add(PushI,0);
		storeCTo(frag,CLEAR_N_BYTES_ELEMENT_ADDR);
		incrementInteger(frag,CLEAR_N_BYTES_ELEMENT_ADDR);
		decrementInteger(frag,CLEAR_N_BYTES_ELEMENT_SIZE);
		
		frag.add(Jump,loopLabel);
		frag.add(Label,endLabel);
		
		loadIFrom(frag,CLEAR_N_BYTES_RETURN_ADDRESS);
		frag.add(Return);
		
		return frag;
	}
	private ASMCodeFragment gcdSubroutine(){
		ASMCodeFragment frag=new ASMCodeFragment(CodeType.GENERATES_VALUE);
		
		Labeller labeller = new Labeller("lowest-term-subroutine");
		String startLabel = labeller.newLabel("loop-start");
		String exchangeLabel = labeller.newLabel("exchange");
		String endLabel=labeller.newLabel("end");
		
		frag.add(Label,LOWEST_TERMS);
		//[...numerator denominator returnAddr]
		//stash the return address in a static location
		declareI(frag,LOWEST_TERMS_RETURN_ADDRESS);
		storeITo(frag,LOWEST_TERMS_RETURN_ADDRESS);
		
		//[...numerator denominator]
		frag.add(Duplicate);//[...numerator denominator denominator]
		frag.add(JumpFalse,OVER_ZERO_DENOMINATOR_RUNTIME_ERROR);
		//[...numerator denominator]
		declareI(frag,LOWEST_TERMS_DENOMINATOR);
		declareI(frag,LOWEST_TERMS_NUMERATOR);
		declareI(frag,LOWEST_TERMS_GCD);
		declareI(frag,LOWEST_TERMS_TEMP_A);
		declareI(frag,LOWEST_TERMS_TEMP_B);
		
		storeITo(frag,LOWEST_TERMS_DENOMINATOR);
		storeITo(frag,LOWEST_TERMS_NUMERATOR);
		//[...]
		loadIFrom(frag,LOWEST_TERMS_NUMERATOR);
		loadIFrom(frag,LOWEST_TERMS_DENOMINATOR);
		//[...numerator denominator]
		frag.add(Subtract);
		//[...numerator-denominator]
		frag.add(JumpNeg,exchangeLabel);
		loadIFrom(frag,LOWEST_TERMS_NUMERATOR);
		loadIFrom(frag,LOWEST_TERMS_DENOMINATOR);//[...numerator denominator]		
		frag.add(Jump,startLabel);
		
		frag.add(Label,exchangeLabel);
		loadIFrom(frag,LOWEST_TERMS_DENOMINATOR);
		loadIFrom(frag,LOWEST_TERMS_NUMERATOR);//[...denominator numerator]
		
		frag.add(Label,startLabel);
		//now we have a and b on stack and a>b [...a b] (a and b are denominator and numerator]
		//store a and b temporarily
		storeITo(frag,LOWEST_TERMS_TEMP_B);
		storeITo(frag,LOWEST_TERMS_TEMP_A);
		loadIFrom(frag,LOWEST_TERMS_TEMP_A);
		loadIFrom(frag,LOWEST_TERMS_TEMP_B);
		//[...a b] (a and b are denominator and numerator]
		
		frag.add(Duplicate);//[...a b b]
		frag.add(JumpFalse, endLabel);//[...a b]
		frag.add(Remainder);//[...a%b]
		loadIFrom(frag,LOWEST_TERMS_TEMP_B);//[...a%b b]
		frag.add(Exchange);//[...b a%b]
		frag.add(Jump,startLabel);
		
		frag.add(Label,endLabel);//[...a b]
		frag.add(Pop);//[...gcd]
		storeITo(frag,LOWEST_TERMS_GCD);
		loadIFrom(frag,LOWEST_TERMS_NUMERATOR);
		loadIFrom(frag,LOWEST_TERMS_GCD);
		frag.add(Divide);//[...numerator/gcd]
		loadIFrom(frag,LOWEST_TERMS_DENOMINATOR);
		loadIFrom(frag,LOWEST_TERMS_GCD);
		frag.add(Divide);//[...numerator/gcd denominator/gcd]
//		frag.add(PStack);
		loadIFrom(frag,LOWEST_TERMS_RETURN_ADDRESS);
		frag.add(Return);
		
		return frag;
	}
	
	public static ASMCodeFragment getEnvironment() {
		RunTime rt = new RunTime();
		return rt.environmentASM();
	}
}

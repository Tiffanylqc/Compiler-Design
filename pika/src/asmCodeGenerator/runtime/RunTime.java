package asmCodeGenerator.runtime;
import static asmCodeGenerator.codeStorage.ASMCodeFragment.CodeType.*;
import static asmCodeGenerator.codeStorage.ASMOpcode.*;

import asmCodeGenerator.Labeller;
import asmCodeGenerator.Macros;
import static asmCodeGenerator.Macros.*;
import asmCodeGenerator.codeStorage.ASMCodeFragment;
import asmCodeGenerator.codeStorage.ASMCodeFragment.CodeType;
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
	public static final String GLOBAL_MEMORY_BLOCK    = "$global-memory-block";
	public static final String USABLE_MEMORY_START    = "$usable-memory-start";
	public static final String MAIN_PROGRAM_LABEL     = "$$main";
	public static final String DASH_PRINT_STRING	="$dash-string";
	public static final String DIVIDE_SIGN_STRING	="$divide-sign-string";
	public static final String MINUS_SIGN_STRING="$minus-sign-string";
	
	public static final String GENERAL_RUNTIME_ERROR = "$$general-runtime-error";
	public static final String INTEGER_DIVIDE_BY_ZERO_RUNTIME_ERROR = "$$i-divide-by-zero";
	public static final String FLOAT_DIVIDE_BY_ZERO_RUNTIME_ERROR = "$$f-divide-by-zero";
	public static final String NULL_ARRAY_RUNTIME_ERROR = "$$null-array";
	public static final String INDEX_OUT_OF_BOUNDS_RUNTIME_ERROR = "$$index-out-of-bound";
	public static final String OVER_ZERO_DENOMINATOR_RUNTIME_ERROR="$$over-zero-denominator";
	public static final String EXPRESSOVER_DIVIDE_BY_ZERO_RUNTIME_ERROR="$$rational-expressover-divide-by-zero";
	public static final String RATIONALIZE_DIVIDE_BY_ZERO_RUNTIME_ERROR="$$rationalize-divide-by-zero";
	public static final String NEGATIVE_LENGTH_ARRAY_RUNTIME_ERROR="$$negative-length-array";
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
	private ASMCodeFragment environmentASM() {
		ASMCodeFragment result = new ASMCodeFragment(GENERATES_VOID);
		result.append(jumpToMain());
		result.append(stringsForPrintf());
		result.append(runtimeErrors());
		result.append(temporaryVariables());
		result.append(gcdSubroutine());
		result.append(clearNBytes());
		
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
		frag.add(DataS, "zero denominator");
		
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
		// [... length]
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

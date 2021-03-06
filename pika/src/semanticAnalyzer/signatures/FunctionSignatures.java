package semanticAnalyzer.signatures;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import asmCodeGenerator.ArrayEmptyCreationCodeGenerator;
import asmCodeGenerator.ArrayIndexingCodeGenerator;
import asmCodeGenerator.ArrayPopulateCreationCodeGenerator;
import asmCodeGenerator.CharIntToRationalCodeGenerator;
import asmCodeGenerator.CharStringAddCodeGenerator;
import asmCodeGenerator.CharToBoolCodeGenerator;
import asmCodeGenerator.CharToIntCodeGenerator;
import asmCodeGenerator.CloneCodeGenerator;
import asmCodeGenerator.FloatDivideCodeGenerator;
import asmCodeGenerator.FloatingExpressOverCodeGenerator;
import asmCodeGenerator.FloatingRationalizeCodeGenerator;
import asmCodeGenerator.FloatingToRationalCodeGenerator;
import asmCodeGenerator.FoldCodeGenerator;
import asmCodeGenerator.FormRationalCodeGenerator;
import asmCodeGenerator.IntToBoolCodeGenerator;
import asmCodeGenerator.IntToCharCodeGenerator;
import asmCodeGenerator.IntegerDivideCodeGenerator;
import asmCodeGenerator.MapCodeGenerator;
import asmCodeGenerator.RationalAddCodeGenerator;
import asmCodeGenerator.RationalDivideCodeGenerator;
import asmCodeGenerator.RationalExpressOverCodeGenerator;
import asmCodeGenerator.RationalMultiplyCodeGenerator;
import asmCodeGenerator.RationalRationalizeCodeGenerator;
import asmCodeGenerator.RationalSubtractCodeGenerator;
import asmCodeGenerator.RationalToFloatCodeGenerator;
import asmCodeGenerator.RationalToIntCodeGenerator;
import asmCodeGenerator.ReduceCodeGenerator;
import asmCodeGenerator.ReverseArrayCodeGenerator;
import asmCodeGenerator.ReverseCodeGenerator;
import asmCodeGenerator.ShortCircuitAndCodeGenerator;
import asmCodeGenerator.ShortCircuitOrCodeGenerator;
import asmCodeGenerator.StringCharAddCodeGenerator;
import asmCodeGenerator.StringIndexingCodeGenerator;
import asmCodeGenerator.StringSliceCodeGenerator;
import asmCodeGenerator.StringStringAddCodeGenerator;
import asmCodeGenerator.ZipCodeGenerator;
import asmCodeGenerator.codeStorage.ASMOpcode;
import lexicalAnalyzer.Keyword;
import lexicalAnalyzer.Punctuator;
import semanticAnalyzer.types.Type;
import semanticAnalyzer.types.TypeVariable;
import semanticAnalyzer.types.Array;
import semanticAnalyzer.types.LambdaType;
import semanticAnalyzer.types.PrimitiveType;
import semanticAnalyzer.signatures.FunctionSignature;

public class FunctionSignatures extends ArrayList<FunctionSignature> {
	private static final long serialVersionUID = -4907792488209670697L;
	private static Map<Object, FunctionSignatures> signaturesForKey = new HashMap<Object, FunctionSignatures>();
	
	Object key;
	
	public FunctionSignatures(Object key, FunctionSignature ...functionSignatures) {
		this.key = key;
		for(FunctionSignature functionSignature: functionSignatures) {
			add(functionSignature);
		}
		signaturesForKey.put(key, this);
	}
	
	public Object getKey() {
		return key;
	}
	public boolean hasKey(Object key) {
		return this.key.equals(key);
	}
	/////////////////////////////////////////////////////////////
	private boolean PredecessorOf(FunctionSignature predecessor, FunctionSignature successor){
		Type[] PredecessorParams=predecessor.getParamTypes();
		Type[] SuccessorParams=successor.getParamTypes();
		
		if(PredecessorParams.length!=SuccessorParams.length)
			return false;
		
		for(int i=0;i<PredecessorParams.length;i++){
			if(!PredecessorParams[i].equivalent(SuccessorParams[i]) && !FunctionSignature.canConvert(PredecessorParams[i],SuccessorParams[i])){
				return false;
			}
		}
		return true;
	}
	
	private FunctionSignature chooseSignature(List<FunctionSignature> acceptableSignatures){
		if(acceptableSignatures.isEmpty())
			return FunctionSignature.nullInstance();
		if(acceptableSignatures.size()==1)
			return acceptableSignatures.get(0);
		else{
			List<FunctionSignature> predecessors=new ArrayList<FunctionSignature>();
			boolean allPredecessor;
			for(FunctionSignature functionSignature1 : acceptableSignatures){
				allPredecessor=true;
				for(FunctionSignature functionSignature2: acceptableSignatures){
					if(functionSignature1.equals(functionSignature2))
						continue;
					if(!PredecessorOf(functionSignature1,functionSignature2)){
						allPredecessor=false;
						break;
					}	
				}
				if(allPredecessor==true)
					predecessors.add(functionSignature1);
			}
			
			if(predecessors.size()==1)
				return predecessors.get(0);
			else 
				return FunctionSignature.nullInstance();
		}
	}
	
	public FunctionSignature acceptingSignature(List<Type> types) {
		//first check whether possible to accept without promotion
		for(FunctionSignature functionSignature: this) {
			if(functionSignature.NoPromotionAccepts(types)) {
				return functionSignature;
			}
		}
		//For array types there is no promotion
//		for(Type type:types){
//			if(type instanceof Array)
//				return FunctionSignature.nullInstance();
//		}	
		
		//then check whether promoting first argument satisfy
		List<FunctionSignature> acceptableSignatures=new ArrayList<FunctionSignature>();
		FunctionSignature finalSignature;
		for(FunctionSignature functionSignature: this){
			if(functionSignature.PromoteFirstArgumentAccepts(types)){
				acceptableSignatures.add(functionSignature);
			}
		}
		
		finalSignature=chooseSignature(acceptableSignatures);
		
		if(!finalSignature.isNull())
			return finalSignature;
		
		if(types.size()<2||this.getKey()==Punctuator.ASSIGN)
			return FunctionSignature.nullInstance();
			
//		System.out.println("yes");
		//then check whether promoting second arguments satisfy
		acceptableSignatures.clear();
		for(FunctionSignature functionSignature: this){
			if(functionSignature.PromoteSecondArgumentAccepts(types)){
				acceptableSignatures.add(functionSignature);
			}
		}
		
		finalSignature=chooseSignature(acceptableSignatures);
		if(!finalSignature.isNull())
			return finalSignature;

		//last check promoting both operand
		acceptableSignatures.clear();
		for(FunctionSignature functionSignature: this){
			if(functionSignature.PromoteBothArgumentsAccepts(types)){
				acceptableSignatures.add(functionSignature);
			}
		}
		
		finalSignature=chooseSignature(acceptableSignatures);
		if(!finalSignature.isNull())
			return finalSignature;
		return FunctionSignature.nullInstance();
	}
	
	public boolean accepts(List<Type> types) {
		return !acceptingSignature(types).isNull();
	}
	
	//Tom's Version
	public FunctionSignature acceptingSignatureStrict(List<Type> types) {
		for(FunctionSignature functionSignature: this) {
			if(functionSignature.acceptsStrict(types)) {
				return functionSignature;
			}
		}
		return FunctionSignature.nullInstance();
	}
//	public boolean accepts(List<Type> types) {
//		return !acceptingSignature(types).isNull();
//	}

	
	/////////////////////////////////////////////////////////////////////////////////
	// access to FunctionSignatures by key object.
	
	public static FunctionSignatures nullSignatures = new FunctionSignatures(0, FunctionSignature.nullInstance());

	public static FunctionSignatures signaturesOf(Object key) {
		if(signaturesForKey.containsKey(key)) {
			return signaturesForKey.get(key);
		}
		return nullSignatures;
	}
	public static FunctionSignature signature(Object key, List<Type> types) {
		FunctionSignatures signatures = FunctionSignatures.signaturesOf(key);
		return signatures.acceptingSignature(types);
	}

	
	
	/////////////////////////////////////////////////////////////////////////////////
	// Put the signatures for operators in the following static block.
	
	static {
		// here's one example to get you started with FunctionSignatures: the signatures for addition.		
		// for this to work, you should statically import PrimitiveType.*
		
		// Array Indexing
		TypeVariable S = new TypeVariable("S");
		TypeVariable U = new TypeVariable("U");
		TypeVariable T = new TypeVariable("T");
		
		List<TypeVariable> setS = Arrays.asList(S);
		List<TypeVariable> setTU = Arrays.asList(T,U);
		List<TypeVariable> setU = Arrays.asList(U);
		List<TypeVariable> setT = Arrays.asList(T);
		List<TypeVariable> setSTU = Arrays.asList(S,T,U);
		new FunctionSignatures(Keyword.MAP,
				new FunctionSignature(
						new MapCodeGenerator(),
						setTU,
						new Array(T),
						new LambdaType(new FunctionSignature(1,setU,T,U)),
						new Array(U)
				)	
		);
		
		new FunctionSignatures(Keyword.REDUCE,
				new FunctionSignature(
						new ReduceCodeGenerator(),
						setT,
						new Array(T),
						new LambdaType(new FunctionSignature(1,T,PrimitiveType.BOOLEAN)),
						new Array(T)
				)
		);
		
		new FunctionSignatures(Keyword.FOLD,
				new FunctionSignature(
						new FoldCodeGenerator(),
						setT,
						new Array(T),
						new LambdaType(new FunctionSignature(1,T,T,T)),
						T
				),
				new FunctionSignature(
						new FoldCodeGenerator(),
						setTU,
						new Array(T),
						U,
						new LambdaType(new FunctionSignature(1,U,T,U)),
						U
				)
		);
		
		new FunctionSignatures(Keyword.ZIP,
				new FunctionSignature(
						new ZipCodeGenerator(),
						setSTU,
						new Array(S),
						new Array(T),
						new LambdaType(new FunctionSignature(1,setSTU,S,T,U)),
						new Array(U)
				)
		);
		
		new FunctionSignatures(Punctuator.ARRAY_INDEXING,
				new FunctionSignature(
						new ArrayIndexingCodeGenerator(),
						setS,
						new Array(S),PrimitiveType.INTEGER,S
				),
				new FunctionSignature(new StringIndexingCodeGenerator(), PrimitiveType.STRING, PrimitiveType.INTEGER, PrimitiveType.CHARACTER)
		);
		
		new FunctionSignatures(Keyword.NEW,
				new FunctionSignature(
						new ArrayEmptyCreationCodeGenerator(),
						setS,
						new Array(S),PrimitiveType.INTEGER,new Array(S)
				));
		new FunctionSignatures(Keyword.LENGTH,
				new FunctionSignature(
						1,
						setS,
						new Array(S),PrimitiveType.INTEGER
				),
				new FunctionSignature(1, PrimitiveType.STRING, PrimitiveType.INTEGER)
		);
		new FunctionSignatures(Punctuator.STRING_SLICE,
				new FunctionSignature(new StringSliceCodeGenerator(), PrimitiveType.STRING, PrimitiveType.INTEGER, PrimitiveType.INTEGER, PrimitiveType.STRING)
		);
		new FunctionSignatures(Keyword.CLONE,
				new FunctionSignature(
						new CloneCodeGenerator(),
						setS,
						new Array(S),new Array(S)
				));
		new FunctionSignatures(Keyword.REVERSE,
				new FunctionSignature(
						new ReverseCodeGenerator(),
						PrimitiveType.STRING,PrimitiveType.STRING
				),
				new FunctionSignature(
						new ReverseArrayCodeGenerator(),
						setS,
						new Array(S),
						new Array(S)
				)
		);
		new FunctionSignatures(Punctuator.OPEN_BRACKET,
				new FunctionSignature(
						new ArrayPopulateCreationCodeGenerator(),
						setS,
						S,new Array(S)));
		//BOOL_AND
		new FunctionSignatures(Punctuator.BOOL_AND,
				new FunctionSignature(new ShortCircuitAndCodeGenerator(), PrimitiveType.BOOLEAN, PrimitiveType.BOOLEAN, PrimitiveType.BOOLEAN)
		);
		//BOOL_OR
		new FunctionSignatures(Punctuator.BOOL_OR,
				new FunctionSignature(new ShortCircuitOrCodeGenerator(), PrimitiveType.BOOLEAN, PrimitiveType.BOOLEAN, PrimitiveType.BOOLEAN)
		);
		//BOOL_NOT
		new FunctionSignatures(Punctuator.BOOL_NOT,
				new FunctionSignature(ASMOpcode.BNegate, PrimitiveType.BOOLEAN, PrimitiveType.BOOLEAN)
		);
		//Over-> //
		new FunctionSignatures(Punctuator.OVER,
				new FunctionSignature(new FormRationalCodeGenerator(),PrimitiveType.INTEGER, PrimitiveType.INTEGER, PrimitiveType.RATIONAL)
		);
		//express over -> ///
		new FunctionSignatures(Punctuator.EXPRESS_OVER,
				new FunctionSignature(new RationalExpressOverCodeGenerator(),PrimitiveType.RATIONAL,PrimitiveType.INTEGER, PrimitiveType.INTEGER),
				new FunctionSignature(new FloatingExpressOverCodeGenerator(),PrimitiveType.FLOATING,PrimitiveType.INTEGER, PrimitiveType.INTEGER)
		);
		//rationalize ->////
		new FunctionSignatures(Punctuator.RATIONALIZE,
				new FunctionSignature(new RationalRationalizeCodeGenerator(),PrimitiveType.RATIONAL,PrimitiveType.INTEGER,PrimitiveType.RATIONAL),
				new FunctionSignature(new FloatingRationalizeCodeGenerator(),PrimitiveType.FLOATING,PrimitiveType.INTEGER,PrimitiveType.RATIONAL)
		);
		
		//assignment signatures
		new FunctionSignatures(Punctuator.ASSIGN,
				new FunctionSignature(1,PrimitiveType.INTEGER,PrimitiveType.INTEGER,PrimitiveType.INTEGER),
				new FunctionSignature(1,PrimitiveType.FLOATING,PrimitiveType.FLOATING,PrimitiveType.FLOATING),
				new FunctionSignature(1,PrimitiveType.CHARACTER,PrimitiveType.CHARACTER,PrimitiveType.CHARACTER),
				new FunctionSignature(1,PrimitiveType.STRING,PrimitiveType.STRING,PrimitiveType.STRING),
				new FunctionSignature(1,PrimitiveType.BOOLEAN,PrimitiveType.BOOLEAN,PrimitiveType.BOOLEAN),
				new FunctionSignature(1,PrimitiveType.RATIONAL,PrimitiveType.RATIONAL,PrimitiveType.RATIONAL),
				new FunctionSignature(1,setS,S,S,S)
		);
		
		//cast signature functionsignature(1,preType,afterType)
		new FunctionSignatures(Punctuator.BAR,
			new FunctionSignature(ASMOpcode.Nop,PrimitiveType.INTEGER,PrimitiveType.INTEGER,PrimitiveType.INTEGER),
			new FunctionSignature(ASMOpcode.Nop,PrimitiveType.FLOATING,PrimitiveType.FLOATING,PrimitiveType.FLOATING),
			new FunctionSignature(ASMOpcode.Nop,PrimitiveType.CHARACTER,PrimitiveType.CHARACTER,PrimitiveType.CHARACTER),
			new FunctionSignature(ASMOpcode.Nop,PrimitiveType.STRING,PrimitiveType.STRING,PrimitiveType.STRING),
			new FunctionSignature(ASMOpcode.Nop,PrimitiveType.BOOLEAN,PrimitiveType.BOOLEAN,PrimitiveType.BOOLEAN),
			
			new FunctionSignature(new CharToIntCodeGenerator(),PrimitiveType.CHARACTER,PrimitiveType.INTEGER,PrimitiveType.INTEGER),
			new FunctionSignature(ASMOpcode.ConvertF,PrimitiveType.INTEGER,PrimitiveType.FLOATING,PrimitiveType.FLOATING),
			new FunctionSignature(new IntToCharCodeGenerator(),PrimitiveType.INTEGER,PrimitiveType.CHARACTER,PrimitiveType.CHARACTER),
			new FunctionSignature(ASMOpcode.ConvertI,PrimitiveType.FLOATING,PrimitiveType.INTEGER,PrimitiveType.INTEGER),
			new FunctionSignature(ASMOpcode.ConvertF,PrimitiveType.CHARACTER,PrimitiveType.FLOATING,PrimitiveType.FLOATING),
			new FunctionSignature(new IntToBoolCodeGenerator(),PrimitiveType.INTEGER,PrimitiveType.BOOLEAN,PrimitiveType.BOOLEAN),
			new FunctionSignature(new CharToBoolCodeGenerator(),PrimitiveType.CHARACTER,PrimitiveType.BOOLEAN,PrimitiveType.BOOLEAN),
			new FunctionSignature(new CharIntToRationalCodeGenerator(),PrimitiveType.CHARACTER,PrimitiveType.RATIONAL,PrimitiveType.RATIONAL),
			new FunctionSignature(new CharIntToRationalCodeGenerator(),PrimitiveType.INTEGER,PrimitiveType.RATIONAL,PrimitiveType.RATIONAL),
			new FunctionSignature(new FloatingToRationalCodeGenerator(),PrimitiveType.FLOATING,PrimitiveType.RATIONAL,PrimitiveType.RATIONAL),
			new FunctionSignature(ASMOpcode.Nop,PrimitiveType.RATIONAL,PrimitiveType.RATIONAL,PrimitiveType.RATIONAL),
			new FunctionSignature(new RationalToFloatCodeGenerator(),PrimitiveType.RATIONAL,PrimitiveType.FLOATING,PrimitiveType.FLOATING),
			new FunctionSignature(new RationalToIntCodeGenerator(),PrimitiveType.RATIONAL,PrimitiveType.INTEGER,PrimitiveType.INTEGER)
		);
		
		new FunctionSignatures(Punctuator.ADD,
		    new FunctionSignature(ASMOpcode.Add, PrimitiveType.INTEGER, PrimitiveType.INTEGER, PrimitiveType.INTEGER),
		    new FunctionSignature(ASMOpcode.FAdd, PrimitiveType.FLOATING, PrimitiveType.FLOATING, PrimitiveType.FLOATING),
		    new FunctionSignature(new RationalAddCodeGenerator(), PrimitiveType.RATIONAL, PrimitiveType.RATIONAL, PrimitiveType.RATIONAL),
		    new FunctionSignature(new StringCharAddCodeGenerator(), PrimitiveType.STRING, PrimitiveType.CHARACTER, PrimitiveType.STRING),
		    new FunctionSignature(new CharStringAddCodeGenerator(), PrimitiveType.CHARACTER, PrimitiveType.STRING, PrimitiveType.STRING),
		    new FunctionSignature(new StringStringAddCodeGenerator(), PrimitiveType.STRING, PrimitiveType.STRING, PrimitiveType.STRING)
		);
		
		new FunctionSignatures(Punctuator.MULTIPLY,
			new FunctionSignature(ASMOpcode.Multiply,PrimitiveType.INTEGER, PrimitiveType.INTEGER, PrimitiveType.INTEGER),
			new FunctionSignature(ASMOpcode.FMultiply,PrimitiveType.FLOATING, PrimitiveType.FLOATING, PrimitiveType.FLOATING),
			new FunctionSignature(new RationalMultiplyCodeGenerator(), PrimitiveType.RATIONAL, PrimitiveType.RATIONAL, PrimitiveType.RATIONAL)
		);
		new FunctionSignatures(Punctuator.SUBTRACT,
			new FunctionSignature(ASMOpcode.Subtract, PrimitiveType.INTEGER, PrimitiveType.INTEGER, PrimitiveType.INTEGER),
			new FunctionSignature(ASMOpcode.FSubtract, PrimitiveType.FLOATING, PrimitiveType.FLOATING, PrimitiveType.FLOATING),
			new FunctionSignature(new RationalSubtractCodeGenerator(), PrimitiveType.RATIONAL, PrimitiveType.RATIONAL, PrimitiveType.RATIONAL)
		);
		new FunctionSignatures(Punctuator.DIVIDE,
			new FunctionSignature(new IntegerDivideCodeGenerator(), PrimitiveType.INTEGER, PrimitiveType.INTEGER, PrimitiveType.INTEGER),
			new FunctionSignature(new FloatDivideCodeGenerator(), PrimitiveType.FLOATING, PrimitiveType.FLOATING, PrimitiveType.FLOATING),
			new FunctionSignature(new RationalDivideCodeGenerator(), PrimitiveType.RATIONAL, PrimitiveType.RATIONAL, PrimitiveType.RATIONAL)
		);
		Punctuator []comparisons = { Punctuator.GREATER, Punctuator.GREATER_EQUAL, Punctuator.LESS, Punctuator.LESS_EQUAL,
									 Punctuator.EQUAL,Punctuator.NOT_EQUAL };
		for(Punctuator comparison: comparisons) {
			FunctionSignature iSignature = new FunctionSignature(1,PrimitiveType.INTEGER, PrimitiveType.INTEGER, PrimitiveType.BOOLEAN);
			FunctionSignature sSignature = new FunctionSignature(1,PrimitiveType.STRING, PrimitiveType.STRING, PrimitiveType.BOOLEAN);
			FunctionSignature cSignature = new FunctionSignature(1,PrimitiveType.CHARACTER, PrimitiveType.CHARACTER, PrimitiveType.BOOLEAN);
			FunctionSignature fSignature = new FunctionSignature(1,PrimitiveType.FLOATING, PrimitiveType.FLOATING, PrimitiveType.BOOLEAN);
			FunctionSignature bSignature = new FunctionSignature(1,PrimitiveType.BOOLEAN, PrimitiveType.BOOLEAN, PrimitiveType.BOOLEAN);
			FunctionSignature aSignature = new FunctionSignature(1,setS,new Array(S), new Array(S), PrimitiveType.BOOLEAN);
			FunctionSignature rSignature = new FunctionSignature(1,PrimitiveType.RATIONAL, PrimitiveType.RATIONAL, PrimitiveType.BOOLEAN);
			if(comparison == Punctuator.EQUAL ||comparison == Punctuator.NOT_EQUAL) {
				new FunctionSignatures(comparison,iSignature, sSignature, cSignature, fSignature, bSignature, aSignature, rSignature);
			}
			else {
				new FunctionSignatures(comparison,iSignature, cSignature, fSignature, rSignature);
			}
		}
		// First, we use the operator itself (in this case the Punctuator ADD) as the key.
		// Then, we give that key two signatures: one an (INT x INT -> INT) and the other
		// a (FLOAT x FLOAT -> FLOAT).  Each signature has a "whichVariant" parameter where
		// I'm placing the instruction (ASMOpcode) that needs to be executed.
		//
		// I'll follow the convention that if a signature has an ASMOpcode for its whichVariant,
		// then to generate code for the operation, one only needs to generate the code for
		// the operands (in order) and then add to that the Opcode.  For instance, the code for
		// floating addition should look like:
		//
		//		(generate argument 1)	: may be many instructions
		//		(generate argument 2)   : ditto
		//		FAdd					: just one instruction
		//
		// If the code that an operator should generate is more complicated than this, then
		// I will not use an ASMOpcode for the whichVariant.  In these cases I typically use
		// a small object with one method (the "Command" design pattern) that generates the
		// required code.

	}

}

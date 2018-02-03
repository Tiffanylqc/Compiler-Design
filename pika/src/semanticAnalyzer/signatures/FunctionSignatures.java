package semanticAnalyzer.signatures;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import asmCodeGenerator.ArrayCloneCodeGenerator;
import asmCodeGenerator.ArrayEmptyCreationCodeGenerator;
import asmCodeGenerator.ArrayIndexingCodeGenerator;
import asmCodeGenerator.ArrayLengthCodeGenerator;
import asmCodeGenerator.ArrayPopulateCreationCodeGenerator;
import asmCodeGenerator.FloatDivideCodeGenerator;
import asmCodeGenerator.IntegerDivideCodeGenerator;
import asmCodeGenerator.codeStorage.ASMOpcode;
import lexicalAnalyzer.Keyword;
import lexicalAnalyzer.Punctuator;
import semanticAnalyzer.types.Type;
import semanticAnalyzer.types.TypeVariable;
import semanticAnalyzer.types.Array;
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
		List<TypeVariable> setS = Arrays.asList(S);
		
		new FunctionSignatures(Punctuator.ARRAY_INDEXING,
				new FunctionSignature(
						new ArrayIndexingCodeGenerator(),
						setS,
						new Array(S),PrimitiveType.INTEGER,S
				));
		
		new FunctionSignatures(Keyword.NEW,
				new FunctionSignature(
						new ArrayEmptyCreationCodeGenerator(),
						setS,
						new Array(S),PrimitiveType.INTEGER,new Array(S)
				));
		new FunctionSignatures(Keyword.LENGTH,
				new FunctionSignature(
						new ArrayLengthCodeGenerator(),
						setS,
						new Array(S),PrimitiveType.INTEGER
				));
		new FunctionSignatures(Keyword.CLONE,
				new FunctionSignature(
						new ArrayCloneCodeGenerator(),
						setS,
						new Array(S),new Array(S)
				));
		new FunctionSignatures(Punctuator.OPEN_BRACKET,
				new FunctionSignature(
						new ArrayPopulateCreationCodeGenerator(),
						setS,
						S,new Array(S)));
		//BOOL_AND
		new FunctionSignatures(Punctuator.BOOL_AND,
				new FunctionSignature(ASMOpcode.And, PrimitiveType.BOOLEAN, PrimitiveType.BOOLEAN, PrimitiveType.BOOLEAN)
		);
		//BOOL_OR
		new FunctionSignatures(Punctuator.BOOL_OR,
				new FunctionSignature(ASMOpcode.Or, PrimitiveType.BOOLEAN, PrimitiveType.BOOLEAN, PrimitiveType.BOOLEAN)
		);
		//BOOL_NOT
		new FunctionSignatures(Punctuator.BOOL_NOT,
				new FunctionSignature(ASMOpcode.BNegate, PrimitiveType.BOOLEAN, PrimitiveType.BOOLEAN)
		);
		//Over-> //
		new FunctionSignatures(Punctuator.OVER,
				new FunctionSignature(1,PrimitiveType.INTEGER, PrimitiveType.INTEGER, PrimitiveType.RATIONAL)
		);
		//express over -> ///
		new FunctionSignatures(Punctuator.EXPRESS_OVER,
				new FunctionSignature(1,PrimitiveType.RATIONAL,PrimitiveType.INTEGER, PrimitiveType.INTEGER),
				new FunctionSignature(1,PrimitiveType.FLOATING,PrimitiveType.INTEGER, PrimitiveType.INTEGER)
		);
		//rationalize ->////
		new FunctionSignatures(Punctuator.RATIONALIZE,
				new FunctionSignature(1,PrimitiveType.RATIONAL,PrimitiveType.INTEGER,PrimitiveType.RATIONAL),
				new FunctionSignature(1,PrimitiveType.FLOATING,PrimitiveType.INTEGER,PrimitiveType.RATIONAL)
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
			new FunctionSignature(1,PrimitiveType.INTEGER,PrimitiveType.INTEGER,PrimitiveType.INTEGER),
			new FunctionSignature(1,PrimitiveType.FLOATING,PrimitiveType.FLOATING,PrimitiveType.FLOATING),
			new FunctionSignature(1,PrimitiveType.CHARACTER,PrimitiveType.CHARACTER,PrimitiveType.CHARACTER),
			new FunctionSignature(1,PrimitiveType.STRING,PrimitiveType.STRING,PrimitiveType.STRING),
			new FunctionSignature(1,PrimitiveType.BOOLEAN,PrimitiveType.BOOLEAN,PrimitiveType.BOOLEAN),
			
			new FunctionSignature(1,PrimitiveType.CHARACTER,PrimitiveType.INTEGER,PrimitiveType.INTEGER),
			new FunctionSignature(1,PrimitiveType.INTEGER,PrimitiveType.FLOATING,PrimitiveType.FLOATING),
			new FunctionSignature(1,PrimitiveType.INTEGER,PrimitiveType.CHARACTER,PrimitiveType.CHARACTER),
			new FunctionSignature(1,PrimitiveType.FLOATING,PrimitiveType.INTEGER,PrimitiveType.INTEGER),
			new FunctionSignature(1,PrimitiveType.INTEGER,PrimitiveType.BOOLEAN,PrimitiveType.BOOLEAN),
			new FunctionSignature(1,PrimitiveType.CHARACTER,PrimitiveType.BOOLEAN,PrimitiveType.BOOLEAN),
			new FunctionSignature(1,PrimitiveType.CHARACTER,PrimitiveType.RATIONAL,PrimitiveType.RATIONAL),
			new FunctionSignature(1,PrimitiveType.INTEGER,PrimitiveType.RATIONAL,PrimitiveType.RATIONAL),
			new FunctionSignature(1,PrimitiveType.FLOATING,PrimitiveType.RATIONAL,PrimitiveType.RATIONAL),
			new FunctionSignature(1,PrimitiveType.RATIONAL,PrimitiveType.RATIONAL,PrimitiveType.RATIONAL),
			new FunctionSignature(1,PrimitiveType.RATIONAL,PrimitiveType.FLOATING,PrimitiveType.FLOATING),
			new FunctionSignature(1,PrimitiveType.RATIONAL,PrimitiveType.INTEGER,PrimitiveType.INTEGER),
			new FunctionSignature(1,setS,S,S,S)
		);
		
		new FunctionSignatures(Punctuator.ADD,
		    new FunctionSignature(ASMOpcode.Add, PrimitiveType.INTEGER, PrimitiveType.INTEGER, PrimitiveType.INTEGER),
		    new FunctionSignature(ASMOpcode.FAdd, PrimitiveType.FLOATING, PrimitiveType.FLOATING, PrimitiveType.FLOATING),
		    new FunctionSignature(1, PrimitiveType.RATIONAL, PrimitiveType.RATIONAL, PrimitiveType.RATIONAL)
		);
		
		new FunctionSignatures(Punctuator.MULTIPLY,
			new FunctionSignature(ASMOpcode.Multiply,PrimitiveType.INTEGER, PrimitiveType.INTEGER, PrimitiveType.INTEGER),
			new FunctionSignature(ASMOpcode.FMultiply,PrimitiveType.FLOATING, PrimitiveType.FLOATING, PrimitiveType.FLOATING),
			new FunctionSignature(1, PrimitiveType.RATIONAL, PrimitiveType.RATIONAL, PrimitiveType.RATIONAL)
		);
		new FunctionSignatures(Punctuator.SUBTRACT,
			new FunctionSignature(ASMOpcode.Subtract, PrimitiveType.INTEGER, PrimitiveType.INTEGER, PrimitiveType.INTEGER),
			new FunctionSignature(ASMOpcode.FSubtract, PrimitiveType.FLOATING, PrimitiveType.FLOATING, PrimitiveType.FLOATING),
			new FunctionSignature(1, PrimitiveType.RATIONAL, PrimitiveType.RATIONAL, PrimitiveType.RATIONAL)
		);
		new FunctionSignatures(Punctuator.DIVIDE,
			new FunctionSignature(new IntegerDivideCodeGenerator(), PrimitiveType.INTEGER, PrimitiveType.INTEGER, PrimitiveType.INTEGER),
			new FunctionSignature(new FloatDivideCodeGenerator(), PrimitiveType.FLOATING, PrimitiveType.FLOATING, PrimitiveType.FLOATING),
			new FunctionSignature(1, PrimitiveType.RATIONAL, PrimitiveType.RATIONAL, PrimitiveType.RATIONAL)
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
			if(comparison == Punctuator.EQUAL ||comparison == Punctuator.NOT_EQUAL) {
				new FunctionSignatures(comparison,iSignature, sSignature, cSignature, fSignature, bSignature, aSignature);
			}
			else {
				new FunctionSignatures(comparison,iSignature, cSignature, fSignature);
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

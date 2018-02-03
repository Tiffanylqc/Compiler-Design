package semanticAnalyzer.signatures;

import java.util.ArrayList;
import java.util.List;

import semanticAnalyzer.types.Array;
import semanticAnalyzer.types.PrimitiveType;
import semanticAnalyzer.types.Type;
import semanticAnalyzer.types.TypeVariable;
import lexicalAnalyzer.Lextant;
import lexicalAnalyzer.Punctuator;

//immutable
public class FunctionSignature {
	private static final boolean ALL_TYPES_ACCEPT_ERROR_TYPES = true;
	private Type resultType;
	private Type[] paramTypes;
	Object whichVariant;
	private List<TypeVariable> typeVariables;
	
	///////////////////////////////////////////////////////////////
	// construction
	public FunctionSignature(Object whichVariant, List<TypeVariable>typeVariables,Type ...types){
		assert(types.length>=1);
		this.typeVariables=typeVariables;
		storeParamTypes(types);
		resultType = types[types.length-1];
		this.whichVariant = whichVariant;
	}
	public FunctionSignature(Object whichVariant, Type ...types) {
		this(whichVariant,new ArrayList<TypeVariable>(),types);
	}
	private void storeParamTypes(Type[] types) {
		paramTypes = new Type[types.length-1];
		for(int i=0; i<types.length-1; i++) {
			paramTypes[i] = types[i];
		}
	}
	
	
	///////////////////////////////////////////////////////////////
	// accessors
	
	public Object getVariant() {
		return whichVariant;
	}
	public Type resultType() {
		return resultType.getConcreteType();
	}
	public boolean isNull() {
		return false;
	}
	public Type[] getParamTypes(){
		return paramTypes;
	}
	
	///////////////////////////////////////////////////////////////
	// main query
	public static boolean canConvert(Type valueType, Type convertedType){
		if(valueType.equivalent(convertedType)){
			return true;
		}
			
		if(valueType==PrimitiveType.CHARACTER&&convertedType==PrimitiveType.INTEGER){
			return true;
		}
		if(valueType==PrimitiveType.CHARACTER&&convertedType==PrimitiveType.FLOATING){
			return true;
		}
		if(valueType==PrimitiveType.CHARACTER&&convertedType==PrimitiveType.RATIONAL){
			return true;
		}
		if(valueType==PrimitiveType.INTEGER&&convertedType==PrimitiveType.FLOATING){
			return true;
		}	
		if(valueType==PrimitiveType.INTEGER&&convertedType==PrimitiveType.RATIONAL){
			return true;
		}
		if(valueType==PrimitiveType.FLOATING&&convertedType==PrimitiveType.FLOATING)
			return true;
		if(valueType==PrimitiveType.RATIONAL&&convertedType==PrimitiveType.RATIONAL)
			return true;
		return false;
	}
	
	public boolean NoPromotionAccepts(List<Type> types) {
		resetTypeVariables();
		if(types.size() != paramTypes.length) {
			return false;
		}
		for(int i=0; i<paramTypes.length; i++) {
			if(!NoPromotionAssignableTo(paramTypes[i], types.get(i))) {
				return false;
			}
		}		
		return true;
	}
	
	private boolean NoPromotionAssignableTo(Type variableType, Type valueType) {
		if(valueType == PrimitiveType.ERROR && ALL_TYPES_ACCEPT_ERROR_TYPES) {
			return true;
		}	
		return variableType.equivalent(valueType);
	}
	private boolean PromotionAssignableTo(Type variableType, Type valueType){
		if(valueType == PrimitiveType.ERROR && ALL_TYPES_ACCEPT_ERROR_TYPES) {
			return true;
		}
		if(canConvert(valueType,variableType))
			return true;
		return false;
	}
	
	public boolean PromoteFirstArgumentAccepts(List<Type> types){		
		resetTypeVariables();
		
		if(types.size() != paramTypes.length) {
			return false;
		}
		Type firstVariableType=paramTypes[0];
		if(PromotionAssignableTo(firstVariableType,types.get(0))){
			for(int i=1;i<paramTypes.length;i++){
				if(!NoPromotionAssignableTo(paramTypes[i],types.get(i)))
					return false;
			}
			return true;
		}
		else 
			return false;
		
	}
	
	public boolean PromoteSecondArgumentAccepts(List<Type> types){
		resetTypeVariables();
		if(types.size() != paramTypes.length) {
			return false;
		}
		
		assert types.size()>=2;
		Type secondVariableType=paramTypes[1];
		if(PromotionAssignableTo(secondVariableType,types.get(1))){
			if(NoPromotionAssignableTo(paramTypes[0],types.get(0))){
				for(int i=2;i<paramTypes.length;i++){
					if(!NoPromotionAssignableTo(paramTypes[i],types.get(i)))
						return false;
				}
				return true;
			}
			else 
				return false;
		}
		else 
			return false;
	}
	
	public boolean PromoteBothArgumentsAccepts(List<Type> types){
		resetTypeVariables();
		
		if(types.size() != paramTypes.length) {
			return false;
		}
		Type firstVariableType=paramTypes[0];
		Type secondVariableType=paramTypes[1];
		
		if(PromotionAssignableTo(firstVariableType,types.get(0))&&PromotionAssignableTo(secondVariableType,types.get(1))){
			for(int i=2;i<paramTypes.length;i++){
				
				if(!NoPromotionAssignableTo(paramTypes[i],types.get(i)))
					return false;
			}
			
			return true;
		}
		else 
			return false;
		
	}

	private void resetTypeVariables(){
		for(TypeVariable T:typeVariables){
			T.reset();
		}
	}
	//Tom's Version
	public boolean acceptsStrict(List<Type> types) {
		resetTypeVariables();
		if(types.size() != paramTypes.length) {
			return false;
		}
		for(int i=0; i<paramTypes.length; i++) {
			if(!assignableTo(paramTypes[i],types.get(i))) {
				return false;
			}
		}		
		return true;
	}
	private boolean assignableTo(Type variableType, Type valueType) {
		if(valueType == PrimitiveType.ERROR && ALL_TYPES_ACCEPT_ERROR_TYPES) {
			return true;
		}	
		return variableType.equivalent(valueType);
	}
	
	// Null object pattern
	private static FunctionSignature neverMatchedSignature = new FunctionSignature(1, PrimitiveType.ERROR) {
		public boolean accepts(List<Type> types) {
			return false;
		}
		public boolean isNull() {
			return true;
		}
	};
	public static FunctionSignature nullInstance() {
		return neverMatchedSignature;
	}
	
	///////////////////////////////////////////////////////////////////
	// Signatures for pika-0 operators
	// this section will probably disappear in pika-1 (in favor of FunctionSignatures)
	
//	private static FunctionSignature addSignature = new FunctionSignature(1, PrimitiveType.INTEGER, PrimitiveType.INTEGER, PrimitiveType.INTEGER);
//	private static FunctionSignature multiplySignature = new FunctionSignature(1, PrimitiveType.INTEGER, PrimitiveType.INTEGER, PrimitiveType.INTEGER);
//	private static FunctionSignature greaterSignature = new FunctionSignature(1, PrimitiveType.INTEGER, PrimitiveType.INTEGER, PrimitiveType.BOOLEAN);

	
	// the switch here is ugly compared to polymorphism.  This should perhaps be a method on Lextant.
//	public static FunctionSignature signatureOf(Lextant lextant) {
//		assert(lextant instanceof Punctuator);	
//		Punctuator punctuator = (Punctuator)lextant;
//		
//		switch(punctuator) {
//		case ADD:		return addSignature;
//		case MULTIPLY:	return multiplySignature;
//		case GREATER:	return greaterSignature;
//
//		default:
//			return neverMatchedSignature;
//		}
//	}

}
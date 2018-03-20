package semanticAnalyzer.types;

import java.util.ArrayList;
import java.util.List;

import semanticAnalyzer.signatures.FunctionSignature;

public class LambdaType implements Type {

	private FunctionSignature signature;
	public LambdaType(FunctionSignature signature) {
		// TODO Auto-generated constructor stub
		this.signature=signature;
	}
	public LambdaType(){
		
	}

	@Override
	public int getSize() {
		// TODO Auto-generated method stub
		return 4;
	}

	@Override
	public String infoString() {
		// TODO Auto-generated method stub
		String types="LambdaType (";
		for(int i=0;i<signature.getParamTypes().length;i++){
			types+=signature.getParamTypes()[i].infoString()+" ";
		}
		types+=")-> (";
		types+=signature.resultType().infoString();
		types+=")";
		return types;
	}

	@Override
	public boolean equivalent(Type type) {
//		 TODO Auto-generated method stub
		if(type instanceof LambdaType){
			
			FunctionSignature signature=((LambdaType)type).getFunctionSignature();
			Type[] type1=signature.getParamTypes();
			Type[] type2=this.getFunctionSignature().getParamTypes();
			if(type1.length==type2.length){
				for(int i=0;i<type1.length;i++){
					if(!type1[i].equivalent(type2[i]))
						return false;
				}
				if(!signature.resultType().equivalent(this.getFunctionSignature().resultType()))
					return false;
				return true;
			}
			else
				return false;
		}
		return false;
//		return type instanceof LambdaType;
	}

	@Override
	public Type getConcreteType() {
		// TODO Auto-generated method stub
		return this;
	}

	public FunctionSignature getFunctionSignature(){
		return this.signature;
	}
}

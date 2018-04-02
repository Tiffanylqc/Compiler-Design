package semanticAnalyzer.types;

public class TypeVariable implements Type {

	private String name;
	private Type typeConstraint;
	
	public TypeVariable(String name) {
		this.name=name;
		this.typeConstraint=PrimitiveType.NO_TYPE;
	}

	public String getName(){
		return name;
	}
	
	public Type getType(){
		return typeConstraint;
	}
	private void setType(Type type){
		this.typeConstraint=type;
	}
	@Override
	public int getSize() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public String infoString() {
		// TODO Auto-generated method stub
		return toString();
	}
	
	public String pikaNativeString(){
		return toString();
	}
	
	public String toString(){
		return "<"+getName()+">";
	}

	@Override
	public boolean equivalent(Type otherType) {
		if(otherType instanceof TypeVariable){
			throw new RuntimeException("equals attempted on two types containing type variables.");
		}
		if(this.getType()==PrimitiveType.NO_TYPE){
//			System.out.println(toString());
			setType(otherType);
			return true;
		}
		return this.getType().equivalent(otherType);
	}
	
	public void reset(){
		this.typeConstraint=PrimitiveType.NO_TYPE;
	}

	@Override
	public Type getConcreteType() {
		return getType().getConcreteType();
	}

}

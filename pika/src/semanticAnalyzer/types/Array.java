package semanticAnalyzer.types;

public class Array implements Type {

	Type subtype;
	public Array(Type S) {
		this.subtype=S;
	}

	public Type getSubtype(){
		return this.subtype;
	}
	@Override
	public int getSize() {
		// TODO Auto-generated method stub
		return 4;
	}

	@Override
	public String infoString() {
		// TODO Auto-generated method stub
		return "ARRAY"+" "+subtype.infoString();
	}

	@Override
	public boolean equivalent(Type otherType) {
		if(otherType instanceof Array){
			Array otherArray=(Array)otherType;
//			System.out.println(subtype);
//			System.out.println(otherArray.getSubtype());
//			System.out.println(subtype.equivalent(otherArray.getSubtype()));
			return subtype.equivalent(otherArray.getSubtype());
		}
		return false;
	}

	@Override
	public Type getConcreteType() {
		Type concreteSubtype=subtype.getConcreteType();
		return new Array(concreteSubtype);
	}

}

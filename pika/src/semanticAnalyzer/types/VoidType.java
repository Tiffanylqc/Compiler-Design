package semanticAnalyzer.types;

public class VoidType implements Type {

	public VoidType() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public int getSize() {
		return 0;
	}

	@Override
	public String infoString() {
		return "VoidType";
	}

	@Override
	public boolean equivalent(Type type) {
		// TODO Auto-generated method stub
		return type instanceof VoidType;
	}

	@Override
	public Type getConcreteType() {
		// TODO Auto-generated method stub
		return this;
	}

}

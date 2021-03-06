package inputHandler;

import java.util.Stack;

public class PushbackCharStream extends LocatedCharStream {
	private Stack<LocatedChar> pushedBack;
	
	public PushbackCharStream(InputHandler handler) {
		super(handler);
		this.pushedBack = new Stack<LocatedChar>();
	}

	@Override
	public boolean hasNext() {
		return !pushedBack.empty() || super.hasNext();
	}

	@Override
	public LocatedChar next() {
		if(pushedBack.empty()) {
			return super.next();
		}
		else {
			return pushedBack.pop();
		}
	}
	public LocatedChar peek() {
		LocatedChar result = next();
		pushback(result);
		return result;
	}
	public boolean hasSecondNext(){
		LocatedChar next;
		if(hasNext()){
			next=next();
			if(hasNext()){
				pushback(next);
				return true;
			}
			else{
				pushback(next);
				return false;
			}
		}
		return false;
	}
	public LocatedChar peekSecondNext(){
		LocatedChar next=next();
		LocatedChar secondNext=next();
		pushback(secondNext);
		pushback(next);
		return secondNext;
	}

	public void pushback(LocatedChar locatedChar) {
		pushedBack.push(locatedChar);
	}

	/**
	 * remove is an unsupported operation.  It throws an UnsupportedOperationException.
	 */
	@Override
	public void remove() {
		throw new UnsupportedOperationException();
	}
	
	public static PushbackCharStream make(InputHandler handler) {
		return new PushbackCharStream(handler);
	}

}

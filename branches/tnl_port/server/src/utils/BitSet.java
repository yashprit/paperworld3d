package utils;

import org.red5.io.amf3.IDataInput;
import org.red5.io.amf3.IDataOutput;
import org.red5.io.amf3.IExternalizable;

public class BitSet implements IExternalizable {

	private int bits = 0;
	
	/**
	 * Default constructor initializes this bit set to all zeros.
	 */
	public BitSet() {
		bits = 0;
	}
	
	/**
	 * Copy constructor.
	 */
	public BitSet(BitSet copy) {
		bits = copy.getBits();
	}
	
	public BitSet(int bits) {
		this.bits = bits;
	}
	
	public int getBits() {
		return bits;
	}
	
	public void setOptions(int bits) {
		this.bits = bits;
	}
	
	public void addOption(int bits) {
		this.bits |= bits;
	}

	public void readExternal(IDataInput input) {
		bits = input.readInt();
	}

	public void writeExternal(IDataOutput output) {
		output.writeInt(bits);
	}
}

package com.paperworld.examples.hellopaperworld;

import org.red5.io.amf3.IDataInput;
import org.red5.io.amf3.IDataOutput;
import org.red5.io.amf3.IExternalizable;

public class Move implements IExternalizable {

	public double left = 0.0;
	
	public double right = 0.0;
	
	public double up = 0.0;
	
	public double down = 0.0;
	
	public double angle = 0.0;
	
	public boolean fire = false;
	
	public int time = 0;
	
	public Move() {
		
	}
	
	@Override
	public void readExternal(IDataInput input) {
		left = input.readDouble();
		right = input.readDouble();
		up = input.readDouble();
		down = input.readDouble();
		angle = input.readDouble();
		fire = input.readBoolean();
		time = input.readInt();
	}

	@Override
	public void writeExternal(IDataOutput output) {
		output.writeDouble(left);
		output.writeDouble(right);
		output.writeDouble(up);
		output.writeDouble(down);
		output.writeDouble(angle);
		output.writeInt(time);
	}

}

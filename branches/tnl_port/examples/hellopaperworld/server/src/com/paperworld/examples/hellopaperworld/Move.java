package com.paperworld.examples.hellopaperworld;

import org.red5.io.amf3.IDataInput;
import org.red5.io.amf3.IDataOutput;

import com.paperworld.server.flash.FlashNetObject;

public class Move extends FlashNetObject {
	
	public float left = 0.0f;
	
	public float right = 0.0f;
	
	public float up = 0.0f;
	
	public float down = 0.0f;
	
	public float angle = 0.0f;
	
	public boolean fire = false;
	
	public int time = 0;
	
	public Move() {
		
	}
	
	@Override
	public void readExternal(IDataInput input) {
		super.readExternal(input);
		
		left = input.readFloat();
		right = input.readFloat();
		up = input.readFloat();
		down = input.readFloat();
		angle = input.readFloat();
		fire = input.readBoolean();
		time = input.readInt();
	}

	@Override
	public void writeExternal(IDataOutput output) {
		super.writeExternal(output);
		
		output.writeFloat(left);
		output.writeFloat(right);
		output.writeFloat(up);
		output.writeFloat(down);
		output.writeFloat(angle);
		output.writeBoolean(fire);
		output.writeInt(time);
	}
	
	public boolean isEqualMove(Move other) {
		return left == other.left && right == other.right && up == other.up && down == other.down && angle == other.angle;
	}

}

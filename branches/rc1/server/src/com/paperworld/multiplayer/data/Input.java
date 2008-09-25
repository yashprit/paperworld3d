package com.paperworld.multiplayer.data;

import org.red5.io.amf3.IDataInput;
import org.red5.io.amf3.IDataOutput;
import org.red5.io.amf3.IExternalizable;

public class Input implements IExternalizable {
	public boolean forward;
	
	public boolean back;
	
	public boolean turnRight;

	public boolean turnLeft;

	public boolean moveRight;

	public boolean moveLeft;

	public boolean turnUp;

	public boolean turnDown;

	public boolean moveUp;

	public boolean moveDown;

	public boolean fire;

	public boolean jump;
	
	public double mouseX;
	
	public double mouseY;
	
	public Input()
	{
		clear();
	}
	
	public void clear() 
	{
		forward = false;
		back = false;
		turnRight = false;
		turnLeft = false;
		moveRight = false;
		moveLeft = false;
		turnUp = false;
		turnDown = false;
		moveUp = false;
		moveDown = false;
		fire = false;
		jump = false;
	}

	public void readExternal(IDataInput input) {
		forward = input.readBoolean( );
		back = input.readBoolean( );
		turnRight = input.readBoolean( );
		turnLeft = input.readBoolean( );
		moveRight = input.readBoolean( );
		moveLeft = input.readBoolean( );
		turnUp = input.readBoolean( );
		turnDown = input.readBoolean( );
		moveUp = input.readBoolean( );
		moveDown = input.readBoolean( );
		fire = input.readBoolean( );
		jump = input.readBoolean( );
		
		mouseX = input.readDouble( );
		mouseY = input.readDouble( );
	}


	public void writeExternal(IDataOutput output) {
		output.writeBoolean( forward );
		output.writeBoolean( back );
		output.writeBoolean( turnRight );
		output.writeBoolean( turnLeft );
		output.writeBoolean( moveRight );
		output.writeBoolean( moveLeft );
		output.writeBoolean( turnUp );
		output.writeBoolean( turnDown );
		output.writeBoolean( moveUp );
		output.writeBoolean( moveDown );
		output.writeBoolean( fire );
		output.writeBoolean( jump );
		
		output.writeDouble( mouseX );
		output.writeDouble( mouseY );
	}

}

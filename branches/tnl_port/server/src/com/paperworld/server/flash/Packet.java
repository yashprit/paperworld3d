package com.paperworld.server.flash;

import org.red5.io.amf3.IDataInput;
import org.red5.io.amf3.IDataOutput;
import org.red5.io.amf3.IExternalizable;

public class Packet implements IExternalizable {
	
	public Packet next;
	
	public Packet() {
		
	}

	public void readExternal(IDataInput input) {
		next = (Packet) input.readObject();
	}

	public void writeExternal(IDataOutput output) {
		output.writeObject(next);
	}
}

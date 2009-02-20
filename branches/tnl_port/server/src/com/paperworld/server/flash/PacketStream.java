package com.paperworld.server.flash;

import org.red5.io.amf3.IDataInput;
import org.red5.io.amf3.IDataOutput;
import org.red5.io.amf3.IExternalizable;

import com.paperworld.server.api.INetObject;


public class PacketStream implements IExternalizable {

	protected INetObject objects;
	
	public PacketStream() {
	}
	
	public INetObject getObjects() {
		return objects;
	}
	
	public void addObject(INetObject object) {
		if (objects != null) {
			object.setNext(objects);
			objects = object;
		} else {
			objects = object;
		}
	}

	public void readExternal(IDataInput input) {		
		objects = (INetObject) input.readObject();
	}

	public void writeExternal(IDataOutput output) {
		output.writeObject(objects);
	}
}

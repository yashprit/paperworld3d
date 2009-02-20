package com.paperworld.server.flash;

import org.red5.io.amf3.IDataInput;
import org.red5.io.amf3.IDataOutput;
import org.red5.io.amf3.IExternalizable;

import com.paperworld.server.api.INetObject;

public class FlashNetObject implements INetObject, IExternalizable {

	protected String key;
	
	protected INetObject next;	
	
	public FlashNetObject() {
		
	}

	public void readExternal(IDataInput input) {
		key = input.readUTF();
		next = (INetObject) input.readObject();
	}

	public void writeExternal(IDataOutput output) {
		output.writeUTF(key);
		output.writeObject(next);
	}

	public void setNext(INetObject packet) {
		if (next == null) {
			next = packet;
		} else {
			packet.setNext(next.getNext());
			next = packet;
		}		
	}

	public INetObject getNext() {
		return next;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
		
	}

}

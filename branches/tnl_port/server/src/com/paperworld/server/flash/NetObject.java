package com.paperworld.server.flash;

import org.red5.io.amf3.IDataInput;
import org.red5.io.amf3.IDataOutput;

import utils.BitSet;


public class NetObject extends Packet {

	protected boolean isInitialUpdate = false;

	protected BitSet flags;
	
	protected BitSet updateMask;
	
	protected BitSet tmpUpdateMask;
	
	public NetObject() {
		
	}
	
	public void performScopeQuery(GhostConnection connection) {
		connection.objectInScope(this);
	}

	

	public void readExternal(IDataInput input) {
		super.readExternal(input);

		tmpUpdateMask = (BitSet) input.readObject();
	}

	public void writeExternal(IDataOutput output) {
		super.writeExternal(output);

		output.writeObject(tmpUpdateMask);
	}

}

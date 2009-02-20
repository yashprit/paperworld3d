package com.paperworld.server.flash;

import org.red5.io.amf3.IDataInput;
import org.red5.io.amf3.IDataOutput;

import utils.BitSet;

import com.paperworld.server.api.IGhostConnection;
import com.paperworld.server.api.IGhostObject;
import com.paperworld.server.api.INetObject;

public class FlashGhostObject extends FlashNetObject implements IGhostObject {

	protected boolean isInitialUpdate = false;

	protected BitSet flags;
	
	protected BitSet updateMask;
	
	protected BitSet tmpUpdateMask;
	
	protected IGhostConnection connection;
	
	public void performScopeQuery(IGhostConnection connection) {
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

	public IGhostConnection getConnection() {
		return connection;
	}

	public void setConnection(IGhostConnection connection) {
		this.connection = connection;
	}

}

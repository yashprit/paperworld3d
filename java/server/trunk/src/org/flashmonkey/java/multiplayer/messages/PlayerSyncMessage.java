package org.paperworld.java.multiplayer.messages;

import org.paperworld.java.api.IInput;
import org.paperworld.java.api.message.IPlayerSyncMessage;
import org.red5.io.amf3.IDataInput;
import org.red5.io.amf3.IDataOutput;

public class PlayerSyncMessage extends BaseMessage implements IPlayerSyncMessage {

	private String objectId = "";
	
	private IInput input;
	
	private int time;
	
	public PlayerSyncMessage() {
		super();
	}
	
	public PlayerSyncMessage(String senderId, String objectId, int time, IInput input) {
		super(senderId);
		
		this.objectId = objectId;
		this.time = time;
		this.input = input;
	}
	
	@Override
	public String getObjectId() {
		return objectId;
	}
	
	@Override 
	public void setObjectId(String objectId) {
		this.objectId = objectId;
	}
	
	@Override
	public IInput getInput() {
		return input;
	}
	
	@Override
	public void setInput(IInput input) {
		this.input = input;
	}	

	@Override
	public int getTime() {
		return time;
	}	

	@Override
	public void setTime(int time) {
		this.time = time;
	}
	
	@Override
	public void readExternal(IDataInput input) {
		super.readExternal(input);
		
		objectId = input.readUTF();
		time = input.readInt();
		this.input = (IInput) input.readObject();
	}

	@Override
	public void writeExternal(IDataOutput output) {
		super.writeExternal(output);
		
		output.writeUTF(objectId);
		output.writeInt(time);
		output.writeObject(input);
	}
}
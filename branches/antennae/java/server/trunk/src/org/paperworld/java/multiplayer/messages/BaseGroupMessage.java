package org.paperworld.java.multiplayer.messages;

import org.paperworld.java.api.message.IGroupMessage;

public abstract class BaseGroupMessage extends BaseMessage implements
		IGroupMessage {

	private String groupId;
	
	public BaseGroupMessage() {
		super(null);
	}
	
	public BaseGroupMessage(String senderId, String groupId) {
		super(senderId);
		
		this.groupId = groupId;
	}
	
	@Override
	public String getGroupId() {
		return groupId;
	}

	@Override
	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}
}
package com.paperworld.java.api;

import java.util.List;

import org.red5.server.api.IConnection;

import com.paperworld.java.api.message.IMessage;

public interface IPlayer {

	public String getId();
	
	public String getName();
	
	public void setName(String name);
	
	public void addAvatar(IAvatar avatar);
	
	public void removeAvatar(IAvatar avatar);
	
	public IAvatar getScopeObject();	
	public void setScopeObject(IAvatar avatar);
	
	public void performScopeQuery(List<IAvatar> avatars);
	
	public IConnection getConnection();
	
	public void setConnection(IConnection connection);
	
	public boolean sendMessage(IMessage message);
}

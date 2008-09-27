package com.paperworld.multiplayer;

import org.red5.server.api.IConnection;

import com.paperworld.multiplayer.objects.Avatar;

public class Player 
{

	protected PlayerContext context;
	
	protected Avatar avatar;
	
	protected String name;
	
	public Player() {
		
	}
	
	public Player(String name, IConnection connection) {
		this.name = name;
		context = new PlayerContext(connection);
	}
	
	public Avatar getAvatar() {
		return avatar;
	}
	
	public void setAvatar(Avatar avatar) {
		this.avatar = avatar;
	}
	
	public void Avatar(Avatar avatar) {
		this.avatar = avatar;
	}
	
	public PlayerContext getContext() {
		return context;
	}
}

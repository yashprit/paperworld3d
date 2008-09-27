package com.paperworld.multiplayer;

import org.red5.server.api.IConnection;
import org.red5.server.api.IScope;

public class PlayerContext 
{

	protected IConnection connection;

	public PlayerContext() {

	}
	
	public PlayerContext(IConnection connection) {
		this.connection = connection;
	}

	public IScope getScope() {
		return connection.getScope();
	}

	public IConnection getConnection() {
		return connection;
	}
}

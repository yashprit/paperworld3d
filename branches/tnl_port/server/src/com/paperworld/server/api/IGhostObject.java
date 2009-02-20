package com.paperworld.server.api;

public interface IGhostObject extends INetObject {

	public void performScopeQuery(IGhostConnection connection);
	
	public IGhostConnection getConnection();
	
	public void setConnection(IGhostConnection connection);
}

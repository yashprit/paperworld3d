package com.paperworld.server.api;

public interface INetObject extends IPacket {

	public void performScopeQuery(IGhostConnection connection);
}

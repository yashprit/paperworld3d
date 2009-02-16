package com.paperworld.server.api.base;


public abstract class BaseEventConnection extends BaseNetConnection {

	public abstract void processEvent(BaseNetEvent event);
	
	public abstract void postEvent(BaseNetEvent event);
}

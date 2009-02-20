package com.paperworld.server.api;

public interface INetObject {

	public INetObject getNext();
	
	public void setNext(INetObject packet);
	
	public String getKey();
	
	public void setKey(String key);
}

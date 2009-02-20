package com.paperworld.server.api;

import java.util.Map;

public interface ISimulation {

	public void start();
	
	public void stop();
	
	public void step();
	
	public void addObject(INetObject object);
	
	public void setInterface(String id, INetInterface netInterface);
	
	public Map<String, INetInterface> getInterfaces();
}

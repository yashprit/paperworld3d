package com.paperworld.server.api.base;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.paperworld.server.api.INetInterface;
import com.paperworld.server.api.INetObject;
import com.paperworld.server.api.ISimulation;

public abstract class BaseSimulation implements ISimulation {

	protected List<INetObject> objects;

	protected Map<String, INetInterface> interfaces;

	public BaseSimulation() {
		objects = new ArrayList<INetObject>();
		interfaces = new HashMap<String, INetInterface>();
	}

	public abstract void start();
	
	public abstract void stop();
	
	public abstract void step();

	public void addObject(INetObject object) {
		objects.add(object);
	}

	public void removeObject(INetObject object) {
		if (objects.contains(object)) {
			objects.remove(object);
		}
	}

	public void setInterface(String id, INetInterface netInterface) {
		interfaces.put(id, netInterface);
	}
	
	public Map<String, INetInterface> getInterfaces() {
		return interfaces;
	}
	
	public List<INetObject> getObjects() {
		return objects;
	}
}

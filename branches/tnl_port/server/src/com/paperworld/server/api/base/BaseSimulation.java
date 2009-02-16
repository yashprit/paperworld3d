package com.paperworld.server.api.base;

import java.util.ArrayList;
import java.util.List;

import com.paperworld.server.api.ISimulation;
import com.paperworld.server.flash.NetObject;

public abstract class BaseSimulation implements ISimulation {

	protected List<NetObject> objects;

	protected List<BaseNetInterface> interfaces;

	public BaseSimulation() {
		objects = new ArrayList<NetObject>();
		interfaces = new ArrayList<BaseNetInterface>();
	}

	public abstract void start();
	
	public abstract void stop();
	
	public abstract void step();

	public void addObject(NetObject object) {
		objects.add(object);
	}

	public void removeObject(NetObject object) {
		if (objects.contains(object)) {
			objects.remove(object);
		}
	}

	public void setInterface(BaseNetInterface netInterface) {
		interfaces.add(netInterface);
	}
	
	public List<NetObject> getObjects() {
		return objects;
	}
}

package com.paperworld.examples.hellopaperworld;

import java.util.Collection;

import com.paperworld.server.api.GhostConnection;
import com.paperworld.server.api.NetObject;

public class ControlObjectConnection extends GhostConnection {

	public ControlObjectConnection(Collection<NetObject> objects) {
		zeroUpdateGhosts.addAll(objects);
		//type = GameConstants.CONTROL_OBJECT_CONNECTION_TYPE;
	}
}

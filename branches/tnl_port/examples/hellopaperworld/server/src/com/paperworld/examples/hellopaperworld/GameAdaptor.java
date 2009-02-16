package com.paperworld.examples.hellopaperworld;

import org.red5.server.api.IConnection;

import com.paperworld.server.api.NetConnection;
import com.paperworld.server.api.NetInterface;
import com.paperworld.server.api.NetObject;
import com.paperworld.server.api.PacketStream;
import com.paperworld.server.api.PaperworldAdapator;

public class GameAdaptor extends PaperworldAdapator {

	public void init() {
		super.init();
		application.addScheduledJob(1000, new UpdateSimulationJob());
	}

	public boolean appConnect(IConnection conn, Object[] args) {
		boolean result = super.appConnect(conn, args);

		NetObject netObject = new GameObject();
		//NetInterface netInterface = new GameNetInterface(conn);
		
		simulation = new GameSimulation(application);
		simulation.addObject(netObject);
		
		NetConnection controlObjectConnection = new ControlObjectConnection(simulation.getObjects());
		//netInterface.setConnection(controlObjectConnection);
		
		//netInterfaces.put(conn.getClient().getId(), netInterface);
		
		return result;
	}
	
	public void checkIncomingPackets(String id, PacketStream stream) {
		netInterfaces.get(id).checkIncomingPackets(id, stream);
	}
}

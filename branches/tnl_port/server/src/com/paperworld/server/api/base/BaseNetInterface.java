package com.paperworld.server.api.base;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.red5.server.api.IConnection;
import org.red5.server.api.service.ServiceUtils;

import utils.Constants;

import com.paperworld.server.api.INetConnection;
import com.paperworld.server.api.INetInterface;
import com.paperworld.server.api.INetObject;
import com.paperworld.server.api.base.BaseNetConnection.NetConnectionState;
import com.paperworld.server.flash.PacketStream;

public class BaseNetInterface implements INetInterface, Constants {

	protected List<INetConnection> connections = new ArrayList<INetConnection>();

	protected IConnection connection;

	public BaseNetInterface() {
		System.out.println("hellopaperworld started");
	}

	// ///// RECEIVING METHODS /////////

	public void checkIncomingPackets(PacketStream stream) {
		System.out.println("checking incoming packets " + stream);

		INetObject packet = stream.getObjects();

		while (packet != null) {
			processPacket(packet);
			packet = packet.getNext();
		}
	}

	protected void processPacket(INetObject packet) {
		INetConnection connection = connections.get(0);
		System.out.println("Processing " + packet.getKey() + " packet with "
				+ connection);
		if (connection != null) {
			connection.readPacket(packet);
		}
	}

	// ///// SENDING METHODS /////////

	public void processConnections() {
		for (INetConnection connection : connections) {
			connection.checkPacketSend();
		}
	}

	public void sendTo(IConnection conn, PacketStream stream) {
		ServiceUtils.invokeOnConnection(conn, CHECK_PACKETS_METHOD,
				new Object[] { stream });
	}

	public void setConnection(INetConnection connection) {
		connection.setNetInterface(this);
		connection.setConnectionState(NetConnectionState.Connected);
		connections.add(connection);
	}

	public void setConnections(List<INetConnection> connections) {
		for (INetConnection connection : connections) {
			setConnection(connection);
		}
	}
}

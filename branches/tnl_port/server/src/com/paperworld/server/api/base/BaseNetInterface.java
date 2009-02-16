package com.paperworld.server.api.base;

import java.util.ArrayList;

import org.red5.server.adapter.ApplicationAdapter;
import org.red5.server.api.IConnection;
import org.red5.server.api.service.ServiceUtils;

import utils.Constants;

import com.paperworld.server.api.INetConnection;
import com.paperworld.server.api.INetInterface;
import com.paperworld.server.api.base.BaseNetConnection.NetConnectionState;
import com.paperworld.server.flash.PacketStream;

public class BaseNetInterface implements INetInterface, Constants {

	protected ApplicationAdapter application;
	
	protected ArrayList<INetConnection> connections;	

	protected IConnection connection;

	public BaseNetInterface() {
		System.out.println("hellopaperworld started");
		connections = new ArrayList<INetConnection>();
	}
	
	/////// RECEIVING METHODS /////////

	/*public void checkIncomingPackets(PacketStream stream) {
		System.out.println("checking incoming packets " + stream);
		
		Packet packet = stream.getPackets();
		
		while (packet != null)
		{
			packet = packet.next;
		}
	}

	protected void processPacket(int type, Packet packet) {
		BaseNetConnection connection = connections.get(type);
		if (connection != null) {
			connection.readPacket(packet);
		}
	}*/
	
	/////// SENDING METHODS /////////

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

	public boolean appConnect(IConnection conn, Object[] args) {
		String uid = conn.getClient().getId();
		
		ServiceUtils.invokeOnConnection(conn, SET_CLIENT_ID_METHOD,
				new Object[] { uid });
		
		return true;
	}
}

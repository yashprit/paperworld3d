package com.paperworld.server.flash;

import org.red5.server.api.IConnection;

import com.paperworld.server.api.base.BaseGhostConnection;

public class BaseFlashNetConnection extends BaseGhostConnection {

	protected IConnection connection;
	
	@Override
	public void checkPacketSend() {
		// TODO Auto-generated method stub

	}

	public boolean isDataToTransmit() {
		// TODO Auto-generated method stub
		return false;
	}

	public void readPacket(Packet packet) {
		// TODO Auto-generated method stub

	}

	public void writePacket(PacketStream stream) {
		// TODO Auto-generated method stub

	}
	
	public void setConnection(IConnection connection) {
		this.connection = connection;
	}
	
	public IConnection getConnection() {
		return connection;
	}

}

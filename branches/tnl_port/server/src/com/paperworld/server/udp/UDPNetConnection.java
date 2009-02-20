package com.paperworld.server.udp;

import com.paperworld.server.api.INetObject;
import com.paperworld.server.api.base.BaseNetConnection;
import com.paperworld.server.flash.Packet;
import com.paperworld.server.flash.PacketStream;

public class UDPNetConnection extends BaseNetConnection {

	public UDPNetConnection() {

	}

	@Override
	public void checkPacketSend() {
		// TODO Auto-generated method stub
		
	}

	public boolean isDataToTransmit() {
		// TODO Auto-generated method stub
		return false;
	}

	public void readPacket(INetObject packet) {
		// TODO Auto-generated method stub
		
	}

	public void writePacket(PacketStream stream) {
		// TODO Auto-generated method stub
		
	}
	
}

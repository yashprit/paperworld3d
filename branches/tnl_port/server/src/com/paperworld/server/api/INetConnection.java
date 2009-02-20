package com.paperworld.server.api;

import com.paperworld.server.api.base.BaseNetConnection.NetConnectionState;
import com.paperworld.server.flash.Packet;
import com.paperworld.server.flash.PacketStream;

public interface INetConnection {
	
	public void checkPacketSend();

	public void readPacket(INetObject packet);

	public void writePacket(PacketStream stream);

	public boolean isDataToTransmit();
	
	public void setNetInterface(INetInterface netInterface);

	public INetInterface getNetInterface();
	
	public void setConnectionState(NetConnectionState state);
	
	public NetConnectionState getConnectionState();
	
	public void addObject(INetObject object);
	
	public String getType();
}

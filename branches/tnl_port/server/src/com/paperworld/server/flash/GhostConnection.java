package com.paperworld.server.flash;

import java.util.List;

import com.paperworld.server.api.IGhostConnection;
import com.paperworld.server.api.base.BaseNetConnection;

public class GhostConnection extends BaseNetConnection implements IGhostConnection {
	
	protected List<NetObject> pendingUpdateGhosts;
	
	protected List<NetObject> zeroUpdateGhosts;
	
	protected List<NetObject> freeGhosts;

	protected NetObject scopeObject;

	public GhostConnection() {

	}

	public void checkPacketSend() {
		System.out.println("checing packets to send from ghost connection");
		if (isDataToTransmit()) {
			prepareWritePacket();
			writePacket(new PacketStream());
		}
	}
	
	public boolean isDataToTransmit() {
		return pendingUpdateGhosts.size() > 0;
	}
	
	public void prepareWritePacket() {
		
	}
	
	public void writePacket(PacketStream stream) {
		for (NetObject packet : pendingUpdateGhosts) {
			stream.addPacket(packet);
		}
	}

	public void objectInScope(NetObject object) {

	}
	
	public void ghostPushNonZero(NetObject info) {
	   if (!pendingUpdateGhosts.contains(info)) {
		   if (zeroUpdateGhosts.contains(info)) {
			   zeroUpdateGhosts.remove(info);
			   pendingUpdateGhosts.add(info);
		   }
	   }
	}
	
	public void ghostPushToZero(NetObject info) {
		if (!zeroUpdateGhosts.contains(info)) {
			if (pendingUpdateGhosts.contains(info)) {
				pendingUpdateGhosts.remove(info);
				zeroUpdateGhosts.add(info);
			}
		}
	}
}

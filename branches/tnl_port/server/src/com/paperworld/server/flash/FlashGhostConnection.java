package com.paperworld.server.flash;

import com.paperworld.server.api.IGhostConnection;
import com.paperworld.server.api.INetObject;

public class FlashGhostConnection extends BaseFlashNetConnection implements
		IGhostConnection {	

	public FlashGhostConnection() {
		TYPE = "GhostConnection";
	}

	public void checkPacketSend() {
		System.out.println("checing packets to send from ghost connection");
		if (isDataToTransmit()) {
			prepareWritePacket();
			writePacket(new PacketStream());
		}
	}

	public void writePacket(PacketStream stream) {
		for (GhostInfo info : pendingUpdateGhosts) {
			stream.addObject(info.ghostObject);
		}
	}

	public void objectInScope(FlashNetObject object) {

	}	

	public void readPacket(INetObject packet) {
		
		
	}
}

package com.paperworld.server.flash;

import org.red5.io.amf3.IDataInput;
import org.red5.io.amf3.IDataOutput;
import org.red5.io.amf3.IExternalizable;


public class PacketStream implements IExternalizable {

	protected Packet packets;
	
	public PacketStream() {
	}
	
	public Packet getPackets() {
		return packets;
	}
	
	public void addPacket(Packet packet) {
		if (packets != null) {
			packets.next = packet;
		} else {
			packets = packet;
		}
	}

	@SuppressWarnings("unused")
	public void readExternal(IDataInput input) {		
		packets = (Packet) input.readObject();
	}

	public void writeExternal(IDataOutput output) {
		output.writeObject(packets);
	}
}

package com.paperworld.server.api.base;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.red5.io.amf3.IDataInput;
import org.red5.io.amf3.IDataOutput;
import org.red5.io.amf3.IExternalizable;

import com.paperworld.server.api.IGhostConnection;
import com.paperworld.server.api.IGhostObject;
import com.paperworld.server.api.INetObject;
import com.paperworld.server.flash.PacketStream;

public class BaseGhostConnection extends BaseNetConnection implements
		IGhostConnection {
	
	public static String TYPE;
	
	public String getType() {
		return TYPE;
	}
	
	protected boolean ghosting;

	protected List<GhostInfo> pendingUpdateGhosts = new ArrayList<GhostInfo>();

	protected List<GhostInfo> zeroUpdateGhosts = new ArrayList<GhostInfo>();

	protected List<GhostInfo> freeGhosts = new ArrayList<GhostInfo>();

	protected INetObject scopeObject;

	protected HashMap<IGhostObject, GhostInfo> ghostLookupTable = new HashMap<IGhostObject, GhostInfo>();

	public BaseGhostConnection() {
	}

	@Override
	public void checkPacketSend() {
		// TODO Auto-generated method stub

	}

	public boolean isDataToTransmit() {
		return pendingUpdateGhosts.size() > 0;
	}

	public void readPacket(INetObject packet) {
		// TODO Auto-generated method stub

	}

	public void writePacket(PacketStream stream) {
		// TODO Auto-generated method stub

	}

	public void objectInScope(IGhostObject ghost) {
		// TODO Auto-generated method stub

	}

	protected void prepareWritePacket() {
		for (GhostInfo info : pendingUpdateGhosts) {
			info.flags &= ~GhostInfo.InScope;
		}
	}

	public void addObject(INetObject object) {
		zeroUpdateGhosts.add(new GhostInfo(object));
	}

	public void ghostPushNonZero(IGhostObject ghost) {
		GhostInfo info = ghostLookupTable.get(ghost);
		if (!pendingUpdateGhosts.contains(info)) {
			if (zeroUpdateGhosts.contains(info)) {
				zeroUpdateGhosts.remove(info);
				pendingUpdateGhosts.add(info);
			}
		}
	}

	public void ghostPushToZero(IGhostObject ghost) {
		GhostInfo info = ghostLookupTable.get(ghost);
		if (!zeroUpdateGhosts.contains(info)) {
			if (pendingUpdateGhosts.contains(info)) {
				pendingUpdateGhosts.remove(info);
				zeroUpdateGhosts.add(info);
			}
		}
	}
	
	public void setGhosting(boolean ghosting) {
		this.ghosting = ghosting;
	}

	public class GhostInfo implements IExternalizable {

		public static final byte InScope = 1 << 0;
		public static final byte ScopeLocalAlways = 1 << 1;
		public static final byte NotYetGhosted = 1 << 2;
		public static final byte Ghosting = 1 << 3;
		public static final byte KillGhost = 1 << 4;
		public static final byte KillingGhost = 1 << 5;
		public static final byte NotAvailable = NotYetGhosted | Ghosting
				| KillGhost | KillingGhost;

		public int flags = 0;

		public int index;

		public INetObject ghostObject;

		public GhostInfo() {

		}

		public GhostInfo(INetObject ghostObject) {
			this.ghostObject = ghostObject;
		}

		public void readExternal(IDataInput input) {
			index = input.readInt();
			flags = input.readInt();
		}

		public void writeExternal(IDataOutput output) {
			output.writeObject(index);
			output.writeObject(flags);
		}
	}
}

package com.paperworld.server.udp;

import org.apache.mina.common.IoSession;
import org.red5.server.BaseConnection;

public class UDPConnection extends BaseConnection {

	private IoSession session;
	
	public UDPConnection(IoSession session) {
		super(PERSISTENT, null, null, 0, null, null, null);
		
		this.session = session;
	}
	
	@Override
	public long getReadBytes() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public long getWrittenBytes() {
		// TODO Auto-generated method stub
		return 0;
	}

	public Encoding getEncoding() {
		// TODO Auto-generated method stub
		return null;
	}

	public int getLastPingTime() {
		// TODO Auto-generated method stub
		return 0;
	}

	public void ping() {
		// TODO Auto-generated method stub

	}

}

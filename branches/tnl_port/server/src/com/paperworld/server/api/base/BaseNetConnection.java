package com.paperworld.server.api.base;

import java.util.List;

import com.paperworld.server.api.INetConnection;
import com.paperworld.server.api.INetInterface;
import com.paperworld.server.api.INetObject;

public abstract class BaseNetConnection implements INetConnection {

	public static String TYPE;
	
	public String getType() {
		return TYPE;
	}
	
	protected INetInterface netInterface;

	protected NetConnectionState connectionState = NetConnectionState.NotConnected;

	public abstract void checkPacketSend();

	public void setNetInterface(INetInterface netInterface) {
		this.netInterface = netInterface;
	}

	public INetInterface getNetInterface() {
		return netInterface;
	}

	public void setConnectionState(NetConnectionState connectionState) {
		this.connectionState = connectionState;
	}

	public NetConnectionState getConnectionState() {
		return connectionState;
	}
	
	public void addObject(INetObject object) {
		
	}

	public void addObjects(List<INetObject> objects) {
		for (INetObject object : objects) {
			addObject(object);
		}
	}

	/**
	 * Connection state flags for a NetConnection instance.
	 * 
	 * @author Trevor
	 *
	 */
	public enum NetConnectionState {
		// Initial state of a NetConnection instance - not connected.
		NotConnected,
		// We've sent a challenge request, awaiting the response.
		AwaitingChallengeResponse, 
		// The state of a pending arranged connection when both sides haven't heard from the other yet
		SendingPunchPackets, 
		// We've received a challenge response, and are in the process of computing a solution to its puzzle.
		ComputingPuzzleSolution, 
		// We've received a challenge response and sent a connect request.
		AwaitingConnectResponse, 
		// The connection timed out during the connection process.
		ConnectTimedOut, 
		// The connection was rejected.
		ConnectRejected, 
		// We've accepted a connect request, or we've received a connect response accept.
		Connected, 
		// The connection has been disconnected.
		Disconnected, 
		// The connection timed out.
		TimedOut,
		StateCount
	};
}

package com.paperworld.server.api.base;

import com.paperworld.server.api.INetInterface;

public abstract class BaseNetConnection {

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

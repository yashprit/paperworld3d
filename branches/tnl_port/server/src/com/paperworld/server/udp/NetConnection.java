package com.paperworld.server.udp;

import java.io.IOException;
import java.net.InetSocketAddress;

import org.apache.mina.common.IdleStatus;
import org.apache.mina.common.IoAcceptor;
import org.apache.mina.common.IoHandler;
import org.apache.mina.common.IoSession;
import org.apache.mina.transport.socket.nio.DatagramAcceptor;

import com.paperworld.server.api.base.BaseNetConnection;

public class NetConnection extends BaseNetConnection implements IoHandler {

	protected int port = 5150;

	public NetConnection() {

	}

	public void init() {
		IoAcceptor acceptor = new DatagramAcceptor();

		try {
			// Try to bind to the port specified.
			acceptor.bind(new InetSocketAddress(port), this);
			System.out.println("Listening on port " + port);
		} catch (IOException e) {
			System.out.println("unable to bind udp handler to port:\n"
					+ e.getMessage());
		}
	}

	@Override
	public void checkPacketSend() {
		// TODO Auto-generated method stub

	}

	public void exceptionCaught(IoSession arg0, Throwable arg1)
			throws Exception {
		// TODO Auto-generated method stub

	}

	public void messageReceived(IoSession arg0, Object arg1) throws Exception {
		// TODO Auto-generated method stub

	}

	public void messageSent(IoSession arg0, Object arg1) throws Exception {
		// TODO Auto-generated method stub

	}

	public void sessionClosed(IoSession arg0) throws Exception {
		// TODO Auto-generated method stub

	}

	public void sessionCreated(IoSession arg0) throws Exception {
		// TODO Auto-generated method stub

	}

	public void sessionIdle(IoSession arg0, IdleStatus arg1) throws Exception {
		// TODO Auto-generated method stub

	}

	public void sessionOpened(IoSession arg0) throws Exception {
		// TODO Auto-generated method stub

	}

	public void setPort(int port) {
		this.port = port;
	}

	public int getPort() {
		return port;
	}
}

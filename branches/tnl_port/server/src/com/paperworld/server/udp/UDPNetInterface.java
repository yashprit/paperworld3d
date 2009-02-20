package com.paperworld.server.udp;

import java.io.IOException;
import java.net.InetSocketAddress;

import org.apache.mina.common.IdleStatus;
import org.apache.mina.common.IoAcceptor;
import org.apache.mina.common.IoHandler;
import org.apache.mina.common.IoSession;
import org.apache.mina.transport.socket.nio.DatagramAcceptor;
import org.red5.server.adapter.ApplicationAdapter;

public class UDPNetInterface implements IoHandler {

	protected ApplicationAdapter applicationAdapter;
	
	protected int port = 5150;

	public UDPNetInterface() {

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

	public void exceptionCaught(IoSession session, Throwable exception)
			throws Exception {
		// TODO Auto-generated method stub

	}

	public void messageReceived(IoSession session, Object message)
			throws Exception {
		// TODO Auto-generated method stub

	}

	public void messageSent(IoSession session, Object message) throws Exception {
		// TODO Auto-generated method stub

	}

	public void sessionClosed(IoSession session) throws Exception {
		// TODO Auto-generated method stub

	}

	public void sessionCreated(IoSession session) throws Exception {
		// TODO Auto-generated method stub

	}

	public void sessionIdle(IoSession session, IdleStatus status)
			throws Exception {
		// TODO Auto-generated method stub

	}

	public void sessionOpened(IoSession session) throws Exception {
		// TODO Auto-generated method stub

	}

	public void setPort(int port) {
		this.port = port;
	}

	public int getPort() {
		return port;
	}
	
	public void setApplicaiton(ApplicationAdapter applicationAdapter) {
		this.applicationAdapter = applicationAdapter;
	}
}

package com.paperworld.server.udp;

import java.io.IOException;
import java.net.InetSocketAddress;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.apache.mina.common.ByteBuffer;
import org.apache.mina.common.IdleStatus;
import org.apache.mina.common.IoAcceptor;
import org.apache.mina.common.IoHandler;
import org.apache.mina.common.IoSession;
import org.apache.mina.transport.socket.nio.DatagramAcceptor;
import org.red5.server.adapter.ApplicationAdapter;
import org.red5.server.api.IClient;
import org.red5.server.api.IConnection;

public class UDPAwareApplicationAdaptor extends ApplicationAdapter implements
		IoHandler {

	public static final int ConnectRequest = 0;
	public static final int ConnectReject = 1;
	public static final int ConnectAccept = 2;
	public static final int Disconnect = 3;
	
	protected Map<IoSession, IConnection> connections = new ConcurrentHashMap<IoSession, IConnection>();

	protected List<IoSession> pendingConnections = new ArrayList<IoSession>();
	
	protected int port = 5150;

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
	
	public void broadcast(IoSession exclude, ByteBuffer message) {
		for (IoSession session : connections.keySet()) {
			if (session.equals(exclude)) {
				continue;
			}

			session.write(message);
		}
	}

	public void createUDPConnection(IoSession session) {

		pendingConnections.remove(session);

		IConnection connection = new UDPConnection(session);
		IClient client = getContext().getClientRegistry().newClient(null);
		connection.initialize(client);

		connections.put(session, connection);

		connect(connection, null, null);

		BitStream stream = new BitStream();

		stream.writeByte((byte) ConnectAccept);
		//System.out.println("responding: " + stream.getByteBuffer());
		int id = Integer.parseInt(client.getId());
		stream.writeInt(id);

		session.write(stream.getByteBuffer());
	}

	public void sessionClosed(IoSession session) throws Exception {
		IConnection connection = connections.get(session);
		appDisconnect(connection);
	}

	public void sessionCreated(IoSession session) throws Exception {
		pendingConnections.add(session);
	}

	public void messageSent(IoSession session, Object message) throws Exception {
		// TODO Auto-generated method stub

	}

	public void sessionIdle(IoSession session, IdleStatus status)
			throws Exception {
		// TODO Auto-generated method stub

	}

	public void sessionOpened(IoSession session) throws Exception {
		// TODO Auto-generated method stub

	}

	public void messageReceived(IoSession arg0, Object arg1) throws Exception {
		// TODO Auto-generated method stub
		//System.out.println("message received");
	}

}

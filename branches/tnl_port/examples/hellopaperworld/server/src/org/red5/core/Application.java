package org.red5.core;

/*
 * RED5 Open Source Flash Server - http://www.osflash.org/red5
 * 
 * Copyright (c) 2006-2008 by respective authors (see below). All rights reserved.
 * 
 * This library is free software; you can redistribute it and/or modify it under the 
 * terms of the GNU Lesser General Public License as published by the Free Software 
 * Foundation; either version 2.1 of the License, or (at your option) any later 
 * version. 
 * 
 * This library is distributed in the hope that it will be useful, but WITHOUT ANY 
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A 
 * PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public License along 
 * with this library; if not, write to the Free Software Foundation, Inc., 
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA 
 */

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.apache.mina.common.ByteBuffer;
import org.apache.mina.common.IoSession;
import org.red5.server.api.IClient;
import org.red5.server.api.IConnection;
import org.red5.server.api.IScope;

import utils.Constants;
import utils.Transcoder;

import com.paperworld.examples.hellopaperworld.Circle;
import com.paperworld.examples.hellopaperworld.ControlObjectConnection;
import com.paperworld.examples.hellopaperworld.GameNetInterface;
import com.paperworld.examples.hellopaperworld.GameSimulation;
import com.paperworld.examples.hellopaperworld.Move;
import com.paperworld.server.api.INetInterface;
import com.paperworld.server.api.INetObject;
import com.paperworld.server.api.ISimulation;
import com.paperworld.server.flash.FlashGhostConnection;
import com.paperworld.server.flash.PacketStream;
import com.paperworld.server.udp.BitStream;
import com.paperworld.server.udp.UDPAwareApplicationAdaptor;
import com.paperworld.server.udp.UDPConnection;

/**
 * Sample application that uses the client manager.
 * 
 * @author The Red5 Project (red5@osflash.org)
 */
public class Application extends UDPAwareApplicationAdaptor implements
		Constants {

	
	public static final int Move = 4;

	public static final int RTMPConnectionType = 0;
	public static final int UDPConnectionType = 1;

	

	private ISimulation simulation;

	public Application() {
		System.out.println("hellopaperworld starting");
		simulation = new GameSimulation(this);
	}

	/** {@inheritDoc} */
	@Override
	public boolean connect(IConnection conn, IScope scope, Object[] params) {
		System.out.println("new client connected");

		String uid = conn.getClient().getId();

		INetObject circle = new Circle();

		FlashGhostConnection connection = new ControlObjectConnection();
		connection.addObject(circle);

		INetInterface netInterface = new GameNetInterface();
		netInterface.setConnection(connection);

		simulation.setInterface(uid, netInterface);
		simulation.addObject(circle);

		// ServiceUtils.invokeOnConnection(conn, SET_CLIENT_ID_METHOD,
		// new Object[] { uid });

		return true;
	}

	public void checkIncomingPackets(String id, PacketStream stream) {
		System.out.println("checking incoming packets in application");
		simulation.getInterfaces().get(id).checkIncomingPackets(stream);
	}

	public void startGhosting(String id) {

	}

	public void stopGhosting(String id) {

	}

	@Override
	public void messageReceived(IoSession session, Object message)
			throws Exception {
		ByteBuffer buffer = (ByteBuffer) message;
		BitStream stream = new BitStream(buffer);

		//System.out.println(buffer);

		byte type = stream.readByte();
		System.out.println("type " + type);

		switch (type) {
		case ConnectRequest:
			createUDPConnection(session);
			break;

		case Move:
			handleMove(session, stream);
			break;

		default:
			break;
		}
	}

	public void handleMove(IoSession session, BitStream stream) {
		// Pass the move data on to the player.

		int id = stream.readInt();
		System.out.println("x: " + stream.readFloat());
		System.out.println("y: " + stream.readFloat());
		//String decodedString = stream.readUTF();
		
		//System.out.println("decoded String: " + decodedString);
		
		//Move move = new Move();
		//move.readExternal(stream);

		ByteBuffer buffer = stream.getByteBuffer();
		// Inform the other players about this player's move.
		broadcast(session, buffer);
	}

	

	/** {@inheritDoc} */
	@Override
	public void disconnect(IConnection conn, IScope scope) {
		super.disconnect(conn, scope);
	}

}

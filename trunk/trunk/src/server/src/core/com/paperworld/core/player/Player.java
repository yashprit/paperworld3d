/*
 * --------------------------------------------------------------------------------------
 * PaperWorld3D - building better worlds
 * --------------------------------------------------------------------------------------
 * Realtime 3D Multi-User Application Framework for the Flash Platform.
 * --------------------------------------------------------------------------------------
 * Copyright (C) 2008 Influxis [http://www.influxis.com]
 * --------------------------------------------------------------------------------------
 * 
 * This library is free software; you can redistribute it and/or modify it under the 
 * terms of the GNU Lesser General Public License as published by the Free Software 
 * Foundation; either version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT ANY 
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A 
 * PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License along with 
 * this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, 
 * Suite 330, Boston, MA 02111-1307 USA 
 * 
 * --------------------------------------------------------------------------------------
 */
package com.paperworld.core.player;

import org.red5.server.api.IConnection;
import org.red5.server.api.ScopeUtils;
import org.red5.server.api.so.ISharedObject;
import org.red5.server.api.so.ISharedObjectService;

import com.paperworld.core.Application;
import com.paperworld.core.avatar.Avatar;
import com.paperworld.core.avatar.AvatarInput;
import com.paperworld.core.room.Room;

/**
 * The Player object holds data about a client that is persistent across Rooms.
 * The input from a user is held in the Player along with username etc. etc.
 * Anything that isn't specific to a Room.
 * 
 * @author Trevor
 * 
 */
public class Player {
	/**
	 * Whether the Remote Shared Object used for Players is persistent or not
	 * (ie. whether it's held in a file by Red5 and is available after a restart
	 * of the server.
	 */
	public static Boolean PERSISTENT = false;

	/**
	 * The user id for this Player. It's created and provided by Red5 when the
	 * user connects. It changes each time a Player reconnects.
	 */
	private String uid;

	/**
	 * The Room this Player is currently in.
	 */
	public Room room;

	/**
	 * The Player's username. Held seperately to the uid as it can be changed
	 * during a session.
	 */
	public String username;

	/**
	 * The Input for this Player.
	 */
	public AvatarInput input = new AvatarInput();

	/**
	 * The current Avatar that's representing this player on the client and
	 * handling the input on the server-side.
	 */
	public Avatar avatar;

	/**
	 * The current time frame for this player. Each player can be at a different
	 * time relative to each other.
	 */
	public Integer time = 0;

	/**
	 * The Shared Object that this player is using to pass data to the client.
	 */
	public ISharedObject so;

	/**
	 * Flags whether this Player is currently active or not.
	 */
	protected Boolean isActive = false;

	/**
	 * The PlayerData object for this Player. PlayerData holds barest
	 * information about the Player. Used in the Shared Object mechanism rather
	 * than the Player object itself in order to save bandwidth.
	 */
	public PlayerData playerData;

	/**
	 * Flags whether this Player is currently connected or not (would be false
	 * if the client is currently reconnecting, for instance).
	 */
	private boolean connected;

	/**
	 * Constructor. Creates a Player with the uid passed.
	 * 
	 * @param uid
	 */
	public Player(String uid) {
		Application.log.debug("Creating player: {}", uid);
		this.uid = uid;

		playerData = new PlayerData(uid, username);
	}

	/**
	 * Creates the Shared Object that this Player will use to communicate with
	 * clients.
	 * 
	 * @param conn
	 */
	public void createSharedObject(IConnection conn) {
		ISharedObjectService service = (ISharedObjectService) ScopeUtils
				.getScopeService(conn.getScope(), ISharedObjectService.class,
						false);

		so = service.getSharedObject(conn.getScope(), uid, PERSISTENT);
		so.setAttribute("uid", uid);
		so.setAttribute("input", input);
	}

	/**
	 * Updates the Shared Object for this Player.
	 * 
	 * @param so
	 */
	public void updateSharedObject(ISharedObject so) {
		PlayerData playerData = new PlayerData(uid, username,
				avatar.getState(), input, time);

		playerData.time = time;
		playerData.state = avatar.getState();
		playerData.input = input;

		so.setAttribute(uid, playerData);
	}

	/**
	 * Set the connected variable for this Player.
	 * 
	 * @param connected
	 */
	public void setConnected(boolean connected) {
		this.connected = connected;
	}

	/**
	 * Returns the current connected state for this Player.
	 * 
	 * @return
	 */
	public boolean getConnected() {
		return connected;
	}

	/**
	 * Called by the Application when Input data is received from a client. The
	 * Input is registered, passed to the Avatar and it's flagged as having
	 * changed to ensure that the Shared Object is updated on the next tick.
	 * 
	 * @param time
	 * @param input
	 */
	public void receiveInput(Integer time, AvatarInput input) {
		this.input = input;

		avatar.input = input;

		input.hasChanged = true;

		this.time = time;
	}

	/**
	 * Returns the current state of the user input for this Player.
	 * 
	 * @return
	 */
	public AvatarInput getInput() {
		return input;
	}

	/**
	 * Returns the current active state of this Player.
	 * 
	 * @return
	 */
	public Boolean getIsActive() {
		return isActive;
	}

	/**
	 * Sets the current active state of this Player.
	 * 
	 * @param value
	 */
	public void setIsActive(Boolean value) {
		isActive = value;
	}

	/**
	 * Returns the current user id for this Player.
	 * 
	 * @return
	 */
	public String getId() {
		return uid;
	}

	/**
	 * Sets the current user id for this Player. It's set initially when the
	 * user connects and then updated on each subsequent reconnection.
	 * 
	 * @param uid
	 */
	public void setId(String uid) {
		this.uid = uid;
	}

	/**
	 * Sets the Avatar object for this Player.
	 * 
	 * @param avatar
	 */
	public void setAvatar(Avatar avatar) {
		this.avatar = avatar;
	}

	/**
	 * Returns the Avatar object for this Player.
	 * 
	 * @return
	 */
	public Avatar getAvatar() {
		return avatar;
	}
}

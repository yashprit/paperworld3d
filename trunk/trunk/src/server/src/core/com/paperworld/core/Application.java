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
package com.paperworld.core;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Properties;

import org.red5.server.adapter.MultiThreadedApplicationAdapter;
import org.red5.server.api.IClient;
import org.red5.server.api.IConnection;
import org.red5.server.api.IScope;
import org.red5.server.api.Red5;
import org.red5.server.api.service.ServiceUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.paperworld.core.avatar.AvatarInput;
import com.paperworld.core.constants.Constants;
import com.paperworld.core.player.Player;
import com.paperworld.core.room.Room;
import com.paperworld.core.util.PlayerManager;

public class Application extends MultiThreadedApplicationAdapter {
	public static Logger log = LoggerFactory.getLogger(Application.class);

	private PlayerManager playerMgr = new PlayerManager();

	private HashMap<String, Room> roomsList = new HashMap<String, Room>();

	private Connection conn;

	static {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException exception) {
			log.error("ClassNotFoundException " + exception.getMessage());
		}
	}

	/**
	 * Creates the database connection that will be used by this application.
	 * Properties are loaded from the database.properties file.
	 * 
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	private static Connection getConnection() throws SQLException, IOException {
		Properties props = new Properties();
		FileInputStream in = new FileInputStream(System
				.getProperty(Constants.RED5_CONFIG_ROOT_KEY)
				+ "/../webapps/paperworld3d/WEB-INF/database.properties");
		props.load(in);
		in.close();

		String drivers = props.getProperty(Constants.JDBC_DRIVERS_KEY);

		if (drivers != null) {
			System.setProperty(Constants.JDBC_DRIVERS_KEY, drivers);
		}

		String url = props.getProperty(Constants.JDBC_URL_KEY);
		String username = props.getProperty(Constants.JDBC_USERNAME_KEY);
		String password = props.getProperty(Constants.JDBC_PASSWORD_KEY);

		return DriverManager.getConnection(url, username, password);
	}

	/**
	 * Entry point for the application.
	 * 
	 * Create the Database connection for use later.
	 */
	@Override
	public synchronized boolean start(IScope scope) {
		try {
			conn = getConnection();
		} catch (IOException ex) {
			log.error("SQLException: " + ex.getMessage());
		} catch (SQLException ex) {
			log.error("SQLException: " + ex.getMessage());
			log.error("SQLState: " + ex.getSQLState());
			log.error("VendorError: " + ex.getErrorCode());
		}

		return super.start(scope);
	}

	/**
	 * Handles a user connecting to the application.
	 * 
	 * If the user is connecting for the first time then there'll be no params
	 * passed. So we just create a new Player object and proceed.
	 * 
	 * If the user is reconnecting then they'll pass the user id, the player
	 * object is retrieved and the user id of the player reconnecting is
	 * updated.
	 */
	@Override
	public boolean connect(IConnection conn, IScope scope, Object[] params) {
		log.debug("params: {}", params.length);

		String uid = conn.getClient().getId();

		log.info("user \"{}\" connecting", uid);

		if (params.length > 0) {
			updatePlayer((String) params[0], uid);
		} else {
			registerPlayer(uid, conn);
		}

		ServiceUtils.invokeOnConnection(conn, Constants.SET_UID_METHOD_KEY,
				new Object[] { uid });

		return true;
	}

	/**
	 * Called when a player is reconnecting. Get the player object and set the
	 * new id.
	 * 
	 * @param oldId
	 * @param newId
	 */
	public void updatePlayer(String oldId, String newId) {
		Player player = playerMgr.getPlayer(oldId);
		player.setId(newId);
	}

	/**
	 * Called by a player on their initial connection to the application.
	 * 
	 * Player object is created and inserted into the PlayerManager.
	 * 
	 * @param uid
	 * @param conn
	 * @return
	 */
	public boolean registerPlayer(String uid, IConnection conn) {
		Player player = new Player(uid);
		playerMgr.addPlayer(conn, player);

		return true;
	}

	/**
	 * Adds a player to a Room. The player is retrieved by their id and inserted
	 * into the Room with the id passed.
	 * 
	 * @param uid
	 * @param roomId
	 * @return
	 */
	public boolean addPlayerToScene(String uid, Integer roomId) {
		Player player = playerMgr.getPlayer(uid);

		Room room = roomsList.get(roomId.toString());
		room.addPlayerToScene(player);

		return true;
	}

	/**
	 * Returns the Room with the id passed. If the Room doesn't exist already
	 * then it's created.
	 * 
	 * @param id
	 * @return
	 */
	public boolean createRoom(Integer id) {
		getRoom(id.toString());

		return true;
	}

	/**
	 * Returns the Room for the id passed. If the Room doesn't exist it's
	 * created.
	 * 
	 * @param id
	 * @return
	 */
	public Room getRoom(String id) {
		if (!roomsList.containsKey(id.toString())) {
			roomsList.put(id, new Room(id,
					Red5.getConnectionLocal().getScope(), this));
		}

		return roomsList.get(id);
	}

	/**
	 * Handles input from a client. The input is received as primitive object
	 * types, it's packed into a new AvatarInput object and passed to the Player
	 * object that represents the client that sent the input.
	 * 
	 * @param uid
	 * @param t
	 * @param left
	 * @param right
	 * @param forward
	 * @param back
	 * @param up
	 * @param down
	 * @param yawNegative
	 * @param yawPositive
	 * @param pitchNegative
	 * @param pitchPositive
	 * @param rollNegative
	 * @param rollPositive
	 * @param mouseX
	 * @param mouseY
	 * @param firing
	 */
	public void handleInput(String uid, Integer t, Boolean left, Boolean right,
			Boolean forward, Boolean back, Boolean up, Boolean down,
			Boolean yawNegative, Boolean yawPositive, Boolean pitchNegative,
			Boolean pitchPositive, Boolean rollNegative, Boolean rollPositive,
			Double mouseX, Double mouseY, Boolean firing) {
		if (uid != null) {
			Player player = playerMgr.getPlayer(uid);

			if (player != null) {
				AvatarInput input = new AvatarInput();

				input.left = left;
				input.right = right;
				input.forward = forward;
				input.back = back;
				input.up = up;
				input.down = down;
				input.yawNegative = yawNegative;
				input.yawPositive = yawPositive;
				input.pitchNegative = pitchNegative;
				input.pitchPositive = pitchPositive;
				input.rollNegative = rollNegative;
				input.rollPositive = rollPositive;
				input.mouseX = mouseX;
				input.mouseY = mouseY;
				input.firing = firing;

				player.receiveInput(t, input);
			}
		}
	}

	/** {@inheritDoc} */
	@Override
	public void disconnect(IConnection conn, IScope scope) {
		Player player = playerMgr.getPlayer(conn.getClient().getId());
		player.setConnected(false);

		player.room.removePlayer(player);

		super.disconnect(conn, scope);
	}

	@Override
	public synchronized void leave(IClient client, IScope scope) {
		super.leave(client, scope);
	}

	@Override
	public synchronized boolean join(IClient client, IScope scope) {
		return super.join(client, scope);
	}
}

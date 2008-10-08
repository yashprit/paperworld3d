/* --------------------------------------------------------------------------------------
 * PaperWorld3D - building better worlds
 * --------------------------------------------------------------------------------------
 * Real-Time Multi-User Application Framework for the Flash Platform.
 * --------------------------------------------------------------------------------------
 * Copyright (C) 2008 Trevor Burton [worldofpaper@googlemail.com]
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
 * -------------------------------------------------------------------------------------- */
package com.paperworld.multiplayer.connectors;

import org.red5.server.api.IConnection;
import org.red5.server.api.IScope;
import org.red5.server.api.ScopeUtils;
import org.red5.server.api.scheduling.ISchedulingService;
import org.red5.server.api.so.ISharedObject;
import org.red5.server.api.so.ISharedObjectService;

import com.paperworld.ai.steering.Kinematic;
import com.paperworld.multiplayer.data.Input;
import com.paperworld.multiplayer.data.State;
import com.paperworld.multiplayer.data.SyncData;
import com.paperworld.multiplayer.objects.Avatar;
import com.paperworld.multiplayer.player.Player;

public class RTMPConnector extends AbstractConnector {

	protected int time = 0;

	protected ISharedObject sharedObject;

	protected ISchedulingService schedulingService;

	public RTMPConnector() {
		super();
	}

	protected ISharedObject getSharedObject(IScope scope, String name,
			boolean persistent) {
		ISharedObjectService service = (ISharedObjectService) ScopeUtils
				.getScopeService(scope, ISharedObjectService.class, false);
		return service.getSharedObject(scope, name, persistent);
	}

	/**
	 * Receives player input. Update the player's avatar with the new input.
	 * Send a SyncEvent back to the player so they can synchronise immediately.
	 */
	public SyncData receiveInput(String uid, int time, Input input) {
		Player player = players.get(uid);
		Avatar avatar = player.getAvatar();
		avatar.update(time, input);

		State state = avatar.getState();

		return new SyncData(time, avatar.input, state);
	}

	public boolean appConnect(IConnection connection, Object[] params) {
		String name = (String) params[0];

		System.out.println(name + " connecting "
				+ connection.getClient().getId());

		Player player = new Player(name, connection);

		Kinematic kinematic = new Kinematic();

		Avatar avatar = new Avatar(kinematic);

		avatar.time = time;
		avatar.setKinematic(kinematic);

		player.setAvatar(avatar);

		// addNewPlayer(player);

		players.put(connection.getClient().getId(), player);

		System.out.println("player "
				+ players.get(connection.getClient().getId()));

		return true;
	}

	public Player getPlayerByConnection(IConnection connection) {
		for (String key : players.keySet()) {
			Player player = players.get(key);
			if (player.getConnection() == connection) {
				return player;
			}
		}

		return null;
	}

	public void appDisconnect(IConnection connection) {
		System.out.println("appDisconnect");
		Player player = getPlayerByConnection(connection);
		System.out.println("removing " + player);
		player.destroy();
	}
}

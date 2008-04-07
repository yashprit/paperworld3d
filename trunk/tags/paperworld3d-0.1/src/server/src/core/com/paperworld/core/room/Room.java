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
package com.paperworld.core.room;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Properties;
import java.util.Random;

import org.red5.server.api.IScope;
import org.red5.server.api.ScopeUtils;
import org.red5.server.api.scheduling.IScheduledJob;
import org.red5.server.api.scheduling.ISchedulingService;
import org.red5.server.api.so.ISharedObject;
import org.red5.server.api.so.ISharedObjectService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.paperworld.core.Application;
import com.paperworld.core.avatar.Avatar;
import com.paperworld.core.constants.Constants;
import com.paperworld.core.player.Player;
import com.paperworld.core.player.PlayerData;
import com.paperworld.core.scene.RemoteScene;

/**
 * The Room provides all the behavioural information for a game area. The Room dictates the class that is used to
 * represent the player as well as how that object will handle the player's input.
 * 
 * @author Trevor
 *
 */
public class Room implements IScheduledJob {
	public static Logger log = LoggerFactory.getLogger(Room.class);

	private IScope scope;

	private Double width = 0.0;

	private Double height = 0.0;

	private Double depth = 100.0;

	private Random generator = new Random();

	private Integer time = 0;

	/**
	 * The number of times per second that the simulation will be updated.
	 */
	private Integer simulationUpdateRate = 30;

	/**
	 * The number of times per second the the players currently connected will
	 * be updated with the simulation's current state.
	 */
	private Integer playerUpdateRate = 10;

	private Integer simulationTimeStep = 1000 / simulationUpdateRate;

	private Integer playerUpdateTimeStep = 1000 / playerUpdateRate;

	private long absoluteTime = 0;

	private long accumulator = 0;

	public RemoteScene scene;

	public ArrayList<Player> players = new ArrayList<Player>();

	private ISharedObject so;

	public String id;

	private Properties props;

	/** Manager for the players. */
	// private PlayerManager playerMgr;
	public Room(String id, IScope scope, Application application) {
		Application.log.debug("Creating Room {}", id);

		this.id = id;
		this.scope = scope;

		try {
			loadProperties();
		} catch (IOException ex) {

		}

		scene = new RemoteScene(scope, this, 0);

		absoluteTime = System.currentTimeMillis();

		application.addScheduledJob(simulationTimeStep, this);
	}

	private void loadProperties() throws IOException {
		props = new Properties();
		FileInputStream in = new FileInputStream(System
				.getProperty(Constants.RED5_CONFIG_ROOT_KEY)
				+ "/../webapps/paperworld3d/WEB-INF/room.properties");
		props.load(in);
		in.close();
	}

	private ISharedObject getSharedObject(IScope scope, String name,
			boolean persistent) {
		ISharedObjectService service = (ISharedObjectService) ScopeUtils
				.getScopeService(scope, ISharedObjectService.class, false);

		return service.getSharedObject(scope, name, persistent);
	}

	private void createSharedObject() {
		Application.log.debug("Creating Shared Object");
		so = getSharedObject(scope, "Room0", false);
	}

	public boolean addObjectToScene() {
		return true;
	}

	public boolean addPlayerToScene(Player player) {
		Application.log.debug("adding {} to scene", player.getId());

		if (players.size() == 0) {
			createSharedObject();
		}

		try {
			String avatarClass = props.getProperty("player.avatar");
			Application.log.debug("Creating avatar instance: {}", avatarClass);
			Avatar avatar = (Avatar) Class.forName(avatarClass).newInstance();

			avatar.setPosition(generator.nextDouble() * width, generator
					.nextDouble()
					* height, generator.nextDouble() * depth);

			avatar.uid = player.getId();

			player.setAvatar(avatar);

			PlayerData playerData = new PlayerData(player.getId(),
					player.username);

			player.room = this;

			players.add(player);

			so.beginUpdate();
			so.setAttribute(player.getId(), playerData);
			so.endUpdate();

			scene.addChild(avatar);

		} catch (Exception ex) {
			log.error("Exception: " + ex.getMessage());
		}

		return true;
	}

	public void removePlayer(Player player) {
		Application.log.debug("Removing player from Room {}", player);

		scene.removeChild(player.avatar);
		players.remove(player);
		so.removeAttribute(player.getId());

		if (players.size() < 1) {
			Application.log.debug("no more players, closing SO");
			so.close();
		}
	}

	public boolean addObjectToScene(String parent, String id) {
		return true;
	}

	public void execute(ISchedulingService isservice) {
		long newTime = System.currentTimeMillis();
		long deltaTime = newTime - absoluteTime;

		absoluteTime = newTime;
		accumulator += deltaTime;

		while (accumulator >= playerUpdateTimeStep) {
			scene.broadcastUpdates();

			accumulator -= playerUpdateTimeStep;

			time++;
		}

		scene.update();
	}
}

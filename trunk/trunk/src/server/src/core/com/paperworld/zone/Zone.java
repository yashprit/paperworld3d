package com.paperworld.zone;

import java.util.HashMap;
import java.util.Map;

import org.red5.server.api.IScope;
import org.red5.server.api.ScopeUtils;
import org.red5.server.api.scheduling.IScheduledJob;
import org.red5.server.api.scheduling.ISchedulingService;
import org.red5.server.api.so.ISharedObject;
import org.red5.server.api.so.ISharedObjectService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.paperworld.core.Application;
import com.paperworld.core.PaperworldService;
import com.paperworld.core.avatar.Avatar;
import com.paperworld.core.player.Player;
import com.paperworld.core.util.math.Vector3D;

public class Zone implements IScheduledJob {

	public static Logger log = LoggerFactory.getLogger(Zone.class);

	private Map<String, IZoneHandler> handlers = new HashMap<String, IZoneHandler>();

	/** Stores the name of the SharedObject to use. */
	private String name;

	/** Should the SharedObject be persistent? */
	private boolean persistent;

	private ISchedulingService timer;

	private ISharedObject so;

	private PaperworldService service;

	public Zone() {
		IZoneHandler playerHandler = new PlayerHandler();
		handlers.put("player", playerHandler);

		IZoneHandler npcHandler = new NPCHandler();
		npcHandler.start();
		handlers.put("npc", npcHandler);

		IZoneHandler projectileHandler = new ProjectileHandler();
		projectileHandler.start();
		handlers.put("projectile", projectileHandler);
	}

	public void init(Application application) {
		application.addScheduledJob(1000 / 25, getHandler("npc"));
		application.addScheduledJob(1000 / 25, getHandler("projectile"));
		application.addScheduledJob(1000 / 25, getHandler("player"));
		application.addScheduledJob(1000 / 25, this);
	}

	public void addPlayer(IScope scope, Avatar avatar) {

		Map<String, Avatar> players = getPlayers();

		so = getSharedObject(scope);
		players.put(avatar.id, avatar);
	}

	public void addNpc(Avatar avatar) {
		Map<String, Avatar> npc = getNPCs();
		npc.put(avatar.id, avatar);
	}

	public void addProjectile(Avatar avatar) {
		Map<String, Avatar> projectiles = getProjectiles();
		projectiles.put(avatar.id, avatar);
	}

	public void clear() {
		for (String key : handlers.keySet()) {
			IZoneHandler handler = getHandler(key);
			handler.setAvatars(new HashMap<String, Avatar>());
		}
	}

	public void removePlayer(IScope scope, Avatar avatar) {
		Map<String, Avatar> players = getPlayers();

		if (players.size() < 1) {
			so.close();
		}
	}

	private ISharedObject getSharedObject(IScope scope) {
		ISharedObjectService service = (ISharedObjectService) ScopeUtils
				.getScopeService(scope, ISharedObjectService.class, false);
		return service.getSharedObject(scope, name, persistent);
	}

	public String getName() {
		return name;
	}

	private int renderCounter = 0;

	public void execute(ISchedulingService arg0)
			throws CloneNotSupportedException {

		doCollisionDetection();

		if (renderCounter > 5) {

			if (so != null) {

				so.beginUpdate();

				for (String i : handlers.keySet()) {

					IZoneHandler handler = (IZoneHandler) handlers.get(i);
					Map<String, Avatar> avatars = handler.getAvatars();

					for (String j : avatars.keySet()) {

						Avatar avatar = (Avatar) avatars.get(j);
						so.setAttribute(avatar.id, avatar.getAvatarData());
					}
				}

				so.endUpdate();
			}
			
			renderCounter = 0;
		}
		
		renderCounter++;
	}

	private void doCollisionDetection() {
		Map<String, Avatar> players = getHandler("player").getAvatars();
		Map<String, Avatar> projectiles = getHandler("projectile").getAvatars();

		for (String playerKey : players.keySet()) {
			Avatar avatar = players.get(playerKey);

			for (String projectileKey : projectiles.keySet()) {
				Avatar projectile = projectiles.get(projectileKey);
				
				Vector3D avatarPosition = avatar.getPosition();
				Vector3D projectilePosition = projectile.getPosition();
				
				Vector3D difference = projectilePosition.returnSubtraction(avatarPosition);
				double distance = difference.length();
				
				if (distance < 100)
					log.debug("HIT!");
			}
		}
	}

	/*
	 * public void setPlayers(Map<String, Avatar> players) { this.players =
	 * players; if (players.size() > 0) init(); }
	 */

	public Map<String, Avatar> getPlayers() {
		return (Map<String, Avatar>) getHandler("player").getAvatars();
	}

	public Map<String, Avatar> getNPCs() {
		return (Map<String, Avatar>) getHandler("npc").getAvatars();
	}

	public Map<String, Avatar> getProjectiles() {
		return (Map<String, Avatar>) getHandler("projectile").getAvatars();
	}

	@SuppressWarnings("unchecked")
	public IZoneHandler getHandler(String key) {
		return (IZoneHandler) handlers.get(key);
	}

	public void setPlayer(Player player) {
		log.debug("adding {}", player.getId());
	}

	public void setName(String n) {
		name = n;
	}

	public void setPersistent(boolean p) {
		persistent = p;
	}

	public void setService(PaperworldService service) {
		this.service = service;
	}

	public void setNpc(Map npc) {
		IZoneHandler handler = getHandler("npc");
		handler.setAvatars(npc);
	}
}

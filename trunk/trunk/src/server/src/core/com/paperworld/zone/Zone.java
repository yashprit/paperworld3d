package com.paperworld.zone;

import java.util.HashMap;
import java.util.Map;

import org.red5.server.api.IScope;
import org.red5.server.api.ScopeUtils;
import org.red5.server.api.scheduling.IScheduledJob;
import org.red5.server.api.scheduling.ISchedulingService;
import org.red5.server.api.so.ISharedObject;
import org.red5.server.api.so.ISharedObjectService;
import org.red5.server.scheduling.QuartzSchedulingService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.paperworld.core.avatar.AvatarData;
import com.paperworld.core.avatar.behaviour.IAvatarBehaviour;
import com.paperworld.core.player.Player;

public class Zone implements IScheduledJob {

	public static Logger log = LoggerFactory.getLogger(Zone.class);
	
	private Map<String, Player> players = new HashMap<String, Player>();

	private IAvatarBehaviour behaviour;

	/** Stores the name of the SharedObject to use. */
	private String name;

	/** Should the SharedObject be persistent? */
	private boolean persistent;

	private ISharedObject so;

	private int interval = 1000 / 5;

	private ISchedulingService scheduleService;
	private String scheduledJob;

	public Zone() {
		scheduleService = new QuartzSchedulingService();
	}

	public void addPlayer(IScope scope, Player player) {
		
		log.debug("ScheduleSErvice {} {} {}", new Object[]{scheduleService, name, scope});
		if (players.size() < 1) {
			so = getSharedObject(scope);
			scheduledJob = scheduleService.addScheduledJob(interval, this);
		}

		players.put(player.getId(), player);
	}

	public void removePlayer(IScope scope, Player player) {
		players.remove(player);

		if (players.size() < 1) {
			so.close();
			so = null;
			scheduleService.removeScheduledJob(scheduledJob);
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

	public void execute(ISchedulingService arg0)
			throws CloneNotSupportedException {		
		
		so.beginUpdate();

		for (String key : players.keySet()) {
			Player player = (Player) players.get(key);
			
			AvatarData data = player.getAvatar().getAvatarData();
			data.id = player.getId();
			data.time = player.time;
			data.input = player.getInput();
			
			so.setAttribute(player.getId(), data);
		}

		so.endUpdate();

	}
	
	public void setName(String n){
		name = n;
	}
	
	public void setPersistent(boolean p){
		persistent = p;
	}
}

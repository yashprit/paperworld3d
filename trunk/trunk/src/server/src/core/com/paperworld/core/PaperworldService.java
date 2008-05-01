package com.paperworld.core;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.red5.server.adapter.IApplication;
import org.red5.server.api.IClient;
import org.red5.server.api.IConnection;
import org.red5.server.api.IScope;
import org.red5.server.api.Red5;
import org.red5.server.api.listeners.IConnectionListener;
import org.red5.server.api.scheduling.IScheduledJob;
import org.red5.server.api.scheduling.ISchedulingService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.paperworld.core.avatar.AvatarInput;
import com.paperworld.core.events.IPaperworldEventListener;
import com.paperworld.core.player.Player;
import com.paperworld.zone.Zone;

public class PaperworldService implements IApplication, IConnectionListener {

	public static Logger log = LoggerFactory.getLogger(Application.class);

	public Map<String, Zone> zones = new HashMap<String, Zone>();
	
	public Map<String, Player> players = new HashMap<String, Player>();

	private Application application;

	public static IScope SCOPE;

	public PaperworldService() {
	}
	
	public void init() {
		for (String key : zones.keySet()) {
			Zone zone = (Zone) zones.get(key);
			zone.init(application);
		}
		
	}

	public boolean connectToZone(String uid, String zoneId) {
		log.debug("player {} connecting to {}", new Object[] { uid, zoneId });
		
		if (!zones.containsKey(zoneId))
		{
			return false;
		}
		
		Zone zone = zones.get(zoneId);

		//IConnection connection = Red5.getConnectionLocal();
		//IScope scope = connection.getScope();
		//IClient client = connection.getClient();
		//Player player = (Player) client.getAttribute("player");

		if (!players.containsKey(uid)) {
			Player player = (Player) SCOPE.getContext().getBean("player");
			player.setId(uid);
			player.setZone(zone);
			
			players.put(uid, player);

			//client.setAttribute("player", player);
			zone.addPlayer(SCOPE, player.getAvatar());
			
			return true;
		}

		

		return false;
	}

	public void handleInput(String uid, Integer t, Boolean left, Boolean right,
			Boolean forward, Boolean back, Boolean up, Boolean down,
			Boolean yawNegative, Boolean yawPositive, Boolean pitchNegative,
			Boolean pitchPositive, Boolean rollNegative, Boolean rollPositive,
			Double mouseX, Double mouseY, Boolean firing) {

		//IClient client = Red5.getConnectionLocal().getClient();
		//Player player = (Player) client.getAttribute("player");
		
		Player player = players.get(uid);
		
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
		
		if(input.firing)
		{
			log.debug("FIRING!");
		}

		player.receiveInput(t, input);
	}

	public void setZones(Map<String, Zone> zones) {
		this.zones = zones;
		/*
		 * for (String key : zones.keySet()) { Zone zone = (Zone)
		 * zones.get(key); listeners.add(zone); }
		 */
	}

	public boolean appConnect(IConnection conn, Object[] params) {
		System.out.println("appStart");
		SCOPE = conn.getScope();
		return false;
	}

	public void appDisconnect(IConnection conn) {
		// TODO Auto-generated method stub
		log.debug("appDisconnect called");

		IClient client = conn.getClient();
		//IScope scope = conn.getScope();
		//Player player = (Player) client.getAttribute("player");
		//player.getZone().removePlayer(scope, player.getAvatar());
		Player player = players.get(client.getId());
		player.getZone().clear();
	}

	public boolean appJoin(IClient arg0, IScope arg1) {
		// TODO Auto-generated method stub
		return false;
	}

	public void appLeave(IClient arg0, IScope arg1) {
		// TODO Auto-generated method stub

	}

	public boolean appStart(IScope scope) {

		return false;
	}

	public void appStop(IScope arg0) {
		// TODO Auto-generated method stub

	}

	public boolean roomConnect(IConnection arg0, Object[] arg1) {
		// TODO Auto-generated method stub
		return false;
	}

	public void roomDisconnect(IConnection arg0) {
		// TODO Auto-generated method stub

	}

	public boolean roomJoin(IClient arg0, IScope arg1) {
		// TODO Auto-generated method stub
		return false;
	}

	public void roomLeave(IClient arg0, IScope arg1) {
		// TODO Auto-generated method stub

	}

	public boolean roomStart(IScope arg0) {
		// TODO Auto-generated method stub
		return false;
	}

	public void roomStop(IScope arg0) {
		// TODO Auto-generated method stub

	}

	public void notifyConnected(IConnection arg0) {
		// TODO Auto-generated method stub

	}

	public void notifyDisconnected(IConnection arg0) {
		// TODO Auto-generated method stub
		log.debug("notifyDisconnect called");

	}

	public void setApplication(Application a) {
		application = a;
		application.addListener(this);
	}

	public Application getApplication() {
		return application;
	}
}

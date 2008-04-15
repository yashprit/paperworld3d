package com.paperworld.core;

import java.util.HashMap;
import java.util.Map;

import org.red5.server.api.IClient;
import org.red5.server.api.IConnection;
import org.red5.server.api.IScope;
import org.red5.server.api.Red5;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.paperworld.core.avatar.AvatarInput;
import com.paperworld.core.player.Player;
import com.paperworld.zone.Zone;

public class PaperworldService {

	public static Logger log = LoggerFactory.getLogger(Application.class);

	public Map<String, Zone> zones = new HashMap<String, Zone>();

	public PaperworldService() {
	}

	public boolean connectToZone(String uid, String zoneId) {
		log.debug("player {} connecting to {}", new Object[] { uid, zoneId });

		Zone zone = zones.get(zoneId);

		IConnection connection = Red5.getConnectionLocal();
		IScope scope = connection.getScope();
		IClient client = connection.getClient();
		Player player = (Player) client.getAttribute("player");

		if (player == null) {
			//player = (Player) scope.getContext().getBean("player");
			//player.setId(uid);
			player = new Player(uid);
			
			client.setAttribute("player", player);
		}

		zone.addPlayer(scope, player);

		return true;
	}

	public void handleInput(String uid, Integer t, Boolean left, Boolean right,
			Boolean forward, Boolean back, Boolean up, Boolean down,
			Boolean yawNegative, Boolean yawPositive, Boolean pitchNegative,
			Boolean pitchPositive, Boolean rollNegative, Boolean rollPositive,
			Double mouseX, Double mouseY, Boolean firing) {

		IClient client = Red5.getConnectionLocal().getClient();
		Player player = (Player) client.getAttribute("player");

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

	public void setZones(Map zones) {
		this.zones = zones;
	}
}

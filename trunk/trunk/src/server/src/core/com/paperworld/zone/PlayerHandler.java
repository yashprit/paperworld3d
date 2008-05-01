package com.paperworld.zone;

import org.red5.server.api.scheduling.ISchedulingService;

import com.paperworld.core.avatar.Avatar;

public class PlayerHandler extends AbstractZoneHandler {

	public PlayerHandler() {
		super();
	}

	public void execute(ISchedulingService arg0)
			throws CloneNotSupportedException {

		for (String key : avatars.keySet()) {
			Avatar avatar = (Avatar) avatars.get(key);
			avatar.update();
		}
	}
}

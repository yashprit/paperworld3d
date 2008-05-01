package com.paperworld.zone;

import org.red5.server.api.scheduling.ISchedulingService;

import com.paperworld.core.avatar.Avatar;

public class ProjectileHandler extends AbstractZoneHandler {
	private int interval = 1000 / 30;

	public ProjectileHandler() {
		super();
	}

	@Override
	public void start() {

	}

	@Override
	public void execute(ISchedulingService arg0)
			throws CloneNotSupportedException {

		for (String key : avatars.keySet()) {
			Avatar avatar = (Avatar) avatars.get(key);
			avatar.update();
		}
	}
}

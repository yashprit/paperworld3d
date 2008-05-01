package com.paperworld.zone;

import java.util.HashMap;
import java.util.Map;

import org.red5.server.api.scheduling.ISchedulingService;
import org.red5.server.scheduling.QuartzSchedulingService;

import com.paperworld.core.avatar.Avatar;

public abstract class AbstractZoneHandler implements IZoneHandler {

	protected Map<String, Avatar> avatars = new HashMap<String, Avatar>();

	protected ISchedulingService timer;

	protected String scheduledJob;

	public AbstractZoneHandler() {
		timer = new QuartzSchedulingService();
	}

	public void addAvatar(Avatar avatar) {
		avatars.put(avatar.id, avatar);
	}

	public Map<String, Avatar> getAvatars() {
		return avatars;
	}
	
	public void setAvatars(Map<String, Avatar> avatars){
		this.avatars = avatars;
	}

	public void start() {
	}

	public void stop() {
		if (scheduledJob != null && scheduledJob != "")
			timer.removeScheduledJob(scheduledJob);
	}

	public void execute(ISchedulingService arg0)
			throws CloneNotSupportedException {
		// TODO Auto-generated method stub

	}

}

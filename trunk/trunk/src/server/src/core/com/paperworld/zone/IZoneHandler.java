package com.paperworld.zone;

import java.util.Map;

import org.red5.server.api.scheduling.IScheduledJob;

import com.paperworld.core.avatar.Avatar;

public interface IZoneHandler extends IScheduledJob {
	public void addAvatar(Avatar avatar);
	public Map<String, Avatar> getAvatars();
	public void setAvatars(Map<String, Avatar> avatars);
	public void start();
	public void stop();
}

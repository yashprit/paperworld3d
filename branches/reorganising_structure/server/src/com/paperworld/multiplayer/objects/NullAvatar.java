package com.paperworld.multiplayer.objects;

import org.red5.server.api.so.ISharedObject;

import com.actionengine.api.IInput;
import com.brainfarm.java.data.State;
import com.paperworld.java.api.ISynchronisedAvatar;
import com.paperworld.java.api.ISynchronisedScene;
import com.paperworld.multiplayer.data.AvatarData;
import com.paperworld.multiplayer.player.PlayerContext;

public class NullAvatar implements ISynchronisedAvatar {

	@Override
	public void destroy() {
		// TODO Auto-generated method stub

	}

	@Override
	public AvatarData getAvatarData() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getId() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public IInput getInput() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getKey() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public State getState() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int getTime() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void setId(String id) {
		// TODO Auto-generated method stub

	}

	@Override
	public void setKey(String key) {
		// TODO Auto-generated method stub

	}

	@Override
	public void setPlayerContext(PlayerContext context) {
		// TODO Auto-generated method stub

	}

	@Override
	public void setUserInput(IInput input) {
		// TODO Auto-generated method stub

	}

	@Override
	public void updateBehaviour() {
		// TODO Auto-generated method stub

	}

	@Override
	public void updateSharedObject(ISharedObject so) {
		// TODO Auto-generated method stub

	}

	@Override
	public ISynchronisedScene getScene() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void setScene(ISynchronisedScene scene) {
		// TODO Auto-generated method stub
		
	}

}

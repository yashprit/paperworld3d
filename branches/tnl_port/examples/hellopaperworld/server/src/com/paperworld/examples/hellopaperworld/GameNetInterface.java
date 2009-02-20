package com.paperworld.examples.hellopaperworld;

import org.red5.server.api.IConnection;

import com.paperworld.server.api.ISimulation;
import com.paperworld.server.api.base.BaseNetInterface;
import com.paperworld.server.flash.FlashGhostConnection;

public class GameNetInterface extends BaseNetInterface {
	
	protected ISimulation simulation;
	
	protected IConnection connection;
	
	public GameNetInterface() {
		
	}
}

package com.paperworld.examples.hellopaperworld;

import com.paperworld.server.api.INetObject;
import com.paperworld.server.flash.FlashGhostConnection;

public class ControlObjectConnection extends FlashGhostConnection {
		
	public ControlObjectConnection() {
		TYPE = "ControlObjectConnection";
	}
	
	public GameObject getControlObject() {
		return (GameObject) scopeObject;
	}
	
	@Override
	public void readPacket(INetObject packet) {
		System.out.println("Control Connection reading packet");
		GameObject controlObject = getControlObject();
		
		/*Move move = (Move) packet;
		
		while (move != null) {
			controlObject.setCurrentMove(move);
			controlObject.idle();
			
			move = (Move) move.getNext();
		}*/
	}
}

package com.paperworld.examples.hellopaperworld;

import java.awt.Point;

import com.paperworld.server.flash.FlashGhostObject;

public class GameObject extends FlashGhostObject {

	protected Point point;
	
	protected Move currentMove;
	
	protected Move previousMove;
	
	public GameObject() {
		point = new Point();
	}
	
	public void setCurrentMove(Move move) {
		System.out.println("setting current move");
		currentMove = move;
	}
	
	public void idle() {
		System.out.println("idling");
	}
}

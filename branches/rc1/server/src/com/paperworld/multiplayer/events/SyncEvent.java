package com.paperworld.multiplayer.events;

import com.paperworld.multiplayer.data.Input;
import com.paperworld.multiplayer.data.State;

public class SyncEvent {

	protected int t;

	protected Input input;

	protected State state;

	public SyncEvent(int t, Input input, State state) {
		this.t = t;
		this.input = input;
		this.state = state;
	}

	public int getT() {
		return t;
	}

	public void setT(int t) {
		this.t = t;
	}

	public Input getInput() {
		return input;
	}

	public void setInput(Input input) {
		this.input = input;
	}

	public State getState() {
		return state;
	}

	public void setState(State state) {
		this.state = state;
	}
}

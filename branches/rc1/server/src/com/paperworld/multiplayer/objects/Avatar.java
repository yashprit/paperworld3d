package com.paperworld.multiplayer.objects;

import org.red5.server.api.so.ISharedObject;

import com.paperworld.ai.steering.Kinematic;
import com.paperworld.multiplayer.data.Input;
import com.paperworld.multiplayer.data.State;

public class Avatar {

	protected Kinematic kinematic;

	/**
	 * The current Input state for this Kinematic.
	 */
	public Input input;

	/**
	 * The current time for this Kinematic.
	 */
	public int time;

	public State state;

	public ISharedObject sharedObject;

	public Avatar(Kinematic kinematic) {
		this.kinematic = kinematic;
	}

	public void update(int time, Input input) {
		System.out.println("updating avatar");
		if (time > this.time) {
			while (this.time < time) {
				kinematic.update(this.time);
				this.time++;
			}

			this.input = input;

		}
		System.out.println("shared object = " + sharedObject);
		sharedObject.setAttribute("trev", getState());
	}

	public Kinematic getKinematic() {
		return kinematic;
	}

	public void setKinematic(Kinematic kinematic) {
		this.kinematic = kinematic;
	}

	public void updateState() {
		state.position = kinematic.position;
		state.orientation = kinematic.orientation;
		state.velocity = kinematic.velocity;
		state.rotation = kinematic.rotation;
	}

	public State getState() {
		updateState();

		return state;
	}
}
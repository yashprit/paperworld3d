package com.paperworld.multiplayer.behaviour;

import com.paperworld.ai.steering.Kinematic;
import com.paperworld.multiplayer.data.Input;

public class SimpleAvatarBehaviour2D implements IAvatarBehaviour {

	public SimpleAvatarBehaviour2D() {

	}

	public void update(int time, Input input, Kinematic kinematic) {

		if (input.getForward()) {
			System.out.println("before: " + kinematic.position);
			kinematic.position.z += 5;
			System.out.println("after: " + kinematic.position);
		}
	}

}

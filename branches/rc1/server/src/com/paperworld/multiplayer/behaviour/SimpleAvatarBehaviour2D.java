package com.paperworld.multiplayer.behaviour;

import com.paperworld.ai.steering.Kinematic;
import com.paperworld.multiplayer.data.Input;

public class SimpleAvatarBehaviour2D implements IAvatarBehaviour {

	public SimpleAvatarBehaviour2D() {

	}

	public void update(int time, Input input, Kinematic kinematic) {

		if (input != null) {
			if (input.getForward())
				kinematic.position.z += 5;

			if (input.getBack())
				kinematic.position.z -= 5;

			if (input.getMoveRight())
				kinematic.position.x += 5;

			if (input.getMoveLeft())
				kinematic.position.x -= 5;

			if (input.getTurnRight())
				kinematic.orientation.w += 1;

			if (input.getTurnLeft())
				kinematic.orientation.w -= 1;
		}
	}

}

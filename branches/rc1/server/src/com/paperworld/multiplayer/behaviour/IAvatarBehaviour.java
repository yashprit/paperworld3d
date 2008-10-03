package com.paperworld.multiplayer.behaviour;

import com.paperworld.ai.steering.Kinematic;
import com.paperworld.multiplayer.data.Input;

public interface IAvatarBehaviour {

	public void update(int time, Input input, Kinematic kinematic);
}

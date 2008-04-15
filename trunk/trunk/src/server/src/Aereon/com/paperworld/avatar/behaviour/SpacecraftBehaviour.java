package com.paperworld.avatar.behaviour;

import com.paperworld.core.avatar.AvatarInput;
import com.paperworld.core.avatar.AvatarState;
import com.paperworld.core.avatar.behaviour.IAvatarBehaviour;
import com.paperworld.core.util.DisplayObject3D;
import com.paperworld.core.util.math.Quaternion;

public class SpacecraftBehaviour implements IAvatarBehaviour {

	public Double maxAcceleration = 5.0;

	public Double maxSpeed = 50.0;

	public Double minSpeed = -maxSpeed;
	
	public SpacecraftBehaviour(){
		
	}

	public void update(AvatarInput input, AvatarState state,
			DisplayObject3D displayObject) {
		if (input.forward)
			state.speed = (state.speed + maxAcceleration > maxSpeed) ? maxSpeed
					: state.speed + maxAcceleration;

		if (input.back)
			state.speed = (state.speed - maxAcceleration < minSpeed) ? minSpeed
					: state.speed - maxAcceleration;

		displayObject.moveForward(state.speed);

		displayObject.pitch(input.mouseY);
		displayObject.yaw(input.mouseX);
		displayObject.roll(-input.mouseX);

		state.setTransform(displayObject.transform);
		state.setOrientation(Quaternion.createFromMatrix(state.returnTransform()));
	}
}

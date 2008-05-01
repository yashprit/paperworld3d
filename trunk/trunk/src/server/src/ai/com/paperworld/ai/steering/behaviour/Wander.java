package com.paperworld.ai.steering.behaviour;

import com.paperworld.ai.core.steering.AbstractSteeringBehaviour;
import com.paperworld.core.Application;
import com.paperworld.core.avatar.Avatar;
import com.paperworld.core.avatar.AvatarState;
import com.paperworld.core.util.DisplayObject3D;
import com.paperworld.core.util.RandomUtils;
import com.paperworld.core.util.math.Quaternion;
import com.paperworld.core.util.math.Vector3D;

public class Wander extends AbstractSteeringBehaviour {

	private Avatar character;

	private Vector3D wanderOffset = new Vector3D(1000.0, 1000.0, 1000.0);

	private double wanderRadiusXZ = 10.0;

	private double wanderRadiusY = 10.0;

	private double wanderRate = 0.4;

	private Vector3D wanderVector = new Vector3D();

	private Vector3D maxAcceleration = new Vector3D(0, 0, 5.0);

	@Override
	public void run() {		
		
		// Create a local reference to the character's state.
		AvatarState state = character.getState();
		DisplayObject3D displayObject = character.getDisplayObject();
		
		//character.getInput().forward = true;
/*
		// Update the wander direction.
		wanderVector.x += RandomUtils.randomBinomial(1) * wanderRate;
		wanderVector.y += RandomUtils.randomBinomial(1) * wanderRate;
		wanderVector.z += RandomUtils.randomBinomial(1) * wanderRate;
		
		wanderVector.normalise();
			
		//Application.log.debug("WanderVector {}", wanderVector);
		
		// Calculate the transformed target direction and scale it.
		Vector3D target = state.returnQuaternion().multiplyVector(wanderVector);
		target.x *= wanderRadiusXZ;
		target.y *= wanderRadiusY;
		target.z *= wanderRadiusXZ;
		
		//Application.log.debug("targetvector {}", target);
		
		// Offset by the centre of the wander circle.
		target.returnAddition(state.returnPosition()).returnAddition(
				state.returnQuaternion().multiplyVector(wanderOffset));

		// Delegate it to face.

		// Now set the linear acceleration to be at full
		// acceleration in the direction of the orientation.
		Vector3D linear = state.returnQuaternion().multiplyVector(
				maxAcceleration);
				
		double x = displayObject.getX();
		double y = displayObject.getY();
		double z = displayObject.getZ();
		
		displayObject.setX(x += linear.x);
		displayObject.setY(y += linear.y);
		displayObject.setZ(z += linear.z);
		
		//state.n14 += linear.x;
		//state.n24 += linear.y;
		//state.n34 += linear.z;
		*/
		state.setTransform(displayObject.transform);
		state.setOrientation(Quaternion.createFromMatrix(state
				.returnTransform()));
	}

	public void setCharacter(Avatar avatar) {
		character = avatar;
	}
}

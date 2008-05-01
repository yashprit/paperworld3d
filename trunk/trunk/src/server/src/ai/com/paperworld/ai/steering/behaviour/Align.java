package com.paperworld.ai.steering.behaviour;

import com.paperworld.ai.core.steering.AbstractSteeringBehaviour;
import com.paperworld.core.avatar.Avatar;
import com.paperworld.core.util.math.Quaternion;
import com.paperworld.core.util.math.Vector3D;

public class Align extends AbstractSteeringBehaviour {

	private Avatar character;

	private Avatar target;

	@Override
	public void run() {
		// Get the character's orientation.
		Quaternion characterOrientation = character.getState()
				.returnQuaternion();

		// Get the target's orientation.
		Quaternion targetOrientation = target.getState().returnQuaternion();

		// Calculate the Quaternion that would transform the character
		// orientation into the target orientation.
		// q = s^-1 * t
		Quaternion changeOrientation = characterOrientation.returnConjugate()
				.returnMultiplication(targetOrientation);
		
		// Split into axis and angle.
		Double angle = 2 * (Math.acos(changeOrientation.w));
		
		Double temp = 1 / Math.sin(angle / 2);
		
		Vector3D axis = new Vector3D( temp * changeOrientation.x,
									  temp * changeOrientation.y,
									  temp * changeOrientation.z );
		
		

	}

	public void setCharacter(Avatar character) {
		this.character = character;
	}

	public void setTarget(Avatar target) {
		this.target = target;
	}
}

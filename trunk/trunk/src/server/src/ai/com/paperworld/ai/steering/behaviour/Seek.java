/**
 * The PaperWorld3d AI library is based on the aicore library provided in:
 * 
 * "Artificial Intelligence for Games" - by Ian Millington (Morgan Kaufmann).
 * 
 * The aicore library is provided for free and i've ported the code to Java for
 * the purposes of PaperWorld3D.
 * 
 * This class is a direct port of the code provided in the aicore library.
 */
package com.paperworld.ai.steering.behaviour;

import com.paperworld.ai.core.steering.AbstractSteeringBehaviour;
import com.paperworld.ai.steering.SteeringOutput;
import com.paperworld.core.util.math.Vector3D;

/**
 * The seek steering behaviour takes a target and aims right for it with maximum
 * acceleration.
 */
public class Seek extends AbstractSteeringBehaviour {
	/**
	 * The target may be any vector (i.e. it might be something that has no
	 * orientation, such as a point in space).
	 */
	public Vector3D target;

	/**
	 * The maximum acceleration that can be used to reach the target.
	 */
	public Double maxAcceleration;

	/**
	 * Works out the desired steering and writes it into the given steering
	 * output structure.
	 */
	public void getSteering(SteeringOutput output) {
		// First work out the direction
		output.linear = target;
		output.linear.returnSubtraction(character.getPosition());

		// If there is no direction, do nothing
		if (output.linear.lengthSquared() > 0) {
			output.linear.normalise();
			output.linear.returnScale(maxAcceleration);
		}
	}

	public SteeringOutput getSteering() {
		// TODO Auto-generated method stub
		return null;
	}
	
	public void update(){
		
	}

}

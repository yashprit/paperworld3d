package com.paperworld.ai.steering.behaviour;

import com.paperworld.ai.core.steering.AbstractSteeringBehaviour;
import com.paperworld.ai.steering.SteeringOutput;
import com.paperworld.core.util.math.Vector3D;

/**
 * The seek steering behaviour takes a target and aims in the opposite direction
 * with maximum acceleration.
 */
public class Flee extends AbstractSteeringBehaviour
{
	/**
	 * The target may be any vector (i.e. it might be something that has no
	 * orientation, such as a point in space).
	 */
	public Vector3D	target;
	
	/**
	 * The maximum acceleration that can be used to reach the target.
	 */
	public Double	maxAcceleration;
	
	/**
	 * Works out the desired steering and writes it into the given steering
	 * output structure.
	 */
	public void getSteering(SteeringOutput output)
	{
		// First work out the direction
		output.linear = character.getPosition();
		output.linear.returnSubtraction(target);
		
		// If there is no direction, do nothing
		if (output.linear.lengthSquared() > 0)
		{
			output.linear.normalise();
			output.linear.returnScale(maxAcceleration);
		}
	}
	
	public SteeringOutput getSteering(){
		return null;
	}
	
	public void run(){
		
	}
}

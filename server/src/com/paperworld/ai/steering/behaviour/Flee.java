/*
 * Part of the Artificial Intelligence for Games system.
 *
 * Copyright (c) Ian Millington 2003-2006. All Rights Reserved.
 *
 * This software is distributed under licence. Use of this software
 * implies agreement with all terms and conditions of the accompanying
 * software licence.
 * 
 * Java port - Trevor Burton [worldofpaper@googlemail.com]
 */
package com.paperworld.ai.steering.behaviour;

import com.paperworld.ai.steering.SteeringBehaviour;
import com.paperworld.ai.steering.SteeringOutput;
import com.paperworld.core.math.Vector3;

/**
 * The seek steering behaviour takes a target and aims in the opposite direction
 * with maximum acceleration.
 */
public class Flee extends SteeringBehaviour
{
	/**
	 * The target may be any vector (i.e. it might be something that has no
	 * orientation, such as a point in space).
	 */
	public Vector3	target;
	
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
		output.linear = character.position;
		output.linear.returnSubtraction(target);
		
		// If there is no direction, do nothing
		if (output.linear.getSquareMagnitude() > 0)
		{
			output.linear.normalise();
			output.linear.returnScale(maxAcceleration);
		}
	}
}

/*
 * Part of the Artificial Intelligence for Games system.
 *
 * Copyright (c) Ian Millington 2003-2006. All Rights Reserved.
 *
 * This software is distributed under licence. Use of this software
 * implies agreement with all terms and conditions of the accompanying
 * software licence.
 * 
 * Actionscript port - Trevor Burton [worldofpaper@googlemail.com]
 */
package com.paperworld.ai.steering.kinematic.behaviours 
{
	import com.paperworld.ai.steering.SteeringOutput;
	import com.paperworld.ai.steering.kinematic.behaviours.KinematicSeek;	

	/**
	 * @author Trevor
	 */
	public class KinematicFlee extends KinematicSeek 
	{
		override public function getSteering(output : SteeringOutput) : void
		{
			// First work out the direction
			output.linear = character.position;
			output.linear.minusEq( target );

			// If there is no direction, do nothing
			if (output.linear.squareMagnitude > 0)
			{
				output.linear.normalise( );
				output.linear.multiplyEq( maxSpeed );
			}
		}
	}
}

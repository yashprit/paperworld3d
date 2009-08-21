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
package org.paperworld.flash.ai.collision 
{
	import org.paperworld.flash.ai.steering.Kinematic;
	
	import org.papervision3d.core.math.Number3D;	

	/**
	 * @author Trevor
	 */
	public interface ICollisionDetector 
	{
		/**
		 * Interface to the collision detection engine. The user must
		 * provide it when instantiating some of the behaviours.
		 *
		 * @param current The current kinematic state of the agent
		 * @param target The agent's target
		 * @param collisionPoint A pointer to a structure into which the
		 * coordinates of the collision point should be entered.
		 * @param collisionNormal A pointer to a structure into which the
		 * vector normal to the collision surface should be entered.
		 *
		 * @return False if no collision is detected.
		 */
		function detectCollisions(current : Kinematic,
                                  target : Kinematic,
                                  collisionPoint : Number3D,
                                  collisionNormal : Number3D) : Boolean
	}
}
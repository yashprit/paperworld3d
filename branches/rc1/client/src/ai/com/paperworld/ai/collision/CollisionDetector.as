/**
 * This class is a port of the original C++ code from the book:
 * 
 * 'Artificial Intelligence for Games' by Ian Millington 
 * Published by Morgan Kaufmann (ISBN: 0124977820)
 * 
 * Adaptations from original source:
 * 
 * - Added BaseClass methods.
 */
package com.paperworld.ai.collision 
{
	import com.paperworld.ai.steering.Kinematic;
	import com.paperworld.util.math.Vector3;	
	
	/**
	 * @author Trevor
	 */
	public interface CollisionDetector 
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
        function detectCollisions(current:Kinematic,
                                  target:Kinematic,
                                  collisionPoint:Vector3,
                                  collisionNormal:Vector3):Boolean
	}
}

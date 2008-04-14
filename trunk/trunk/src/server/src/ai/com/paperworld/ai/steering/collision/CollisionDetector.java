package com.paperworld.ai.steering.collision;

import com.paperworld.core.avatar.Avatar;
import com.paperworld.core.util.math.Vector3D;

/**
 * This class is an interface to a collision detector. It should be overridden
 * to implement a specific collision detector. A function needing a collision
 * detector should create an instance of this interface.
 */
public interface CollisionDetector {
	/**
	 * Interface to the collision detection engine. The user must provide it
	 * when instantiating some of the behaviours.
	 * 
	 * @param current
	 *            The current kinematic state of the agent
	 * @param target
	 *            The agent's target
	 * @param collisionPoint
	 *            A pointer to a structure into which the coordinates of the
	 *            collision point should be entered.
	 * @param collisionNormal
	 *            A pointer to a structure into which the vector normal to the
	 *            collision surface should be entered.
	 * 
	 * @return False if no collision is detected.
	 */
	public boolean detectCollisions(Avatar current, Avatar target,
			Vector3D collisionPoint, Vector3D collisionNormal);
}

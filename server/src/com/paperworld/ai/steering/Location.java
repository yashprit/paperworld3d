package com.paperworld.ai.steering;

import com.paperworld.core.math.Quaternion;
import com.paperworld.core.math.Vector3;

public class Location {
	
	/**
	 * The position in 3 space.
	 */
	public Vector3 position;

	/**
	 * The orientation, as a euler angle in radians around the
	 * positive y axis (i.e. up) from the positive z axis.
	 */
	public Quaternion orientation;

	/**
	 * Creates a location with the given position and orientation.
	 */
	public Location(Vector3 position, Quaternion orientation)
	{
		this.position = position;
		this.orientation = orientation;
	}
	
	public Location()
	{
		position = new Vector3();
		orientation = new Quaternion();
	}

	/**
	 * Assignment operator.
	 */
	public void copy(Location other)
	{					
		position = other.position;
		orientation = other.orientation;
	}

	/**
	 * Zeros the position and orientation.
	 */
	public void clear()
	{
		position.clear( );
		orientation.clear();
	}

	/**
	 * Checks that the given location is equal to this. Locations
	 * are equal if their positions and orientations are equal.
	 */
	public boolean equals(Location other)
	{
		return position.equals( other.position ) && orientation == other.orientation;
	}

	/**
	 * Perfoms a forward Euler integration of the Kinematic for
	 * the given duration, applying the given steering velocity
	 * and rotation.
	 *
	 * \note All of the integrate methods in this class are designed
	 * to provide a simple mechanism for updating position. They are
	 * not a substitute for a full physics engine that can correctly
	 * resolve collisions and constraints.
	 *
	 * @param steer The velocity to apply over the integration.
	 *
	 * @param duration The number of simulation seconds to
	 * integrate over.
	 */
	public void integrate( SteeringOutput steer, double duration)
	{
	}

	/**
	 * Sets the orientation of this location so it points along
	 * the given velocity vector.
	 */
	public void setOrientationFromVelocity(Vector3 velocity)
	{
		// If we haven't got any velocity, then we can do nothing.
		if (velocity.getSquareMagnitude() > 0) 
		{
			orientation.w = Math.atan2( velocity.x, velocity.z );
		}
	}

	/**
	 * Returns a unit vector in the direction of the current
	 * orientation.
	 */
	public Vector3 getOrientationAsVector()
	{
		return new Vector3( Math.sin( orientation.w ), 0, Math.cos( orientation.w ) );
	}
	
}

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
package com.paperworld.ai.steering 
{
	import com.paperworld.core.BaseClass;
	import com.paperworld.util.math.Vector3;	

	/**
	 * @author Trevor
	 */
	public class Location extends BaseClass
	{
		/**
		 * The position in 3 space.
		 */
		public var position : Vector3;

		/**
		 * The orientation, as a euler angle in radians around the
		 * positive y axis (i.e. up) from the positive z axis.
		 */
		public var orientation : Number;

		/**
		 * Creates a location with the given position and orientation.
		 */
		public function Location(position : Vector3 = null, orientation : Number = NaN)
		{
			this.position = position;
			this.orientation = orientation;
		}

		/**
		 * Assignment operator.
		 */
		override public function copy(other : Location) : void
		{			
			position = other.position;
			orientation = other.orientation;
		}

		/**
		 * Zeros the position and orientation.
		 */
		public function clear() : void
		{
			position.clear( );
			orientation = 0.0;
		}

		/**
		 * Checks that the given location is equal to this. Locations
		 * are equal if their positions and orientations are equal.
		 */
		override public function equals(other : Location) : Boolean
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
		public function integrate( steer : SteeringOutput, duration : Number) : void
		{
		}

		/**
		 * Sets the orientation of this location so it points along
		 * the given velocity vector.
		 */
		public function setOrientationFromVelocity(velocity : Vector3) : void
		{
		}

		/**
		 * Returns a unit vector in the direction of the current
		 * orientation.
		 */
		public function getOrientationAsVector() : Vector3
		{
			return null;
		}
	}
}

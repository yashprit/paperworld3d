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
package com.paperworld.ai.steering.kinematic.behaviours 
{
	import com.paperworld.util.number.RandomUtils;	
	import com.paperworld.ai.steering.SteeringOutput;
	import com.paperworld.ai.steering.kinematic.behaviours.KinematicMovement;	

	/**
	 * @author Trevor
	 */
	public class KinematicWander extends KinematicMovement 
	{
		/**
		 * The maximum rate at which the character can turn.
		 */
		public var maxRotation : Number;

		/**
		 * Works out the desired steering and writes it into the given
		 * steering output structure.
		 */
		override public function getSteering(output : SteeringOutput) : void
		{
			// Move forward in the current direction
			output.linear = character.getOrientationAsVector( );
			output.linear.multiplyEq( maxSpeed );

			// Turn a little
			var change : Number = RandomUtils.randomBinomial( );
			output.angular = change * maxRotation;
		}
	}
}

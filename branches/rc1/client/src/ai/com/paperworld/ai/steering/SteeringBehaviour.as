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
	
	/**
	 * The steering behaviour is the base class for all dynamic
	 * steering behaviours.
	 * 
	 * @author Trevor
	 */
	public class SteeringBehaviour extends BaseClass
	{
		/**
		 * The character who is moving.
		 */
		public var character : Kinematic;

		/**
		 * Works out the desired steering and writes it into the given
		 * steering output structure.
		 */
		public function getSteering(output : SteeringOutput) : void
		{
		}
	}
}

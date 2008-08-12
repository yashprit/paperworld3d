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
package com.paperworld.ai.steering.behaviours 
{
	import com.paperworld.ai.steering.SteeringOutput;
	import com.paperworld.ai.steering.behaviours.Seek;	

	/**
	 * @author Trevor
	 */
	public class Flee extends Seek 
	{
		/**
		 * Works out the desired steering and writes it into the given
		 * steering output structure.
		 */
		override public function getSteering(output : SteeringOutput) : void
		{
		}
	}
}

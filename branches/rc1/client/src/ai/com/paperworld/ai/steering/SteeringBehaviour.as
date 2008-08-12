package com.paperworld.ai.steering 
{

	/**
	 * The steering behaviour is the base class for all dynamic
	 * steering behaviours.
	 * 
	 * @author Trevor
	 */
	public class SteeringBehaviour 
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

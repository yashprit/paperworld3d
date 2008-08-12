package com.paperworld.ai.steering.behaviours 
{
	import com.paperworld.ai.steering.SteeringBehaviour;
	import com.paperworld.ai.steering.SteeringOutput;
	import com.paperworld.util.math.Vector3;	

	/**
	 * @author Trevor
	 */
	public class Seek extends SteeringBehaviour 
	{
		/**
		 * The target may be any vector (i.e. it might be something
		 * that has no orientation, such as a point in space).
		 */
		public var target : Vector3;

		/**
		 * The maximum acceleration that can be used to reach the
		 * target.
		 */
		public var maxAcceleration : Number;

		/**
		 * Works out the desired steering and writes it into the given
		 * steering output structure.
		 */
		override public function getSteering(output : SteeringOutput) : void
		{
		}
	}
}

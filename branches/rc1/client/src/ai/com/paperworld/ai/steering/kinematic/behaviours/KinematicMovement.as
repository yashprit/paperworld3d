package com.paperworld.ai.steering.kinematic.behaviours 
{
	import com.paperworld.ai.steering.Location;
	import com.paperworld.ai.steering.SteeringOutput;	
	
	/**
     * The base class for all kinematic movement behaviours.
     * 
     * @author Trevor
     */
	public class KinematicMovement 
	{
		/**
         * The character who is moving.
         */
        public var character:Location;

        /**
         * The maximum movement speed of the character.
         */
        public var maxSpeed:Number;

        /**
         * Works out the desired steering and writes it into the given
         * steering output structure.
         */
        public function getSteering(output:SteeringOutput):void
        {
        }
		
	}
}

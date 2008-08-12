package com.paperworld.ai.steering.kinematic.behaviours 
{
	import com.paperworld.util.math.Vector3;	
	import com.paperworld.ai.steering.kinematic.behaviours.KinematicMovement;
	
	/**
     * This is a base class that adds a target vector to its parent
     * class definition.
     * 
     * @author Trevor
     */
	public class TargetedKinematicMovement extends KinematicMovement 
	{
		/**
         * The target may be any vector (i.e. it might be something
         * that has no orientation, such as a point in space).
         */
        public var target : Vector3;
	}
}

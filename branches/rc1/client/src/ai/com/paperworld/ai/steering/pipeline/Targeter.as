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
package com.paperworld.ai.steering.pipeline 
{
	import com.paperworld.core.BaseClass;	
	import com.paperworld.ai.steering.Kinematic;	
	
	/**
	 * Generates goals in the form of a kinematic (position,
	 * orientation, velocity and rotation) that can be sought by the
	 * steering system.  This class can be used as is, to specify the
	 * target, or it may be extended to provide more sophisticated
	 * targeting behaviour.  Targeters are intended to work only when
	 * installed in a SteerPipe class.
	 * 
	 * @author Trevor
	 */
	public class Targeter extends BaseClass
	{
		/**
		 * Pointer to the SteerPipe class, where details about the actor and
		 * the goal are stored. This is set by the SteerPipe class when the
		 * targeter is installed.
		 */
		public var steering : SteeringPipeline;

		/**
		 * Pointer to the generated goal. This pointer is returned by
		 * the inline function getGoal.
		 */
		protected var goal : Kinematic;

		/**
		 * Creates a new targeter seeking the given goal.
		 */
		public function Targeter(g : Kinematic)
		{
			goal = g;
		}

		/**
		 * Gets the goal to the given kinematic.
		 */
		public function setGoal(g : Kinematic) : void
		{
			goal = g;
		}

		/**
		 * Gets the current goal for this targeter. For efficiency,
		 * this method is inline and cannot be overloaded. The pointer
		 * stored in this class can be set when the targeter receives
		 * execution time (in the normal manner, through its run
		 * function), or by calling setGoal explicitly.
		 *
		 * @returns The current goal, always the pointer stored in the
		 * goal member.
		 */
		public function getGoal() : Kinematic
		{
			return goal;
		}

		/**
		 * Returns the kinematick of the agent's actor.
		 */
		public function getActor() : Kinematic
		{
			if (!steering) return null;
			return steering.getActor();
		}

		/**
		 * Runs the targeter. The default implementation does nothing,
		 * because the goal is assumed to be explicit.
		 */
		public function run() : void
		{
		}
	}
}

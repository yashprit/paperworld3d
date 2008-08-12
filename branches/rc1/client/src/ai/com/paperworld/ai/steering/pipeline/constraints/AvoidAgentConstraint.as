package com.paperworld.ai.steering.pipeline.constraints 
{
	import com.paperworld.ai.steering.Kinematic;
	import com.paperworld.ai.steering.pipeline.SteeringConstraint;	

	/**
	 * @author Trevor
	 */
	public class AvoidAgentConstraint extends SteeringConstraint 
	{
		/**
		 * Function calculating the suggested goal when a collision is
		 * detected.
		 *
		 * @param actor The position and course from which collisions
		 * were probed.
		 *
		 * @param margin The current safety margin (can be different
		 * from safetyMargin)
		 *
		 * @param tOffset The time offset by which the actor has been
		 * moved before probing.
		 *
		 * The result is written directly to the suggestedGoal member
		 * variable.  The time member variable is not altered. The
		 * caller must set it to the appropriate value before calling
		 * this method.
		 */
		protected function calcResolution(actor : Kinematic, margin : Number,
                                    tOffset : Number = 0) : void
		{
		}

		/**
		 * The agent being avoided. Can be changed freely at runtime.
		 */
		public var agent : Kinematic;

		/**
		 * The minimum distance from the location that the constraint
		 * will tolerate. This parameter can be changed freely at
		 * runtime. The default value is 1.
		 */
		public var safetyMargin : Number;

		/**
		 * Creates a new avoid agent constraint to avoid the given
		 * kinematic.
		 */
		public function AvoidAgentConstraint(agent : Kinematic = null)
		{
			super( );
        	
			this.agent = agent;                
		}

		override public function initialise() : void
		{
			super.initialise( );
        	
			safetyMargin = 1;
		}

		/**
		 * Runs the constraint.
		 */
		override public function run() : void
		{
		}
	}
}

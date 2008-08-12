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
package com.paperworld.ai.steering.pipeline.constraints 
{
	import com.paperworld.ai.steering.Kinematic;	
	
	/**
	 * @author Trevor
	 */
	public class AvoidPredatorConstraint extends AvoidAgentConstraint
	{
        /**
         * See AvoidAgentConstraint::calcResolution().
         */
        override protected function calcResolution(actor : Kinematic, margin : Number,
                                    tOffset : Number = 0) : void
		{
		}

        /**
         * The time which the constraint should look ahead for
         * violations.
         *
         * Any violation which happens further ahead than this time
         * will be ignored. The default value is 1.
         */
        public var lookAheadTime:Number;

        /**
         * Creates a new constraint to avoid the given predator.
         */
        public function AvoidPredatorConstraint(predator:Kinematic = null)
        {
			super( predator );
		}
        
        override public function initialise():void
        {
        	super.initialise();
        	
			lookAheadTime = 1;
		}

        /**
         * Runs the constraint.
         */
        override public function run():void
        {
        }
	}
}

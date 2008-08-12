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
	import com.paperworld.ai.steering.pipeline.constraints.AvoidAgentConstraint;	

	/**
	 * @author Trevor
	 */
	public class AvoidLocationConstraint extends AvoidAgentConstraint 
	{
		/**
         * See AvoidAgentConstraint::calcResolution().
         */
        override protected function calcResolution(actor : Kinematic, margin : Number,
                                    tOffset : Number = 0) : void
		{
		}

        /**
         * Constructor.
         */
        public function AvoidLocationConstraint(location:Kinematic = null)
        {
        	super(location);
        }

        /**
         * Runs the constraint.
         */
        override public function run():void
        {
        }
	}
}

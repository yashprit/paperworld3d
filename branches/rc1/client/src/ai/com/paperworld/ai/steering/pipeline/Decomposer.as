package com.paperworld.ai.steering.pipeline 
{

	/**
	 * @author Trevor
	 */
	public class Decomposer 
	{
		/**
         * Pointer to the SteerPipe class, where details about the actor and
         * the goal are stored. This is set by the SteerPipe class when the
         * decomposer is installed.
         */
        public var steering : SteeringPipeline;

        /**
         * Decomposers can be structured in a list. This points to the
         * next item.
         */
        public var next : Decomposer;

        /**
         * Creates a new decomposer.
         */
        public function Decomposer()
        {
        }

        /**
         * Runs the decomposer.
         */
        public function run():void
        {
        }
	}
}

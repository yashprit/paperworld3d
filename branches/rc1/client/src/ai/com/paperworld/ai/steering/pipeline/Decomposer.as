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
	
	/**
	 * @author Trevor
	 */
	public class Decomposer extends BaseClass
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

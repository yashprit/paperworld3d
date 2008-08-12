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
package com.paperworld.action 
{
	import com.paperworld.action.CompoundAction;

	/**
	 * An action combination is a set of actions that can be performed
	 * at the same time.
	 * 
	 * @author Trevor
	 */
	public class ActionSequence extends CompoundAction 
	{
		/**
		 * Checks if this action can interrupt. The combination can
		 * interrupt if the first action can.
		 */
		override public function get canInterrupt() : Boolean
		{
			if (subActions) return subActions.canInterrupt;
	        else return false;
		}

		/**
		 * Returns true if all the sub-actions are done. Otherwise the
		 * manager keeps scheduling the action.
		 */
		override public function get isComplete() : Boolean
		{
			return subActions == null;
		}

		override public function act() : void
		{
			// Check if we have anything to do
			if (subActions) return;
	
			// Run the first action in the list
			subActions.act( );
	
			// Then consume it if its done
			if (subActions.isComplete) 
			{	
				//var temp : Action = subActions;
				subActions = subActions.next;
			}
		}
	}
}

package com.paperworld.action 
{
	import com.paperworld.action.Action;

	/**
	 * An action combination is a set of actions that can be performed
	 * at the same time.
	 * 
	 * @author Trevor
	 */
	public class CombinationAction extends CompoundAction 
	{
		/**
         * Checks if this action can interrupt. The combination can
         * interrupt if any of its actions can.
         */
		override public function canInterrupt() : Boolean
		{
			var next : Action = subActions;
			
			while (next)
			{
				if (next.canInterrupt) return true;
				next = next.next;
			}
	        
			return false;	
		}

		/**
         * Returns true if all the sub-actions is done. Otherwise the
         * manager keeps scheduling the action.
         */
		override public function get isComplete() : Boolean
		{
			var next : Action = subActions;
	        
			while (next)
			{
				if (!next.isComplete) return false;
				next = next.next;
			}
	        
			return true;
		}
		
		/**
         * Called to make the action do its stuff. It calls all its
         * subactions.
         */
		override public function act() : void
		{
			var next : Action = subActions;
	        
			while (next)
			{
				if (!next.isComplete) next.act( );
				next = next.next;
			}
		}
	}
}

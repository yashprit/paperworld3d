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
	import com.paperworld.action.Action;

	/**
	 *
     * Compund actions are made up of sub-actions. This is a base
     * class that adds the sub-action management code that then has
     * sematics added in its sub-classes.
	 * 
	 * @author Trevor
	 */
	public class CompoundAction extends Action 
	{
		public var subActions : Action;

		/**
		 * Requests that the action delete itself and its children.
		 */
		override public function deleteList() : void
		{
			if (subActions) subActions.deleteList( );
			super.deleteList( );
		}

		/**
		 * Compound actions are compatible, only if all their
		 * components are compatible.
		 */
		override public function canDoBoth(other : Action) : Boolean
		{
			var next : Action = subActions;
	        
			while (next)
			{
				if (!next.canDoBoth( other )) return false;
				next = next.next;
			}
	        
			return true;
		}
	}
}

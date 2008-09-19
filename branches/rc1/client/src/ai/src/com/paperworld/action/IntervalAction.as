package com.paperworld.action 
{
	import com.paperworld.action.Action;
	
	/**
	 * @author Trevor
	 */
	public class IntervalAction extends Action 
	{
		/**
		 * The interval between actions.
		 */
		public var interval : int = 0;

		/**
		 * The time at which last act() occured.
		 */
		protected var lastinterpolationTime : int = 0;

		/**
		 * Current time.
		 */
		public var time : int = 0;
		
		/**
		 * Checks to see if enough time has passed since last action.
		 */
		override public function get canAct():Boolean
		{
			if (lastinterpolationTime + interval > time)
			{
				lastinterpolationTime = time;
				return true;	
			}	
			
			return false;
		}
	}
}

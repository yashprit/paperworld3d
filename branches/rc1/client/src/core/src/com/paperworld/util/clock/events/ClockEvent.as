package com.paperworld.util.clock.events 
{
	import flash.events.Event;

	/**
	 * @author Trevor
	 */
	public class ClockEvent extends Event 
	{
		public static const RENDER : String = "Render";

		public static const TIMESTEP : String = "TimeStep";

		public var time : int;

		public function ClockEvent(type : String, time : int, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super( type, bubbles, cancelable );
			
			this.time = time;
		}
	}
}

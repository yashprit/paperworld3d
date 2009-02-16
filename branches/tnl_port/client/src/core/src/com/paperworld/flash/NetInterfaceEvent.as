package com.paperworld.flash 
{
	import flash.events.Event;
	
	/**
	 * @author Trevor
	 */
	public class NetInterfaceEvent extends Event 
	{
		public static const READY:String = "Ready";
		
		public function NetInterfaceEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super( type, bubbles, cancelable );
		}
	}
}

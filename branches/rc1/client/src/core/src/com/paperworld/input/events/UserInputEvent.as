package com.paperworld.input.events 
{
	import flash.events.Event;
	
	import com.paperworld.input.Input;	

	/**
	 * @author Trevor
	 */
	public class UserInputEvent extends Event 
	{
		public static var INPUT_CHANGED:String = "InputChanged";
		
		public var time:int;
		
		public var input:Input;
		
		public function UserInputEvent(type : String, time:int, input:Input, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super( type, bubbles, cancelable );
			
			this.time = time;
			this.input = input;
		}
	}
}

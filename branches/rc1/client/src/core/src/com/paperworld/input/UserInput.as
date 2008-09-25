package com.paperworld.input 
{
	import flash.display.DisplayObject;
	
	import com.paperworld.util.clock.events.ClockEvent;		

	/**
	 * @author Trevor
	 */
	public interface UserInput 
	{
		function get input() : Input;

		function set displayObject(value : DisplayObject) : void;

		/**
		 * Returns the mouse x position.
		 */
		function get mouseX() : Number 

		/**
		 * Returns the mouse y position.
		 */
		function get mouseY() : Number

		/**
		 * Called by the <code>GameTimer</code>'s integration event.</br>
		 * Takes a snapshot of the user's input.
		 */
		function update( event : ClockEvent = null ) : void 
	}
}

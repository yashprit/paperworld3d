package com.paperworld.input 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import com.paperworld.core.EventDispatchingBaseClass;
	import com.paperworld.input.UserInput;
	import com.paperworld.util.clock.events.ClockEvent;		

	/**
	 * @author Trevor
	 */
	public class AbstractUserInput extends EventDispatchingBaseClass implements UserInput 
	{
		/**
		 * The state of the user's input in the current timestep.
		 */
		public var current : Input;

		/**
		 * The state of the user's input in the previous timestep.
		 */
		public var previous : Input;
		
		/**
		 * Flags whether or not this user's input has changed since the last tick.
		 */
		protected var _hasChanged : Boolean;
		
		protected var _displayObject : DisplayObject;
		
		public function set displayObject(value : DisplayObject):void
		{
			_displayObject = value;
		}

		public function AbstractUserInput()
		{
			super( this );
		}

		override public function initialise() : void
		{
			current = new Input( );
			previous = new Input( );
			
			_hasChanged = false;
		}

		public function get input() : Input
		{
			return current;
		}

		public function update(event : ClockEvent = null) : void
		{
			if (_hasChanged)
			{
				dispatchEvent(new Event( Event.CHANGE ) );
				_hasChanged = false;
			}
		}

		public function get mouseX() : Number
		{
			return 0;
		}

		public function get mouseY() : Number
		{
			return 0;
		}
	}
}

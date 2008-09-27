package com.paperworld.input 
{
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	
	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.core.EventDispatchingBaseClass;
	import com.paperworld.input.UserInput;
	import com.paperworld.input.events.UserInputEvent;
	import com.paperworld.util.clock.Clock;
	import com.paperworld.util.clock.events.ClockEvent;		

	/**
	 * @author Trevor
	 */
	public class AbstractUserInput extends EventDispatchingBaseClass implements UserInput 
	{
		private var logger : XrayLog = new XrayLog( );

		/**
		 * The state of the user's input in the current timestep.
		 */
		public var current : Input;

		/**
		 * The state of the user's input in the previous timestep.
		 */
		public var previous : Input;

		protected var _target : Stage;

		public function set target(value : Stage) : void
		{
			_target = value;
		}

		protected var _commands : Array;

		public function AbstractUserInput()
		{
			super( this );
		}

		override public function initialise() : void
		{
			current = new Input( );
			previous = new Input( );
			
			_commands = new Array( );
			
			Clock.getInstance( ).addEventListener( ClockEvent.TIMESTEP, update );
		}

		public function get input() : Input
		{
			return current;
		}

		public function update(event : ClockEvent = null) : void
		{			
			if (current.notEquals( previous ))
			{
				dispatchEvent( new UserInputEvent( UserInputEvent.INPUT_CHANGED, event.time, current ) );
				
				previous.copyFrom( current );
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

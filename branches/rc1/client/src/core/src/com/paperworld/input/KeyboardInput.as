package com.paperworld.input 
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import com.paperworld.core.patterns.Command;
	import com.paperworld.input.AbstractUserInput;	

	/**
	 * @author Trevor
	 */
	public class KeyboardInput extends AbstractUserInput 
	{
		//private var logger : XrayLog = new XrayLog( );
		
		protected var _keyUpCommands:Array;
		
		protected var _keyDownCommands:Array;

		override public function set target(value : Stage) : void
		{
			super.target = value;
				
			_target.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			_target.addEventListener( KeyboardEvent.KEY_UP, onKeyUp );
		}

		public function KeyboardInput()
		{
			super( );
		}

		override public function initialise() : void
		{
			super.initialise();
			
			_keyUpCommands = new Array();
			_keyDownCommands = new Array();
			
			_commands[0] = _keyUpCommands;
			_commands[1] = _keyDownCommands;	
		}

		public function onClick(event : MouseEvent) : void
		{
		}

		/**
		 * Handles a key being pressed. Updates the <code>InputData</code> object.
		 */
		public function onKeyDown( event : KeyboardEvent ) : void 
		{	
			var command : Command = Command( _keyDownCommands[event.keyCode] );
			
			if (command) command.execute( );
		}

		/**
		 * Handles a key being released. Updates the <code>InputData</code> object.
		 */
		public function onKeyUp( event : KeyboardEvent ) : void 
		{
			var command : Command = Command( _keyUpCommands[event.keyCode] );
			
			if (command) command.execute( );
		}
	}
}

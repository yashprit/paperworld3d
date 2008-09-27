package com.paperworld.input 
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.core.patterns.Command;
	import com.paperworld.input.AbstractUserInput;
	import com.paperworld.util.keys.KeyDefinitions;
	import com.paperworld.util.keys.KeyDownCommand;
	import com.paperworld.util.keys.KeyUpCommand;	

	/**
	 * @author Trevor
	 */
	public class KeyboardInput extends AbstractUserInput 
	{
		private var logger : XrayLog = new XrayLog( );

		/**
		 * Sensitivity of the mouse values. The larger this value is the less angular movement
		 * you'll get with your player's avatar.
		 */
		public var sensitivity : Number = 300;

		public var threshold : Number = 0;
		
		protected var _keyUpCommands:Array;
		
		protected var _keyDownCommands:Array;

		override public function set target(value : Stage) : void
		{
			super.target = value;
				
			_target.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			_target.addEventListener( KeyboardEvent.KEY_UP, onKeyUp );
			_target.addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
			_target.addEventListener( MouseEvent.CLICK, onClick );
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
			
			var keyUpCommand : KeyUpCommand = new KeyUpCommand(this );
			keyUpCommand.property = 'forward';
			
			var keyDownCommand : KeyDownCommand = new KeyDownCommand(this );
			keyDownCommand.property = 'forward';
			
			_keyUpCommands[KeyDefinitions.W] = keyUpCommand;
			_keyDownCommands[KeyDefinitions.W] = keyDownCommand;	
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

		/**
		 * Handles a mouse move. Updates the <code>Input</code> object.
		 */
		public function onMouseMove( event : MouseEvent ) : void
		{						
			var x : Number = ( event.stageX - ( _target.stageWidth / 2 ) ) / sensitivity;
			var y : Number = ( event.stageY - ( _target.stageHeight / 2 ) ) / sensitivity;
			
			var squareDistance : Number = x * x + y * y;
			
			if (squareDistance > threshold)
			{
				current.mouseX = x;
				current.mouseY = y;
			}
		}
	}
}

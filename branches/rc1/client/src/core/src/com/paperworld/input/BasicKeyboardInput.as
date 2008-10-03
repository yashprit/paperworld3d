package com.paperworld.input 
{
	import com.paperworld.input.KeyboardInput;
	import com.paperworld.util.keys.KeyDefinitions;
	import com.paperworld.util.keys.KeyDownCommand;
	import com.paperworld.util.keys.KeyUpCommand;	

	/**
	 * @author Trevor
	 */
	public class BasicKeyboardInput extends KeyboardInput 
	{
		public function BasicKeyboardInput()
		{
			super( );
		}
		
		override public function initialise():void
		{
			super.initialise();
			
			// Handle Forward Key Press - mapped to 'w' key.
			var forwardKeyUpCommand : KeyUpCommand = new KeyUpCommand(this );
			forwardKeyUpCommand.property = 'forward';
			
			var forwardKeyDownCommand : KeyDownCommand = new KeyDownCommand(this );
			forwardKeyDownCommand.property = 'forward';
			
			_keyUpCommands[KeyDefinitions.W] = forwardKeyUpCommand;
			_keyDownCommands[KeyDefinitions.W] = forwardKeyDownCommand;
			
			// Handle Back Key Press - mapped to 's' key.
			var backKeyUpCommand : KeyUpCommand = new KeyUpCommand(this );
			backKeyUpCommand.property = 'back';
			
			var backKeyDownCommand : KeyDownCommand = new KeyDownCommand(this );
			backKeyDownCommand.property = 'back';
			
			_keyUpCommands[KeyDefinitions.S] = backKeyUpCommand;
			_keyDownCommands[KeyDefinitions.S] = backKeyDownCommand;
			
			// Handle Right Key Press - mapped to 'd' key.
			var rightKeyUpCommand : KeyUpCommand = new KeyUpCommand(this );
			rightKeyUpCommand.property = 'moveRight';
			
			var rightKeyDownCommand : KeyDownCommand = new KeyDownCommand(this );
			rightKeyDownCommand.property = 'moveRight';
			
			_keyUpCommands[KeyDefinitions.D] = rightKeyUpCommand;
			_keyDownCommands[KeyDefinitions.D] = rightKeyDownCommand;
			
			// Handle Left Key Press - mapped to 'a' key.
			var leftKeyUpCommand : KeyUpCommand = new KeyUpCommand(this );
			leftKeyUpCommand.property = 'moveLeft';
			
			var leftKeyDownCommand : KeyDownCommand = new KeyDownCommand(this );
			leftKeyDownCommand.property = 'moveLeft';
			
			_keyUpCommands[KeyDefinitions.A] = leftKeyUpCommand;
			_keyDownCommands[KeyDefinitions.A] = leftKeyDownCommand;
		}
	}
}

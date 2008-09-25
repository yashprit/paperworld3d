package com.paperworld.input 
{
	import flash.display.DisplayObject;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import com.paperworld.input.AbstractUserInput;
	import com.paperworld.util.keys.KeyDefinitions;		

	/**
	 * @author Trevor
	 */
	public class KeyboardInput extends AbstractUserInput 
	{
		/**
		 * Sensitivity of the mouse values. The larger this value is the less angular movement
		 * you'll get with your player's avatar.
		 */
		public var sensitivity : Number = 300;

		public var threshold : Number = 0;

		public function KeyboardInput()
		{
			super( );
		}
		
		/**
		 * Handles a key being pressed. Updates the <code>InputData</code> object.
		 */
		public function onKeyDown( event : KeyboardEvent ) : void 
		{			
			switch ( event.keyCode )
			{
				case KeyDefinitions.LEFT_ARROW:
					current.moveLeft = true;
					break;
	
				case KeyDefinitions.RIGHT_ARROW:
					current.moveRight = true;
					break;
	
				case KeyDefinitions.UP_ARROW:
					current.forward = true;
					break;
	
				case KeyDefinitions.DOWN_ARROW:
					current.back = true;
					break;
			}
		}
		
		/**
		 * Handles a key being released. Updates the <code>InputData</code> object.
		 */
		public function onKeyUp( event : KeyboardEvent ) : void 
		{						
			switch ( event.keyCode )
			{
				case KeyDefinitions.LEFT_ARROW:
					current.moveLeft = false;
					break;
	
				case KeyDefinitions.RIGHT_ARROW:
					current.moveRight = false;
					break;
	
				case KeyDefinitions.UP_ARROW:
					current.forward = false;
					break;
	
				case KeyDefinitions.DOWN_ARROW:
					current.back = false;
					break;
			}
		}
		
		/**
		 * Handles a mouse move. Updates the <code>Input</code> object.
		 */
		public function onMouseMove( event : MouseEvent ) : void
		{			
			var x : Number = ( event.stageX - ( _displayObject.width / 2 ) ) / sensitivity;
			var y : Number = ( event.stageY - ( _displayObject.height / 2 ) ) / sensitivity;
			
			var squareDistance : Number = x * x + y * y;
			
			if (squareDistance > threshold)
			{
				current.mouseX = x;
				current.mouseY = y;
				
				_hasChanged = true;
			}
		}
	}
}

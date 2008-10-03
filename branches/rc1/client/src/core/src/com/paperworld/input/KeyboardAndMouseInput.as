package com.paperworld.input 
{
	import flash.display.Stage;
	import flash.events.MouseEvent;
	
	import com.paperworld.input.KeyboardInput;	

	/**
	 * @author Trevor
	 */
	public class KeyboardAndMouseInput extends KeyboardInput 
	{
		/**
		 * Sensitivity of the mouse values. The larger this value is the less angular movement
		 * you'll get with your player's avatar.
		 */
		public var sensitivity : Number = 300;

		public var threshold : Number = 0;
		
		override public function set target(value : Stage) : void
		{
			super.target = value;
			
			_target.addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
			_target.addEventListener( MouseEvent.CLICK, onClick );
		}
		
		public function KeyboardAndMouseInput()
		{
			super( );
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

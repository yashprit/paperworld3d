package com.paperworld.multiplayer.behaviours 
{
	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.input.Input;
	import com.paperworld.multiplayer.data.State;	

	/**
	 * @author Trevor
	 */
	public class SimpleAvatarBehaviour2D implements AvatarBehaviour 
	{
		private var logger : XrayLog = new XrayLog( );

		public function update(input : Input, state : State) : void
		{
			if (input.forward) state.position.z += 5;
			if (input.back) state.position.z -= 5;
			if (input.moveRight) state.position.x += 5;
			if (input.moveLeft) state.position.x -= 5;
			
			if (input.turnRight) state.orientation.w += 1;
			if (input.turnLeft) state.orientation.w -= 1;
		}
	}
}

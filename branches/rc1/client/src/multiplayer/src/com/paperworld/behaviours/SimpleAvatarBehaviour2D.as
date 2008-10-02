package com.paperworld.behaviours 
{
	import com.paperworld.behaviours.AvatarBehaviour;
	import com.paperworld.data.State;
	import com.paperworld.input.Input;
	import com.paperworld.util.Synchronizable;	

	/**
	 * @author Trevor
	 */
	public class SimpleAvatarBehaviour2D implements AvatarBehaviour 
	{
		public function update(input : Input, state : State, syncObject : Synchronizable) : void
		{
			if (input.forward)
			{
				state.position.z += 5;
			}	
			
			if (input.moveRight) state.position.x += 5;
			if (input.moveLeft) state.position.x -= 5;
		}
	}
}

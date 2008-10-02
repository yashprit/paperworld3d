package com.paperworld.multiplayer.behaviours 
{
	import com.paperworld.input.Input;
	import com.paperworld.multiplayer.data.State;	

	/**
	 * @author Trevor
	 */
	public interface AvatarBehaviour 
	{
		function update(input : Input, state : State) : void;
	}
}

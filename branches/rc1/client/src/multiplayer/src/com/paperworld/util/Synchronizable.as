package com.paperworld.util
{
	import com.paperworld.core.interfaces.Destroyable;
	import com.paperworld.multiplayer.data.State;	

	/**
	 * @author Trevor
	 */
	public interface Synchronizable extends Destroyable
	{
		function synchronise(state : State) : void
	}
}

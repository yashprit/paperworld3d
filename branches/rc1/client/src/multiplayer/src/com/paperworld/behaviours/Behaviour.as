package com.paperworld.behaviours 
{
	import com.paperworld.data.Input;
	import com.paperworld.data.State;
	import com.paperworld.util.Synchronizable;		

	/**
	 * @author Trevor
	 */
	public interface Behaviour 
	{
		function update(input : Input, state : State, syncObject : Synchronizable) : void;
	}
}

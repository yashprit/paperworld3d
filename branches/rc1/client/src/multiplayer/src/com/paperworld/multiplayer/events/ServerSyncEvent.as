package com.paperworld.multiplayer.events 
{
	import com.paperworld.core.BaseClass;
	import com.paperworld.input.Input;
	import com.paperworld.multiplayer.data.State;	

	/**
	 * @author Trevor
	 */
	public class ServerSyncEvent extends BaseClass 
	{
		public var t : int;

		public var input : Input;

		public var state : State;

		public function ServerSyncEvent()
		{
			super( );
		}

		public function getT() : int
		{
			return t;
		}

		public function setT(t : int) : void
		{
			this.t = t;
		}

		public function getInput() : Input
		{
			return input;	
		}

		public function setInput(input : Input) : void
		{	
			this.input = input;
		}

		public function getState() : State
		{
			return state;	
		}

		public function setState(state : State) : void
		{
			this.state = state;	
		}
	}
}

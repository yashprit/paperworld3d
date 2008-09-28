package com.paperworld.objects 
{
	import com.paperworld.data.State;
	import com.paperworld.input.Input;
	import com.paperworld.objects.SyncObject;	

	/**
	 * @author Trevor
	 */
	public class Proxy extends SyncObject 
	{
		protected var _lastSyncTime : int;

		public var updating : Boolean;

		public function Proxy()
		{
		}

		override public function initialise() : void
		{
			_lastSyncTime = 0;
			updating = false;	
		}

		override public function synchronise(t : int, state : State, input : Input) : void
		{
			if (t < _lastSyncTime)
            	return;

			_lastSyncTime = t;
			updating = true;
	
			// set proxy input	
			this.input = Input( input.clone( ) );
	
	        // correct if significantly different
	
	        /*if (state.compare(cube.state()))
	        {
	            cube.snap(state);
	            smooth();
	        }*/
		}

		override public function update(t : int) : void
		{
			if (updating)
          		super.update( t );
		}
	}
}

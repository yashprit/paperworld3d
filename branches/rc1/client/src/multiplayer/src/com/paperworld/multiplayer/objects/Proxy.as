package com.paperworld.multiplayer.objects 
{
	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.input.Input;
	import com.paperworld.multiplayer.data.State;	

	/**
	 * @author Trevor
	 */
	public class Proxy extends SyncObject 
	{
		protected var _lastSyncTime : int;

		public var updating : Boolean;

		private var logger : XrayLog = new XrayLog( );

		public function Proxy()
		{
			super();
		}

		override public function initialise() : void
		{
			_lastSyncTime = 0;
			updating = false;	
		}

		override public function synchronise(t : int, state : State, input : Input) : void
		{
			//logger.info( "synchronising proxy" );
			
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

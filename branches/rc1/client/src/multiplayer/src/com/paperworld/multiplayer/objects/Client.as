package com.paperworld.multiplayer.objects 
{
	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.input.Input;
	import com.paperworld.multiplayer.data.State;
	import com.paperworld.util.History;
	import com.paperworld.util.Move;
	import com.paperworld.util.Synchronizable;	

	/**
	 * @author Trevor
	 */
	public class Client extends SyncObject 
	{
		protected var _history : History;

		public var syncObject : Synchronizable;

		

		private var logger : XrayLog = new XrayLog( );

		public function Client()
		{
			super( );
		}

		override public function initialise() : void
		{
			super.initialise( );
			
			_history = new History( );
		}

		override public function update(t : int) : void
		{						
			// add to history
			var move : Move = new Move( );
			move.time = t;
			move.input = input.clone();
			move.state = state.clone();

			_history.add( move );
			
			syncObject.synchronise( state );

			// update scene
			super.update( t );
			
			
		}

		override public function synchronise(t : int, state : State, input : Input) : void
		{
			//logger.info("synchronising client");
			//var original:State = cube.state();

			//_history.correction( this, t, state, input );
			
			

       		//if (original.compare(cube.state()))
            // smooth();
		}
	}
}

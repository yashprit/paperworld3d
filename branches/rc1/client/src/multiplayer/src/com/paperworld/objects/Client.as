package com.paperworld.objects 
{
	import com.paperworld.data.State;
	import com.paperworld.input.Input;
	import com.paperworld.objects.SyncObject;
	import com.paperworld.util.History;
	import com.paperworld.util.Move;	

	/**
	 * @author Trevor
	 */
	public class Client extends SyncObject 
	{
		protected var _history : History;

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
			move.input = input;
			//move.state = cube.state();

			_history.add( move );

			// update scene
			super.update( t );
		}

		override public function synchronise(t : int, state : State, input : Input) : void
		{
			//var original:State = cube.state();

			//_history.correction( this, t, state, input );

       		//if (original.compare(cube.state()))
            // smooth();
		}
	}
}

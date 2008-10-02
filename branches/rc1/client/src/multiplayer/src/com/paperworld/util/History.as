package com.paperworld.util 
{
	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.core.BaseClass;
	import com.paperworld.input.Input;
	import com.paperworld.multiplayer.data.State;
	import com.paperworld.multiplayer.objects.SyncObject;	

	/**
	 * @author Trevor
	 */
	public class History extends BaseClass
	{
		public var moves : CircularBuffer;

		public var importantMoves : CircularBuffer;

		private var logger : XrayLog = new XrayLog( );

		public function History(size : int = 1000)
		{
			super( );
			
			moves.resize( size );
			importantMoves.resize( size );
		}

		override public function initialise() : void
		{
			moves = new CircularBuffer( );
			importantMoves = new CircularBuffer( );	
		}

		override public function destroy() : void
		{
		}

		public function add(move : Move) : void
		{	
			// determine if important move

			var important : Boolean = true;
	
			if (!moves.empty( ))
			{
				var previous : Move = moves.newest( );

				important = move.input.notEquivalentTo( previous.input );
			}
	
			if (important)
	            importantMoves.add( move );
	
			// add move to history

			moves.add( move );
		}

		public function correction(syncObject : SyncObject, t : int, state : State, input : Input) : void
		{
			// discard out of date important moves 
			if (importantMoves.oldest( ))
			{
				//while (importantMoves.oldest( ).time < t && !importantMoves.empty( ))
	            	//importantMoves.remove( );
			}
	
			// discard out of date moves
			if (moves.oldest( ))
			{
				while (moves.oldest( ).time < t && !moves.empty( ))
	           		moves.remove( );
			}
			
			if (moves.empty( ))
	            return;
	
			// compare correction state with move history state
			if (state.notEquals( moves.oldest( ).state ))
			{
				// discard corrected move

				moves.remove( );
	
				// save current scene data

				//var	savedTime : int = syncObject.time;
				var	savedInput : Input = Input( syncObject.input.clone( ) );
	
				// rewind to correction and replay moves

				syncObject.time = t;
				syncObject.input = input;
				syncObject.snap( state );
	
				syncObject.replaying = true;
	
				var i : int = moves.tail;
	
				while (i != moves.head)
				{
					var next:Move = Move(moves.moves[i]);
					
					if (next)
					{
						while (syncObject.time < moves.moves[i].time)
						{
							syncObject.update( syncObject.time );
						}
					
						syncObject.input = moves.moves[i].input;
						moves.moves[i].state = syncObject.state;
					}
					
					i++;
					if (i > 1000) i = 0;
				}
	
				syncObject.update( syncObject.time );
	            
				syncObject.replaying = false;
	
				// restore saved input

				syncObject.input = savedInput;
			}
		}

		public function importantMoveArray(array : Array) : void
		{
			var size : int = importantMoves.size;
	
			array = new Array( size );
	
			var i : int = importantMoves.tail;
	
			for (var j : int = 0; j < size ; j++)
			{
				array[j] = importantMoves[i];
				importantMoves.next( i );
			}
		}
	}
}

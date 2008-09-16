package com.paperworld.util 
{
	import com.paperworld.core.BaseClass;
	import com.paperworld.data.Input;
	import com.paperworld.data.State;
	import com.paperworld.objects.SyncObject;		
	/**
	 * @author Trevor
	 */
	public class History extends BaseClass
	{
		public var moves : CircularBuffer;

		public var importantMoves : CircularBuffer;

		public function History(size : int = 1000)
		{
			moves.resize( size );
			importantMoves.resize( size );
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

			while (importantMoves.oldest( ).time < t && !importantMoves.empty( ))
	            importantMoves.remove( );
	
			// discard out of date moves

			while (moves.oldest( ).time < t && !moves.empty( ))
	            moves.remove( );
	        
			if (moves.empty( ))
	            return;
	
			// compare correction state with move history state

			if (state.notEquals( moves.oldest( ).state ))
			{
				// discard corrected move

				moves.remove( );
	
				// save current scene data

				//var	savedTime : int = syncObject.time;
				var	savedInput : Input = Input(syncObject.input.clone());
	
				// rewind to correction and replay moves

				syncObject.time = t;
				syncObject.input = input;
				syncObject.snap( state );
	
				syncObject.replaying = true;
	
				var i : int = moves.tail;
	
				while (i != moves.head)
				{
					while (syncObject.time < moves[i].time)
					{
						syncObject.update( syncObject.time );
					}
					
					syncObject.input = moves[i].input;
					moves[i].state = syncObject.state;
					moves.next( i );
				}
	
				syncObject.update( syncObject.time );
	            
				syncObject.replaying = false;
	
				// restore saved input

				syncObject.input = savedInput;
			}
		}
	}
}

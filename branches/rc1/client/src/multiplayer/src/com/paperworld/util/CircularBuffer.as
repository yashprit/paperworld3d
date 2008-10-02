package com.paperworld.util 
{
	import org.pranaframework.utils.Assert;

	import com.paperworld.core.BaseClass;		

	/**
	 * @author Trevor
	 */
	public class CircularBuffer extends BaseClass
	{
		public var head : int;

		public var tail : int;

		public var index : int;

		public var moves : Array;

		public function CircularBuffer()
		{
			super( );
		}

		override public function initialise() : void
		{
			head = 0;
			tail = 0;
			index = 0;
			moves = new Array( );	
		}

		public function resize(size : int) : void
		{
			head = 0;
			tail = 0;
			moves = new Array( size );
		}

		public function get size() : int
		{
			var count : int = head - tail;
			
			if (count < 0) count += moves.length;
                
			return count;
		}

		public function add(move : Move) : void
		{
			moves[head] = move;

			head++;
			if (head >= moves.length) 
                head -= moves.length;
		}

		public function remove() : void
		{
			Assert.state( !empty( ), "Expecting CircularBuffer to contain Moves." );

			tail++;
			if (tail >= moves.length) 
                tail -= moves.length;
		}

		public function oldest() : Move
		{
			//Assert.state( !empty( ), "Expecting CircularBuffer to contain Moves." );
			return moves[tail];
		}

		public function newest() : Move
		{
			Assert.state( !empty( ), "Expecting CircularBuffer to contain Moves." );
			var index : int = head - 1;
			if (index == -1)
                index = moves.length - 1;
			return moves[index];
		}

		public function empty() : Boolean
		{
			return head == tail;
		}

		public function next(index : int) : void
		{
			index++;
			if (index >= moves.length) 
                index -= moves.length;
		}

		public function previous(index : int) : void
		{
			index--;
			if (index < 0)
                index += moves.length;
		}

		public function toString() : String
		{
			return 'CBuffer[size = ' + size + ']';
		}
	}
}

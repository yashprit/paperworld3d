/**
 * Copyright (c) Michael Baczynski 2007
 * http://lab.polygonal.de/ds/
 *
 * This software is distributed under licence. Use of this software
 * implies agreement with all terms and conditions of the accompanying
 * software licence.
 */
package de.polygonal.ds
{
	import de.polygonal.ds.DLinkedList;
	
	/**
	 * A linked stack.
	 * <p>A stack is a LIFO structure (Last In, First Out)</p>.
	 */
	public class LinkedStack
	{
		private var _list:DLinkedList;
		
		/**
		 * Initializes a linked stack.
		 * You can pass an existing doubly linked list
		 * to provide stack-like access.
		 * 
		 * @param list An existing list to use as a stack.
		 */
		public function LinkedStack(list:DLinkedList = null)
		{
			if (list == null)
				_list = new DLinkedList();
			else
				_list = list;
		}

		/**
		 * The total number of items in the stack.
		 */
		public function get size():int
		{
			return _list.size;
		}

		/**
		 * Indicates the top item.
		 *
		 * @return The top item.
		 */
		public function peek():*
		{
			if (_list.size > 0)
				return _list.tail.data;
			else
				return null;
		}

		/**
		 * Pushes data onto the stack.
		 * 
		 * @param obj The data to insert.
		 */
		public function push(obj:*):void
		{
			_list.append(obj);
		}

		/**
		 * Pops data off the stack.
		 * 
		 * @return A reference to the top item
		 *         or null if the stack is empty.
		 */
		public function pop():*
		{
			var o:* = null;
			if (_list.size > 0)
				o = _list.tail.data;
			_list.removeTail();
			return o;
		}

		/**
		 * Returns a string representing the current object.
		 */
		public function toString():String
		{
			return "[LinkedStack > " + _list + "]";
		}
		
		/**
		 * Prints out all elements in the stack (for debug/demo purposes).
		 */
		public function dump():String
		{
			return "LinkedStack:\n" + _list.dump();
		}
	}
}
package com.paperworld.core 
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import com.paperworld.core.interfaces.*;	
	/**
	 * @author Trevor
	 */
	public class EventDispatchingBaseClass extends EventDispatcher implements Cloneable, Comparable, Copyable, Destroyable, Equalable, Initialisable
	{
		public function EventDispatchingBaseClass(target : IEventDispatcher = null)
		{
			super( target );
		}
		
		public function clone() : Cloneable
		{
			return null;
		}
		
		public function compare(other : Comparable) : Boolean
		{
			return false;
		}
		
		public function copy(other : Copyable) : void
		{
		}
		
		public function destroy() : void
		{
		}
		
		public function equals(other : Equalable) : Boolean
		{
			return false;
		}
		
		public function notEquals(other : Equalable) : Boolean
		{
			return false;
		}
		
		public function initialise() : void
		{
		}
	}
}

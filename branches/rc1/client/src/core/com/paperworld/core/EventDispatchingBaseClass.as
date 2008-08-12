package com.paperworld.core 
{
	import flash.events.EventDispatcher;	

	/**
	 * @author Trevor
	 */
	public class EventDispatchingBaseClass extends EventDispatcher implements BaseInterface
	{
		public function EventDispatchingBaseClass()
		{
			super( );
			
			initialise( );
		}

		public function initialise() : void
		{
		}

		public function destroy() : void
		{
		}

		public function clone() : BaseInterface
		{
			return null;
		}

		public function equals(other : BaseInterface) : Boolean
		{
			return false;
		}

		public function notEquals(other : BaseInterface) : Boolean
		{
			return !( this.equals( other ) );
		}
	}
}

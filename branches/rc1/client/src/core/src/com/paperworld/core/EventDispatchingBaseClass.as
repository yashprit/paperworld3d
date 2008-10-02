package com.paperworld.core 
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	import com.paperworld.core.interfaces.*;	

	/**
	 * @author Trevor
	 */
	public class EventDispatchingBaseClass extends EventDispatcher implements Destroyable, Initialisable
	{
		public function EventDispatchingBaseClass(target : IEventDispatcher = null)
		{
			super( target );
			
			initialise( );
		}

		public function destroy() : void
		{
		}

		public function initialise() : void
		{
		}
	}
}

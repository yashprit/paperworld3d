package com.paperworld.bootstrapper 
{
	import flash.display.Sprite;
	import flash.events.Event;

	import org.pranaframework.context.support.XMLApplicationContext;	

	/**
	 * @author Trevor
	 */
	public class Bootstrapper extends Sprite
	{
		private static const MAIN_CLASS_KEY : String = "main.class";

		private var _applicationContext : XMLApplicationContext;

		public function Bootstrapper()
		{
			initialise( );
		}

		private function initialise() : void
		{
			_applicationContext = new XMLApplicationContext( "rootContext.xml" );
			_applicationContext.addEventListener( Event.COMPLETE, onContextLoaded );
			_applicationContext.load( );	
		}

		private function onContextLoaded(event : Event) : void
		{
			_applicationContext.getObject( MAIN_CLASS_KEY, [ loaderInfo.parameters ] );
		}
	}
}

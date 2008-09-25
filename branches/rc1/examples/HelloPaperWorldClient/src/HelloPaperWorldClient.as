package  
{
	import flash.net.Responder;	
	import flash.display.Sprite;
	import flash.events.Event;

	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.multiplayer.events.SynchronisedSceneEvent;
	import com.paperworld.scenes.SynchronisedScene;
	import com.paperworld.util.math.Vector3;
	
	import flash.net.registerClassAlias;		

	/**
	 * @author Trevor
	 */
	public class HelloPaperWorldClient extends Sprite 
	{
		private var logger : XrayLog = new XrayLog( );

		private var scene : SynchronisedScene;

		public function HelloPaperWorldClient()
		{			
			logger.info( "HelloPaperWorldClient" );
			
			scene = new SynchronisedScene( );
			scene.addEventListener( SynchronisedSceneEvent.CONTEXT_LOADED, onContextLoaded );
			scene.addEventListener( SynchronisedSceneEvent.CONNECTED_TO_SERVER, onConnectedToServer );
			scene.connect( "test", "applicationContext.xml" );
			
			registerClassAlias( 'com.paperworld.core.math.Vector3', Vector3 );
		}

		public function onContextLoaded(event : Event) : void 
		{
			logger.info( "Context Loaded" );
		}

		public function onConnectedToServer(event : Event) : void
		{
			logger.info( "\nConnected To Server" );
			
			var responder : Responder = new Responder( onResult, onStatus );
			scene.connection.call( 'multiplayer.echo', responder, new Vector3(1, 2, 3 ) );
		}

		private function onResult(event : Object) : void
		{
			logger.info( "result: " + event );
		}

		private function onStatus(event : Object) : void
		{
			for (var i:String in event)
			{
				logger.info( i + " = " + event[i] );
			}
		}
	}
}

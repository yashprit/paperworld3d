package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.Responder;
	import flash.net.registerClassAlias;
	
	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.input.Input;
	import com.paperworld.multiplayer.events.SynchronisedSceneEvent;
	import com.paperworld.multiplayer.player.Player;
	import com.paperworld.scenes.SynchronisedScene;	

	/**
	 * @author Trevor
	 */
	public class HelloPaperWorldClient extends Sprite 
	{
		private var logger : XrayLog = new XrayLog( );

		private var scene : SynchronisedScene;

		private var player : Player;

		public function HelloPaperWorldClient()
		{			
			logger.info( "HelloPaperWorldClient" );
			
			scene = new SynchronisedScene( );
			scene.addEventListener( SynchronisedSceneEvent.CONTEXT_LOADED, onContextLoaded );
			scene.addEventListener( SynchronisedSceneEvent.CONNECTED_TO_SERVER, onConnectedToServer );
			scene.connect( "test", "applicationContext.xml" );
			
			player = new Player( );
			
			scene.addPlayer( player );
			
			//registerClassAlias( 'com.paperworld.core.math.Vector3', Vector3 );
			//registerClassAlias( 'com.paperworld.core.math.Quaternion', Quaternion );
			//registerClassAlias( 'com.paperworld.multiplayer.data.Input', Input );
			//registerClassAlias( 'com.paperworld.multiplayer.data.TestState', TestState );
			registerClassAlias( 'com.paperworld.multiplayer.data.Input', Input );
			registerClassAlias('org.red5.core.MyClass', MyClass );
		}

		public function onContextLoaded(event : Event) : void 
		{
			logger.info( "Context Loaded connecting" );
		}

		public function onConnectedToServer(event : Event) : void
		{
			logger.info( "Connected To Server" );
			
			var responder : Responder = new Responder( onResult, onStatus );
			scene.connection.call( 'multiplayer.receiveInput', responder, "0", 99, new Input() );
			scene.connection.call( 'multiplayer.receiveInput', responder, "1", 100, new MyClass( ) );
			scene.connection.call( 'getMyObject', responder, new MyClass( ) );
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

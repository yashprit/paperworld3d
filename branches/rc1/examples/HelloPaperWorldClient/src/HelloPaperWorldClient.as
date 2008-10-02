package  
{
	import com.paperworld.data.State;	
	import com.paperworld.multiplayer.events.ServerSyncEvent;	
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.registerClassAlias;
	
	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.input.Input;
	import com.paperworld.input.KeyboardInput;
	import com.paperworld.input.UserInput;
	import com.paperworld.multiplayer.events.SynchronisedSceneEvent;
	import com.paperworld.multiplayer.player.Player;
	import com.paperworld.scenes.SynchronisedScene;
	import com.paperworld.util.clock.Clock;		

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
			
			var input : UserInput = new KeyboardInput( );
			input.target = stage;
			
			player.input = input;
			
			scene.addPlayer( player );
			
			registerClassAlias( 'com.paperworld.multiplayer.data.Input', Input );
			registerClassAlias('com.paperworld.multiplayer.events.SyncEvent', ServerSyncEvent );
			registerClassAlias('com.paperworld.multiplayer.data.State', State );
		}

		public function onContextLoaded(event : Event) : void 
		{
			logger.info( "Context Loaded connecting" );
		}

		public function onConnectedToServer(event : Event) : void
		{
			logger.info( "Connected To Server" );
						
			Clock.getInstance( ).start( );
		}
	}
}

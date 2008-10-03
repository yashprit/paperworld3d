package  
{
	import com.paperworld.input.BasicKeyboardInput;	
	import com.paperworld.util.math.Vector3;	

	import flash.events.Event;
	import flash.net.registerClassAlias;

	import org.papervision3d.objects.primitives.Plane;
	import org.papervision3d.view.BasicView;

	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.input.Input;
	import com.paperworld.input.KeyboardInput;
	import com.paperworld.input.UserInput;
	import com.paperworld.multiplayer.behaviours.SimpleAvatarBehaviour2D;
	import com.paperworld.multiplayer.data.State;
	import com.paperworld.multiplayer.events.ServerSyncEvent;
	import com.paperworld.multiplayer.events.SynchronisedSceneEvent;
	import com.paperworld.multiplayer.objects.SynchronisableObject;
	import com.paperworld.multiplayer.player.Player;
	import com.paperworld.multiplayer.scenes.SynchronisedScene;
	import com.paperworld.util.clock.Clock;
	import com.paperworld.util.clock.events.ClockEvent;	

	/**
	 * @author Trevor
	 */
	public class HelloPaperWorldClient extends BasicView 
	{
		private var logger : XrayLog = new XrayLog( );

		private var syncScene : SynchronisedScene;

		private var player : Player;

		public function HelloPaperWorldClient()
		{			
			logger.info( "HelloPaperWorldClient" );
			
			syncScene = new SynchronisedScene( );
			syncScene.addEventListener( SynchronisedSceneEvent.CONTEXT_LOADED, onContextLoaded );
			syncScene.addEventListener( SynchronisedSceneEvent.CONNECTED_TO_SERVER, onConnectedToServer );
			syncScene.connect( "test", "applicationContext.xml" );
			
			player = new Player( );
			
			var input : UserInput = new BasicKeyboardInput( );
			input.target = stage;
			
			var object : SynchronisableObject = new SynchronisableObject( new Plane( null, 100, 100 ) );
			
			syncScene.addRemoteChild( object );
			
			player.input = input;
			player.avatar.syncObject = object;
			player.avatar.behaviour = new SimpleAvatarBehaviour2D( );
			syncScene.addPlayer( player );
			
			scene = syncScene.scene;
			
			registerClassAlias( 'com.paperworld.multiplayer.data.Input', Input );
			registerClassAlias( 'com.paperworld.multiplayer.events.SyncEvent', ServerSyncEvent );
			registerClassAlias( 'com.paperworld.multiplayer.data.State', State );
			registerClassAlias( 'com.paperworld.core.math.Vector3', Vector3 );
		}

		public function onContextLoaded(event : Event) : void 
		{
			logger.info( "Context Loaded connecting" );
		}

		public function onConnectedToServer(event : Event) : void
		{
			logger.info( "Connected To Server" );
						
			var clock : Clock = Clock.getInstance( );
						
			clock.addEventListener( ClockEvent.RENDER, onRenderTick );
						
			clock.start( );
		}
	}
}

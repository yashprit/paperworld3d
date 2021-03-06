package com.paperworld.examples.loadtest 
{
	import com.actionengine.flash.core.context.CoreContext;
	import com.actionengine.flash.input.BasicKeyboardInput;
	import com.actionengine.flash.util.clock.Clock;
	import com.actionengine.flash.util.clock.events.ClockEvent;
	import com.actionengine.flash.util.logging.Logger;
	import com.actionengine.flash.util.logging.LoggerContext;
	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.flash.behaviours.SimpleAvatarBehaviour25D;
	import com.paperworld.flash.factory.RemoteAndLocalAvatarFactory;
	import com.paperworld.flash.objects.LocalAvatar;
	import com.paperworld.flash.objects.RemoteAvatar;
	import com.paperworld.flash.player.Player;
	import com.paperworld.flash.scenes.RTMPEventTypes;
	import com.paperworld.pv3d.scenes.SynchronisedScene;
	import com.paperworld.pv3d.views.ChequerBoardView;

	import flash.events.Event;	

	/**
	 * @author Trevor
	 */
	public class LoadTestClient extends ChequerBoardView 
	{		
		private var logger : Logger;

		private var player : Player;

		public function LoadTestClient()
		{			
			super( );
			
			var classes : Array = [ ColouredCube, SimpleAvatarBehaviour25D, LocalAvatar, RemoteAvatar, XrayLog ];
			
			var context : CoreContext = CoreContext.getInstance( );
			
			context.addContexts( [ 'logging-context.xml', 'multiplayer-context.xml', 'connection-context.xml' ] );
			context.addEventListener( Event.COMPLETE, onContextLoaded );
			context.load( );			
		}

		private function onContextLoaded(event : Event) : void 
		{
			logger = LoggerContext.getLogger( LoadTestClient );
			
			initialise( );
		}

		override public function initialise(...args) : void
		{			
			logger.info( "initialising" );
			
			super.initialise( );
			
			syncScene = new SynchronisedScene( scene );
			syncScene.userInput = new BasicKeyboardInput( stage );
			syncScene.avatarFactory = new RemoteAndLocalAvatarFactory( );
			syncScene.addEventListener( RTMPEventTypes.CONNECTED_TO_SERVER, onConnectedToServer );
			syncScene.connect( "test" );
			
			player = new Player( );			
		}

		public function onConnectedToServer(event : Event) : void
		{
			logger.info( "Connected To Server" );
						
			syncScene.addPlayer( player );
						
			var clock : Clock = Clock.getInstance( );
						
			clock.addEventListener( ClockEvent.RENDER, onRenderTick );
	
			clock.start( );
		}
	}
}

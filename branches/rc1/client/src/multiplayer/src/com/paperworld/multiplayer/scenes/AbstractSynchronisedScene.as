package com.paperworld.multiplayer.scenes 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.SyncEvent;
	
	import org.pranaframework.context.support.XMLApplicationContext;
	
	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.action.Action;
	import com.paperworld.action.IntervalAction;
	import com.paperworld.multiplayer.events.ServerSyncEvent;
	import com.paperworld.multiplayer.events.SynchronisedSceneEvent;
	import com.paperworld.multiplayer.lod.LodConstraint;
	import com.paperworld.multiplayer.objects.Avatar;
	import com.paperworld.multiplayer.player.Player;
	import com.paperworld.util.Synchronizable;
	import com.paperworld.util.clock.Clock;
	
	import jedai.events.Red5Event;
	import jedai.net.rpc.Red5Connection;
	import jedai.net.rpc.RemoteSharedObject;	

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class AbstractSynchronisedScene extends IntervalAction
	{
		private var logger : XrayLog = new XrayLog( );

		/**
		 * The 3D scene - cast to correct type using implicit getter in child classes.
		 */
		//public var scene : *;

		/**
		 * The Clock instance used as a timer for this scene.
		 */
		public var clock : Clock;

		/**
		 * The 'point of view' object for Level of Detail heuristics - if no pov is defined then LOD will not be activated.
		 */
		public var pov : Avatar;

		/**
		 * The list of avatars in this scene.
		 */
		public var avatars : Avatar;

		public var avatarsByName : Array;

		/**
		 * The list of Level of Detail heuristics used in this scene.
		 */
		public var lodConstraints : LodConstraint;

		/**
		 * Flagged true if the application context for this scene (the Prana Definitions file that contains the
		 * objects that this scene needs to operate) has been loaded and parsed.
		 */
		protected var _contextLoaded : Boolean = false;

		/**
		 * The access point to the Prana Definitions this scene needs to operate.
		 */
		protected var _applicationContext : XMLApplicationContext;

		/**
		 * Flagged true if the connect() method has been called and either the context hasn't been loaded yet
		 * or if the connection to the server hasn't been established yet. While the load is happening and/or
		 * the connection is being established this flag is checked to see if the scene needs to do anything else.
		 */
		protected var _connecting : Boolean = false;

		public var context : String;

		public var sceneName : String;

		protected var _connection : Red5Connection;

		public function get connection() : Red5Connection
		{
			return _connection;	
		}

		protected var _remoteSharedObject : RemoteSharedObject;

		public var clientID : Number;

		/**
		 * Adds a LOD Heuristic to the list. Implicit setter used in order to allow heuristics to be set via prana.
		 */
		public function addLodConstraint(lc : LodConstraint) : void
		{
			lc.next = lodConstraints;
			lodConstraints = lc;
		}

		/**
		 * Constructor.
		 */
		public function AbstractSynchronisedScene()
		{
			super( );			
		}

		/**
		 * Initialise implementation - initialises linked lists.
		 */
		override public function initialise() : void
		{			
			// Create a new Clock to keep time.
			clock = new Clock( );
			
			avatarsByName = new Array( );
		}

		/**
		 * Returns true if a connection to the server has been established.
		 */
		public function get connected() : Boolean
		{
			return _connection.connected;
		}

		/**
		 * Connect this scene to the server and synchronise with it's remote counterpart.
		 */
		public function connect(sceneName : String = null, context : String = null) : void
		{
			logger.info( "connecting" );
			
			_connecting = true;
			
			// If a sceneName has been passed as an argument, that's the scene we'll be connecting to.
			if (sceneName) this.sceneName = sceneName;			

			// If the context file isn't loaded yet...
			if (!_contextLoaded)
			{
				// load it!
				loadContext( context );
			}
			else
			{
				// If there's no rtmp connection established with the server...
				if (!connected)
				{
					// Connect to the server.
					connectToServer( );
				}
			}
		}

		/**
		 * Load the Prana Definitions file this scene requires to operate.
		 */
		public function loadContext(context : String) : void
		{
			logger.info( "loading context" );
			
			_applicationContext = new XMLApplicationContext( context );
			_applicationContext.addEventListener( Event.COMPLETE, onContextLoaded );
			_applicationContext.load( );
		}

		/**
		 * Called when the context file has been loaded.
		 * Flags the context as having been loaded.
		 * If we're in the process of connecting (ie. the connect() method has been called) then continue.
		 */
		protected function onContextLoaded(event : Event) : void
		{
			logger.info( "context loaded" );
			
			_contextLoaded = true;
			
			_connection = _applicationContext.getObject( "connection" ) as Red5Connection;
			
			dispatchEvent( new SynchronisedSceneEvent( SynchronisedSceneEvent.CONTEXT_LOADED, this ) );
			
			if (_connecting) connect( );
		}

		/**
		 * Calls the Red5Bootstrapper to establish an rtmp connection with a Red5 server.
		 */
		public function connectToServer(event : Event = null) : void
		{	
			logger.info( "connecting to server " );
			
			_connection.addEventListener( Red5Event.CONNECTED, onConnectionEstablished );
			_connection.addEventListener( Red5Event.DISCONNECTED, onConnectionDisconnected );
			_connection.client = this;
			_connection.connect( _connection.rtmpURI, _connection.clientManager.username, _connection.clientManager.password );
		}

		public function setClientID(val : Number) : void
		{
			clientID = val;	
		}

		/**
		 * Called when a connection has been established.
		 * If we're in the process of connecting (ie. the connect() method has been called) then continue.
		 */
		protected function onConnectionEstablished(event : Red5Event) : void
		{
			logger.info( "connection established" );
			
			dispatchEvent( new SynchronisedSceneEvent( SynchronisedSceneEvent.CONNECTED_TO_SERVER, this ) );
			
			_remoteSharedObject = new RemoteSharedObject( "avatars", false, false, _connection );
			_remoteSharedObject.addEventListener( SyncEvent.SYNC, synchronise );
		}

		protected function onConnectionDisconnected(event : Red5Event) : void
		{
			dispatchEvent( new SynchronisedSceneEvent( SynchronisedSceneEvent.DISCONNECTED_FROM_SERVER, this ) );	
		}

		public function addPlayer(player : Player, isLocal : Boolean = true) : void
		{
			if (isLocal) pov = player.avatar;
			
			addEventListener( SynchronisedSceneEvent.CONNECTED_TO_SERVER, player.onSceneConnected );	
			
			player.avatar.next = avatars;
			avatars = player.avatar;
					
			avatarsByName[player.username] = player.avatar;
		}

		/**
		 * Add a simple object to the scene.
		 */
		public function addChild(child : *) : *
		{
			// Nothing here, implementation specific to a particular 3D engine in child classes.
			return child;
		}

		/**
		 * Adds an object to the scene that can be synchronised across clients.
		 * 
		 * @param child The object that will be synced across clients and added to the 3D scene.
		 * @param pov Flags whether or not this object should be used as the 'point of view' for the Level of Detail heuristics.
		 */
		public function addRemoteChild(child : Synchronizable, pov : Boolean = false) : Synchronizable
		{
			// Create a new Avatar to handle synchronisation.
			var avatar : Avatar = new Avatar( );
			avatar.syncObject = child;
			
			// Add this avatar to the local list.
			avatar.next = avatars;
			avatars = avatar;
			
			// If this SyncObject is the local player then set as pov.
			if (pov) this.pov = avatar;
			
			// Finally, add the object to the 3D scene.
			addChild( child );
			
			return child;
		}

		public function removeChild(child : * ) : *
		{
			return child;
		}

		public function removeRemoteChild(child : Synchronizable) : Synchronizable
		{
			var previous : Avatar;
			var next : Avatar = avatars;
			
			// Loop through each avatar in the list.
			while (next)
			{			
				// When we find the avatar that's handling the child passed.	
				if (next.syncObject == child)
				{
					// Link the previous avatar with the next one - removing the current one from the list.
					previous.next = next.next;
					next.destroy( );					
					break;	
				}	
				
				// Move to the next avatar in the list.
				previous = next;
				next = Avatar( next.next );				
			}	
			
			return child;
		}

		/**
		 * Handles a sync event from the RemoteSharedObject.
		 * Iterate over the list of avatars in this scene and apply the LOD heuristics.
		 */
		public function synchronise(event : flash.events.SyncEvent) : void
		{
			//logger.info( "synchronising" );
			
			var list : Array = event.changeList;
			var length : int = list.length;
			
			// Iterate over event.changelist to check if this Avatar is in the list.
			for (var i : int = 0; i < length ; i++)
			{
				var name : String = list[i].name;
				// If this object has changed.
				//if (list[i].name == name)
				//{
				//logger.info( "CODE: " + list[i].code );
				// Decide which action to perform depending on what's happened to the SharedObject.
				switch (list[i].code)
				{
					case "change":
						var avatar : Avatar = Avatar( avatarsByName[name] );
						//logger.info( "avatar = " + avatar );
						var e : ServerSyncEvent = ServerSyncEvent(_remoteSharedObject._so.data[name]);
						avatar.synchronise(e.t, e.input, e.state);
						break;
							
					default:
						break;	
				}
				//}
			}
			
			if (canAct)
			{
				// Iterate over heuristics for each avatar to set lod interval.	
				var nextAvatar : Avatar = avatars;
				
				while (nextAvatar)
				{
					if (nextAvatar != pov)
					{
						var nextConstraint : Action = lodConstraints;
					
						while (nextConstraint)
						{
							nextConstraint.act( );
							nextConstraint = nextConstraint.next;
						}
					}
					
					nextAvatar = nextAvatar.next;
				}
			}
		}		
		
		
	}
}


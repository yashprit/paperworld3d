package com.paperworld.scenes 
{
	import com.paperworld.multiplayer.events.SynchronisedSceneEvent;	

	import flash.events.EventDispatcher;	
	import flash.events.IEventDispatcher;	
	import flash.events.Event;
	import flash.events.SyncEvent;
	import flash.net.registerClassAlias;

	import org.pranaframework.context.support.XMLApplicationContext;

	import com.paperworld.action.IntervalAction;
	import com.paperworld.data.Input;
	import com.paperworld.data.State;
	import com.paperworld.data.SyncData;
	import com.paperworld.lod.LodConstraint;
	import com.paperworld.objects.Avatar;
	import com.paperworld.util.Synchronizable;
	import com.paperworld.util.clock.Clock;

	import jedai.Red5BootStrapper;
	import jedai.events.Red5Event;
	import jedai.net.rpc.Red5Connection;		
	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class SynchronisedScene extends IntervalAction implements IEventDispatcher
	{
		/**
		 * The 3D scene - cast to correct type using implicit getter in child classes.
		 */
		public var scene : *;

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

		protected var _bootStrapper : Red5BootStrapper;

		protected var _connection : Red5Connection;

		/**
		 * EventDispatcher instance used for... er... dispatching events.
		 */
		protected var _eventDispatcher : EventDispatcher;

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
		public function SynchronisedScene()
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
			
			// Get a reference to the Red5 BootStrapper class.
			// So we can get a reference to its connection property whenever we need it.
			_bootStrapper = Red5BootStrapper.getInstance( );
			
			_eventDispatcher = new EventDispatcher( );
			
			// Register class aliases.
			registerClassAlias( "com.paperworld.data.input", Input );
			registerClassAlias( "com.paperworld.data.state", State );
			registerClassAlias( "com.paperworld.data.SyncData", SyncData );
		}

		/**
		 * Returns true if a connection to the server has been established.
		 */
		public function get connected() : Boolean
		{
			if (_bootStrapper.connection)
			{
				return _bootStrapper.connection.connected;
			}
			
			return false;
		}

		/**
		 * Connect this scene to the server and synchronise with it's remote counterpart.
		 */
		public function connect(sceneName : String = null, context : String = "multiplayerContext.xml") : void
		{
			// If a sceneName has been passed as an argument, that's the scene we'll be connecting to.
			if (sceneName) this.sceneName = sceneName;			
			
			// If the context file isn't loaded yet...
			if (!_contextLoaded)
			{
				// load it!
				loadContext( );
			}
			else
			{
				// If there's no rtmp connection established with the server...
				if (!connected)
				{
					// Connect to the server.
					connectToServer( );
				}
				// Otherwise...
				else 
				{
					// Connect to the scene.
					connectToRemoteScene( );
				}
			}
		}

		/**
		 * Uses the Red5Connection to connect this scene to its remote counterpart.
		 */
		protected function connectToRemoteScene() : void
		{
			_bootStrapper.connection.connect( );
		}

		/**
		 * Load the Prana Definitions file this scene requires to operate.
		 */
		protected function loadContext() : void
		{
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
			_contextLoaded = true;
			
			dispatchEvent( new SynchronisedSceneEvent( SynchronisedSceneEvent.CONTEXT_LOADED ) );
			
			if (_connecting) connect( );
		}

		/**
		 * Calls the Red5Bootstrapper to establish an rtmp connection with a Red5 server.
		 */
		protected function connectToServer(event : Event = null) : void
		{			
			_bootStrapper.addEventListener( Red5Event.CONNECTED, onConnectionEstablished );
			_bootStrapper.connect( );
		}

		/**
		 * Called when a connection has been established.
		 * If we're in the process of connecting (ie. the connect() method has been called) then continue.
		 */
		protected function onConnectionEstablished(event : Red5Event) : void
		{
			dispatchEvent( new SynchronisedSceneEvent( SynchronisedSceneEvent.CONNECTED_TO_SERVER ) );
			
			if (_connecting) connect( );
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
		public function synchronise(event : SyncEvent) : void
		{
			if (canAct)
			{
				// Iterate over heuristics for each avatar to set lod interval.	
				var nextAvatar : Avatar = avatars;
				
				while (nextAvatar)
				{
					if (nextAvatar != pov)
					{
						var nextConstraint : LodConstraint = lodConstraints;
					
						while (nextConstraint)
						{
							nextConstraint.testConstraint( pov, nextAvatar );
							nextConstraint = nextConstraint.next;
						}
					}
					
					nextAvatar = nextAvatar.next;
				}
			}
		}

		public function dispatchEvent(event : Event) : Boolean
		{
			return _eventDispatcher.dispatchEvent( event );
		}

		public function hasEventListener(type : String) : Boolean
		{
			return _eventDispatcher.hasEventListener( type );
		}

		public function willTrigger(type : String) : Boolean
		{
			return _eventDispatcher.willTrigger( type );
		}

		public function removeEventListener(type : String, listener : Function, useCapture : Boolean = false) : void
		{
			_eventDispatcher.removeEventListener( type, listener, useCapture );
		}

		public function addEventListener(type : String, listener : Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false) : void
		{
			_eventDispatcher.addEventListener( type, listener, useCapture, priority, useWeakReference );
		}
	}
}


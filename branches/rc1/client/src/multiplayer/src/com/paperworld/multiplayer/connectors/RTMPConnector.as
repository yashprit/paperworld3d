package com.paperworld.multiplayer.connectors
{
	import flash.events.Event;
	import flash.events.SyncEvent;
	import flash.net.Responder;
	
	import org.pranaframework.context.support.XMLApplicationContext;
	
	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.core.EventDispatchingBaseClass;
	import com.paperworld.input.UserInput;
	import com.paperworld.input.events.UserInputEvent;
	import com.paperworld.multiplayer.connectors.events.ConnectorEvent;
	import com.paperworld.multiplayer.data.SyncData;
	import com.paperworld.multiplayer.events.ServerSyncEvent;
	
	import jedai.events.Red5Event;
	import jedai.net.rpc.Red5Connection;
	import jedai.net.rpc.RemoteSharedObject;	

	/**
	 * @author Trevor
	 */
	public class RTMPConnector extends AbstractConnector 
	{
		private var logger : XrayLog = new XrayLog( );

		/**
		 * Flagged true if the application context for this scene (the Prana Definitions file that contains the
		 * objects that this scene needs to operate) has been loaded and parsed.
		 */
		//protected var _contextLoaded : Boolean = false;

		/**
		 * The access point to the Prana Definitions this scene needs to operate.
		 */
		//protected var _applicationContext : XMLApplicationContext;

		/**
		 * Flagged true if the connect() method has been called and either the context hasn't been loaded yet
		 * or if the connection to the server hasn't been established yet. While the load is happening and/or
		 * the connection is being established this flag is checked to see if the scene needs to do anything else.
		 */
		//protected var _connecting : Boolean = false;

		//public var context : String;

		//public var sceneName : String;

		//protected var _connection : Red5Connection;

		/*public function get connection() : Red5Connection
		{
			return _connection;	
		}*/

		protected var _remoteSharedObject : RemoteSharedObject;

		public var clientID : Number;

		//private var _responder : Responder = new Responder( onResult, onStatus );

		public function RTMPConnector()
		{
			super( /*this*/ );
		}

		/**
		 * Returns true if a connection to the server has been established.
		 */
		/*public function get connected() : Boolean
		{
			return _connection.connected;
		}*/

		/**
		 * Connect this scene to the server and synchronise with it's remote counterpart.
		 */
		/*public function connect(sceneName : String = null, context : String = null) : void
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
		}*/

		/**
		 * Load the Prana Definitions file this scene requires to operate.
		 */
		/*public function loadContext(context : String) : void
		{			
			_applicationContext = new XMLApplicationContext( context );
			_applicationContext.addEventListener( Event.COMPLETE, onContextLoaded );
			_applicationContext.load( );
		}*/

		/**
		 * Called when the context file has been loaded.
		 * Flags the context as having been loaded.
		 * If we're in the process of connecting (ie. the connect() method has been called) then continue.
		 */
		/*protected function onContextLoaded(event : Event) : void
		{			
			_contextLoaded = true;
			
			_connection = _applicationContext.getObject( "connection" ) as Red5Connection;
			
			dispatchEvent( new ConnectorEvent( ConnectorEvent.CONTEXT_LOADED, this ) );
			
			if (_connecting) connect( );
		}*/

		/**
		 * Calls the Red5Bootstrapper to establish an rtmp connection with a Red5 server.
		 */
		override public function connectToServer(event : Event = null) : void
		{				
			_connection.addEventListener( Red5Event.CONNECTED, onConnectionEstablished );
			_connection.addEventListener( Red5Event.DISCONNECTED, onConnectionDisconnected );
			_connection.client = this;
			_connection.connect( _connection.rtmpURI, _connection.clientManager.username, _connection.clientManager.password );
		}

		public function setClientID(val : Number) : void
		{
			logger.info( "setting client id == " + val );
			
			clientID = val;	
		}

		protected var _input : UserInput;

		public function get input() : UserInput
		{
			return _input;	
		}

		/*public function set input(value : UserInput) : void
		{
			logger.info( "setting input " + value );
			
			_input = value;	
			
			
		}*/

		
		
		/**
		 * Called when a connection has been established.
		 * If we're in the process of connecting (ie. the connect() method has been called) then continue.
		 */
		protected function onConnectionEstablished(event : Red5Event) : void
		{
			logger.info( "connection established" );
			
			dispatchEvent( new ConnectorEvent( ConnectorEvent.CONNECTED_TO_SERVER, this ) );
			
			_remoteSharedObject = new RemoteSharedObject( "avatars", false, false, _connection );
			_remoteSharedObject.addEventListener( SyncEvent.SYNC, synchronise );
			
			_input.addEventListener( UserInputEvent.INPUT_CHANGED, onInputUpdate);
		}

		protected function onConnectionDisconnected(event : Red5Event) : void
		{
			dispatchEvent( new ConnectorEvent( ConnectorEvent.DISCONNECTED_FROM_SERVER, this ) );	
		}

		/**
		 * Handles a sync event from the RemoteSharedObject.
		 * Iterate over the list of avatars in this scene and apply the LOD heuristics.
		 */
		public function synchronise(event : flash.events.SyncEvent) : void
		{
			//logger.info( "synchronising" );

			var changeList : Array = event.changeList;
			var length : int = changeList.length;
			
			// Iterate over event.changelist to check if this Avatar is in the list.
			for (var i : int = 0; i < length ; i++)
			{
				var name : String = changeList[i].name;
				// If this object has changed.
				//if (list[i].name == name)
				//{
				logger.info( clientID + "\nCODE: " + changeList[i].code );

				// Decide which action to perform depending on what's happened to the SharedObject.
				switch (changeList[i].code)
				{
					case "change":
						dispatchEvent( new ServerSyncEvent( ServerSyncEvent.AVATAR_SYNC, name, SyncData( _remoteSharedObject._so.data[name] ) ) );

						break;
						
					case "clear":
						break;
						
					case "success":
						logger.info( "changeList[" + i + "].code: " + changeList[i].code );
						break;
						
					case "reject":
						logger.info( "changeList[" + i + "].code: " + changeList[i].code );
						break;
						
					case "delete":
						logger.info( "changeList[" + i + "].code: " + changeList[i].code );
						break;
							
					default:
						break;	
				}
				//}
			}
			
			/*if (canAct)
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
			}*/
		}		

		/*protected function onInputUpdate(event : UserInputEvent) : void
		{
			logger.info("input update");
			
			_connection.call( 'multiplayer.receiveInput', _responder, clientID, event.time, event.input );
		}*/

		public function onResult(result : SyncData) : void
		{
			//logger.info("result: " + result );
		}

		public function onStatus(status : Object) : void
		{
			for (var i:String in status)
			{
				logger.info( i + " " + status[i] );
			}
		}
	}
}

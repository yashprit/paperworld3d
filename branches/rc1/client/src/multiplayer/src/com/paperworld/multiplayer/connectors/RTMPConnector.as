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

		protected var _remoteSharedObject : RemoteSharedObject;

		public var clientID : Number;

		public function RTMPConnector()
		{
			super( );
		}

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
			
			_userInput.addEventListener( UserInputEvent.INPUT_CHANGED, onInputUpdate);
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
			var changeList : Array = event.changeList;
			var length : int = changeList.length;
			
			// Iterate over event.changelist to check if this Avatar is in the list.
			for (var i : int = 0; i < length ; i++)
			{
				var name : String = changeList[i].name;

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

		override public function onInputUpdate(event : UserInputEvent) : void
		{			
			_connection.call( 'multiplayer.receiveInput', _responder, clientID, event.time, event.input );
		}

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

package com.paperworld.client.flash 
{
	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.api.NetObject;
	import com.paperworld.flash.BaseConnection;
	import com.paperworld.flash.NetInterfaceEvent;
	import com.paperworld.flash.PacketStream;

	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;		

	/**
	 * @author Trevor
	 */
	public class NetInterface extends NetConnection 
	{
		public static const NotConnected : int = 0;
		public static const ConnectTimedOut : int = 1;
		public static const ConnectRejected : int = 2;
		public static const Connected : int = 3;
		public static const Disconnected : int = 4;
		public static const TimedOut : int = 5;

		protected var _responder : Responder;

		protected var _clientId : String = "1";

		public function setClientID(id : String) : void 
		{
			logger.info( "setting client id " + id );
			_clientId = id;
		}

		protected var _connections : Dictionary;

		public function get connections() : Dictionary
		{
			return _connections;
		}

		protected var _receivedPackets : NetObject;

		private var logger : XrayLog = new XrayLog( );

		public function NetInterface()
		{
			super( );
			
			_connections = new Dictionary( );
			_responder = new Responder( onResponse, onFail );
			
			addEventListener( NetStatusEvent.NET_STATUS, onNetStatus );
		}

		protected function onNetStatus(status : NetStatusEvent) : void 
		{
			var code : String = status.info.code;
			
			switch (code)
			{
				case "NetConnection.Connect.Success":
					handleConnectSuccess( );
					break;
				
				default:
					break;
			}
		}

		protected function handleConnectSuccess() : void 
		{
			logger.info( "handling connection " + _connections );
			for each (var connection:BaseConnection in _connections)
			{
				connection.connectionState = Connected;
			}
			
			dispatchEvent( new NetInterfaceEvent( NetInterfaceEvent.READY ) );
		}

		public function addConnection(connection : BaseConnection) : void 
		{
			if (connection.type == null || connection.type.length == 0)
			{
				throw new Error( "trying to add a BaseConnection that does not have a connectionType assigned" );
			}
			
			_connections[connection.type] = connection;
			connection.netInterface = this;
		}

		public function removeConnection(connection : BaseConnection) : void 
		{
			connection.netInterface = null;
			connection.connectionState = Disconnected;
			
			_connections[connection.type] = null;
			delete _connections[connection.type];
		}

		public function receivePackets(stream : PacketStream) : void 
		{
			if (_receivedPackets != null)
			{
				stream.packets.next = _receivedPackets;
				_receivedPackets = stream.packets;
			}
			else
			{
				_receivedPackets = stream.packets;
			}
		}

		public function checkIncomingPackets() : void 
		{
			var object : NetObject = _receivedPackets;
			
			while (object != null) 
			{
				var connection : BaseConnection = findConnection( object.connectionType );
				
				if (connection)
				{
					connection.readPacket( object );
				}
				
				object = object.next;
			}
		}

		public function findConnection(type : String) : BaseConnection
		{
			return BaseConnection( _connections[type] );
		}

		public function processConnections() : void
		{
			logger.info( "processing connections" );
			
			for each (var connection:BaseConnection in _connections)
			{
				logger.info( "processing " + connection );
				connection.checkPacketSend( false, getTimer( ) );
			}
		}

		public function onResponse(object : Object) : void 
		{
			logger.info( "Message response" );
			
			for (var i:String in object)
			{
				logger.info( i + " => " + object[i] );
			}
		}

		public function onFail(object : Object) : void
		{
			logger.info( "Message failed" );
			
			for (var i:String in object)
			{
				logger.info( i + " => " + object[i] );
			}
		}

		public function sendTo(stream : PacketStream) : void 
		{
			logger.info( "sending " + stream + " to checkIncomingPackets()" );
			
			call( "checkIncomingPackets", _responder, _clientId, stream );
		}

		public function destroy() : void 
		{
			if (connected)
			{
				close( );
			}
		}
	}
}

package com.paperworld.flash 
{
	import com.blitzagency.xray.logger.XrayLog;

	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;
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
			logger.info("setting client id " + id);
			_clientId = id;
		}

		protected var _connections : Array;

		public function get connections() : Array
		{
			return _connections.concat( );
		}

		private var logger : XrayLog = new XrayLog( );

		public function NetInterface()
		{
			super( );
			
			_connections = new Array( );
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
			_connections.push( connection );
			connection.netInterface = this;
		}

		public function removeConnection(connection : BaseConnection) : void 
		{
			for (var i : int = 0; i < _connections.length ; i++)
			{
				var c : BaseConnection = BaseConnection( _connections[i] );
				
				if (connection == c)
				{
					c.connectionState = Disconnected;
					_connections.splice( i, 1 );
					break;
				}
			}
		}

		public function checkIncomingPackets(packet : PacketStream) : void 
		{
		}

		public function processConnections() : void
		{
			for each (var connection:BaseConnection in _connections)
			{
				connection.checkPacketSend( false, getTimer( ) );
			}
		}

		public function onResponse(object:Object) : void 
		{
			logger.info( "Message response" );
			
			for (var i:String in object)
			{
				logger.info(i + " => " + object[i]);
			}
		}

		public function onFail(object:Object) : void
		{
			logger.info( "Message failed" );
			
			for (var i:String in object)
			{
				logger.info(i + " => " + object[i]);
			}
		}

		public function sendTo(stream : PacketStream) : void 
		{
			call( "multiplayer.checkIncomingPackets", _responder, _clientId, stream );
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

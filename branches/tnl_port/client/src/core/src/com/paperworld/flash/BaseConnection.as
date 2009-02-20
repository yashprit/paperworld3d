package com.paperworld.flash 
{
	import com.paperworld.api.NetObject;	
	import com.paperworld.client.flash.NetInterface;	
	import com.blitzagency.xray.logger.XrayLog;	

	/**
	 * @author Trevor
	 */
	public class BaseConnection 
	{
		private var logger : XrayLog = new XrayLog( );

		protected var _type : String;

		public function get type() : String
		{
			return _type;
		}

		public function set type(value : String) : void 
		{
			_type = value;
		}

		protected var _netInterface : NetInterface;

		public function set netInterface(value : NetInterface) : void 
		{
			_netInterface = value;
		}

		protected var _connectionState : int = NetInterface.NotConnected;

		public function get connectionState() : int
		{
			return _connectionState;
		}

		public function set connectionState(value : int) : void 
		{
			logger.info( "setting connection state " + value );
			_connectionState = value;
		}

		public function BaseConnection()
		{
		}

		public function checkPacketSend(force : Boolean, currentTime : int) : void 
		{
			logger.info( "checkPacketSend() on " + this );
			
			prepareWritePacket( );
			var stream : PacketStream = new PacketStream( );
			writePacket( stream );
			_netInterface.sendTo( stream );
		}

		public function prepareWritePacket() : void 
		{
		}

		public function writePacket(stream : PacketStream) : void 
		{
		}

		public function readPacket(object : NetObject) : void 
		{
		}

		public function isDataToTransmit() : Boolean 
		{ 
			return false; 
		}

		public function destroy() : void 
		{
			_type = null;
			_netInterface = null;
		}
	}
}

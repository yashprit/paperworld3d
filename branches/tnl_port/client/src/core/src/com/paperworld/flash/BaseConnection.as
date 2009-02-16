package com.paperworld.flash 
{
	import com.blitzagency.xray.logger.XrayLog;	
	
	/**
	 * @author Trevor
	 */
	public class BaseConnection 
	{
		private var logger : XrayLog = new XrayLog();

		protected var _address : String;
		
		public function get address():String
		{
			return _address;
		}
		
		public function set address(value:String):void 
		{
			_address = value;
		}

		protected var _netInterface : NetInterface;
		
		public function set netInterface(value:NetInterface):void 
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
			logger.info("setting connection state " + value);
			_connectionState = value;
		}

		public function BaseConnection()
		{
		}

		public function checkPacketSend(force : Boolean, currentTime : int) : void 
		{
		}

		public function isDataToTransmit() : Boolean 
		{ 
			return false; 
		}

		public function destroy() : void 
		{
			_address = null;
			_netInterface = null;
		}
	}
}

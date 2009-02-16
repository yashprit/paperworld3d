package com.paperworld.flash 
{
	import com.blitzagency.xray.logger.XrayLog;	
	import com.paperworld.flash.BaseConnection;

	import flash.net.Responder;	

	/**
	 * @author Trevor
	 */
	public class DummyGhostConnection extends BaseConnection 
	{
		public var packetSent : Boolean = false;
		
		private var logger : XrayLog = new XrayLog();

		override public function set connectionState(value : int) : void 
		{
			logger.info("setting connection state");
			super.connectionState = value;
		}

		public function DummyGhostConnection()
		{
			super( );
		}

		override public function checkPacketSend(force : Boolean, currentTime : int) : void 
		{
			logger.info("checking packet send " + _netInterface );
			//_netInterface.call( "readPackets", new Responder( onPacketSent, onPacketSendFail ), new NetObject( ) );
		}

		public function onPacketSent() : void 
		{
			packetSent = true;
		}

		public function onPacketSendFail() : void 
		{
		}
	}
}

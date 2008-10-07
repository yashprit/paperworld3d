package com.paperworld.multiplayer.objects 
{
	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.input.Input;
	import com.paperworld.multiplayer.events.ServerSyncEvent;
	import com.paperworld.multiplayer.objects.Avatar;		

	/**
	 * @author Trevor
	 */
	public class RemoteAvatar extends Avatar 
	{
		private var logger : XrayLog = new XrayLog();

		public function RemoteAvatar()
		{
			super( );
		}

		override public function synchronise(event : ServerSyncEvent) : void
		{
			super.synchronise( event );
			//logger.info("synchronising remote avatar");
			client.input = event.data.input;
		}
	}
}

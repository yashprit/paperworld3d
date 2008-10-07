package com.paperworld.multiplayer.objects 
{
	import com.paperworld.multiplayer.events.ServerSyncEvent;
	import com.paperworld.multiplayer.objects.Avatar;	

	/**
	 * @author Trevor
	 */
	public class RemoteAvatar extends Avatar 
	{
		//private var logger : XrayLog = new XrayLog();

		public function RemoteAvatar()
		{
			super( );
		}

		override public function synchronise(event : ServerSyncEvent) : void
		{
			super.synchronise( event );

			client.input = event.data.input;
		}
	}
}

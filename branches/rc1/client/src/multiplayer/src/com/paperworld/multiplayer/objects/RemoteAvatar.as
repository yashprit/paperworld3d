package com.paperworld.multiplayer.objects 
{
	import com.blitzagency.xray.logger.XrayLog;	
	import com.paperworld.input.Input;
	import com.paperworld.multiplayer.data.State;
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

		override public function synchronise(t : int, input : Input, state : State) : void
		{
			super.synchronise( t, input, state );
			logger.info("synchronising remote avatar");
			client.input = input.clone( );
		}
	}
}

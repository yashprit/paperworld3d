package com.paperworld.multiplayer.player 
{
	import flash.events.Event;
	
	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.core.EventDispatchingBaseClass;
	import com.paperworld.input.UserInput;
	import com.paperworld.objects.Avatar;	

	/**
	 * @author Trevor
	 */
	public class Player extends EventDispatchingBaseClass 
	{
		private var logger : XrayLog = new XrayLog( );

		protected var _avatar : Avatar;

		public function get avatar() : Avatar
		{
			return _avatar;	
		}

		public function set avatar(value : Avatar) : void
		{
			_avatar = value;	
		}

		public var username : String;

		protected var _input : UserInput;
		
		public function set input(value : UserInput):void
		{
			_input = value;
			
			_input.addEventListener( Event.CHANGE, onInputUpdate);	
		}

		public function Player()
		{
			super( this );
		}

		override public function initialise() : void
		{
			_avatar = new Avatar( );
		}

		protected function onInputUpdate(event : Event) : void
		{
			logger.info("input has changed - sending update to server");
		}
	}
}

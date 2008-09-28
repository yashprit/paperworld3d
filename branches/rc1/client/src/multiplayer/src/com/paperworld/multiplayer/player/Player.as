package com.paperworld.multiplayer.player 
{
	import com.paperworld.multiplayer.events.SynchronisedSceneEvent;	

	import flash.net.Responder;

	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.core.EventDispatchingBaseClass;
	import com.paperworld.input.UserInput;
	import com.paperworld.input.events.UserInputEvent;
	import com.paperworld.objects.Avatar;

	import jedai.net.rpc.Red5Connection;	

	/**
	 * @author Trevor
	 */
	public class Player extends EventDispatchingBaseClass 
	{
		private var logger : XrayLog = new XrayLog( );

		protected var _responder : Responder;

		protected var _connection : Red5Connection;

		protected var _avatar : Avatar;

		public function get avatar() : Avatar
		{
			return _avatar;	
		}

		public function set avatar(value : Avatar) : void
		{
			_avatar = value;	
		}

		public var username : String = "tits";

		protected var _input : UserInput;

		public function get input() : UserInput
		{
			return _input;	
		}

		public function set input(value : UserInput) : void
		{
			_input = value;	
		}

		public function Player()
		{
			super( this );
		}

		override public function initialise() : void
		{
			_avatar = new Avatar( );
			
			_responder = new Responder( onResult, onStatus );
		}

		public function onSceneConnected(event : SynchronisedSceneEvent) : void
		{
			_connection = event.scene.connection;
			
			_input.addEventListener( UserInputEvent.INPUT_CHANGED, onInputUpdate );	
			
			event.scene.removeEventListener( SynchronisedSceneEvent.CONNECTED_TO_SERVER, onSceneConnected );
		}

		protected function onInputUpdate(event : UserInputEvent) : void
		{
			_connection.call( 'multiplayer.recieveInput', _responder, username, event.time, event.input );
		}

		public function onResult(result : Object) : void
		{
		}

		public function onStatus(stats : Object) : void
		{
		}
	}
}

package com.paperworld.multiplayer.player 
{
	import com.paperworld.util.clock.events.ClockEvent;	
	
	import flash.net.Responder;
	
	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.core.EventDispatchingBaseClass;
	import com.paperworld.input.UserInput;
	import com.paperworld.input.events.UserInputEvent;
	import com.paperworld.multiplayer.events.SynchronisedSceneEvent;
	import com.paperworld.objects.Avatar;
	import com.paperworld.util.clock.Clock;
	
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

		public var username : String = "user";

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
			
			Clock.getInstance().addEventListener( ClockEvent.TIMESTEP, update);
		}
		
		protected function update(event:ClockEvent):void
		{
			avatar.update( event.time );	
		}

		protected function onInputUpdate(event : UserInputEvent) : void
		{
			logger.info("sending input " + _connection.connected);
			_connection.call( 'multiplayer.receiveInput', _responder, username, event.time, event.input );
			//_connection.call( 'multiplayer.getGet', _responder );
		}

		public function onResult(result : Object) : void
		{
			logger.info("RESULT: " + result);
		}

		public function onStatus(status : Object) : void
		{
			for (var i:String in status)
			{
				logger.info(i + " " + status[i]);
			}
		}
	}
}

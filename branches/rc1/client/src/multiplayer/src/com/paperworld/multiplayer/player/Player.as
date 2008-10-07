/* --------------------------------------------------------------------------------------
 * PaperWorld3D - building better worlds
 * --------------------------------------------------------------------------------------
 * Real-Time Multi-User Application Framework for the Flash Platform.
 * --------------------------------------------------------------------------------------
 * Copyright (C) 2008 Trevor Burton [worldofpaper@googlemail.com]
 * --------------------------------------------------------------------------------------
 * 
 * This library is free software; you can redistribute it and/or modify it under the 
 * terms of the GNU Lesser General Public License as published by the Free Software 
 * Foundation; either version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT ANY 
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A 
 * PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License along with 
 * this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, 
 * Suite 330, Boston, MA 02111-1307 USA 
 * 
 * -------------------------------------------------------------------------------------- */
package com.paperworld.multiplayer.player 
{
	import flash.net.Responder;

	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.core.EventDispatchingBaseClass;
	import com.paperworld.input.UserInput;
	import com.paperworld.input.events.UserInputEvent;
	import com.paperworld.multiplayer.events.ServerSyncEvent;
	import com.paperworld.multiplayer.events.SynchronisedSceneEvent;
	import com.paperworld.multiplayer.objects.Avatar;
	import com.paperworld.util.clock.Clock;
	import com.paperworld.util.clock.events.ClockEvent;

	import jedai.net.rpc.Red5Connection;

	import com.paperworld.multiplayer.scenes.AbstractSynchronisedScene;		

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class Player extends EventDispatchingBaseClass 
	{
		private var logger : XrayLog = new XrayLog( );

		

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

		

		public function Player()
		{
			super( this );
		}

		override public function initialise() : void
		{
			_avatar = new Avatar( );
			
			//_responder = new Responder( onResult, onStatus );
		}

		/*public function onSceneConnected(event : SynchronisedSceneEvent) : void
		{
			// Keep a reference to the connection, we need this to send input to the server.
			_connection = event.scene.connection;
			
			// Keep a reference to the unique id given to this client by the server.
			_clientID = String( event.scene.clientID );
			
			_input.addEventListener( UserInputEvent.INPUT_CHANGED, onInputUpdate );	
			
			event.scene.removeEventListener( SynchronisedSceneEvent.CONNECTED_TO_SERVER, onSceneConnected );
			
			Clock.getInstance( ).addEventListener( ClockEvent.TIMESTEP, update );
		}*/

		/*protected function update(event : ClockEvent) : void
		{
			avatar.input = _input.input;
			//avatar.update( event.time );	
		}*/

		/*protected function onInputUpdate(event : UserInputEvent) : void
		{
			_connection.call( 'multiplayer.receiveInput', _responder, _clientID, event.time, event.input );
		}*/

		/*public function onResult(result : ServerSyncEvent) : void
		{
			//logger.info("result: " + result );
		}*/

		/*public function onStatus(status : Object) : void
		{
			for (var i:String in status)
			{
				logger.info( i + " " + status[i] );
			}
		}*/
	}
}

/*
 * --------------------------------------------------------------------------------------
 * PaperWorld3D - building better worlds
 * --------------------------------------------------------------------------------------
 * Realtime 3D Multi-User Application Framework for the Flash Platform.
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
 * --------------------------------------------------------------------------------------
 */
package com.paperworld.rpc.connector 
{
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	
	import com.paperworld.PaperWorld;
	import com.paperworld.logging.ILogger;
	import com.paperworld.logging.LoggerFactory;
	import com.paperworld.rpc.player.GamePlayer;	

	/**
	 * <p>The <code>GameConnector</code> class sets up the connection to the server.<p>
	 * 
	 * <p>It handles creating a connection to the server when the game is initialised and then handles 
	 * setting the player's user ID and initialising the low level elements prior to letting a user/player get involved.</p>
	 * 
	 * @author Trevor
	 */
	public class GameConnector extends EventDispatcher
	{
		/**
		 * Flags whether this object is deliberately disconnecting. Used to stop an automatic 
		 * reconnection when the server response fails.
		 */
		public var disconnecting : Boolean = false;

		/**
		 * Returns the <code>NetConnection</code> this class encapsulates.
		 */
		public function get connection() : NetConnection
		{
			return $connection;	
		}

		/**
		 * Returns the uri this connection is pointed at.
		 */
		public function get uri() : String
		{
			return $uri;	
		}

		/**
		 * Constructor.
		 */		
		public function GameConnector(uri : String = null)
		{
			super( );
			
			logger = LoggerFactory.getLogger( this );
			
			$uri = uri || PaperWorld.getInstance( ).getProperty( "uri" );
			
			logger.info("Connecting to: " +$uri);
			
			createConnection( );
		}	

		/**
		 * Connects to the server.
		 */
		public function connect() : void 
		{
			logger.info( "connecting to " + $uri );
			
			$connection.connect( $uri );
		}

		/**
		 * Reconnect to the server.
		 */
		public function reconnect() : void
		{
			logger.info( "reconnecting" );
			
			//$connection.connect( $uri, GamePlayer.getInstance( ).uid );	
		}

		/**
		 * Handles a <code>NetStatusEvent</code> from the server connection. A successful connection
		 * triggers a new <code>GameConnectorEvent</code>. A failure event triggers a reconnection attempt
		 * unless the disconnection was deliberate.
		 */
		public function netStatusHandler(event : NetStatusEvent) : void
		{			
			switch (event.info["code"])
			{
				case SUCCESS:

					dispatchEvent( new GameConnectorEvent( "Connected", this ) );
			
					break;

				case FAILURE:
					
					logger.info( "Connection closed by server" );
					
					if (!disconnecting)
					{
						logger.info( "... reconnecting" );
						reconnect( );
					}										

					break;	

				default:

					logger.info( "Code: " + event.info["code"] );
					break;
			}
		}

		/**
		 * Called remotely from the server. When a user successfully connects to the game server
		 * the unique client id is passed back before the <code>NetStatusEvent</code> is received.
		 */
		public function setUID(obj : Object) : void 
		{
			GamePlayer.getInstance( ).connection = $connection;
			GamePlayer.getInstance( ).setUID( obj );
		}

		/**
		 * Handles a <code>SecurityErrorEvent</code> from the server connection.
		 */
		public function securityErrorHandler(event : SecurityErrorEvent) : void
		{
			logger.info( event.text );
		}

		/**
		 * Handles a <code>IOErrorEvent</code> from the server connection.
		 */
		public function iOErrorHandler(event : IOErrorEvent) : void
		{
			logger.info( event.text );
		}

		/**
		 * Creates the connection, initialises it with the necessary parameters and 
		 * adds event listeners.
		 */
		private function createConnection() : void
		{
			$connection = new NetConnection( );
			$connection.objectEncoding = ObjectEncoding.AMF3;
			$connection.client = this;
			
			$connection.addEventListener( NetStatusEvent.NET_STATUS, netStatusHandler );
			$connection.addEventListener( SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler );
			$connection.addEventListener( IOErrorEvent.IO_ERROR, iOErrorHandler );
		}

		/**
		 * Static connection string keys.
		 */
		private static const SUCCESS : String = "NetConnection.Connect.Success";

		private static const FAILURE : String = "NetConnection.Connect.Closed";

		/**
		 * The <code>NetConnection</code> used to communicate with the server.
		 */
		private var $connection : NetConnection;

		/**
		 * The uri the connector connects to. It's held as a member variable as it's used when 
		 * trying to reconnect to the server if we get kicked off.
		 */
		private var $uri : String;

		/**
		 * Logger instance.
		 */
		private var logger : ILogger;
	}
}

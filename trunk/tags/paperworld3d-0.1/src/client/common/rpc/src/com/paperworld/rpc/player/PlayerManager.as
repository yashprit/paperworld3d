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
package com.paperworld.rpc.player
{
	import flash.events.SyncEvent;
	import flash.net.SharedObject;
	
	import com.paperworld.logging.ILogger;
	import com.paperworld.logging.LoggerFactory;
	import com.paperworld.rpc.connector.GameConnector;
	
	import de.polygonal.ds.HashMap;	

	/**
	 * @author Trevor
	 */
	public class PlayerManager 
	{		
		public var players : HashMap;

		public var so : SharedObject;

		public var logger : ILogger;

		public var id : int = 0;

		public function PlayerManager()
		{
			logger = LoggerFactory.getLogger( this );
						
			players = new HashMap( );	
		}

		public function createRoomSO(connection : GameConnector, id : int) : void 
		{
			logger.info( "Creating room SO: " + id );
			
			so = SharedObject.getRemote( "Room" + id, connection.uri, false );
			so.addEventListener( SyncEvent.SYNC, onSync );
			so.connect( connection.connection );	
		}

		public function onSync(event : SyncEvent) : void 
		{
			for (var j : int = 0; j < event.changeList.length ; j++)
			{
				var item : Object = event.changeList[j];
				var name : String = item["name"];
				
				switch (item["code"])
				{
					case "clear":

						logger.info( "Clearing " + name );
						break;

					case "change":

						var player : AbstractPlayer;
						
						var data : Object = so.data[name];
						
						if (!playerExists( name ))
						{
							player = (name == GamePlayer.getInstance( ).uid) ? GamePlayer.getInstance( ) : new RemotePlayer( );
							
							player.uid = data["uid"];
							player.username = data["username"];
							player.modelKey = data["modelKey"];
							
							addPlayer( player.uid, player );
						}
						break;	
				}
			}
		}

		public function addPlayer(key : String, value : AbstractPlayer) : void 
		{
			players.insert( key, value );	
		}

		public function getPlayer(key : String) : AbstractPlayer 
		{
			return players.find( key ) as AbstractPlayer;
		}	

		public function playerExists(key : String) : Boolean
		{
			return players.containsKey( key );	
		}
	}
}

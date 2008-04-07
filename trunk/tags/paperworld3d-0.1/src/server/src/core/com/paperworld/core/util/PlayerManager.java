/*
 * --------------------------------------------------------------------------------------
 * PaperWorld3D - building better worlds
 * --------------------------------------------------------------------------------------
 * Realtime 3D Multi-User Application Framework for the Flash Platform.
 * --------------------------------------------------------------------------------------
 * Copyright (C) 2008 Influxis [http://www.influxis.com]
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
package com.paperworld.core.util;

import java.util.Hashtable;

import org.red5.server.api.IConnection;

import com.paperworld.core.player.Player;


public class PlayerManager
{	
	private Hashtable<String, Player> players;
	
	public PlayerManager() 
	{		
		players = new Hashtable<String, Player>();
	}
	
	public void addPlayer(IConnection connection, Player player) 
	{				
		players.put(player.getId(), player);
	}
	
	public String removePlayer(Player player) 
	{
		players.remove(player.getId());
		
		return player.username;
	}
	
	public Player getPlayer(String uid)
	{
		if (players.containsKey(uid))
		{
			return players.get(uid);
		}
		
		return null;
	}
	
	public Player getPlayerForConnection(IConnection connection)
	{
		return null;
	}
	
	public Player getPlayerByClientId(String clientId)
	{		
		return null;
	}	
}

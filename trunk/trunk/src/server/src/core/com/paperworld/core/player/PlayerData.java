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
package com.paperworld.core.player;

import com.paperworld.core.avatar.AvatarInput;
import com.paperworld.core.avatar.AvatarState;

public class PlayerData 
{
	public String uid;
	public String username;
	
	public AvatarState state;
	public Integer time;
	public AvatarInput input;
	
	public PlayerData(String uid, String username) 
	{
		this.uid = uid;
		this.username = username;
		
		state = new AvatarState();
		input = new AvatarInput();
		time = 0;
	}
	
	public PlayerData(String uid, String username, AvatarState state, AvatarInput input, Integer time)
	{
		this.uid = uid;
		this.username = username;
		this.state = state;
		this.input = input;
		this.time = time;
	}
	
	public PlayerData copy()
	{
		PlayerData copy = new PlayerData(uid, username);
		
		copy.state = state;
		copy.input = input;
		copy.time = time;
		
		return copy;
	}
}

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
package com.paperworld.core.player.updates;

import java.util.ArrayList;

import com.paperworld.core.avatar.AvatarInput;
import com.paperworld.core.avatar.AvatarState;

public class PlayerUpdate /*implements IExternalizable*/{

	public Integer time;
	
	public String uid;
	
	public String username;
	
	public AvatarState state;
	
	public AvatarInput input;
	
	public ArrayList<ProjectileUpdate> projectileUpdates;
	
	public PlayerUpdate(){
		projectileUpdates = new ArrayList<ProjectileUpdate>();
	}
	
	public PlayerUpdate(Integer time, String uid, AvatarState state, AvatarInput input){
		this.time = time;
		this.uid = uid;
		this.state = state;
		this.input = input;
	}
	
	public void addProjectileUpdate(ProjectileUpdate update){
		projectileUpdates.add(update);
	}
	
	/*
	public void readExternal(IDataInput input) {
		time = input.readInt();
		uid = input.readUTF();
		username = input.readUTF();
		state = (AvatarState) input.readObject();
		this.input = (AvatarInput) input.readObject();
	}
	
	public void writeExternal(IDataOutput output) {
		output.writeInt(time);
		output.writeUTF(uid);
		output.writeUTF(username);
		output.writeObject(state);
		output.writeObject(input);
	}*/
}

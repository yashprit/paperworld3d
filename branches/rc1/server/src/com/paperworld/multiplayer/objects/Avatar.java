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
package com.paperworld.multiplayer.objects;

import org.red5.server.api.IScope;
import org.red5.server.api.ScopeUtils;
import org.red5.server.api.so.ISharedObject;
import org.red5.server.api.so.ISharedObjectService;

import com.paperworld.ai.steering.Kinematic;
import com.paperworld.multiplayer.PlayerContext;
import com.paperworld.multiplayer.behaviour.IAvatarBehaviour;
import com.paperworld.multiplayer.behaviour.SimpleAvatarBehaviour2D;
import com.paperworld.multiplayer.data.AvatarData;
import com.paperworld.multiplayer.data.Input;
import com.paperworld.multiplayer.data.State;
import com.paperworld.multiplayer.data.SyncData;
import com.paperworld.multiplayer.events.SyncEvent;

public class Avatar {

	protected Kinematic kinematic;

	/**
	 * The current Input state for this Kinematic.
	 */
	public Input input;

	/**
	 * The current time for this Kinematic.
	 */
	public int time;

	public State state;

	public String ref;

	protected PlayerContext playerContext;

	/**
	 * The IBehaviour object that's used to interpret the Input for this
	 * Kinematic.
	 */
	public IAvatarBehaviour behaviour;

	public ISharedObject sharedObject;

	protected ISharedObject getSharedObject(IScope scope, String name,
			boolean persistent) {
		ISharedObjectService service = (ISharedObjectService) ScopeUtils
				.getScopeService(scope, ISharedObjectService.class, false);
		return service.getSharedObject(scope, name, persistent);
	}

	public Avatar(Kinematic kinematic) {
		this.kinematic = kinematic;
		initialise();
	}

	public void initialise() {
		behaviour = new SimpleAvatarBehaviour2D();
		input = new Input();
		state = new State();
	}

	public void update(int time, Input input) {
		System.out.println("updating avatar " + this.time + " " + time);
		if (this.time < time) {
			while (this.time < time) {
				behaviour.update(this.time, this.input, kinematic);
				this.time++;
			}

			this.input = input;
		}

		updateSharedObject();
	}

	public void updateSharedObject() {
		System.out.println("updating shared object");
		sharedObject.setAttribute(playerContext.getId(), new SyncData(time,
				this.input, getState()));
	}

	public Kinematic getKinematic() {
		return kinematic;
	}

	public void setKinematic(Kinematic kinematic) {
		this.kinematic = kinematic;
	}

	public void updateState() {
		state.position = kinematic.position;
		state.orientation = kinematic.orientation;
		state.velocity = kinematic.velocity;
		state.rotation = kinematic.rotation;
	}

	public State getState() {
		updateState();

		return state;
	}

	public AvatarData getAvatarData() {
		return new AvatarData(ref, time, playerContext.getId());
	}

	public void setPlayerContext(PlayerContext playerContext) {
		this.playerContext = playerContext;

		sharedObject = getSharedObject(this.playerContext.getScope(),
				"avatars", false);
		
		updateSharedObject();
	}
	
	public void destroy() {
		sharedObject.removeAttribute(playerContext.getId());
	}
}

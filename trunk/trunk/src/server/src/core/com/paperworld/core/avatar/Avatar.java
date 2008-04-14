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
package com.paperworld.core.avatar;

import com.paperworld.core.avatar.behaviour.IAvatarBehaviour;
import com.paperworld.core.util.DisplayObject3D;
import com.paperworld.core.util.math.Matrix3D;
import com.paperworld.core.util.math.Quaternion;
import com.paperworld.core.util.math.Vector3D;

public class Avatar {
	/**
	 * The DisplayObject3D object that this Avatar uses to calculate position
	 * and orientation.
	 */
	private DisplayObject3D displayObject;

	private AvatarState state = new AvatarState();

	public String modelKey = "";

	/**
	 * Constructor.
	 */
	public Avatar() {
		super();

		displayObject = new DisplayObject3D();
	}

	/**
	 * Called by the Scene this Avatar is currently in. Updates the speed,
	 * position and orientation of the displayObject.
	 */
	public void update(AvatarInput input, IAvatarBehaviour behaviour) {
		behaviour.update(input, state, displayObject);
	}

	/**
	 * Sets the position of the Avatar.
	 * 
	 * @param x
	 * @param y
	 * @param z
	 */
	public void setPosition(double x, double y, double z) {
		displayObject.setX(x);
		displayObject.setY(y);
		displayObject.setZ(z);
	}

	public Vector3D getPosition() {
		return new Vector3D(displayObject.getX(), displayObject.getY(),
				displayObject.getZ());
	}

	/**
	 * This method updates the state object that is used to pass information to
	 * the client that's presenting the data to a user.
	 */
	protected void recalculate() {
		Matrix3D transform = state.returnTransform();

		Quaternion q = Quaternion.createFromMatrix(transform);
		q.normalize();

		state.setOrientation(q);

		state.setPosition(new Vector3D(transform.n14, transform.n24,
				transform.n34));
		state.setTransform(transform);

		state.setSpeed(state.speed);
	}

	public AvatarData getAvatarData() {
		AvatarData avatarData = new AvatarData(modelKey, state);

		return avatarData;
	}

	/**
	 * Returns the Avatar's speed.
	 * 
	 * @return
	 */
	public Double getSpeed() {
		return state.speed;
	}

	/**
	 * Returns the AvatarState object that's added to the Remote Shared Object.
	 * 
	 * @return
	 */
	public AvatarState getState() {
		recalculate();

		return state;
	}

	/**
	 * Sets the state of this Avatar.
	 * 
	 * @param value
	 */
	public void setState(AvatarState value) {
		state = value;
	}
}

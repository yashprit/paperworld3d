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
package com.paperworld.multiplayer.behaviour;

import com.actionengine.api.IInput;
import com.brainfarm.java.data.State;
import com.paperworld.java.api.ISynchronisedAvatar;
import com.paperworld.java.api.IBehaviour;

public class SimpleAvatarBehaviour2D implements IBehaviour {

	//private static Logger log = LoggerFactory
			//.getLogger(SimpleAvatarBehaviour2D.class);

	public double moveForwardAmount = 1.0;

	public double moveBackAmount = 1.0;

	public double moveRightAmount = 1.0;

	public double moveLeftAmount = 1.0;

	public double turnLeftAmount = 1.0;

	public double turnRightAmount = 1.0;

	public SimpleAvatarBehaviour2D() {

	}

	@Override
	public void apply(ISynchronisedAvatar avatar) {
		
		State state = avatar.getState();
		IInput input = avatar.getInput();
		
		if (input != null) {
			if (input.getMoveForward())
				state.position.z += moveForwardAmount;
				
			if (input.getMoveBackward())
				state.position.z -= moveBackAmount;
				
			if (input.getMoveRight())
				state.position.x += moveRightAmount;

			if (input.getMoveLeft())
				state.position.x -= moveLeftAmount;

			if (input.getTurnRight())
				state.orientation.w += turnRightAmount;

			if (input.getTurnLeft())
				state.orientation.w -= turnLeftAmount;
		}
		
	}

}

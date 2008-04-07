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

public class AvatarData {
	/**
	 * The Avatar's id.
	 */
	public String id;

	/**
	 * Contains the speed, position and orientation of the Avatar.
	 */
	public AvatarState state;

	/**
	 * Contains the AvatarInput for this Avatar.
	 */
	public AvatarInput input;

	/**
	 * Holds the full classname of the object that handles the input on the
	 * server and provides a visual representation on the client.
	 */
	public String modelKey;

	/**
	 * Constructor.
	 * 
	 * @param id
	 * @param modelKey
	 * @param state
	 * @param input
	 */
	public AvatarData(String id, String modelKey, AvatarState state,
			AvatarInput input) {
		this.id = id;
		this.modelKey = modelKey;
		this.state = state;
		this.input = input;
	}
}

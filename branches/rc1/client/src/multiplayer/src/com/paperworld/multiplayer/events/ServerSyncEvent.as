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
package com.paperworld.multiplayer.events 
{
	import flash.events.Event;

	import com.paperworld.input.Input;
	import com.paperworld.multiplayer.data.State;
	import com.paperworld.multiplayer.data.SyncData;	

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class ServerSyncEvent extends Event 
	{
		public var id : String ;

		public var data : SyncData;

		public function get time() : int
		{
			return data.t;
		}

		public function get input() : Input
		{
			return data.input;
		}

		public function get state() : State
		{
			return data.state;
		}

		public function ServerSyncEvent(id : String, data : SyncData)
		{
			super( 'AvatarSync' );

			this.id = id;
			this.data = data;
		}		

		override public function toString() : String
		{
			return 'ServerSyncEvent {\n' + '    time: ' + time + '\n    input: ' + input + '\n    state: ' + state + '\n}';
		}
	}
}

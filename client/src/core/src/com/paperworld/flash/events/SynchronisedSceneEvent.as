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
package com.paperworld.flash.events 
{
	import flash.events.Event;
	
	import com.paperworld.flash.scenes.AbstractSynchronisedScene;	

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class SynchronisedSceneEvent extends Event 
	{
		public static const CONTEXT_LOADED : String = "ContextLoaded";

		public static const CONNECTED_TO_SERVER : String = "ConnectedToServer";

		public static const CONNECTED_TO_SCENE : String = "ConnectedToScene";

		public static const DISCONNECTED_FROM_SERVER : String = "DisconnectedFromServer";

		public var scene : AbstractSynchronisedScene;

		public function SynchronisedSceneEvent(type : String, scene : AbstractSynchronisedScene, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super( type, bubbles, cancelable );
			
			this.scene = scene;
		}
	}
}

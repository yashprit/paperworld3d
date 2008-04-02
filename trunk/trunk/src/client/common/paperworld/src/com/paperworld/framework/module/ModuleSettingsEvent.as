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
package com.paperworld.framework.module
{
	import flash.events.Event;
	
	/**
	 * A ModuleSettingsEvent event object that contains information about the key and
	 * value that caused the event.
	 * 
	 * Adapted pretty thoroughly from Christophe Herreman's AppSettingsEvent class.
	 * (info@herrodius.com)
	 */
	public class ModuleSettingsEvent extends Event 
	{
		
		public static const ADD:String = "AppSettings_Add";
		public static const CHANGE:String = "AppSettings_Change";
		public static const CLEAR:String = "AppSettings_Clear";
		public static const DELETE:String = "AppSettings_Delete";
		public static const LOAD:String = "AppSettings_Load";
		
		public var key:String;
		public var value:*;
		
		/**
		 * Constructs a new AppSettingsEvent.
		 * 
		 */
		public function ModuleSettingsEvent(type:String, key:String, value:*, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			this.key = key;
			this.value = value;
		}
		
	}
}
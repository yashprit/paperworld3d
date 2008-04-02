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
	/**
	 * By implementing this interface, a type can be added as a listener to the
	 * AppSettings class and receive notifications when the keys or values are
	 * modified.
	 * 
	 * @author Christophe Herreman (info@herrodius.com)
	 */
	public interface ModuleSettingsListener {
		
		/**
		 * Invoked when a new setting is added.
		 */
		function ModuleSettings_Add(event:ModuleSettingsEvent):void;
		
		/**
		 * Invoked when the value of a setting is changed.
		 */
		function ModuleSettings_Change(event:ModuleSettingsEvent):void;
		
		/**
		 * Invoked when all settings are removed.
		 */
		function ModuleSettings_Clear(event:ModuleSettingsEvent):void;
		
		/**
		 * Invoked when a setting is deleted.
		 */
		function ModuleSettings_Delete(event:ModuleSettingsEvent):void;
		
		/**
		 * Invoked when the settings are loaded from an external source.
		 */
		function ModuleSettings_Load(event:ModuleSettingsEvent):void;
	}
}
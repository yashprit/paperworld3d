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
package com.paperworld.framework.loading.filerequests 
{
	import com.paperworld.framework.module.ModuleData;
	import com.paperworld.managers.PropertiesManager;	

	/**
	 * <p>Loads a module's config file - part of the <code>ModuleLoader</code>'s loading process.</p>
	 * 
	 * @see com.paperworld.framework.loading.ModuleLoader
	 * 
	 * @author Trevor
	 */
	public class ConfigFileRequest extends XMLFileRequest 
	{
		//--------------------------------------
		// PUBLIC
		//--------------------------------------
		
		/**
		 * Constructor.
		 * 
		 * @param component The module whose config file this request is loading.
		 * @param node The filepath to the config file from the modules directory.
		 * @param component The root filepath to the module's directory.
		 */
		public function ConfigFileRequest(component : String, node : String)
		{
			super( component, node );
		}

		/**
		 * When a module's config file is loaded, a <code>ModuleData</code> instance is created and 
		 * the config file's contents are added to it. The <code>ModuleData</code> instance is then
		 * registered with the PropertiesManager.
		 */
		override public function onLoadComplete() : void 
		{
			var config : XML = getContent( );
			
			var data : ModuleData = new ModuleData( );
			data.name = config.@name;
			data.type = config.name().toString();
			//data.root = config.@root;

			data.parseSettingsFromXml( config );
			//data.config = config;
		
			PropertiesManager.getInstance( ).setModuleData( config.@name, data );
		}
	}
}

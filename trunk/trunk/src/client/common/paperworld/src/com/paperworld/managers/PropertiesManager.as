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
package com.paperworld.managers
{
	import flash.utils.Dictionary;

	import com.paperworld.framework.constants.Constants;
	import com.paperworld.framework.constants.ErrorMessages;
	import com.paperworld.framework.module.AbstractModule;
	import com.paperworld.framework.module.ModuleData;
	import com.paperworld.logging.ILogger;
	import com.paperworld.logging.LoggerFactory;	
	
	public class PropertiesManager extends Dictionary
	{
		/**
		 * Properties manager instance.
		 */
		private static var $instance : PropertiesManager;

		/**
		 * Module properties.
		 */
		private var $modules : Dictionary;

		private var $loadedModules : Array;

		/**
		 * The Configuration file is held as a native XML datatype.
		 */
		private var $properties : XML;

		/**
		 * Returns the XML configuration file.
		 */
		public function get properties() : XML 
		{
			return $properties;
		}

		/**
		 * @private (setter)
		 */
		public function set properties(xml : XML) : void 
		{
			$properties = xml;
		}

		/**
		 * Logger instance.
		 */
		private var $logger : ILogger;

		/**
		 * Constructor.
		 * 
		 * @param caller Used to enforce Singleton functionality.
		 */
		public function PropertiesManager( caller : Function )
		{	
			if ( caller != PropertiesManager.getInstance )
                throw new Error( ErrorMessages.SINGLETON_GET_INSTANCE_ERROR );
			
			if ( PropertiesManager.$instance != null )
                throw new Error( ErrorMessages.MULTIPLE_SINGLETON_ERROR );	
			
			$modules = new Dictionary( );		
			$loadedModules = new Array( );	
			
			$logger = LoggerFactory.getLogger( this );
		}

		/**
		 * Return the singleton instance of this class.
		 * 
		 * @return The singleton instance of this class.
		 */
		public static function getInstance() : PropertiesManager
		{
			if ($instance == null) 
				$instance = new PropertiesManager( arguments.callee );			
			
			return $instance;
		}	

		/**
		 * Returns the Dictionary object that contains the definition of the 
		 * module that was loaded from the PaperWorldConfig.xml file.
		 * 
		 * @param key The <code>String</code> name of the module being requested.
		 * 
		 * @return The <code>Dictionary</code> object that contains the elements of the module being requested.
		 */
		public function getModuleTable(key : String) : Dictionary 
		{
			// If there isn't already an entry for this module, then create one.
			if ($modules[key] == undefined) addModuleTable( key );
			
			return $modules[key] as Dictionary;
		}

		/**
		 * Adds a new module table to the list. 
		 * 
		 * @param key The <code>String</code> name of the module to add this table for.
		 */
		public function addModuleTable(key : String) : void 
		{
			$modules[key] = new Dictionary( );
		}

		/**
		 * Sets the <code>ModuleData</code> object for a particular module.
		 * 
		 * @param key 	The <code>String</code> name of the module this <code>ModuleData</code> object belongs to.
		 * @param value The <code>ModuleData</code> object being set.
		 */
		public function setModuleData(key : String, value : ModuleData) : void 
		{
			$logger.info( "Setting Module Data for " + key + ", " + value );
			getModuleTable( key )[Constants.DATA_CONFIG_KEY] = value;
			
			getModuleData( key );
		}		

		/**
		 * Returns the <code>ModuleData</code> object for the Module who's name is passed as an argument.
		 * 
		 * @param key The <code>String</code> name of the module.
		 * 
		 * @return The <code>ModuleData</code> object for this module.
		 */
		public function getModuleData(key : String) : ModuleData
		{
			var data : ModuleData = getModuleTable( key )[Constants.DATA_CONFIG_KEY] as ModuleData;
			
			return data;
		}

		public function setModule(key : String, value : AbstractModule) : void 
		{			
			getModuleTable( key )[Constants.MODULE_CONFIG_KEY] = value;
		}

		public function getModule(key : String) : AbstractModule
		{
			return getModuleTable( key )[Constants.MODULE_CONFIG_KEY] as AbstractModule;
		}

		public function setModuleProperties(key : String, value : XML) : void 
		{
			getModuleTable( key )[Constants.PROPERTIES_KEY] = value;
		}

		public function getModuleProperties(key : String) : XML 
		{
			return getModuleTable( key )[Constants.PROPERTIES_KEY] as XML;
		}

		public function addModulePage(key : String, content : XML) : void 
		{
			var module : Dictionary = getModuleTable( key );
			
			if (module[Constants.PAGES_KEY] == undefined)
				module[Constants.PAGES_KEY] = new Dictionary( );
			
			var pages : Dictionary = module[Constants.PAGES_KEY] as Dictionary;
			pages[content.@name] = content;
		}

		public function getAllPagesForModule(key : String) : Dictionary
		{
			return getModuleTable( key )[Constants.PAGES_KEY] as Dictionary;
		}

		public function getGameDetails(key : String) : XMLList
		{
			return $properties.game.(@name == key);	
		}
	}
}

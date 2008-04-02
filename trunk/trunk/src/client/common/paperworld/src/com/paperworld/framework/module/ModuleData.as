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
	import flash.events.*;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;

	import com.paperworld.logging.ILogger;
	import com.paperworld.logging.LoggerFactory;		

	/**
	 * <p>Holds references to all the properties for a module.</p>
	 */
	public class ModuleData extends Proxy implements IEventDispatcher
	{
		/**
		 * EventDispatcher instance.
		 */
		private var $eventDispatcher : EventDispatcher;

		/**
		 * Contains the key/value pairs
		 */
		private var $settings : Object;	

		/**
		 * Contains temp settings, needed for Proxy implementation
		 */				
		private var $tempSettings : Array;

		/**
		 * Logger.
		 */
		private var $logger : ILogger;	

		public function get name() : String 
		{
			return flash_proxy::getProperty( "name" );
		}

		public function set name(value : String) : void 
		{
			flash_proxy::setProperty( "name", value );
		}	

		public function get root() : String
		{
			return flash_proxy::getProperty( "root" );
		}

		public function set root(value : String) : void 
		{
			flash_proxy::setProperty( "root", value );	
		}

		public function get filePaths() : XMLList
		{
			return flash_proxy::getProperty( "filepaths" );	
		}

		public function get moduleComponents() : XML
		{
			return new XML( flash_proxy::getProperty( "module-components" ) );	
		}

		public function get requiredLibraries() : XML
		{
			return new XML( flash_proxy::getProperty( "required-libraries" ) );	
		}

		public function get moduleClass() : String
		{
			return flash_proxy::getProperty( "module-class" );
		}

		public function set type(value : String) : void
		{
			flash_proxy::setProperty( "type", value );	
		}

		public function get type() : String
		{
			return new XML( flash_proxy::getProperty( "type" ) );
		}

		/**
		 * Constructor.
		 */
		public function ModuleData() 
		{
			$eventDispatcher = new EventDispatcher( );
			
			$settings = new Object( );
			
			$logger = LoggerFactory.getLogger( this );
		}

		/**
		 * Adds a listener to the AppSettings.
		 * 
		 * @param listener The listener object to be added
		 */
		public function addListener(listener : ModuleSettingsListener, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false) : void 
		{
			addEventListener( ModuleSettingsEvent.ADD, listener.ModuleSettings_Add, useCapture, priority, useWeakReference );
			addEventListener( ModuleSettingsEvent.CHANGE, listener.ModuleSettings_Add, useCapture, priority, useWeakReference );
			addEventListener( ModuleSettingsEvent.CLEAR, listener.ModuleSettings_Add, useCapture, priority, useWeakReference );
			addEventListener( ModuleSettingsEvent.DELETE, listener.ModuleSettings_Add, useCapture, priority, useWeakReference );
			addEventListener( ModuleSettingsEvent.LOAD, listener.ModuleSettings_Add, useCapture, priority, useWeakReference );
		}

		/**
		 * Removes a listener from the AppSettings object.
		 * 
		 * @param listener The listener object to be removed.
		 */
		public function removeListener(listener : ModuleSettingsListener, useCapture : Boolean = false) : void 
		{
			removeEventListener( ModuleSettingsEvent.ADD, listener.ModuleSettings_Add, useCapture );
			removeEventListener( ModuleSettingsEvent.CHANGE, listener.ModuleSettings_Add, useCapture );
			removeEventListener( ModuleSettingsEvent.CLEAR, listener.ModuleSettings_Add, useCapture );
			removeEventListener( ModuleSettingsEvent.DELETE, listener.ModuleSettings_Add, useCapture );
			removeEventListener( ModuleSettingsEvent.LOAD, listener.ModuleSettings_Add, useCapture );
		}

		//---------------------------------------------------------------------
		// IEventDispatcher implementation
		//---------------------------------------------------------------------
		public function addEventListener(type : String, listener : Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false) : void 
		{
			$eventDispatcher.addEventListener( type, listener, useCapture, priority, useWeakReference ); 
		}

		public function dispatchEvent(event : Event) : Boolean 
		{
			return $eventDispatcher.dispatchEvent( event );
		}

		public function removeEventListener(type : String, listener : Function, useCapture : Boolean = false) : void 
		{
			$eventDispatcher.removeEventListener( type, listener, useCapture );
		}

		public function hasEventListener(type : String) : Boolean 
		{
			return $eventDispatcher.hasEventListener( type );
		}

		public function willTrigger(type : String) : Boolean 
		{
			return $eventDispatcher.willTrigger( type );
		}

		//---------------------------------------------------------------------
		
		//---------------------------------------------------------------------
		// Proxy implementation
		//---------------------------------------------------------------------
		/**
		 * Returns the value that matches the setting with the given name.
		 * 
		 * @param name The name of the setting you want to receive.
		 * @returns The value of the setting with the given name. If the key
		 * does not exist, undefined is returned.
		 */
		flash_proxy override function getProperty(name : *) : *
		{
			return $settings[name];
		}

		/**
		 * Sets a property.
		 */
		flash_proxy override function setProperty(name : *, value : *) : void 
		{
			var eventType : String = (this.hasOwnProperty( name )) ? ModuleSettingsEvent.CHANGE : ModuleSettingsEvent.ADD;
			var event : ModuleSettingsEvent = new ModuleSettingsEvent( eventType, name, value, true, true );
			
			$settings[name] = value;
			dispatchEvent( event );
		}

		/**
		 * Catches unknown method calls.
		 */
		flash_proxy override function callProperty(methodName : *, ... args) : * 
		{
			return this[String( methodName )].apply( args );
		}

		/**
		 * Deletes a property.
		 */
		flash_proxy override function deleteProperty(name : *) : Boolean 
		{
			var value : * = $settings[name];
			delete $settings[name];
			
			if (!this.hasOwnProperty( name )) 
			{
				dispatchEvent( new ModuleSettingsEvent( ModuleSettingsEvent.DELETE, name, value, true, true ) );
			}
			return (!this.hasOwnProperty( name ));
		}

		/**
		 * Checks if a property exists.
		 */
		flash_proxy override function hasProperty(name : *) : Boolean 
		{
			return ($settings[name] !== undefined);
		}

		/**
		 * Returns the index of the next property while looping through the
		 * collection with a for or for each loop.
		 */
		flash_proxy override function nextNameIndex(index : int) : int 
		{
			if (index == 0) 
			{
				$tempSettings = new Array( );
				
				for (var x:* in $settings) 
				{
					$tempSettings.push( x );
				}
			}
			
			return ((index < $tempSettings.length) ? (index + 1) : 0);
		}

		/**
		 * Returns the name of the next property when looping through the
		 * collection.
		 */
		flash_proxy override function nextName(index : int) : String 
		{
			var count : int = 1;
			var result : String = "";
			
			for (var x:* in $settings) 
			{
				if (count == index) 
				{
					result = x;
					break;
				}
				count++;
			}
			
			return result;
		}

		/**
		 * Returns the value of the next property when looping through the
		 * collection.
		 */
		flash_proxy override function nextValue(index : int) : * 
		{
			var count : int = 1;
			var result : *;
			
			for each (var x:* in $settings) 
			{
				if (count == index) 
				{
					result = x;
					break;
				}
				count++;
			}
			
			return result;
		}

		//---------------------------------------------------------------------
		
		/**
		 * Parses the settings from the given XML instance.
		 * 
		 * @param xml The XML object that contains the settings.
		 */
		public function parseSettingsFromXml(xml : XML) : void 
		{			
			for each(var i:XML in xml.children( ))
			{
				$logger.info( "setting " + i.name( ) + " => " + i.toString( ) );
				$settings[i.name( )] = i.toString( );
			}
		}
	}
}

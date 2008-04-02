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
	import flash.events.EventDispatcher;
	
	import com.paperworld.lang.LanguageConstants;
	import com.paperworld.lang.events.LanguageChangeEvent;
	import com.paperworld.logging.ILogger;
	
	import de.polygonal.ds.HashMap;	
	
	public class LanguageManager extends EventDispatcher
	{	
		/**
		 * Key to cycle up through available languages.
		 */
		public static var INC_KEY : String = "36";	

		// Home
		
		/**
		 * Key to cycle down through available languages.
		 */
		public static var DEC_KEY : String = "35";	

		// End
		
		/**
		 * Singleton instance of this class.
		 */
		private static var $instance : LanguageManager;

		/**
		 * Stores language files for multiple components indexed by language code.
		 */
		private var languages : HashMap;

		/**
		 * Language components.
		 */
		private var components : HashMap;

		/**
		 * Set a list of available languages.
		 * Currently used for development only.
		 */
		private var availableLangs : Array;

		/**
		 * The default language.
		 * Supplied via the core url or development config.
		 */
		private var defaultLang : String = LanguageConstants.LANG_ENGLISH;

		/**
		 * The current language.
		 * Set to be the default language initially when the default lang is set.
		 */
		private var lang : String;

		/**
		 * Logger instance.
		 */
		private var logger : ILogger;

		/**
		 * Constructor, private to prevent instantiation.
		 */
		public function LanguageManager()
		{
			lang = defaultLang;
			
			components = new HashMap( );
			languages = new HashMap( );
		}

		/**
		 * Return the singleton instance of this class.
		 */
		public static function getInstance() : LanguageManager
		{
			if ($instance == null)
			{
				$instance = new LanguageManager( );
			}
			
			return $instance;
		}

		/**
		 * Once the event listener has been added to the EventDispatcher, 
		 * update the listeners to ensure they populate immediately with their keys.
		 * 
		 * @inheritDoc
		 */
		override public function addEventListener(type : String, listener : Function, useCapture : Boolean = false, priority : int = 0.0, useWeakReference : Boolean = false) : void
		{
			super.addEventListener( type, listener, useCapture, priority, useWeakReference );
			
			updateListeners( );
		}

		/**
		 * Does this language exist?
		 */
		private function languageExists(lang : String) : Boolean
		{
			return languages.containsKey( lang );
		}

		/**
		 * Set the default language.
		 * Also initialise the current language.
		 * Supplied via the core url or development config.
		 * If no valid language is supplied use English as the default.
		 */
		public function setDefaultLanguage(defaultLang : String) : void
		{
			if (defaultLang != null)
			{
				defaultLang = LanguageConstants.LANG_ENGLISH;
			}
			
			// Finally set the default language and initialise the current language.
			logger.info( "Setting default language " + defaultLang );
			this.defaultLang = defaultLang;
			this.lang = defaultLang;
		}

		/**
		 * Set the available languages.
		 * Currently used in development only.
		 */
		public function setAvailableLanguages(al : Array) : void
		{
			this.availableLangs = al;
		}

		/**
		 * Return the current language code.
		 */
		public function getLang() : String
		{
			return lang;
		}

		/**
		 * Add a processed language file for the specified language and component.
		 * All keys must be unique as we store in flat file structure.
		 */
		public function addFile(lang : String, fileData : XMLList) : void
		{
			logger.info( "Adding language file for language " + lang + "\n\n" + fileData );
			
			var langData : HashMap = HashMap( languages.find( lang ) );
			if (langData == null)
			{
				langData = new HashMap( );
				languages.insert( lang, langData );
			}
			
			// Add the new key / value pairs for this data.
			for each(var element:XML in fileData)
			{
				langData.insert( element.@resname.toString( ), element.source.toString( ) );
			}
				
			updateListeners( );
		}

		/**
		 * Return the value for a key in the current language.
		 */
		public function getString(key : String) : String
		{
			return ( languages.find( lang ) as HashMap).find( key ) as String;
		}

		/**
		 * Update all listeners.
		 */
		public function updateListeners() : void
		{		
			logger.info( "Language changed, informing listeners." );
			
			dispatchEvent( new LanguageChangeEvent( $instance ) );
		}
	}
}
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
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import com.paperworld.managers.LanguageManager;	

	/**
	 * <p>Designed for handling Language files into the PaperWorld framework.</p>
	 */
	public class LanguageFileRequest extends XMLFileRequest
	{
		//--------------------------------------
		// PUBLIC
		//--------------------------------------
			
		/**
		 * Constructs the file path from the root language directory path (passed in from the 
		 * application configuration file).
		 * 
		 * @param urlRoot The path the directory where all the language files for this module are being kept. 
		 */
		override public function getFilePath() : String
		{			
			return $filePath;// + $language + Constants.XML_FILE_EXTENSION;
		}

		/**
		 * <p>Constructor.</p>
		 * 
		 * <p>Constructs the file path from the root language directory path (passed in from the 
		 * application configuration file).</p>
		 * 
		 * @param component The module this Language file is a part of.
		 * @param node The path to the file.
		 * @param root The path to the root of the module.
		 */
		public function LanguageFileRequest( component : String, node : String, root : String = "")
		{
			super( component, node );
			
			$language = LanguageManager.getInstance( ).getLang( );
		}

		/**
		 * Sets the Language for this request to something other than the default language.
		 */
		public function setLang(lang : String) : void 
		{
			$language = lang;	
		}

		/**
		 * @inheritDoc
		 * 
		 * Processes the language file that has been loaded and registers all the keys and their
		 * values with the <code>LanguageManager</code>
		 * 
		 * @see com.paperworld.util.LanguageManager#addFile
		 */
		override public function onLoadComplete() : void 
		{
			super.onLoadComplete( );
			
			var data : XMLList = getContent( ).file.body["trans-unit"];

			LanguageManager.getInstance( ).addFile( $language, data );
		}
		
		//--------------------------------------
		// PROTECTED
		//--------------------------------------
		
		override protected function startLoading() : void 
		{			
			URLLoader( $loader ).load( new URLRequest( $filePath + $language + ".xml" ) );
		}
		
		//--------------------------------------
		// PRIVATE
		//--------------------------------------
		
		/**
		 * <p>Holds a reference to the language being loaded. Held locally in case the user
		 * switches languages during the loading process.</p>
		 */
		private var $language : String;
	}
}
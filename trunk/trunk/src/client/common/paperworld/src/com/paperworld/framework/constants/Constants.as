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
package com.paperworld.framework.constants
{

	/**
	 * Constants used throughout the application.
	 * I don't want to see ANY literal strings anywhere but HERE ;)
	 */
	public class Constants
	{
		//--------------------------------------
		// PUBLIC
		//--------------------------------------

		public static const BUTTON_KEY : String = "Button";

		public static const DATA_CONFIG_KEY : String = "data";
		
		public static const DEFAULT_LOCALE_KEY : String = "default-locale";

		public static const DEFAULT_MODULE_KEY : String = "default-module";

		public static const FACTORY_KEY : String = "Factory";

		public static const FAR_KEY : String = "far"	;

		public static const FILE_REQUEST_KEY : String = "FileRequest"	;
		
		public static const GAME_CONFIG_KEY:String = "game";
		
		public static const GAME_MODULE_KEY:String = "game-module";

		public static const LIBRARY_KEY : String = "library-component";

		public static const LOADER_KEY : String = "preloader";

		public static const MODULE_CONFIG_KEY : String = "module"	;

		public static const NAVIGATION_KEY : String = "Navigation";	

		public static const OPTIONS_KEY : String = "Options";

		public static const PAGES_KEY : String = "Pages";

		public static const PAPERWORLD_KEY : String = "PaperWorld";

		public static const PROPERTIES_KEY : String = "Properties";

		public static const PWML_KEY : String = "PWML"	;

		public static const REGISTRATION_KEY : String = "Registration";

		public static const REQUIRES_REGISTRATION_KEY : String = "requiresRegistration";

		public static const SKIN_KEY : String = "Skin"	;

		public static const SOUND_KEY : String = "Sound";

		public static const UI_KEY : String = "UIComponents";

		public static const XML_FILE_EXTENSION : String = ".xml";

		public static const CLASSNAME_ATTRIBUTE : String = "classname";

		public static const FILE_PATHS_ATTRIBUTE : String = "filepaths";

		public static const NAME_ATTRIBUTE : String = "name";

		public static const REQUIRES_ATTRIBUTE : String = "requires";

		public static const SUCCESS_MESSAGE : String = "Success";

		public static const FAILURE_MESSAGE : String = "Failure";

		public static const WAIT_MESSAGE : String = "Wait";

		public static const EFFECT_KEY : String = "Effect";

		public static const YES_KEY : String = "yes";

		public static const RETRY_KEY : String = "retry";

		public static const NO_KEY : String = "no";

		public static const EXIT_KEY : String = "exit";

		public static const CANCEL_KEY : String = "cancel";

		public static const OK_KEY : String = "ok";

		public function Constants( singleton : Singleton)
		{
		}
	}
}

class Singleton
{
}
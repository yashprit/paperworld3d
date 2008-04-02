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
package com.paperworld.lang
{
	import de.polygonal.ds.HashMap;		

	/**
	 * LanguageCodes.
	 * This is using ISO 639-1.
	 * There is now ISO 639-2 which uses 3 character codes to define language.
	 * @author trevor.burton
	 */
	public class LanguageConstants 
	{	
		/**
		 * XLIFF XML Node name constants.
		 */
		public static var BODY_NODE : String = "body";

		public static var FILE_NODE : String = "file";

		public static var HEADER_NODE : String = "header";

		public static var SOURCE_NODE : String = "source";

		public static var TRANS_UNIT_NODE : String = "trans-unit";

		public static var XLIFF_NODE : String = "xliff";

		/**
		 * XLIFF XML Attribute constants.
		 */
		public static var RESNAME_ATTRIBUTE : String = "resname";
		
		/**
		 * HashTable to contain both ISO 639-1 and ISO 639-2 language codes.
		 */
		private static var LANGUAGE_CODES : HashMap = createLanguageCodes( );

		/**
		 * The ISO 639 revision number to use.
		 */
		private static var ISO_639_REVISION : Number = 1;

		/**
		 * Language code keys.
		 * Use IS0 639-1.
		 */
		public static var LANG_CHINESE : String = "zh";

		public static var LANG_DANISH : String = "da";

		public static var LANG_DUTCH : String = "nl";

		public static var LANG_ENGLISH : String = "en";

		public static var LANG_FINNISH : String = "fi";

		public static var LANG_FRENCH : String = "fr";

		public static var LANG_GERMAN : String = "de";

		public static var LANG_GREEK : String = "el";

		public static var LANG_IRISH : String = "ga";

		public static var LANG_ITALIAN : String = "it";

		public static var LANG_JAPANESE : String = "ja";

		public static var LANG_NORWEGIAN : String = "no";

		public static var LANG_POLISH : String = "pl";

		public static var LANG_PORTUGUESE : String = "pt";

		public static var LANG_RUSSIAN : String = "ru";

		public static var LANG_SPANISH : String = "es";

		public static var LANG_SWEDISH : String = "sv";

		public static var LANG_TURKISH : String = "tr";

		public static var LANG_WELSH : String = "cy";

		/**
		 * Constructor.
		 */
		public function LanguageConstants()
		{															
		}

		/**
		 * Create the language codes.
		 * Store the IS0 639-1 and ISO 639-2 codes.
		 */
		private static function createLanguageCodes() : HashMap
		{
			var languageCodes : HashMap = new HashMap( );
			
			languageCodes.insert( LANG_CHINESE, new Array( LANG_CHINESE, "zho" ) );
			languageCodes.insert( LANG_DANISH, new Array( LANG_DANISH, "dan" ) );
			languageCodes.insert( LANG_DUTCH, new Array( LANG_DUTCH, "nld" ) );
			languageCodes.insert( LANG_ENGLISH, new Array( LANG_ENGLISH, "eng" ) );
			languageCodes.insert( LANG_FINNISH, new Array( LANG_FINNISH, "fin" ) );
			languageCodes.insert( LANG_FRENCH, new Array( LANG_FRENCH, "fra" ) );
			languageCodes.insert( LANG_GERMAN, new Array( LANG_GERMAN, "deu" ) );
			languageCodes.insert( LANG_GREEK, new Array( LANG_GREEK, "ell" ) );
			languageCodes.insert( LANG_IRISH, new Array( LANG_IRISH, "gle" ) );
			languageCodes.insert( LANG_ITALIAN, new Array( LANG_ITALIAN, "ita" ) );
			languageCodes.insert( LANG_JAPANESE, new Array( LANG_JAPANESE, "jpn" ) );
			languageCodes.insert( LANG_NORWEGIAN, new Array( LANG_NORWEGIAN, "nor" ) );
			languageCodes.insert( LANG_POLISH, new Array( LANG_POLISH, "pol" ) );		
			languageCodes.insert( LANG_PORTUGUESE, new Array( LANG_NORWEGIAN, "por" ) );		
			languageCodes.insert( LANG_RUSSIAN, new Array( LANG_RUSSIAN, "rus" ) );
			languageCodes.insert( LANG_SPANISH, new Array( LANG_SPANISH, "spa" ) );
			languageCodes.insert( LANG_SWEDISH, new Array( LANG_SWEDISH, "swe" ) );	
			languageCodes.insert( LANG_TURKISH, new Array( LANG_TURKISH, "tur" ) );	
			languageCodes.insert( LANG_WELSH, new Array( LANG_WELSH, "cym" ) );
			
			return languageCodes;
		}

		/**
		 * Return either an ISO 639-1 or ISO 639-2 language code.
		 */
		public static function getLanguageCode(key : String) : String
		{
			return LANGUAGE_CODES.find( key )[ISO_639_REVISION - 1] as String;
		}
	}
}
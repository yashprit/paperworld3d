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
	import flash.text.StyleSheet;
	import flash.text.TextFormat;

	import com.paperworld.logging.ILogger;
	import com.paperworld.logging.LoggerFactory;	

	public class StyleManager
	{	
		/**
		 * Syle attributes.
		 */
		public static var FONT_SIZE : String = "fontSize";

		public static var BACKGROUND_COLOR : String = "backgroundColor";

		public static var BORDER_COLOR : String = "borderColor";

		/**
		 * Style definition prefix.
		 */
		private static var STYLE_PREFIX : String = ".";

		/**
		 * Size suffix.
		 */
		private static var SIZE_SUFFIX : String = "px";

		/**
		 * An instance of this class.
		 */
		private static var $instance : StyleManager;

		/**
		 * The single stylesheet for the core.
		 */
		private var styleSheet : StyleSheet;

		/**
		 * Logger.
		 */
		private var $logger : ILogger;

		/**
		 * Constructor, private to prevent external instantiation.
		 */
		public function StyleManager()
		{
			$logger = LoggerFactory.getLogger( this );
			
			// Create the single global style sheet instance.
			styleSheet = new StyleSheet( );
		}	

		/**
		 * Return an instance of this class.
		 */
		public static function getInstance() : StyleManager
		{		
			if ($instance == null)
			{
				$instance = new StyleManager( );
			}
			
			return $instance;
		}	

		/**
		 * Return the global style sheet to allow styles to be added.
		 */
		public function getStyleSheet() : StyleSheet
		{
			$logger.info( "StyleSheet: " + styleSheet.styleNames );
			return styleSheet;
		}

		/**
		 * Transform a CSS style to a TextFormat.
		 * Used for input text fields to set the TextFormat.
		 */
		public function getTextFormat(style : String) : TextFormat
		{
			var styleSheet : StyleSheet = getStyleSheet( );
			var styleObj : Object = styleSheet.getStyle( STYLE_PREFIX + style );
			return styleSheet.transform( styleObj );
		}

		/**
		 * Returns the value of an attribute of a style in the stylesheet.
		 */
		public function getStyleAttribute(style : String, attribute : String) : Object
		{
			return styleSheet.getStyle( STYLE_PREFIX + style )[attribute];
		}

		/**
		 * Sets the value of an attribute of a style in the stylesheet.
		 */
		public function setStyleAttribute(style : String, attribute : String, value : String) : void
		{
			var copy : Object = styleSheet.getStyle( STYLE_PREFIX + style );			
			copy[attribute] = value;		
			styleSheet.setStyle( STYLE_PREFIX + style, copy );
			
			copy = null;
		}

		/**
		 * Changes for size of the output text by changing style attributes.
		 */
		public function changeFontSize(style : String, inc : Number, min : Number, max : Number) : void
		{
			var size : String = String( getStyleAttribute( style, FONT_SIZE ) );		
			var newSize : Number = Number( size.substr( 0, size.indexOf( SIZE_SUFFIX ) ) ) + inc;

			if (newSize < max && newSize > min)
			{
				setStyleAttribute( style, FONT_SIZE, String( newSize ) + SIZE_SUFFIX );		
			}
		}
	}
}
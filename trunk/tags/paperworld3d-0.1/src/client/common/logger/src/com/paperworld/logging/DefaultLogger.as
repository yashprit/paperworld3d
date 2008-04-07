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
package com.paperworld.logging
{
	import flash.utils.getQualifiedClassName;
	
	import com.blitzagency.xray.logger.XrayLog;	

	/**
	 * <p>This is the default interface to Xray - the default logging library provided with PaperWorld3D</p>
	 * 
	 * <p>If no other logging library is provided to the application then this is the logging interface 
	 * created by the <code>LoggerFactory</code></p>
	 * 
	 * @see com.paperworld.logging.LoggerFactory
	 * 
	 * @author trevor.burton
	 */
	public class DefaultLogger extends XrayLog implements ILogger
	{
		//--------------------------------------
		// PUBLIC
		//--------------------------------------
		
		/**
		 * Constructor.
		 * 
		 * @param source The object that is instantiating the logger. The qualified class name of the 'source' for the logger 
		 * will be displayed in the logger output.
		 */
		public function DefaultLogger(source:*)
		{
			super( );
			
			this.source = getQualifiedClassName(source);
			
			info( this.source + " Created" );
		}

		/**
		 * Passes a debug message to the logger library.
		 */
		override public function debug(message : String, ... rest) : void
		{
			super.debug( source + ":\n" + message, rest );
		}

		/**
		 * Passes a info message to the logger library.
		 */
		override public function info(message : String, ... rest) : void
		{
			super.info( source + ":\n" + message, rest );
		}

		/**
		 * Passes a warn message to the logger library.
		 */
		override public function warn(message : String, ... rest) : void
		{
			super.warn( source + ":\n" + message, rest );
		}

		/**
		 * Passes a error message to the logger library.
		 */
		override public function error(message : String, ... rest) : void
		{
			super.error( source + ":\n" + message, rest );
		}

		/**
		 * Passes a fatal message to the logger library.
		 */
		override public function fatal(message : String, ... rest) : void
		{
			super.fatal( source + ":\n" + message, rest );
		}
		
		//--------------------------------------
		// PRIVATE
		//--------------------------------------
		
		/**
		 * The object that instantiated and is using this logger instance.
		 */
		private var source : String;
	}
}

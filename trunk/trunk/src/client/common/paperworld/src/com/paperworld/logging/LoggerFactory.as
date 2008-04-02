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
	import flash.system.ApplicationDomain;
	import flash.utils.getDefinitionByName;	

	/**
	 * @author Trevor
	 */
	public class LoggerFactory 
	{
		public static const DEFAULT_LOG_CLASS : String = "com.paperworld.logging.DefaultLogger";

		public static var LOGGER_CLASS : String = DEFAULT_LOG_CLASS;

		public static function getLogger(source : *) : ILogger
		{
			var logger : ILogger;
			
			if (ApplicationDomain.currentDomain.hasDefinition( LOGGER_CLASS ))
			{
				var LoggerClass : Class = getDefinitionByName( LOGGER_CLASS ) as Class;
				logger = new LoggerClass( source );
			}
			else
			{
				logger = new NullLogger( );
			}
			
			return logger;
		}
	}
}

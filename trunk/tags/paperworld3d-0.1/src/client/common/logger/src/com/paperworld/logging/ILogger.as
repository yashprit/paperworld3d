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

	/**
	 * <p>The <code>ILogger</code> provides an Interface for an interface between the application
	 * and a logger library. If you want to use a logging interface other than Xray (the default logging
	 * interface) then you'll need to create a class that implements <code>ILogger</code> and ensure that 
	 * it is included in the configuration file for the application for it to be instantiated at 
	 * start-up.</p>
	 * 
	 * @author Trevor
	 */
	public interface ILogger 
	{
		/**
		 * Passes a debug message to the logger library.
		 */
		function debug(message : String, ... rest) : void;

		/**
		 * Passes a info message to the logger library.
		 */
		function info(message : String, ... rest) : void;

		/**
		 * Passes a warn message to the logger library.
		 */
		function warn(message : String, ... rest) : void;

		/**
		 * Passes a error message to the logger library.
		 */
		function error(message : String, ... rest) : void;

		/**
		 * Passes a fatal message to the logger library.
		 */
		function fatal(message : String, ... rest) : void;
	}
}

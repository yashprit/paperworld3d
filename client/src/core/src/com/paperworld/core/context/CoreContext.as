/* --------------------------------------------------------------------------------------
 * PaperWorld3D - building better worlds
 * --------------------------------------------------------------------------------------
 * Real-Time Multi-User Application Framework for the Flash Platform.
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
 * -------------------------------------------------------------------------------------- */
package com.paperworld.core.context 
{
	import org.pranaframework.context.support.XMLApplicationContext;	

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class CoreContext 
	{
		/**
		 * The Singleton instance of this class.
		 */
		protected static var _instance : CoreContext;

		/**
		 * The application context used to load and store all Prana definitions for this application.
		 */
		protected var _applicationContext : XMLApplicationContext;

		/**
		 * Constructor - uses internal class instance to prevent direct instantiation.
		 */
		public function CoreContext(singleton : Singleton)
		{
		}

		public static function getInstance() : CoreContext
		{
			return _instance = (_instance == null) ? new CoreContext( new Singleton( ) ) : _instance;	
		}

		public function getObject(name : String) : *
		{
			return _applicationContext.getObject( name );
		}

		public function getObjectWithConstructorArgs(name : String, args : Array) : *
		{
			return _applicationContext.getObject( name, args );
		}
	}
}

internal class Singleton 
{
}
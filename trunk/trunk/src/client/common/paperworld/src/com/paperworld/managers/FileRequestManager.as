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
	import com.paperworld.framework.loading.filerequests.FileRequest;
	import com.paperworld.logging.ILogger;
	import com.paperworld.logging.LoggerFactory;

	import de.polygonal.ds.HashMap;		

	/**
	 * <p><code>FileRequestManager</code> keeps a record of all the <code>FileRequest</code> objects created. If the application
	 * attempts to load the same file more than once the existing <code>FileRequest</code> is returned rather than creating a new
	 * one. This saves memory and reduces the number of requests to the server to minimum as the same file is returned from 
	 * memory rather than from the cache or from a clean call.</p>
	 * 
	 * @author Trevor
	 */
	public class FileRequestManager 
	{
		//--------------------------------------
		// PUBLIC
		//--------------------------------------

		//private var $logger : ILogger;

		/**
		 * Constructor.
		 */
		public function FileRequestManager(singleton : Singleton)
		{
			//$logger = LoggerFactory.getLogger( this );
			
			$fileRequests = new HashMap( );
		}

		/**
		 * Returns the Singleton instance of this class.
		 */
		public static function getInstance() : FileRequestManager
		{
			if ($instance == null)
				$instance = new FileRequestManager( new Singleton( ) );
			
			return $instance;
		}

		/**
		 * Add a new file request.
		 */
		public function addFileRequest(component : String, type : String, request : FileRequest) : void 
		{
			//$logger.info( "Adding filerequest: " + component + ", " + type );
			var components : HashMap = getTable( component, $fileRequests );
			 
			components.insert( type, request );
		}

		/**
		 * Returns true if a component for the module name passed has been loaded.
		 */
		public function isComponentLoaded(module : String) : Boolean 
		{
			return $fileRequests.containsKey( module );
		}

		/**
		 * Returns true if the component has already been loaded.
		 */
		public function containsRequest(component : String, type : String) : Boolean 
		{
			var components : HashMap = getTable( component, $fileRequests );
			 
			return components.containsKey( type );	
		}

		/**
		 * Returns the file request that matches the parameters passed, or <code>null</code> if none exists.
		 */
		public function getFileRequest(component : String, type : String) : FileRequest 
		{
			var components : HashMap = getTable( component, $fileRequests );
			
			return components.find( type ) as FileRequest;	
		}

		//--------------------------------------
		// PRIVATE
		//--------------------------------------
		
		/**
		 * Return the table stored for the key passed. If it doesn't already exist, create it.
		 */
		private function getTable(key : String, parent : HashMap) : HashMap 
		{
			if (!parent.containsKey( key ))
				parent.insert( key, new HashMap( ) );
			
			return parent.find( key ) as HashMap;
		}

		/**
		 * The Singleton instance of this class.
		 */
		private static var $instance : FileRequestManager;

		/**
		 * The list of <code>FileRequest</code> objects already created by the application.
		 */
		private var $fileRequests : HashMap;
	}
}

class Singleton
{
}

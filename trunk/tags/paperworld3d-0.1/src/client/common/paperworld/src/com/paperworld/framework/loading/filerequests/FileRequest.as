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
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.utils.getDefinitionByName;
	
	import com.paperworld.managers.FileRequestManager;	

	//--------------------------------------
	//  Events
	//--------------------------------------
	
	/**
	 *  Dispatched when the the <code>IEventDispatcher</code> instance being
	 *  used to load the file has dispatched a progress event.
	 *
	 *  @eventType flash.events.ProgressEvent.PROGRESS
	 *
	 * @langversion 3.0
	 */
	[Event(name="progress", type="flash.events.ProgressEvent")]

	/**
	 * <code>FileRequest</code> is an abstract base class for all the file requests that extend it.
	 * 
	 * <p>It provides a set of properties and methods that can be overridden by children and a single Factory method <code>getFileRequest</code>
	 * that is used to return the correct <code>FileRequest</code> type for the file being loaded.</p>
	 */
	public class FileRequest extends EventDispatcher
	{		
		//--------------------------------------
		// PUBLIC
		//--------------------------------------
		
		/**
		 * The data that has been loaded.
		 */
		public var data : *;
		
		/**
		 * Returns the loader class object being used to load this file.
		 * 
		 * <p>This is defined in the child class for this filetype-specific load but will be either:
		 * 		<ul>
		 * 			<li><code>Loader</code>    - To load a binary file.</li>
		 * 			<li><code>URLLoader</code> - To load a text file.</li>
		 * 		</ul>
		 * </p>
		 */
		public function get loader() : EventDispatcher 
		{
			return $loader;
		}
		
		/**
		 * The type of component element this request is loading.
		 */
		public var type : String;
		
		/**
		 * Returns true if the file has started loading but has not completed.
		 */
		public function setIsLoading(value : Boolean) : void 
		{
			isLoading = value;
		}

		/**
		 * @private (setter)
		 */
		public function getIsLoading() : Boolean 
		{
			return isLoading;
		}

		/**
		 * Returns true if the file has completed loading.
		 */
		public function getIsLoaded() : Boolean
		{
			return isLoaded;
		}

		/**
		 * @private (setter)
		 */
		public function setIsLoaded(value : Boolean) : void 
		{
			isLoaded = true;
		}

		public function getComponent() : String 
		{
			return component;
		}
		
		public function getFilePath():String
		{
			return $filePath;	
		}

		/**
		 * Constructor.
		 * 
		 * @param component The module this <code>FileRequest</code> is loading a component of.
		 * @param node Used to retreive the file path.
		 */
		public function FileRequest(component : String, node : *)
		{		
			$loader = createLoader( );
			
			this.component = component;
			$filePath = (node is XML) ? (node as XML).toString( ) : node as String;	
			//this.type = node.@key;

			requires = new Array( );
		}

		/**
		 * <p>Static "Factory" method to return the correct type of file request for an item in the application configuration file.</p>
		 * 
		 * <p>If this is the first time this file has been requested then a new <code>FileRequest</code> is created, if the file
		 * has been requested previously then the previous request is retrieved from the <code>FileRequestManager</code> and returned.
		 * 
		 * @return A <code>FileRequest</code> instance that encapsulates the request for a file.
		 */
		public static function getFileRequest( component : String, node : XML, root : String) : FileRequest
		{
			var useKey : String = node.@key;
			var request : FileRequest;
			
			if (FileRequestManager.getInstance( ).containsRequest( component, useKey ))
			{
				request = FileRequestManager.getInstance( ).getFileRequest( component, useKey );
			}
			else
			{
				var FileRequestClass : Class = getDefinitionByName( PACKAGE_PREFIX + node.@key + PACKAGE_SUFFIX ) as Class;
				request = new FileRequestClass( component, node.toString( ), root );
				request.type = node.@key;
				FileRequestManager.getInstance( ).addFileRequest( component, useKey, request );
			}
			
			return request; 
		}

		/**
		 * Returns the list of modules required to be loaded before this file can load.
		 */
		public function getRequires() : Array 
		{
			return requires;
		}
		
		/**
		 * Adds a required request to the list for this file.
		 */
		public function addRequiredRequest(request : FileRequest) : void 
		{
			requires.push( request );
		}
		
		/**
		 * Creates an object that's used to load the file requested.
		 */
		public function createLoader() : EventDispatcher 
		{
			return null;
		}
		
		/**
		 * Handles a completed file load.
		 */
		public function onLoadComplete() : void 
		{
			isLoaded = true;
			isLoading = false;
		}

		/**
		 * Sets the $isLoading flag to true.
		 */
		public function load() : void 
		{
			if (!isLoading && !isLoaded)
			{
				//logger.info("Request not loaded, starting load");
				isLoading = true;
				startLoading( );
			}
		}
		
		/**
		 * Abstract Definition.
		 */
		public function get bytesLoaded() : int 
		{
			return 0;
		}		

		/**
		 * Abstract Definition.
		 */
		public function get bytesTotal() : int 
		{
			return 0;
		}	

		/**
		 * Abstract Definition.
		 */
		public function getLoaderTarget() : EventDispatcher 
		{
			return null;
		}

		override public function toString() : String 
		{
			return $filePath + " => " + isLoaded;
		}
		
		//--------------------------------------
		// PROTECTED
		//--------------------------------------
		
		/**
		 * The path to the file this request is loading.
		 */
		protected var $filePath : String;
		
		/**
		 * @private
		 * 
		 * The loader that's being used to load this file.
		 */
		protected var $loader : EventDispatcher;

		/**
		 * @private
		 * 
		 * The key for the component this file is a part of.
		 */
		protected var component : String;	
		
		/**
		 * @private 
		 * 
		 * A list of required modules. This request cannot load until these requirements have been loaded.
		 */
		protected var requires : Array;

		/**
		 * Flag: has the download commenced?
		 */
		protected var isLoading : Boolean = false;

		/**
		 * Flag: Has the download completed?
		 */
		protected var isLoaded : Boolean = false;

		/**
		 * Abstract Definition.
		 */
		protected function configureListeners(dispatcher : IEventDispatcher) : void 
		{
		}		

		/**
		 * Abstract Definition.
		 */
		protected function openHandler(event : Event = null) : void 
		{
			//isLoading = true;
		}

		/**
		 * Abstract Definition.
		 */
		protected function completeHandler(event : Event = null) : void 
		{
			isLoaded = true;
		}

		/**
		 * Sets the $isLoaded flag to true.
		 */
		protected function initHandler(event : Event) : void 
		{
			//isLoading = true;
		}

		/**
		 * Informs listeners that the <code>IEventDisptacher</code> instance being used to load 
		 * the file has dispatched a progress event.
		 */
		protected function progressHandler(event : ProgressEvent) : void 
		{
			dispatchEvent( event );
		}

		/**
		 * Handle a <code>SecurityErrorEvent</code>.
		 */
		protected function securityErrorHandler(event : SecurityErrorEvent) : void 
		{
		}

		/**
		 * Handle a <code>HTTPStatusEvent</code>.
		 */
		protected function httpStatusHandler(event : HTTPStatusEvent) : void 
		{
		}

		/**
		 * Handle an <code>IOErrorEvent</code>.
		 */
		protected function ioErrorHandler(event : IOErrorEvent) : void 
		{
		}
		
		/**
		 * Start this request loading.
		 */
		protected function startLoading() : void 
		{
		}

		//--------------------------------------
		// PRIVATE
		//--------------------------------------
		
		private static const PACKAGE_PREFIX : String = "com.paperworld.framework.loading.filerequests.";

		private static const PACKAGE_SUFFIX : String = "FileRequest";
	}
}

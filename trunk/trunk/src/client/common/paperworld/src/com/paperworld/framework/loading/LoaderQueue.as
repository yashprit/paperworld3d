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
package com.paperworld.framework.loading
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	
	import com.paperworld.framework.loading.events.LoadProgressEvent;
	import com.paperworld.framework.loading.events.LoaderQueueEvent;
	import com.paperworld.framework.loading.filerequests.FileRequest;
	import com.paperworld.logging.ILogger;
	import com.paperworld.logging.LoggerFactory;
	
	import de.polygonal.ds.HashMap;
	import de.polygonal.ds.Iterator;	

	//--------------------------------------
	//  Events
	//--------------------------------------
	
	/**
	 *  Dispatched when the queue starts a file loading.
	 *
	 *  @eventType flash.events.Event.OPEN
	 *
	 * @langversion 3.0
	 */
	[Event(name="open", type="flash.events.Event")]

	/**
	 *  Dispatched when a <code>FileRequest</code> progress event is received 
	 *  by the <code>LoaderQueue</code>
	 *
	 *  @eventType com.paperworld.events.EventMessages.LOAD_PROGRESS_EVENT_MESSAGE
	 *
	 * @langversion 3.0
	 */
	[Event(name="progress", type="com.paperworld.preload.events.LoadProgressEvent")]

	/**
	 *  Dispatched when all file requests in the queue have completely loaded.
	 *
	 *  @eventType flash.events.Event.COMPLETE
	 *
	 * @langversion 3.0
	 */
	[Event(name="complete", type="com.paperworld.preload.events.LoaderQueueEvent")]

	/**
	 * LoaderQueue provides functionality for loading multiple modules.
	 * 
	 * <p>A Modules is declared in the main core configuration file and can be declared to 'require' other modules.</p>
	 * 
	 * <p>A required module can be loaded concurrently or consecutively. If a Module is required to be loaded consecutively then
	 * the LoaderQueue checks after each module's load has completed to see if any modules waiting to begin their load process
	 * required that module. If they do and all the module's requirements have been achieved then that module can begin it's load.</p>
	 */	
	public class LoaderQueue extends EventDispatcher implements IEventDispatcher 
	{	
		//--------------------------------------
		// PUBLIC
		//--------------------------------------
		
		/**
		 * Store loading assets in a HashTable.
		 */
		public var fileRequests : HashMap;

		/**
		 * Get the total size, in bytes of the files being loaded.
		 * 
		 * @return The total size, in bytes, of the requests in the queue.
		 */
		public function get bytesTotal() : Number
		{
			var bytes : int = 0;
			
			var componentIterator : Iterator = fileRequests.getIterator( );
			
			while (componentIterator.hasNext( ))
			{
				var componentRequests : HashMap = componentIterator.next( ) as HashMap;
				var requestIterator : Iterator = componentRequests.getIterator( );
				
				while (requestIterator.hasNext( ))
				{
					var request : FileRequest = requestIterator.next( ) as FileRequest;
					bytes += request.bytesTotal;
				}
			}				
			
			return bytes;
		}

		/**
		 * Get the amount of bytes currently loaded.
		 * 
		 * @return The total amount of bytes of the files currently loaded.
		 */
		public function get bytesLoaded() : Number
		{
			var bytes : int = 0;
			
			var componentIterator : Iterator = fileRequests.getIterator( );
			
			while (componentIterator.hasNext( ))
			{
				var componentRequests : HashMap = componentIterator.next( ) as HashMap;
				var requestIterator : Iterator = componentRequests.getIterator( );
				
				while (requestIterator.hasNext( ))
				{
					var request : FileRequest = requestIterator.next( ) as FileRequest;
					bytes += request.bytesLoaded;
				}
			}
						
			return bytes;
		}

		/**
		 * Returns the number of files that have been loaded so far.
		 * 
		 * @return The number of files in the queue that have been completely loaded.
		 */
		public function get filesLoaded() : int 
		{
			var loaded : int = 0;
			
			var componentIterator : Iterator = fileRequests.getIterator( );
			
			while (componentIterator.hasNext( ))
			{
				var componentRequests : HashMap = componentIterator.next( ) as HashMap;
				var requestIterator : Iterator = componentRequests.getIterator( );
				
				while (requestIterator.hasNext( ))
				{
					var request : FileRequest = requestIterator.next( ) as FileRequest;
					if (request.getIsLoaded( )) loaded++;
				}
			}				
				
			return loaded;
		}

		/**
		 * Returns the total number of files in the queue.
		 * 
		 * @return the number of files in the queue.
		 */
		public function get totalFiles() : int 
		{
			var total : int = 0;
			
			var componentIterator : Iterator = fileRequests.getIterator( );
			
			while (componentIterator.hasNext( ))
			{
				var componentRequests : HashMap = componentIterator.next( ) as HashMap;
				
				total += componentRequests.size;
			}	
			
			return total;
		}

		/**
		 * Constructor.
		 */
		public function LoaderQueue()
		{
			super( );
			
			//$logger = LoggerFactory.getLogger( this );
						
			fileRequests = new HashMap( );
		}

		public function clearQueue() : void 
		{
			fileRequests.clear( );
		}

		/**
		 * Add a <code>FileRequest</code> to the current queue.
		 * 
		 * <p>The file requests are all stored in groups related to the module the request
		 * is a part of.<p>
		 * 
		 * @param request The <code>FileRequest</code> to add to the queue.
		 * @param key     The <code>String</code> name of the module this request is a part of.
		 */
		public function addFileRequest(request : FileRequest) : EventDispatcher
		{	
			if (!containsRequest( request ))
			{				
				configureListeners( request );
				
				if (!fileRequests.containsKey( request.getComponent( ) ))
					fileRequests.insert( request.getComponent( ), new HashMap( ) );
				
				var requestTable : HashMap = fileRequests.find( request.getComponent( ) ) as HashMap;
				requestTable.insert( request.type, request );			
			}
			
			return request.loader;
		}

		/**
		 * Returns true if the queue contains the request supplied.
		 * 
		 * @param request The request we're looking for.
		 * 
		 * @return true if the request is already in the queue, false if it isn't.
		 */
		public function containsRequest(request : FileRequest) : Boolean 
		{
			if (!fileRequests.containsKey( request.getComponent( ) ))
				return false;
				
			var requests : HashMap = fileRequests.find( request.getComponent( ) ) as HashMap;
			
			return	requests.containsKey( request.type );
		}

		/**
		 * Returns the <code>HashMap</code> that contains the structured file requests.
		 * 
		 * @return The <code>HashMap</code> that contains all the file requests in the queue. 
		 */
		public function getFileRequests() : HashMap
		{
			return fileRequests;
		}

		/**
		 * Returns all the requests present in the queue for a specific module.
		 */
		public function getModuleRequests(key : String) : HashMap
		{
			return fileRequests.find( key ) as HashMap;
		}

		/**
		 * Returns the file request that corresponds with the module and the request type passed.
		 * 
		 * @param module The module this request is for.
		 * @param type The type of file request.
		 * 
		 * @return The <code>FileRequest</code> instance that corresponds to the module and type passed as parameters.
		 */
		public function getFileRequest(module : String, type : String) : FileRequest
		{
			return getModuleRequests( module ).find( type ) as FileRequest;
		}

		public function moduleRequestsInQueue(module : String) : Boolean
		{
			return fileRequests.containsKey( module );
		}

		/**
		 * <p>Start the queue loading.</p> 
		 * 
		 * <p>Only files that are able to load concurrently are started loading at this point.
		 * A check is performed to see if an Library requests rely on another Library request to already have loaded. Any 
		 * required libraries must wait for their requirements to complete their load before commencing loading themselves.</p>
		 */
		public function startLoading() : void 
		{
			checkLoadStatus( );
		}

		/**
		 * <p>Have all the files loaded? If so then an Event.COMPLETE event is dispatched. Otherwise
		 * <code>LoaderQueue.loadRequests()</code> is called to check if any libraries were waiting for this file to load.</p>
		 */
		public function checkLoadStatus() : void 
		{
			//$logger.info("Loading Queue - (" + filesLoaded + "/" + totalFiles + ")");
			if ( filesLoaded == totalFiles )
				dispatchEvent( new LoaderQueueEvent( Event.COMPLETE, fileRequests ) );
			else
				loadRequests( );
		}

		//--------------------------------------
		// PRIVATE
		//--------------------------------------

		/**
		 * Logger instance.
		 */
		//private var $logger : ILogger;

		/**
		 * Works through the queue and starts the requests it finds loading if they aren't already loading and haven't
		 * already been loaded.
		 */
		private function loadRequests() : void 
		{
			var componentIterator : Iterator = fileRequests.getIterator( );
			
			while (componentIterator.hasNext( ))
			{
				var componentRequests : HashMap = componentIterator.next( ) as HashMap;
				var requestIterator : Iterator = componentRequests.getIterator( );
				
				while (requestIterator.hasNext( ))
				{
					var request : FileRequest = requestIterator.next( ) as FileRequest;
					
					if (requestCanLoad( request ))
					{	
						//$logger.info("loading: " + request.getFilePath());
						request.load( );
					}
				}
			}
		}

		/**
		 * Checks to see if a LibraryFileRequest can load. 
		 * Required libraries must be loaded before this library can load.
		 */
		private function requestCanLoad( request : FileRequest ) : Boolean
		{
			var loaded : Boolean = true;
			var requires : Array = request.getRequires( );
			
			// Check if there are any required libraries.
			if (requires != null && requires.length > 0)
			{											
				// Iterate through all the required libraries
				for (var i : int = 0; i < requires.length ; i++)
				{
					var requiredRequest : FileRequest = requires[i] as FileRequest;

					if (requiredRequest == null)
					{
						loaded = true;
					}
					else
					{
						if (!requiredRequest.getIsLoaded( )) 
						{
							loaded = false;
							break;
						}
					}
				}
				
				return loaded;
			}
			
			return loaded;
		}

		/**
		 * Configure the listeners for a load request.
		 */
		private function configureListeners( dispatcher : IEventDispatcher ) : void 
		{
			dispatcher.addEventListener( Event.COMPLETE, completeHandler );
			dispatcher.addEventListener( Event.OPEN, openHandler );
			dispatcher.addEventListener( ProgressEvent.PROGRESS, progressHandler );
			dispatcher.addEventListener( SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler );
			dispatcher.addEventListener( HTTPStatusEvent.HTTP_STATUS, httpStatusHandler );
			dispatcher.addEventListener( IOErrorEvent.IO_ERROR, ioErrorHandler );
		}

		/**
		 * Checs the progress of the queue's loading. Dispatches an event that contains a value that 
		 * represents the percentage of the queue that has currently loaded by querying all the requests
		 * in the queue. Also provides the list of requests in the queue as a value in the event for
		 * use in a GUI.
		 * 
		 * @param event A <code>ProgressEvent</code> recieved from a <code>FileRequest</code> in the queue.
		 */
		private function progressHandler( event : Event ) : void
		{	
			var currentPercent : Number = Math.round( ( bytesLoaded / bytesTotal ) * 100 );
			
			var percentFilesComplete : Number = (  filesLoaded / totalFiles ) * 100;
			
			var unitPercent : Number = 1 / totalFiles * 100;
			
			var unitPercentComplete : Number = currentPercent * unitPercent / 100;
			
			var currentPercentTotal : Number = Math.round( percentFilesComplete + unitPercentComplete );
			
			dispatchEvent( new LoadProgressEvent( currentPercentTotal, fileRequests ) );
		}

		private function ioErrorHandler( event : Event ) : void
		{
			//$logger.info("IO Error Occured loading File: " + FileRequest(event.target).filePath);
		}

		private function openHandler( event : Event ) : void
		{
			//$logger.info("Open event received: " + FileRequest(event.target).filePath);
		}

		private function securityErrorHandler( event : Event ) : void 
		{
			//$logger.info("Security Error Received: " + FileRequest(event.target).filePath);
		}

		private function httpStatusHandler( event : Event ) : void 
		{
			//$logger.info("HTTP Security Error Received: " + FileRequest(event.target).filePath);
		}

		/**
		 * A <code>FileRequest</code> has completed loading. Check if all files have now loaded, if so, dispatch a COMPLETE event.
		 * If not check if the file that has just completed loading is a Library request. If so check to see if any libraries
		 * are waiting for this library to complete before commencing their load.
		 */
		private function completeHandler( event : Event ) : void
		{			
			/*var iterator : Iterator = fileRequests.getIterator();
			while(iterator.hasNext())
			{
				$logger.info("load complete: " + (iterator.next() as HashMap).dump());	
			}*/
			
			( event.target as FileRequest ).onLoadComplete( );

			checkLoadStatus( );
		}
	}
}
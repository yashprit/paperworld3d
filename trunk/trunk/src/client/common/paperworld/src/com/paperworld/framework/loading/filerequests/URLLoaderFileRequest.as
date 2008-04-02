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
	import flash.net.URLLoader;
	import flash.net.URLRequest;	

	//--------------------------------------
	//  Events
	//--------------------------------------
	/**
	 *  Dispatched when the entire archive has finished loading
	 *
	 *  @eventType flash.events.Event.INIT
	 *
	 * @langversion 3.0
	 */
	[Event(name="init", type="flash.events.Event")]

	/**
	 * <p>Provides an implementation of <code>FileRequest</code> specifically for loading text files. Overrides only the 
	 * methods necessary for this implementation.</p>
	 */
	public class URLLoaderFileRequest extends FileRequest
	{
		//--------------------------------------
		// PUBLIC
		//--------------------------------------
		
		/**
		 * Constructor.
		 */
		public function URLLoaderFileRequest( component : String, node : String )
		{
			super( component, node );
			
			configureListeners( $loader );
		}
		
		/**
		 * Creates a new <code>URLLoader</code> instance to load the requested file with.
		 */
		override public function createLoader() : EventDispatcher 
		{
			return new URLLoader( );
		}

		/**
		 * Returns the target of the load (the <code>IEventDispatcher</code> instance that will perform the load).
		 */
		override public function getLoaderTarget() : EventDispatcher
		{
			return URLLoader( $loader );
		}
		
		/**
		 * Returns the number of bytes currently loaded.
		 * 
		 * @see #getBytesTotal
		 */
		override public function get bytesLoaded() : int 
		{
			return URLLoader( $loader ).bytesLoaded;
		}

		/**
		 * Returns the total size, in bytes, of the file being loaded.
		 * 
		 * @see #getBytesLoaded
		 */
		override public function get bytesTotal() : int 
		{
			return URLLoader( $loader ).bytesTotal;
		}
		
		//--------------------------------------
		// PROTECTED
		//--------------------------------------

		/**
		 * @inheritDoc
		 * 
		 * listens for events directly on the passed <code>IEventDispatcher</code> instance. As
		 * at this points it is known to be an instance of <code>URLLoader</code>
		 */
		override protected function configureListeners( dispatcher : IEventDispatcher ) : void 
		{

			dispatcher.addEventListener( Event.COMPLETE, completeHandler );
			dispatcher.addEventListener( Event.OPEN, openHandler );
			dispatcher.addEventListener( ProgressEvent.PROGRESS, progressHandler );
			dispatcher.addEventListener( SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler );
			dispatcher.addEventListener( HTTPStatusEvent.HTTP_STATUS, httpStatusHandler );
			dispatcher.addEventListener( IOErrorEvent.IO_ERROR, ioErrorHandler );
		}

		/**
		 * @inheritDoc
		 * 
		 * informs listeners that loading has completed.
		 */
		override protected function completeHandler( event : Event = null ) : void 
		{
			super.completeHandler( event );
			
			data = URLLoader( loader ).data;
			
			dispatchEvent( new Event( Event.COMPLETE ) );
		}

		/**
		 * Start the load process.
		 */
		override protected function startLoading() : void 
		{
			URLLoader( $loader ).load( new URLRequest( $filePath ) );
		}
	}
}
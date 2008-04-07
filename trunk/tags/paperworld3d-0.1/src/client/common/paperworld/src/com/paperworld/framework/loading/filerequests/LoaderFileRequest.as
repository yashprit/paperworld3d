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
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
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
	 * <p>Designed to load a binary file into the PaperWorld application. Ensures the listeners are configured correctly
	 * and that the file is loaded into the current <code>ApplicationDomain</code></p>
	 */
	public class LoaderFileRequest extends FileRequest
	{	
		//--------------------------------------
		// PUBLIC
		//--------------------------------------
		
		/**
		 * Constructor.
		 */
		public function LoaderFileRequest( component : String, node : String )
		{
			super( component, node );
			
			configureListeners( Loader( loader ).contentLoaderInfo );
		}
		
		/**
		 * Creates the correct type of loader class for this request
		 * 
		 * @return The <code>Loader</code> object used to load this request.
		 */
		override public function createLoader() : EventDispatcher 
		{
			return new Loader( );
		}

		/**
		 * Returns the target of the <code>Loader</code> object used to load this class. This is the 
		 * <code>LoaderInfo</code> object that load event listeners should be added to.
		 */
		override public function getLoaderTarget() : EventDispatcher
		{
			return Loader( $loader ).contentLoaderInfo;
		}
		
		//--------------------------------------
		// PROTECTED
		//--------------------------------------

		/**
		 * @inheritDoc
		 */
		override protected function configureListeners( dispatcher : IEventDispatcher ) : void 
		{
			dispatcher.addEventListener( Event.COMPLETE, completeHandler );
			dispatcher.addEventListener( HTTPStatusEvent.HTTP_STATUS, httpStatusHandler );
			//dispatcher.addEventListener(Event.INIT, initHandler);
			dispatcher.addEventListener( IOErrorEvent.IO_ERROR, ioErrorHandler );
			dispatcher.addEventListener( Event.OPEN, openHandler );
			dispatcher.addEventListener( ProgressEvent.PROGRESS, progressHandler );
		}

		/**
		 * @inheritDoc
		 * 
		 * Dispatch event to inform listeners load is complete.
		 */
		override protected function completeHandler(event : Event = null) : void 
		{
			super.completeHandler( event );
			
			data = Loader( loader ).content;
						
			dispatchEvent( new Event( Event.COMPLETE ) );
		}

		/**
		 * Start the request loading the file. Ensure the file is loaded into the current <code>ApplicationDomain</code>
		 * this ensures that classes are available without having to retrieve them from another domain.
		 */
		override protected function startLoading() : void 
		{
			if ($filePath != null)
			{
				Loader( $loader ).load( new URLRequest( $filePath ) );
			}
		}
	}
}
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
	import flash.events.ProgressEvent;

	import com.paperworld.framework.loading.LoaderQueue;	

	/**
	 * <p>Handles loading a set of Pages for a module.</p>
	 */
	public class PagesFileRequest extends URLLoaderFileRequest
	{
		//--------------------------------------
		// PUBLIC
		//--------------------------------------
				
		/**
		 * Returns a customised file path for this file request.
		 */
		override public function getFilePath() : String 
		{
			return component + "Pages";
		}

		/**
		 * Constructor.
		 * 
		 * @param name The name of the module this <code>FileRequest</code> is a part of.
		 * @param node The <code>XML</code> object from the oonfiguration file used to create this request.
		 */
		public function PagesFileRequest( component : String, node : XML, root : String )
		{
			super( component, root + node );
			
			createLoadQueue( node );
		}

		/**
		 * Iterates through the list of pages. Adds them to the <code>LoaderQueue</code>.
		 */
		public function createLoadQueue( content : XML ) : void 
		{
			$loaderQueue = new LoaderQueue( );
			
			for each ( var page:XML in content.children( ) )
				$loaderQueue.addFileRequest( new XMLFileRequest( page, page ) );
			
			configureListeners( $loaderQueue );
		}
		
		/**
		 * Overrides the default behaviour for this FileRequest in order to return the 
		 * correct value for all the models in the queue.
		 */
		override public function get bytesLoaded() : int 
		{
			return $loaderQueue.bytesLoaded;
		}

		/**
		 * Overrides the default behaviour for this FileRequest in order to return the 
		 * correct value for all the models in the queue.
		 */
		override public function get bytesTotal() : int 
		{
			return $loaderQueue.bytesTotal;
		}
		
		//--------------------------------------
		// PROTECTED
		//--------------------------------------

		override protected function completeHandler( event : Event = null ) : void 
		{
			dispatchEvent( new Event( Event.COMPLETE ) );
		}

		override protected function progressHandler(event : ProgressEvent) : void 
		{
		}

		/**
		 * Starts the queue of pages loading.
		 */
		override protected function startLoading() : void 
		{			
			$loaderQueue.startLoading( );
		}
		
		//--------------------------------------
		// PRIVATE
		//--------------------------------------
		
		/**
		 * Loader queue used to load all the models.
		 */
		private var $loaderQueue : LoaderQueue;
	}
}
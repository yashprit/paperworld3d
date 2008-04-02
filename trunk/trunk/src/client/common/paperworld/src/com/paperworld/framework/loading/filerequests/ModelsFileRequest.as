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
	import com.paperworld.framework.loading.LoaderQueue;
	import com.paperworld.managers.ModelManager;	

	/**
	 * <p>This <code>FileRequest</code> handles loading multiple model files. The XML files are loaded in a child <code>LoaderQueue</code> object
	 * which this class encapsulates. All events from the queue are passed up to the queue this request is a part of.<p>
	 * 
	 * <p>Before loading begins the models are registered with the <code>ModelManager</code> so they can be retrieved by module
	 * code as soon as the model is loaded.</p>
	 */
	public class ModelsFileRequest extends URLLoaderFileRequest
	{
		//--------------------------------------
		// PUBLIC
		//--------------------------------------

		/**
		 * Constructor.
		 */
		public function ModelsFileRequest( game : String, node : XML )
		{
			super( game, node );
			
			createLoadQueue( game, new XML( node ) );						
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

		/**
		 * Starts the queue of models loading.
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

		/**
		 * Iterates through the list of models. Adds them to the <code>LoaderQueue</code> and 
		 * registers them with the <code>ModelManager</code>
		 */
		private function createLoadQueue( game : String, content : XML ) : void 
		{
			$loaderQueue = new LoaderQueue( );
			
			for each (var model:XML in content.children( ))
			{
				var request : XMLFileRequest = new XMLFileRequest( model.@key, "games/" + game + "/locale/en_us/" + model );
				request.type = content.@key;
				
				$loaderQueue.addFileRequest( request );
				
				ModelManager.getInstance( ).addModel( model.@key, model.@type, request.loader );
			}
			
			configureListeners( $loaderQueue );
		}
	}
}
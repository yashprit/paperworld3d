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
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.URLRequest;

	import org.vanrijkom.far.FarEvent;
	import org.vanrijkom.far.FarStream;

	import com.paperworld.logging.ILogger;
	import com.paperworld.logging.LoggerFactory;	

	//--------------------------------------
	//  Events
	//--------------------------------------
	/**
	 *  Dispatched when the the archive has dispatched a progress event.
	 *
	 *  @eventType flash.events.ProgressEvent.PROGRESS
	 *
	 * @langversion 3.0
	 */
	[Event(name="progress", type="flash.events.ProgressEvent")]

	/**
	 *  Dispatched when the entire archive has finished loading
	 *
	 *  @eventType flash.events.Event.INIT
	 *
	 * @langversion 3.0
	 */
	[Event(name="init", type="flash.events.Event")]

	/**
	 * Handles loading a Flash Archive (FAR) file.
	 * 
	 * <p>The archive created by the FAR application contains a table of contents, each item in the table is keyed with a <code>String</code> index that 
	 * relates to a type of <code>FileRequest</code>. The content of each element loaded from the archive is processed by the correct type of 
	 * <code>FileRequest</code> once the load of that element has completed, rather than waiting for the whole archive to be downloaded before processing.</p>
	 */
	public class FARFileRequest extends FileRequest
	{
		private var $logger : ILogger

		private var $count : int = 0

		private var $filesLoaded : int = 0

		public function FARFileRequest( key : String, node : XML )
		{
			super( key, node );
			
			$logger = LoggerFactory.getLogger( this );
			
			configureListeners( FarStream( $loader ) )
		}

		/**
		 * @inheritDoc
		 * 
		 * Listen for FAR events.
		 */
		override protected function configureListeners( dispatcher : IEventDispatcher ) : void 
		{
			dispatcher.addEventListener( FarEvent.TABLE_COMPLETE, tableCompleteHandler )
			dispatcher.addEventListener( FarEvent.ITEM_COMPLETE, itemCompleteHandler )
			dispatcher.addEventListener( FarEvent.ITEM_PROGRESS, itemProgressHandler )
		}

		/**
		 * Called when the FAR table has downloaded and been uncompressed. 
		 */
		private function tableCompleteHandler( event : FarEvent ) : void 
		{
			$count = event.file.count
		}

		private function itemProgressHandler( event : FarEvent ) : void 
		{
			var percent : int = ( bytesLoaded / bytesTotal ) * 100
			
			//dispatchEvent( new LoadProgressEvent( percent, ProgressEvent.PROGRESS ) )
		}

		private function itemCompleteHandler( event : FarEvent ) : void 
		{
			$filesLoaded++
			
			/*var request:FileRequest = getFileRequest( event.item.index )
			request.data = event.item.asText()
			request.onLoadComplete()
			
			if ( $filesLoaded == $count ) dispatchEvent( new Event( Event.INIT ) )*/
		}

		override public function createLoader() : EventDispatcher 
		{
			return new FarStream( )
		}

		override public function load() : void 
		{
			FarStream( $loader ).load( new URLRequest( $filePath ) )
		}

		override public function getLoaderTarget() : EventDispatcher
		{
			return FarStream( $loader )
		}

		override public function get bytesLoaded() : int 
		{
			return FarStream( $loader ).bytesLoaded
		}

		override public function get bytesTotal() : int 
		{
			return FarStream( $loader ).bytesTotal
		}
	}
}
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
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	
	import com.paperworld.PaperWorld;
	import com.paperworld.framework.loading.events.LoadProgressEvent;
	import com.paperworld.framework.module.AbstractModule;
	import com.paperworld.logging.ILogger;
	import com.paperworld.logging.LoggerFactory;
	import com.paperworld.managers.LibraryManager;	

	/**
	 * <p>An abstract class for presenting a preload view to the user while a game (a set of modules) is loading.</p>
	 */
	public class AbstractPreloader extends AbstractModule
	{
		//--------------------------------------
		// PUBLIC
		//--------------------------------------
		
		/**
		 * Graphic Keys.
		 */
		public static const WINDOW_BACKGROUND_KEY : String = "WindowBackground";
		
		/**
		 * Constructor.
		 */
		public function AbstractPreloader()
		{
			super( );
			
			$logger = LoggerFactory.getLogger( this );
		}

		/**
		 * Overrides the <code>AbstractModule.initialise()</code> method to add this class's resize handler.
		 */
		override public function initialise(target : Sprite) : void 
		{			
			super.initialise( target );
			
			var stage : Stage = PaperWorld.getInstance( ).stage;
			stage.addEventListener( "resize", alignAssets );
		}
		
		private function createBackground() : void 
		{			
			$logger.info( "Creating background" );
			
			$background = LibraryManager.getInstance( ).getMovieClip( getProperty( "name" ), WINDOW_BACKGROUND_KEY );
			$background.x = -($background.width / 2);
			$background.y = -($background.height / 2);
			
			$logger.info( "Background: " + $background );
			target.name = "testName";
			target.addChild( $background );
		}
		
		private function createAssets() : void 
		{
		}

		/**
		 * Re-aligns the base display object for the view, all a child class's objects should be
		 * added to the <code>target</code> property of this module to ensure they're all re-aligned.
		 */
		public function alignAssets( event : Event = null ) : void 
		{
			var stage : Stage = PaperWorld.getInstance( ).stage;
			
			target.x = stage.stageWidth / 2; 
			target.y = stage.stageHeight / 2;
		}

		/**
		 * Should be overridden by a child class to handles a <code>LoadProgressEvent</code> from a <code>LoaderQueue</code>.
		 */
		public function onLoadProgress(event : LoadProgressEvent) : void 
		{
			$logger.info( "LOADER PROGRESS: Load Progress" );
		}

		/**
		 * Should be overridden by a child class to handles a <code>LoadCompleteEvent</code> from a <code>LoaderQueue</code>.
		 */
		public function onLoadComplete(event : Event) : void 
		{
			$logger.info( "LOADER VIEW: Load Complete" );
		}
		
		//--------------------------------------
		// PRIVATE
		//--------------------------------------
		
		/**
		 * Logger instance.
		 */
		private var $logger : ILogger;

		private var $background : MovieClip;
	}
}
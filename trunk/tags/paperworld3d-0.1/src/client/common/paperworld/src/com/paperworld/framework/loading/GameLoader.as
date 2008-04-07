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
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;

	import com.paperworld.framework.constants.Constants;
	import com.paperworld.framework.loading.events.LoadProgressEvent;
	import com.paperworld.framework.module.AbstractModule;
	import com.paperworld.framework.module.ModuleData;
	import com.paperworld.logging.ILogger;
	import com.paperworld.logging.LoggerFactory;
	import com.paperworld.managers.FileRequestManager;
	import com.paperworld.managers.PropertiesManager;
	import com.paperworld.framework.locale.LocaleContext;	

	/**
	 * @author Trevor
	 */
	public class GameLoader 
	{
		//--------------------------------------
		// PUBLIC
		//--------------------------------------
		
		/**
		 * <p>Constructor. When <code>LoadManager.loadGame()</code> is called it creates an instance of this class.
		 * 
		 * @param request Contains the information about the Game and how it should be loaded.
		 * 
		 * @see com.paperworld.framework.loading.GameLoadRequest
		 * @see com.paperworld.framework.loading.LoadManager
		 */
		public function GameLoader(request : GameLoadRequest)
		{		
			$logger = LoggerFactory.getLogger( this );

			$game = request.game;
			$target = request.target;
			$usePreloader = request.usePreloader;
			$locale = request.localeContext.locale;
		}

		/**
		 * Set this load running.
		 */
		public function load() : void 
		{
			if ($usePreloader)
				initialiseLoader( );
			else
				loadGame( );				
		}

		/**
		 * Loads the components that are listed in the GameConfig node in the config.
		 * 
		 * @param event The Event.COMPLETE event from the module loader used to load the preloader.
		 */
		public function loadGame(event : Event = null) : void
		{
			// Create a new ModuleLoader instance to handle loading all the files.
			var moduleLoader : ModuleLoader = new ModuleLoader( );
			moduleLoader.addEventListener( Event.COMPLETE, gameLoaded );
			
			// Keep a local copy of the PropertiesManager.... just for a laugh.
			var propertiesManager : PropertiesManager = PropertiesManager.getInstance( );
						
			// If a preloader is required for this load then initialise it here and
			// add the event listeners so the preload view can display progress.
			if ($usePreloader)
			{
				initialiseModule( Constants.LOADER_KEY );
				var loaderModule : AbstractModule = propertiesManager.getModule( Constants.LOADER_KEY );
				moduleLoader.loader.addEventListener( Event.COMPLETE, AbstractPreloader( loaderModule ).onLoadComplete );
				moduleLoader.loader.addEventListener( LoadProgressEvent.LOAD_PROGRESS_EVENT, AbstractPreloader( loaderModule ).onLoadProgress );
			}	
			
			// Add each of the game's constituent modules to the loader.
			for each (var gameModule:XML in propertiesManager.getGameDetails($game)[Constants.GAME_MODULE_KEY].children())
				moduleLoader.addModule( gameModule );
			
			// Add the game module to the loader.
			moduleLoader.addGame( $game );
			
			// Start the loader loading.
			moduleLoader.load( );
		}

		//--------------------------------------
		// PRIVATE
		//--------------------------------------

		/**
		 * The name of the game being loaded.
		 */
		private var $game : String;

		/**
		 * The <code>Sprite</code> that the game loaded will use as the base of its display tree.
		 */
		private var $target : Sprite;

		/**
		 * Flags whether this game load will use a preloader.
		 */
		private var $usePreloader : Boolean;

		/**
		 * The locale this game needs to be loaded from/for. 
		 */
		private var $locale : String;

		/**
		 * Logger instance.
		 */
		private var $logger : ILogger;

		/**
		 * Loads the loader skin and properties for this brand.
		 * when the loading is complete, calls loadGame()
		 */
		private function initialiseLoader() : void
		{
			// If the Loader module has already loaded then just go ahead and load the game.
			if (FileRequestManager.getInstance( ).isComponentLoaded( Constants.LOADER_KEY ))
			{
				loadGame( );
			}
			else
			{
				// The Loader module needs loading before we can load the game that's been requested.
				var moduleLoader : ModuleLoader = new ModuleLoader( );
				moduleLoader.addModule( Constants.LOADER_KEY );
				moduleLoader.addEventListener( Event.COMPLETE, loadGame );
				moduleLoader.load( );
			}
		}

		/**
		 * The game load has completed. Initialise the modules that it consists of.
		 */
		private function gameLoaded(event : Event) : void
		{			
			// Get the list of modules that make up the game that's been requested.			
			var gameComponents : XMLList = PropertiesManager.getInstance( ).getGameDetails( $game ).(@name == Constants.GAME_MODULE_KEY);

			// Initialise a module that matches the game.
			initialiseModule( $game );
			
			// Initialise each game component as a module.
			for each (var element:XML in gameComponents.children())
				initialiseModule( element.toString( ) );
		}

		/**
		 * Initialise the Module that relates to the name passed.
		 */
		private function initialiseModule(key : String) : void 
		{
			// Retrieve the class name given in the module's config file.
			var className : String = PropertiesManager.getInstance( ).getModuleData( key ).moduleClass;
			
			// If a class name exists for this module then create an instance of that class.
			if (className != null)
			{
				// Create the class.
				var ModuleInstance : Class = getDefinitionByName( className ) as Class;
				var module : AbstractModule = new ModuleInstance( ) as AbstractModule;
				
				// Create the data for the class and pass it to the module.
				var moduleData : ModuleData = PropertiesManager.getInstance( ).getModuleData( key );
				module.data = moduleData;
				
				// Register the module instance with the PropertiesManager.
				PropertiesManager.getInstance( ).setModule( key, module );
				
				// Call the module's initialise() method.	
				module.initialise( $target );
			}
		}		
	}
}

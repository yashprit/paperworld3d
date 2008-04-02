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
package com.paperworld
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import com.paperworld.framework.constants.Constants;
	import com.paperworld.framework.loading.GameLoadRequest;
	import com.paperworld.framework.locale.LocaleContext;
	import com.paperworld.framework.module.AbstractModule;
	import com.paperworld.framework.module.ModuleData;
	import com.paperworld.logging.ILogger;
	import com.paperworld.logging.LoggerFactory;
	import com.paperworld.managers.LoadManager;
	import com.paperworld.managers.PropertiesManager;		

	/**
	 * <p>System entry point. This Singleton is created by the initialiser when it loads the paperworld library</p>
	 * 
	 * <p><code>PaperWorld</code> acts as a central point of reference for the whole application. It stores various global variables
	 * (e.g. The uri to connect to, a reference to the <code>Stage</code> for classes that need to add key listeners etc.) and 
	 * loads and parses the global configuration file on start-up, once this file has been loaded it immediately attempts to initialise
	 * the game named in its <code>defaultGame</code> property.</p>
	 */
	public class PaperWorld extends AbstractModule
	{
		//--------------------------------------
		// PUBLIC
		//--------------------------------------
		
		/**
		 * The String name of the current game being worked with.
		 */
		public var module : String = "";

		/**
		 * Returns the game type currently in use.
		 */
		public function get currentModule() : AbstractModule
		{
			return PropertiesManager.getInstance( ).getModule( module );
		}		

		/**
		 * Returns a reference to the Stage.
		 */
		public function get stage() : Stage
		{
			return target.stage;
		}

		/**
		 *  Constructor, can only be called from getInstance method to enforce Singleton behaviour.
		 * 
		 *  @param caller passed from getInstance() to enforce Singleton behaviour.
		 */
		public function PaperWorld( singleton : Singleton )
		{	
			$logger = LoggerFactory.getLogger( this );
		}

		/**
		 * Return the singleton instance of this class.
		 */
		public static function getInstance() : PaperWorld
		{
			if ( $instance == null ) 
            	 $instance = new PaperWorld( new Singleton( ) );
			
			return $instance;
		}

		/**
		 * Initialise the core.
		 * Set the parameters passed in via the url query string.
		 */
		override public function initialise(target : Sprite) : void
		{			
			this.target = target;
			loadConfiguration( );
		}
		
		/**
		 * Load the default game.
		 */
		public function loadGame() : void
		{			
			var request : GameLoadRequest = new GameLoadRequest( module, target, new LocaleContext() );
			LoadManager.loadGame(request);
		}

		//--------------------------------------
		// PROTECTED
		//--------------------------------------

		/**
		 * <p>Initialise listeners for the module. </p>
		 * 
		 * <ul>
		 * 		<li>"resize" listener to the <code>Stage</code></li>
		 * </ul>
		 */
		protected function initListeners() : void 
		{
			stage.addEventListener( "resize", alignStage );
		}	

		//--------------------------------------
		// PRIVATE
		//--------------------------------------

		/**
		 * <p>Loads the global configuration file which contains:</p> 
		 * 
		 * <ul>
		 * 		<li>The default properties for this instance of the application.</li>
		 * 		<li>The list of games that this instance of the application has access to.</li>
		 * </ul>
		 */
		private function loadConfiguration() : void 
		{
			$logger.info( "loading configuration" );
			
			var configURL : String = "conf/config.xml";
			
			var loader : URLLoader = new URLLoader( );
			loader.addEventListener( Event.COMPLETE, configLoaded );
	
			loader.load( new URLRequest( configURL ) );
		}

		/**
		 * Handles the configuration file loaded completing. Parses the file to register the 
		 * core paperworld properties.
		 */
		private function configLoaded( event : Event ) : void
		{
			$logger.info( "config loaded" );
			
			var xml : XML = new XML( event.target[Constants.DATA_CONFIG_KEY].toString( ) );
			
			PropertiesManager.getInstance( ).properties = xml;
			
			for each (var element:XML in xml[Constants.MODULE_CONFIG_KEY])
			{
				var data : ModuleData = new ModuleData( );
				data.name = element.@name;

				data.parseSettingsFromXml( element );
			
				PropertiesManager.getInstance( ).setModuleData( element.@name, data );
			}	
			
			configProcessed( );
		}
		
		/**
		 * Called when parsing of the global configuration file is complete. 
		 * 
		 * Sets the data for this instance of the application.
		 * Ensures the stage is created correctly and starts to load the default game.
		 */
		private function configProcessed() : void 
		{
			data = PropertiesManager.getInstance( ).getModuleData( Constants.PAPERWORLD_KEY );
			module = getProperty( Constants.DEFAULT_MODULE_KEY );
			
			drawStage( );
			initListeners( );
			loadGame( );
		}
		
		/**
		 * The singleton instance of this class.
		 */
		private static var $instance : PaperWorld;

		/**
		 * Logger.
		 */
		private var $logger : ILogger;
	}
}

class Singleton
{
}
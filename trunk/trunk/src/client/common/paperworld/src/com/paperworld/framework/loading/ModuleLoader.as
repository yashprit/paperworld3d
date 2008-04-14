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

	import com.paperworld.framework.constants.Constants;
	import com.paperworld.framework.loading.events.LoaderQueueEvent;
	import com.paperworld.framework.loading.filerequests.ConfigFileRequest;
	import com.paperworld.framework.loading.filerequests.FileRequest;
	import com.paperworld.framework.loading.filerequests.LanguageFileRequest;
	import com.paperworld.framework.loading.filerequests.LibraryFileRequest;
	import com.paperworld.framework.loading.filerequests.ModelsFileRequest;
	import com.paperworld.framework.loading.filerequests.PropertiesFileRequest;
	import com.paperworld.framework.loading.filerequests.SkinFileRequest;
	import com.paperworld.framework.loading.filerequests.StylesheetFileRequest;
	import com.paperworld.framework.module.ModuleData;
	import com.paperworld.logging.ILogger;
	import com.paperworld.logging.LoggerFactory;
	import com.paperworld.managers.FileRequestManager;
	import com.paperworld.managers.PropertiesManager;	

	//--------------------------------------
	//  Events
	//--------------------------------------
	
	/**
	 *  Dispatched when all components for all the modules added to the list have finished loading.
	 *
	 *  @eventType flash.events.Event.COMPLETE
	 *
	 * @langversion 3.0
	 */
	[Event(name="complete", type="flash.events.Event")]

	/**
	 * <p>The <code>ModuleLoader</code> class provides the functionality to load all the components of a module and any required modules
	 * defined by the module's config file.</p>
	 * 
	 * <p>When a module is added to this class via the <code>addModule()</code> method this class attempts to load the config file from the 
	 * module from the default location - <i>deploy directory</i>/<i>module name</i>/<i>conf.xml</i></p>.
	 * 
	 * <p>Once all the config files are loaded we loop through them all to check if any of the modules requested require other modules 
	 * to be loaded - if there are required moudules and these module's config files have not been loaded then they're added to the <code>LoaderQueue</code
	 * and it is restarted (this will not result in reloading the config files already loaded due to the intelligence of the <code>LoaderQueue</code>).</p>
	 * 
	 * <p>Once all the config files for all modules and required modules are loaded the <code>LoaderQueue</code> is cleared and all
	 * the components for all the modules are added to it and loaded.</p>
	 *  
	 * @author trevor.burton
	 */
	public class ModuleLoader extends EventDispatcher
	{	
		/**
		 * The <code>LoaderQueue</code> used to load all the files.
		 */
		public var loader : LoaderQueue;

		/**
		 * Constructor.
		 */
		public function ModuleLoader()
		{		
			//$logger = LoggerFactory.getLogger( this );
			
			loader = new LoaderQueue( );
			loader.addEventListener( Event.COMPLETE, configsLoaded );
		}

		/**
		 * Start the module loading process.
		 */
		public function load() : void
		{	
			loader.startLoading( );
		}

		/**
		 * Adds a game's module to the list of required modules.
		 * 
		 * @param key The name of the game to add to the list of modules.
		 */
		public function addGame(key : String) : void 
		{
			//$logger.info( "Adding Game: " + key );
			var request : FileRequest = new ConfigFileRequest( key, "games/" + key + "/conf.xml" );
			request.type = "config";
			loader.addFileRequest( request );
		}

		/**
		 * Adds a module to the list of required modules.
		 * 
		 * @param key The name of the module to add to the list of modules.
		 */
		public function addModule(key : String) : void
		{
			var request : FileRequest = new ConfigFileRequest( key, "modules/" + key + "/conf.xml" );
			request.type = "config";
			loader.addFileRequest( request );	
		}

		/**
		 * Add a set of components to the <code>LoaderQueue</code> being used to load this module.
		 * 
		 * <p><code>addComponents()</code> first checks to see if this module has already been loaded. if it has then there's
		 * no need to reload (even loading from the cache is going to cause a delay) so we can jump straight to the completed load
		 * event handler.</p>
		 *
		 * <p>The next step is to iterate through the list of components defined for this module in the configuration file loaded
		 * at runtime. A <code>FileRequest</code> object is created for each component and this object is added to the 
		 * <code>LoaderQueue</code></p>
		 * 
		 * <p>Then we check for any other modules that the requested module requires for its operation. They're added to the queue with 
		 * another call to this method. So all requirements for all modules are added recursively.</p>
		 * 
		 * @param key 		The String name of the module to be loaded - relates to the @name attribute of the module in the configuration file.
		 */
		public function addComponents(key : String) : void 
		{		
			//$logger.info( "adding components: " + key );
					
			var propertiesManager : PropertiesManager = PropertiesManager.getInstance( );	
			var moduleData : ModuleData = propertiesManager.getModuleData( key );
			for (var i:String in moduleData)
			{
				//$logger.info( i + " => " + moduleData[i] );
			}
			
			//$logger.info( "TYPE: " + moduleData.type );
			var components : XML = moduleData.moduleComponents;
			
			//$logger.info( "COMPONENTS: " + components.name( ).toString( ) );
			
			for each (var component:XML in components.children( ))
			{
				//$logger.info( "component => " + component.name( ) );
				
				var request : FileRequest;
				var name : String = component.name( ).toString( );
				
				if (FileRequestManager.getInstance( ).containsRequest( key, name ))
				{
					request = FileRequestManager.getInstance( ).getFileRequest( key, name );
				}
				else
				{
					if (name == "library-component")
					{
						//$logger.info( moduleData.type + "s/" + key + "/lib/" + component.toString( ) );
						request = new LibraryFileRequest( key, moduleData.type + "s/" + key + "/lib/" + component.toString( ) );
					}
					else
					{
						var filePath : String = moduleData.type + "s/" + key + "/locale/en_us/" + component.toString( );
						//$logger.info( "FilePath: " + filePath );
						
						switch (component.name( ).toString( ))
						{
							case "skin-component":							
								request = new SkinFileRequest( key, filePath );
								break;
							case "properties-component":
								request = new PropertiesFileRequest( key, filePath );
								break;
							case "stylesheet-component":
								request = new StylesheetFileRequest( key, filePath );
								break;
							case "language-component":
								request = new LanguageFileRequest( key, filePath );
								break;
							case "models-component":
								request = new ModelsFileRequest( key, component );
							default:
								break;
						}
					}
					
					FileRequestManager.getInstance( ).addFileRequest( key, name, request );	
				}
					
				request.type = component.name( ).toString( );			
				loader.addFileRequest( request );
			}
			/*
			for each ( var element:XML in filePaths )
			{				
			var request : FileRequest = FileRequest.getFileRequest( key, element, moduleData.root );

			loader.addFileRequest( request );
			}
			 */
			var libraryRequest : FileRequest = FileRequestManager.getInstance( ).getFileRequest( key, Constants.LIBRARY_KEY );
			//$logger.info( "libraryREquest: " + libraryRequest );
			if (libraryRequest != null)
			{
				var requires : XML = moduleData.requiredLibraries;
				//$logger.info( "REQUIRED MODULES: " + requires.children( ).length( ) );
				if (requires.children( ).length( ) > 0)
				{
					for each (var module:XML in requires.children( ))
					{
						//$logger.info( "adding required module " + module.toString( ) );
						var requiredModule : String = module.toString( );
						
						addComponents( requiredModule );
						
						var required : FileRequest = FileRequestManager.getInstance( ).getFileRequest( requiredModule, Constants.LIBRARY_KEY );
						libraryRequest.addRequiredRequest( required );
					}
				}
			}
		}	

		//--------------------------------------
		// PRIVATE
		//--------------------------------------
		
		/**
		 * Logger instance.
		 */
		//private var $logger : ILogger;

		/**
		 * Returns <code>true</code> if all the config files for all modules
		 * (including required modules) have been loaded.
		 */
		private function allConfigsLoaded(modules : Array) : Boolean
		{
			//$logger.info( "Checking if configs loaded for : " + modules );
			for each (var i:String in modules)
			{
				//$logger.info( "Module: " + i );
				if (PropertiesManager.getInstance( ).getModuleData( i ))
				{
					if (PropertiesManager.getInstance( ).getModuleData( i ).requiredLibraries != null)
					{
						if (PropertiesManager.getInstance( ).getModuleData( i ).requiredLibraries.descendants( "required-library" ).children( ).length( ) > 0)
						{
							for each (var j:XML in PropertiesManager.getInstance( ).getModuleData( i ).requiredLibraries.descendants( "required-library" ))
							{
								//$logger.info( "Required Library: " + j );
								if (PropertiesManager.getInstance( ).getModuleData( j ) == null)
								{
									//$logger.info( "Required library not present" );
									return false;								
								}
							}
						}
					}
				}
			}
			
			return true;
		}

		/**
		 * Adds a config file to the <code>LoaderQueue</code> if it hasn't already been loaded.
		 */
		private function addConfigFiles(modules : Array) : void 
		{
			for each (var i:String in modules)
			{
				//$logger.info( "Adding config for module: " + i );
				if (PropertiesManager.getInstance( ).getModuleData( i ).requiredLibraries != null)
				{
					for each (var j:XML in PropertiesManager.getInstance( ).getModuleData( i ).requiredLibraries.descendants( "required-library" ))
					{
						//$logger.info( "Adding required library: " + j );
						addModule( j.toString( ) );	
					}
				}
			}
		}

		/**
		 * Called when the <code>LoaderQueue</code> has loaded a set of config files.
		 */
		private function configsLoaded(event : LoaderQueueEvent) : void 
		{
			// Get the list of modules whose config files have been loaded.
			var modules : Array = event.fileRequests.getKeySet( );
			
			//$logger.info( "Config files loaded " + allConfigsLoaded( modules ) );

			// If all modules and their required module's config files have been loaded...
			if (allConfigsLoaded( modules ))
			{
				// Remove this method as a listener from the LoaderQueue and clear the queue.
				loader.removeEventListener( Event.COMPLETE, configsLoaded );
				loader.clearQueue( );
				
				// Add all the component files for the modules list.
				for each (var i:String in modules)
					addComponents( i );
				
				// Add the new listener.	
				loader.addEventListener( Event.COMPLETE, allFilesLoaded );
				loader.startLoading( );
			}
			else
			{
				// Run through the list of modules and ensure required modules are added.
				addConfigFiles( modules );
				loader.startLoading( );
			}
			
			// Whether we're loading configs or components, set the queue loading.
			//loader.startLoading( );
		}

		/**
		 * Called when all the component files have been loaded.
		 */
		private function allFilesLoaded( event : Event = null ) : void 
		{
			dispatchEvent( event );
		}
	}
}
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
package com.paperworld.managers 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	import flash.media.Sound;
	import flash.system.ApplicationDomain;
	
	import com.paperworld.PaperWorld;
	import com.paperworld.framework.constants.Constants;
	import com.paperworld.framework.module.AbstractModule;
	import com.paperworld.logging.ILogger;
	import com.paperworld.logging.LoggerFactory;
	
	import de.polygonal.ds.HashMap;	

	/**
	 * <p>Keeps track of Skin and Sound assets in the application. Provides access to those
	 * assets.</p>
	 * 
	 * @author trevor.burton
	 */
	public class LibraryManager
	{
		//--------------------------------------
		// PUBLIC
		//--------------------------------------
		
		/**
		 * Constructor.
		 */
		public function LibraryManager(singleton : Singleton)
		{
			$logger = LoggerFactory.getLogger( this );
			
			$assets = new HashMap( );
		}

		/**
		 * Return an instance of this class.
		 */
		public static function getInstance() : LibraryManager
		{
			if ($instance == null)
				$instance = new LibraryManager( new Singleton( ) );
			
			return $instance;
		}
		
		/**
		 * Add a skin library.
		 */
		public function addSkinLibrary(component : String, loader : Loader) : void
		{
			addLibrary( component + Constants.SKIN_KEY, loader );
		}

		/**
		 * Add a sound library.
		 */
		public function addSoundLibrary(component : String, loader : Loader) : void
		{
			addLibrary( component + Constants.SOUND_KEY, loader );
		}

		/**
		 * Remove a skin library.
		 */
		public function removeSkinLibrary(component : String) : void
		{
			//removeMovie(component + CoreXMLConstants.SKIN_KEY);
			var loader : Loader = getLibrary( component + Constants.SKIN_KEY ) as Loader;
			PaperWorld.getInstance( ).target.removeChild( loader );
		}

		/**
		 * Remove a sound library.
		 */
		public function removeSoundLibrary(component : String) : void
		{
			removeLibrary( component + Constants.SOUND_KEY );
		}	

		/**
		 * Return a skin asset as a MovieClip.
		 */
		public function getMovieClip(component : String, key : String) : MovieClip 
		{
			var AssetClass : Class = getLibraryClass( component + Constants.SKIN_KEY, key );
			
			if (AssetClass != null)
			{
				return new AssetClass( ) as MovieClip;
			}
			
			return null;
		}

		/**
		 * Return a skin asset as a Bitmap.
		 */
		public function getBitmap(component : String, key : String) : Bitmap
		{
			var AssetClass : Class = getLibraryClass( component + Constants.SKIN_KEY, key );
			
			if (AssetClass != null)
			{
				return new AssetClass( ) as Bitmap;
			}
			
			return null;
		}

		/**
		 * <p>Returns a <code>BitmapData</code> instance created from an asset in a skin library.</p>
		 * 
		 * <p>Relies on correct property having been defined in the properties file for the module requested.
		 * The dimensions of the <code>BitmapData</code> must be defined in the properties file.</p>
		 */
		public function getBitmapData(module : AbstractModule, key : String) : BitmapData
		{
			var dimensions : Array = module.getProperty( key + "Dimensions" ).split( "," );
			var width : Number = Number( dimensions[0] );
			var height : Number = Number( dimensions[1] );
			
			var BitmapInstance : Class = getLibraryClass( module.getProperty( "name" ) + Constants.SKIN_KEY, key );
			
			return new BitmapInstance( width, height );
		}

		/**
		 * Return a sound object.
		 */	
		public function getSound(component : String, key : String) : Sound
		{
			var AssetClass : Class = getLibraryClass( component + Constants.SOUND_KEY, key );
			
			if (AssetClass != null)
			{
				return new AssetClass( ) as Sound;
			}
			
			return null;
		}

		//--------------------------------------
		// PRIVATE
		//--------------------------------------
		
		/**
		 * Logger instance.
		 */
		private var $logger : ILogger;
		
		/**
		 * HashMap to contain loaded assets.
		 */
		private var $assets : HashMap;

		/**
		 * The singleton instance of this class.
		 */
		private static var $instance : LibraryManager;
		
		/**
		 * Add an asset.
		 */
		private function addLibrary(key : String, asset : *) : void
		{
			$assets.insert( key, asset );
		}
		
		/**
		 * Remove a library.
		 */
		private function removeLibrary(key : String) : void
		{
			$assets.remove( key );
		}
		
		/** 
		 * Return a library.
		 */
		private function getLibrary(key : String) : EventDispatcher
		{				
			return $assets.find( key ) as EventDispatcher;
		}
		
		/**
		 * Return a <code>Loader</code>.
		 */
		private function getLoader(component : String) : Loader 
		{
			return getLibrary( component ) as Loader;
		}
		
		/**
		 * Return the <code>ApplicationDomain</code> the component requested was loaded into.
		 */
		private function getApplicationDomain(component : String) : ApplicationDomain
		{
			var loader : Loader = getLoader( component );
			
			if (loader != null)
			{
				return loader.contentLoaderInfo.applicationDomain;
			}
			
			return null;
		}

		/**
		 * Returns the <code>Class</code> reference for the key passed.
		 */
		private function getLibraryClass(component : String, key : String) : Class 
		{
			var appDomain : ApplicationDomain = getApplicationDomain( component );
			
			if (appDomain != null)
			{
				//logger.info("App domain: " + appDomain);
				if (appDomain.hasDefinition( key ))
				{
					return appDomain.getDefinition( key ) as Class;
				}
			}
			
			return null;
		}
	}
}

class Singleton
{
}
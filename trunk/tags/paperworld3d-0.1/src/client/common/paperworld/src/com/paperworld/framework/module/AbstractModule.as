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
package com.paperworld.framework.module
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.flash_proxy;

	import com.paperworld.PaperWorld;
	import com.paperworld.logging.ILogger;
	import com.paperworld.logging.LoggerFactory;
	import com.paperworld.managers.LanguageManager;
	import com.paperworld.managers.PropertiesManager;

	import de.polygonal.ds.HashMap;		

	/**
	 * <p><code>AbstractModule</code> provides a base class for all module implementations to extend.</p>
	 * 
	 * <p>Provides a set of methods and properties that initialise the module and handle common events
	 * to remove the need to duplicate this functionality in each module created.</p>
	 */
	public class AbstractModule extends EventDispatcher
	{
		//--------------------------------------
		// PUBLIC
		//--------------------------------------

		/**
		 * @private
		 * The root display object for this module.
		 */
		public var target : Sprite;

		/**
		 * @private
		 * The properties of this module.
		 */
		public var data : ModuleData;

		/**
		 * The pages for this module.
		 */
		public var pages : HashMap;

		/**
		 * Returns the name of this module.
		 */
		public function name() : String 
		{
			return getProperty( "name" ) as String;
		}

		/**
		 * Constructor.
		 */
		public function AbstractModule()
		{
			$logger = LoggerFactory.getLogger( this );
			
			$languageManager = LanguageManager.getInstance( );
			
			$targetPosition = new Array( 0, 0 );
			pages = new HashMap( );		
		}

		/**
		 * Initialises the basic properties of this module.
		 * <p><code>initialise()</code> is called by the child class that is extending <code>AbstractModule</code>
		 * 
		 * @param target The display object that will become the root display object for this module.
		 */
		public function initialise(target : Sprite) : void 
		{			
			getSettings( );
			
			// Create a new Sprite that will be the root display object for this module.
			this.target = target.addChild( new Sprite( ) ) as Sprite;
		}

		/**
		 * Removes the module's visible elements from the display 
		 * list and cleans up it's properties so they can be picked up by GC.
		 */
		public function destroy() : void 
		{
			//$logger.info("destroying: " + this.target + ", " + (this.target.parent as Sprite));
			//var child:Sprite = this.target;
			//(this.target.parent as Sprite).removeChild( child );
			//$base.removeChild(target);
		}

		/**
		 * Set the value of a property on this module.
		 * <p>This is generally used by the initialisation process but it made public in order that
		 * it can be used arbitrarily by developers during a module's lifetime.
		 */
		public function setProperty( key : *, value : * ) : void 
		{
			data.flash_proxy::setProperty( key, value );
		}

		/**
		 * Get a property's value.
		 */
		public function getProperty( key : String ) : *
		{
			return data.flash_proxy::getProperty( key );
		} 

		/**
		 * Get a property's value as a String.
		 */
		public function getStringProperty(key : String) : String 
		{
			return getProperty( key ) as String;
		}

		/**
		 * Get a property's value as an Array.
		 * <p>Pass a value for the list's delimiter - defaults to ","</p>
		 */
		public function getArrayProperty(key : String, delimiter : String = ",") : Array 
		{
			return getProperty( key ).split( delimiter );
		}

		/**
		 * Called when a Stage.resize event is fired. This method provides basic functionality and is 
		 * made public so it can be overridden to allow custom functionality in child modules.
		 */
		public function alignStage( event : Event = null ) : void
		{
			var stage : Stage = PaperWorld.getInstance( ).stage;
			
			target.x = $targetPosition[0];
			target.y = $targetPosition[1];

			drawStage( );
		}

		public function getString(key : String) : String
		{
			return $languageManager.getString( key );
		}

		/**
		 * Called as part of the stage resize handling mechanism. This basic implementation simply colours the
		 * viewable area of the screen with the colour defined in the module's <code>backgroundColour</code> property.
		 */
		public function drawStage() : void
		{
			var graphics : Graphics = PaperWorld.getInstance( ).target.graphics;
			var stage : Stage = PaperWorld.getInstance( ).stage;
			
			graphics.clear( );
			graphics.beginFill( getProperty( "backgroundColour" ), 100 );
			graphics.drawRect( $targetPosition[0], $targetPosition[1], stage.stageWidth, stage.stageHeight );
			graphics.endFill( );
		}

		//--------------------------------------
		// PRIVATE
		//--------------------------------------
		
		/**
		 * The position the root display object for this module will be placed at when a Stage.resize event fires.
		 */
		private var $targetPosition : Array;

		/**
		 * The <code>LanguageManager</code> instance this module uses to manage language keys.
		 */
		private var $languageManager : LanguageManager;

		/**
		 * Logger instance.
		 */
		private var $logger : ILogger;

		/**
		 * Tries to get hold of the settings for this module.
		 * 
		 * @throws If there are no settings for this module, logs a message.
		 */
		private function getSettings() : void
		{			
			var settings : XML = PropertiesManager.getInstance( ).getModuleProperties( getProperty( "name" ) );
			
			try 
			{
				data.parseSettingsFromXml( settings );
			}
			catch (error : Error)
			{
			}
		}
	}
}
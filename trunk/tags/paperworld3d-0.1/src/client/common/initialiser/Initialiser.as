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
package 
{
	import flash.text.TextField;	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;

	import com.paperworld.PaperWorld;	

	public class Initialiser extends Sprite
	{
		private const PAPERWORLD_URL_KEY : String = "paperworldURL";

		private const DEBUG_KEY : String = "Debug";

		private const LIBRARY_URL_PREFIX : String = "modules/";

		private const LIBRARY_URL_SUFFIX : String = "/lib/library.swf";

		private var libraries : Array = new Array( "logger", "datastructures", "paperworld" );

		private var libCounter : int = 1;

		private var console : TextField;

		public function Initialiser()
		{			
			super( );
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			console = new TextField( );
			console.width = 200;
			addChild( console );
			
			//loadDataStructures();	
			loadLibraries( );		
		}

		private function loadLibraries() : void
		{
			var debug : String = this.loaderInfo.parameters[ DEBUG_KEY ];
			
			if (debug == "true") 
				libCounter--;
				
			loadNextLibrary( );
		}

		private function loadNextLibrary() : void 
		{
			var lib : String = libraries[libCounter];
			
			console.appendText( "loading " + lib + " library\n" );
			
			loadLibrary( LIBRARY_URL_PREFIX + lib + LIBRARY_URL_SUFFIX, libraryLoadComplete );	
		}

		private function libraryLoadComplete(event : Event) : void 
		{
			var lib : String = libraries[libCounter];
			
			console.appendText( lib + " library loaded\n" );
			
			if (libCounter == libraries.length - 1)
			{
				onPaperWorldLoaded( );
			}
			else
			{
				libCounter++;
				loadNextLibrary( );
			}
		}	

		private function loadLibrary(url : String, handler : Function) : void 
		{
			var loader : Loader = new Loader( );
			loader.contentLoaderInfo.addEventListener( Event.COMPLETE, handler );
			
			//var url:String = this.loaderInfo.parameters[ PAPERWORLD_URL_KEY ] 

			var request : URLRequest = new URLRequest( url );
			var context : LoaderContext = new LoaderContext( false, ApplicationDomain.currentDomain )
			
			loader.load( request, context );
		}

		private function onPaperWorldLoaded() : void 
		{
			PaperWorld.getInstance().initialise(this);
		}
	}
}

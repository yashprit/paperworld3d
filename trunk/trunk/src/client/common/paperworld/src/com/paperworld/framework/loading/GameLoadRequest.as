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
	import com.paperworld.framework.locale.LocaleContext;	
	
	import flash.display.Sprite;		

	/**
	 * <p>Encapsulates all the data needed for loading a PaperWorld3D game</p>
	 * 
	 * @author Trevor
	 */
	public class GameLoadRequest 
	{
		/**
		 * The name of the game to load.
		 */
		public var game : String;

		/**
		 * The display object that will form the root of the game's display tree when it initialises.
		 */
		public var target : Sprite;

		/**
		 * Flags whether a preloader is needed for loading this game.
		 */
		public var usePreloader : Boolean;
		
		/**
		 * The locale context to load the game from.
		 */
		public var localeContext : LocaleContext;

		/**
		 * Constructor.
		 */
		public function GameLoadRequest(game : String, target : Sprite, localeContext:LocaleContext, usePreloader : Boolean = true)
		{
			this.game = game;
			this.target = target;
			this.usePreloader = usePreloader;
			this.localeContext = localeContext;
		}
	}
}

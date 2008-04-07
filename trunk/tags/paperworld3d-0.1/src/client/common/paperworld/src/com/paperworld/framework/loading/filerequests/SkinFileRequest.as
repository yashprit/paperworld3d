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
	import flash.display.Loader;
	import flash.events.Event;

	import com.paperworld.managers.LibraryManager;	

	/**
	 * Handles loading a Skin file for a module.</p>
	 */
	public class SkinFileRequest extends LoaderFileRequest
	{
		//--------------------------------------
		// PUBLIC
		//--------------------------------------
		
		/**
		 * Constructor.
		 */
		public function SkinFileRequest( component : String, node : String, root : String = "")
		{
			super( component, root + node );
		}		

		/**
		 * Before beginning to load the file, the <code>Loader</code> object is registered with 
		 * the <code>LibraryManager</code>.
		 */
		override protected function openHandler(event : Event = null) : void 
		{
			LibraryManager.getInstance( ).addSkinLibrary( component, $loader as Loader );
		}
	}
}
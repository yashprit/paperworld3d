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
	import com.paperworld.managers.StyleManager;		

	/**
	 * Designed to load an external Stylesheet file into the PaperWorld framework.
	 */
	public class StylesheetFileRequest extends URLLoaderFileRequest
	{		
		//--------------------------------------
		// PUBLIC
		//--------------------------------------
		
		/**
		 * Constructor.
		 */
		public function StylesheetFileRequest( component : String, node : String, root : String = "" )
		{
			super( component, root + node );
		}

		/**
		 * <p>Customised behaviour called when the style sheet has loaded. Parses the styles contained
		 * in the file into the global stylesheet.</p>
		 */
		override public function onLoadComplete() : void 
		{
			StyleManager.getInstance( ).getStyleSheet( ).parseCSS( data );
			
			super.onLoadComplete( );		
		}
	}
}

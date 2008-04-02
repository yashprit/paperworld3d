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
	import flash.net.URLLoader;	

	/**
	 * <p>This file request is used as a base class for loading xml files used in other areas of the 
	 * framework but can be used on it's own for handling loading of custom XML files.</p>
	 * 
	 * <p>override <code>getContent()</code> to provide functionality that will be performed
	 * when the load has completed.</p>
	 */
	public class XMLFileRequest extends URLLoaderFileRequest
	{
		//--------------------------------------
		// PUBLIC
		//--------------------------------------
		
		/**
		 * Constructor.
		 */
		public function XMLFileRequest( component : String, node : String )
		{
			super( component, node );
		}
		
		//--------------------------------------
		// PROTECTED
		//--------------------------------------

		/**
		 * Returns the XML object that has loaded from the file requested.
		 * 
		 * @param content Optional argument. Used to provide the correct functionality for a file loaded as part of a FAR archive.
		 * 
		 * @return The XML object that has been loaded.
		 */
		protected function getContent( content : * = null ) : XML 
		{
			return new XML( ( content == null ) ? URLLoader( $loader ).data : content );
		}
	}
}
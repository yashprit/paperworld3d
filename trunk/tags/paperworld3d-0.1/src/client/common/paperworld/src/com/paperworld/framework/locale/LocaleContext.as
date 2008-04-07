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
package com.paperworld.framework.locale 
{
	import com.paperworld.framework.constants.Constants;	
	import com.paperworld.PaperWorld;	

	/**
	 * <p>Handles the locale settings for game and module loading.</p>
	 * 
	 * <p>PaperWord3D supports multiple locales which contain files specific for a particular locale (or region).
	 * These can be any type of file capable of being loaded into a game or module, apart from the library.</p>
	 * 
	 * <p>Locale is defined when the application initialises, and can also be switched at runtime. Switching at runtime
	 * is not currently supported in this version, this feature is coming very soon.</p>
	 * 
	 * @author Trevor
	 */
	public class LocaleContext 
	{
		/**
		 * Returns the default locale - defined in the global configuration file.
		 */
		public static var DEFAULT_CONTEXT : String = PaperWorld.getInstance( ).getProperty( Constants.DEFAULT_LOCALE_KEY );
		
		/**
		 * The locale for this context.
		 */
		public var locale:String;

		/**
	 	 * Constructor.
	 	 */
		public function LocaleContext(locale : String = null)
		{
			this.locale = locale || DEFAULT_CONTEXT;
		}
	}
}

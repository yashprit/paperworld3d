package com.paperworld.managers 
{
	import com.paperworld.framework.locale.LocaleContext;	
	
	/**
	 * @author Trevor
	 */
	public class LocaleManager 
	{
		public static var CURRENT_LOCALE:String;
		
		public static function updateLocale(localeContext:LocaleContext):void
		{
			CURRENT_LOCALE = localeContext.locale;
		}
	}
	
	
}

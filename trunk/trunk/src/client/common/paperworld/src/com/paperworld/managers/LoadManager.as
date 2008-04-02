package com.paperworld.managers 
{
	import com.paperworld.framework.loading.GameLoader;	
	import com.paperworld.framework.loading.GameLoadRequest;	
	
	/**
	 * @author Trevor
	 */
	public class LoadManager 
	{
		public static function loadGame(request : GameLoadRequest):void 
		{
			var gameLoader : GameLoader = new GameLoader(request);
			gameLoader.load();	
		}
	}
}

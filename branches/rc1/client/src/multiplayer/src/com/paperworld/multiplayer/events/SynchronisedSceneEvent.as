package com.paperworld.multiplayer.events 
{
	import com.paperworld.scenes.AbstractSynchronisedScene;	
	
	import flash.events.Event;
	/**
	 * @author Trevor
	 */
	public class SynchronisedSceneEvent extends Event 
	{
		public static const CONTEXT_LOADED : String = "ContextLoaded";

		public static const CONNECTED_TO_SERVER : String = "ConnectedToServer";

		public static const CONNECTED_TO_SCENE : String = "ConnectedToScene";

		public static const DISCONNECTED_FROM_SERVER : String = "DisconnectedFromServer";
		
		public var scene : AbstractSynchronisedScene;

		public function SynchronisedSceneEvent(type : String, scene: AbstractSynchronisedScene, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super( type, bubbles, cancelable );
			
			this.scene = scene;
		}
	}
}

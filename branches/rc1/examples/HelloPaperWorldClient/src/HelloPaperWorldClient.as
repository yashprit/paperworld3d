/**
* ...
* @author Default
* @version 0.1
*/

package  
{
	import com.paperworld.scenes.SynchronisedScene;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.NetConnection;
	import flash.events.NetStatusEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import jedai.Red5BootStrapper;
	import jedai.events.Red5Event;
	import com.paperworld.multiplayer.events.SynchronisedSceneEvent;

	public class HelloPaperWorldClient extends Sprite
	{		
		public var bootStrapper:Red5BootStrapper
		
		public function HelloPaperWorldClient()
		{			
			var scene:SynchronisedScene = new SynchronisedScene();
			scene.addEventListener(SynchronisedSceneEvent.CONTEXT_LOADED, onContextLoaded);
			scene.addEventListener(SynchronisedSceneEvent.CONNECTED_TO_SERVER, onConnectedToServer);
			scene.connect("test", "applicationContext.xml");
		}
		
		public function onContextLoaded(event:Event):void 
		{
			trace("Context Loaded");
		}
		
		public function onConnectedToServer(event:Event):void
		{
			trace("\nConnected To Server");
		}
	}
	
	
	
}

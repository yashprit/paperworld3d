package  
{
	import com.paperworld.client.flash.GhostConnection;
	import com.paperworld.client.flash.GhostObject;
	import com.paperworld.client.flash.NetInterface;
	import com.paperworld.flash.NetInterfaceEvent;
	
	import flash.display.Sprite;	

	/**
	 * @author Trevor
	 */
	public class HelloPaperworld extends Sprite 
	{
		private var uri:String = "rtmp://localhost/hellopaperworld";
		
		private var netInterface : NetInterface;

		private var gameConnection : ControlObjectConnection;

		private var netObject : GameObject;

		public function HelloPaperworld()
		{
			netInterface = new NetInterface( );
			gameConnection = new ControlObjectConnection( );
			
			netInterface.addConnection( gameConnection );
			netInterface.addEventListener( NetInterfaceEvent.READY, onNetStatus );
			netInterface.connect(uri);
		}

		private function onNetStatus(event : NetInterfaceEvent) :void 
		{
			netObject = new GameObject();
			netObject.connectionType = ControlObjectConnection.TYPE;
			
			gameConnection.addObject(netObject);
			
			gameConnection.addMove(new Move());
			
			netInterface.processConnections();
		}
	}
}

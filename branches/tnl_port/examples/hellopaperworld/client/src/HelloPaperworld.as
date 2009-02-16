package  
{
	import com.paperworld.flash.GhostConnection;
	import com.paperworld.flash.NetInterface;
	import com.paperworld.flash.NetInterfaceEvent;
	import com.paperworld.flash.NetObject;
	
	import flash.display.Sprite;		

	/**
	 * @author Trevor
	 */
	public class HelloPaperworld extends Sprite 
	{
		private var uri:String = "rtmp://localhost/hellopaperworld";
		
		private var netInterface : NetInterface;

		private var ghostConnection : GhostConnection;

		private var netObject : NetObject;

		public function HelloPaperworld()
		{
			netInterface = new NetInterface( );
			ghostConnection = new GhostConnection( );
			
			netInterface.addConnection( ghostConnection );
			netInterface.addEventListener( NetInterfaceEvent.READY, onNetStatus );
			netInterface.connect(uri);
		}

		private function onNetStatus(event : NetInterfaceEvent) :void 
		{
			ghostConnection.addObject(netObject);
			
			netInterface.processConnections();
		}
	}
}

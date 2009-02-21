package  
{
	import flash.events.Event;	
	import flash.events.KeyboardEvent;	
	
	import com.blitzagency.xray.logger.XrayLog;
	
	import flash.display.Sprite;
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;		

	/**
	 * @author Trevor
	 */
	public class HelloPaperworld extends Sprite 
	{
		private var uri:String = "rtmp://localhost/hellopaperworld";
		
		//private var netInterface : NetInterface;

		//private var gameConnection : ControlObjectConnection;

		//private var netObject : GameObject;
		
		private var netConnection : NetConnection;
		
		private var responder : Responder;
		
		private var id:String;
		
		private var objects:Array = new Array();
		
		private var logger : XrayLog = new XrayLog();
		
		private var up:Boolean = false;
		
		private var down:Boolean = false;
		
		private var left:Boolean = false;
		
		private var right:Boolean = false;

		public function HelloPaperworld()
		{
			/*netInterface = new NetInterface( );
			gameConnection = new ControlObjectConnection( );
			
			netInterface.addConnection( gameConnection );
			netInterface.addEventListener( NetInterfaceEvent.READY, onNetStatus );
			netInterface.connect(uri);*/
			netConnection = new NetConnection( );
			netConnection.addEventListener( NetStatusEvent.NET_STATUS, onNetStatus );
			netConnection.client = this;
			netConnection.connect( uri );
			
			stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown);			stage.addEventListener( KeyboardEvent.KEY_UP, onKeyUp);
			
			responder = new Responder(onResponse, onFault);
		}
		
		private function onKeyDown(event:KeyboardEvent):void
		{
			switch (event.keyCode)
			{
				case 37:
					left = true;
					break;
				
				case 38:
					up = true;
					break;
				
				case 39:
					right = true;
					break;
					
				case 40:
					down = true;
					break;
				
				default:
					break;
			}
		}
		
		private function onKeyUp(event : KeyboardEvent):void 
		{
			logger.info("code: " + event.keyCode);
			switch (event.keyCode)
			{
				case 37:
					left = false;
					break;
				
				case 38:
					up = false;
					break;
				
				case 39:
					right = false;
					break;
					
				case 40:
					down = false;
					break;
				
				default:
					break;
			}
		}

		private function onNetStatus(event : NetStatusEvent) : void 
		{
			/*netObject = new GameObject();
			netObject.connectionType = ControlObjectConnection.TYPE;
			
			gameConnection.addObject(netObject);
			
			gameConnection.addMove(new Move());
			
			netInterface.processConnections();*/
			
			var code:String = event.info.code;			
			logger.info("net status received: " + code);
			
			switch (code)
			{
				case "NetConnection.Connect.Success":
					addEventListener( Event.ENTER_FRAME, update);
					break;
					
				default:
					break;
			}
		}
		
		private function update(event:Event):void 
		{
			var sprite:Sprite = objects[id];
			if (up) sprite.y--;
			if (down) sprite.y++;
			if (right) sprite.x++;
			if (left) sprite.x--;
			
			netConnection.call("checkIncomingPackets", responder, id, sprite.x, sprite.y);
		}
		
		public function setClientId(id:String):void 
		{
			logger.info("setting client id");
			this.id = id;
			
			var obj:Sprite = new Circle(0x00ff00);
			objects[id] = obj;
			addChild(obj);
		}
		
		public function checkIncomingPackets(id:String, x:Number, y:Number):void 
		{
			var obj : Sprite;
			
			if (objects[id] == null) 
			{
				obj = new Circle(0xff0000);
				addChild(obj);
				objects[id] = obj;
			}
			
			obj = objects[id];
			
			obj.x = x;
			obj.y = y;			
		}
		
		public function onResponse(o:Object):void 
		{
			//logger.info("response");
		}
		
		public function onFault(o:Object):void 
		{
			//logger.info("fault");
		}
	}
}

package  
{
	import com.paperworld.client.flash.NetInterface;

	import flash.display.Sprite;		

	/**
	 * @author Trevor
	 */
	public class Game 
	{
		protected var _view : Sprite;

		public function get view() : Sprite
		{
			return _view;
		}

		public function set view(value : Sprite) : void 
		{
			_view = view;
		}

		protected var _netInterface : NetInterface;

		public function set netInterface(value : NetInterface) : void 
		{
			_netInterface = value;
		}

		protected var _connectionToServer : ControlObjectConnection;

		public function set connectionToServer(value : ControlObjectConnection) : void 
		{
			_connectionToServer = value;
		}

		protected var _gameUserInterface : GameUserInterface;

		public function set gameUserInterface(value : GameUserInterface) : void 
		{
			_gameUserInterface = value;
		}

		protected var _gameObjects : Array;

		public function Game() 
		{
			_gameObjects = new Array( );
		}

		public function idle() : void 
		{
			_netInterface.checkIncomingPackets( );
			
			var move : Move = _gameUserInterface.getCurrentMove( );
			
			_connectionToServer.addMove( move );
			
			var controlObject : GameObject = _connectionToServer.controlObject;
			
			for each (var object:GameObject in _gameObjects)
			{
				if (object == controlObject)
				{
					object.currentMove = move;
					object.idle( GameObject.ClientIdleControlMain );
				}
				else
				{
					var m : Move = object.currentMove;
					object.currentMove = m;
					object.idle( GameObject.ClientIdleMainRemote );
				}
			}
		}
	}
}

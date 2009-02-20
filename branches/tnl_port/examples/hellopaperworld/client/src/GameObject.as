package  
{
	import com.paperworld.client.flash.GhostObject;

	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;	

	/**
	 * @author Trevor
	 */
	public class GameObject extends GhostObject 
	{
		public static const ClientIdleMainRemote : int = 0;
		public static const ClientIdleControlMain : int = 1;
		public static const ClientIdleControlReplay : int = 2;

		public static const MOVE_MASK : int = 1 << 0;
		public static const POSITION_MASK : int = 1 << 1;

		protected var _currentMove : Move;

		public function get currentMove() : Move
		{
			return _currentMove;
		}

		public function set currentMove(value : Move) : void 
		{
			_currentMove = value;
		}

		protected var _previousMove : Move;

		public function GameObject()
		{
			super( );
		}

		override public function readExternal(input : IDataInput) : void
		{
			super.readExternal( input );
		}

		override public function writeExternal(output : IDataOutput) : void
		{
			super.writeExternal( output );
		}

		public function idle(path:int) : void 
		{
		}
	}
}

package  
{
	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.api.NetObject;
	import com.paperworld.client.flash.GhostConnection;
	import com.paperworld.client.flash.GhostObject;
	import com.paperworld.flash.PacketStream;		

	/**
	 * @author Trevor
	 */
	public class ControlObjectConnection extends GhostConnection 
	{
		private var logger : XrayLog = new XrayLog( );

		public static const TYPE : String = "ControlObjectConnection";

		override public function get type() : String
		{
			return TYPE;
		}

		protected var _pendingMoves : Array;

		public function addMove(move : Move) : void 
		{
			_pendingMoves.push( move );
		}
		
		protected var _controlObject : GameObject;

		public function get controlObject() : GameObject
		{
			return _controlObject;
		}
		
		public function set controlObject(value : GameObject):void 
		{
			_controlObject = value;
		}

		public function ControlObjectConnection()
		{
			_pendingMoves = new Array( );
		}

		override public function writePacket(stream : PacketStream) : void 
		{
			logger.info( "writing moves" );
			for each (var move:Move in _pendingMoves) 
			{
				logger.info( "writing " + move );
				move.connectionType = type;
				stream.addPacket( move );
			}
			
			_pendingMoves = new Array( );
		}

		override public function readPacket(object : NetObject) : void 
		{
			var ghost : GhostObject = GhostObject( object );
			if (ghost.isInitialUpdate) 
			{
				logger.info( "initial update - adding the ghost to the list" );
				addObject( ghost );
				ghost.isInitialUpdate = false;
			}
		}
	}
}

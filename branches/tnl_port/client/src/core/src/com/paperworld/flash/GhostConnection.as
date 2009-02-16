package com.paperworld.flash 
{
	import com.paperworld.flash.EventConnection;	

	/**
	 * @author Trevor
	 */
	public class GhostConnection extends EventConnection 
	{
		protected var _objects : Array;

		public function GhostConnection()
		{
			super( );
			
			_objects = new Array( );
		}

		public function addObject(object : NetObject) : void 
		{
			_objects.push( object );
		}

		public function removeObject(object : NetObject) : Boolean
		{
			for (var i : int = 0; i < _objects.length ; i++)
			{
				var o : NetObject = NetObject( _objects[i] );
				
				if (o == object) 
				{
					_objects.splice( i, 1 );
					return true;
				}
			}
			
			return false;
		}

		override public function checkPacketSend(force : Boolean, currentTime : int) : void 
		{
			var stream : PacketStream = new PacketStream( );
			
			for each (var object:NetObject in _objects)
			{
				stream.addPacket( object );
			}
			
			_netInterface.sendTo(stream);
		}
	}
}

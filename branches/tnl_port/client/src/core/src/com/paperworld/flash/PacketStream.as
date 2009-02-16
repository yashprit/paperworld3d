package com.paperworld.flash 
{
	import flash.utils.IExternalizable;	

	import com.paperworld.flash.IRegisteredClass;

	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;	

	/**
	 * @author Trevor
	 */
	public class PacketStream implements IRegisteredClass, IExternalizable
	{
		public var _packets : Packet;

		public function get aliasName() : String
		{
			return "com.paperworld.server.api.PacketStream";
		}

		public function PacketStream() 
		{			
			Registration.registerClass( this );
		}
		
		public function addPacket(packet:Packet):void 
		{
			if (_packets)
			{
				_packets.next = packet;
			}
			else
			{
				_packets = packet;
			}
		}

		public function readExternal(input : IDataInput) : void
		{
			//_packets = input.readObject( ) as Array;
		}

		public function writeExternal(output : IDataOutput) : void
		{
			output.writeObject( _packets );
		}
	}
}

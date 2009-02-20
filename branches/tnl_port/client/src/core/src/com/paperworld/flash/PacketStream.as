package com.paperworld.flash 
{
	import com.paperworld.api.NetObject;
	import com.paperworld.flash.util.IRegisteredClass;
	import com.paperworld.flash.util.Registration;
	
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;	

	/**
	 * @author Trevor
	 */
	public class PacketStream implements IRegisteredClass, IExternalizable
	{
		public var packets : NetObject;

		public function get aliasName() : String
		{
			return "com.paperworld.server.flash.PacketStream";
		}

		public function PacketStream() 
		{			
			Registration.registerClass( this );
		}

		public function addPacket(packet : NetObject) : void 
		{
			if (packets)
			{
				packet.next = packets;
				packets = packet;
			}
			else
			{
				packets = packet;
			}
		}

		public function readExternal(input : IDataInput) : void
		{
			packets = NetObject( input.readObject( ) );
		}

		public function writeExternal(output : IDataOutput) : void
		{
			output.writeObject( packets );
		}
	}
}

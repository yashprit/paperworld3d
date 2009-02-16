package com.paperworld.flash 
{
	import flash.utils.IExternalizable;	

	import com.paperworld.flash.IRegisteredClass;

	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;	

	/**
	 * @author Trevor
	 */
	public class Packet implements IRegisteredClass, IExternalizable
	{
		public var next : Packet;

		public function get aliasName() : String
		{
			return "com.paperworld.server.api.Packet";
		}

		public function Packet()
		{
			Registration.registerClass( this );
		}

		public function readExternal(input : IDataInput) : void
		{
			next = Packet( input.readObject( ) );
		}

		public function writeExternal(output : IDataOutput) : void
		{
			output.writeObject( next );
		}
	}
}

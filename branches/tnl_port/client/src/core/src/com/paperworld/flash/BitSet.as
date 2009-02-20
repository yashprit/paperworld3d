package com.paperworld.flash 
{
	import com.paperworld.flash.util.IRegisteredClass;
	import com.paperworld.flash.util.Registration;
	
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;	

	/**
	 * @author Trevor
	 */
	public class BitSet implements IExternalizable, IRegisteredClass
	{
		public var bits : int = 0;

		public function BitSet() 
		{
			Registration.registerClass( this );
		}

		public function set(value : int) : void 
		{
			bits = value;
		}

		public function addOptions(value : int) : void 
		{
			bits |= value;
		}

		public function test(value : int) : Boolean
		{
			return (bits & value) != 0;
		}

		public function readExternal(input : IDataInput) : void
		{
			bits = input.readInt( );
		}

		public function writeExternal(output : IDataOutput) : void
		{
			output.writeInt( bits );
		}

		public function get aliasName() : String
		{
			return "com.paperworld.server.api.BitSet";
		}
	}
}

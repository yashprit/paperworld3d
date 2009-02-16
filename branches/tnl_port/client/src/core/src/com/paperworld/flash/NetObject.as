package com.paperworld.flash 
{
	import flash.utils.IExternalizable;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;	

	/**
	 * @author Trevor
	 */
	public class NetObject extends Packet implements IRegisteredClass, IExternalizable
	{	
		protected var _flags : Object;

		protected var _updateMask : int;

		protected var _tmpUpdateMask : BitSet;

		protected var _isInitialUpdate : Boolean = false;

		override public function get aliasName() : String
		{
			return "com.paperworld.server.api.NetObject";
		}

		public function NetObject()
		{
			Registration.registerClass( this );
		}

		override public function readExternal(input : IDataInput) : void
		{
			super.readExternal( input );
			
			_tmpUpdateMask = BitSet( input.readObject( ) );
		}

		override public function writeExternal(output : IDataOutput) : void
		{
			super.writeExternal( output );
			
			output.writeObject( _updateMask );
		}
	}
}

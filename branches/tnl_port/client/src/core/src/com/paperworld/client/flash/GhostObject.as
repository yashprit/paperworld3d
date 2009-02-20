package com.paperworld.client.flash 
{
	import com.paperworld.api.NetObject;
	import com.paperworld.flash.BitSet;
	import com.paperworld.flash.util.IRegisteredClass;
	import com.paperworld.flash.util.Registration;
	
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;	

	/**
	 * @author Trevor
	 */
	public class GhostObject extends NetObject implements IRegisteredClass, IExternalizable
	{	
		protected var _flags : Object;

		protected var _updateMask : int;

		protected var _tmpUpdateMask : BitSet;

		protected var _isInitialUpdate : Boolean = false;
		
		public function get isInitialUpdate():Boolean
		{
			return _isInitialUpdate;
		}
		
		public function set isInitialUpdate(value:Boolean):void 
		{
			_isInitialUpdate = value;
		}

		override public function get aliasName() : String
		{
			return "com.paperworld.server.api.NetObject";
		}

		public function GhostObject()
		{
			Registration.registerClass( this );
		}

		override public function readExternal(input : IDataInput) : void
		{
			super.readExternal( input );
			
			_tmpUpdateMask = BitSet( input.readObject( ) );
			_isInitialUpdate = input.readBoolean();
		}

		override public function writeExternal(output : IDataOutput) : void
		{
			super.writeExternal( output );
			
			output.writeObject( _updateMask );
			output.writeBoolean( _isInitialUpdate );
		}
	}
}

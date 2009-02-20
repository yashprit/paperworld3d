package com.paperworld.api 
{
	import com.paperworld.flash.util.IRegisteredClass;
	import com.paperworld.flash.util.Registration;
	
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;		

	/**
	 * @author Trevor
	 */
	public class NetObject implements IRegisteredClass, IExternalizable
	{
		private var _connectionType:String;
		
		public function get connectionType():String
		{
			return _connectionType;
		}
		
		public function set connectionType(value:String):void 
		{
			_connectionType = value;
		}

		public var next : NetObject;

		public function NetObject() 
		{
			Registration.registerClass( this );
		}

		public function get aliasName() : String
		{
			return "com.paperworld.server.flash.FlashNetObject";
		}

		public function readExternal(input : IDataInput) : void
		{
			_connectionType = input.readUTF();
			next = NetObject( input.readObject( ) );
		}

		public function writeExternal(output : IDataOutput) : void
		{
			output.writeUTF( _connectionType );
			output.writeObject( next );
		}
	}
}

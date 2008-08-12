package com.paperworld.data 
{
	import flash.utils.IExternalizable;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;	

	/**
	 * @author Trevor
	 */
	public class SyncData implements IExternalizable
	{
		public var input : Input;

		public var state : State;

		public function readExternal(input : IDataInput) : void
		{
			this.input = input.readObject( );
			state = input.readObject( );
		}

		public function writeExternal(output : IDataOutput) : void
		{
			output.writeObject( input );
			output.writeObject( state );
		}
	}
}

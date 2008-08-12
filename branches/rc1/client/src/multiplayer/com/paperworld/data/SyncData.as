package com.paperworld.data 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	
	import com.paperworld.core.BaseClass;	

	/**
	 * @author Trevor
	 */
	public class SyncData extends BaseClass implements IExternalizable
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

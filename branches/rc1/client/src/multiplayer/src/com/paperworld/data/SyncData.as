package com.paperworld.data 
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	
	import com.paperworld.core.BaseClass;
	import com.paperworld.input.Input;	

	/**
	 * @author Trevor
	 */
	public class SyncData extends BaseClass implements IExternalizable
	{
		public var input : Input;

		public var state : State;

		public var time : int = 0;

		public var serverTime : int = 0;

		public function readExternal(input : IDataInput) : void
		{
			this.input = input.readObject( );
			state = input.readObject( );
			time = input.readInt( );
			serverTime = input.readInt( );
		}

		public function writeExternal(output : IDataOutput) : void
		{
			output.writeObject( input );
			output.writeObject( state );
			output.writeInt( time );
			output.writeInt( serverTime );
		}
	}
}

package com.paperworld.flash.util
{
	import com.paperworld.flash.api.IInput;
	
	public class SyncObject
	{
		public var id:String;
		
		public var input:IInput;
		
		public function SyncObject(id:String, input:IInput)
		{
			this.id = id;
			this.input = input;
		}

	}
}
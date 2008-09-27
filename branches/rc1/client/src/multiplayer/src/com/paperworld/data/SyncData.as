package com.paperworld.data 
{
	import com.paperworld.core.BaseClass;	import com.paperworld.input.Input;	
	/**
	 * @author Trevor
	 */
	public class SyncData extends BaseClass
	{
		public var input : Input;

		public var state : State;

		public var time : int = 0;

		public var serverTime : int = 0;
	}
}

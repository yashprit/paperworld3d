package com.paperworld.flash.ai.scheduling 
{
	import com.paperworld.flash.action.Action;

	/**
	 * @author Trevor
	 */
	public class ScheduledObject implements Scheduleable
	{
		public var behaviour:Action;
		
		public var frequency:int;
		
		public var phase:int;
		
		public var priority : int;
		
		public function run(time : int = 0) : void
		{
		}
	}
}
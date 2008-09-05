package com.paperworld.ai.scheduling 
{
	import com.paperworld.ai.scheduling.ScheduledBehaviour;
	
	import de.polygonal.ds.HashMap;	
	/**
	 * @author Trevor
	 */
	public class PriorityScheduler implements Scheduleable
	{
		public var behaviours:HashMap;
		
		public var frame:int;
		
		public function addBehaviour(behaviour : ScheduledBehaviour) : void
		{
		}
		
		public function run(time : int = 0) : void
		{
		}
	}
}

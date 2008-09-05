package com.paperworld.ai.scheduling 
{
	import com.paperworld.ai.scheduling.ScheduledBehaviour;
	import com.paperworld.core.BaseClass;		
	/**
	 * @author Trevor
	 */
	public class FrequencyScheduler extends BaseClass implements Scheduleable
	{
		public var behaviours : Array;

		public var frame : int = 0;

		public function FrequencyScheduler()
		{
			super( );	
		}

		override public function initialise() : void
		{
			behaviours = new Array( );	
		}

		public function addBehaviour(behaviour : ScheduledBehaviour) : void
		{			
			behaviours.push( behaviour );
		}

		public function run(time : int = 0) : void
		{
			frame++;
			
			for each (var behaviour:ScheduledBehaviour in behaviours)
			{
				if (behaviour.frequency % (frame + behaviour.phase))
				{
					behaviour.run( );
				}	
			}	
		}
	}
}

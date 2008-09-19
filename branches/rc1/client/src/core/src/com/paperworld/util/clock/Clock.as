package com.paperworld.util.clock
{
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	import com.paperworld.util.clock.events.ClockEvent;		

	/**
	 * @author Trevor
	 */
	public class Clock extends EventDispatcher 
	{
		/**
		 * The duration between each 'physics' update on the game objects.
		 * This value is kept constant across all clients and the server to try and
		 * ensure that all object's behaviour is deterministic.
		 */
		private var _renderRate : Number = 30;

		public function set renderRate(value : Number) : void 
		{
			_renderRate = value;
		}

		private var _renderTimestep : Number = 1000 / _renderRate;

		private var _integrationRate : Number = 60;

		public function set integrationRate(value : Number) : void 
		{
			_integrationRate = value;
		}

		private var _integrationTimestep : Number = 1000 / _integrationRate;

		private var _paused : Boolean = false;

		/**
		 * Holds a reference to the current lifetime of the simulation.
		 */
		private var _absoluteTime : Number;

		/**
		 * 'Accumulates' delta-t - when the accumulator's value is larger than TIMESTEP we
		 * get a physics update.
		 */
		private var _accumulator : Number = 0.0;

		private var _time : int = 0;

		private var _timer : Timer;
		
		public function Clock()
		{
			super( );
		}
		
		/**
		 * Starts the simulation running.
		 */
		public function start() : void 
		{			
			_absoluteTime = getTimer( );
			
			_timer = new Timer( _renderTimestep );
			_timer.addEventListener( TimerEvent.TIMER, tick );
			_timer.start( );
		}

		/**
		 * Pause/Resume the simulation.
		 */
		public function pause() : void 
		{
			_paused = !_paused;
		}

		/**
		 * Stop the simulation.
		 */
		public function stop() : void 
		{
			_timer.stop( );
			_timer.removeEventListener( TimerEvent.TIMER, tick );			
		}
		
		protected function tick( event : TimerEvent ) : void 
		{						
			if ( !_paused )
			{
				// find the change in time since the last tick 
				// (don't rely on the timer to be accurate)
				var newTime : Number = getTimer( );
				var deltaTime : Number = newTime - _absoluteTime;
		
				_absoluteTime = newTime;	
				_accumulator += deltaTime;
				
				// update discrete time	
				while ( _accumulator >= _integrationTimestep )
				{		        	
					// advance the simulation
					dispatchEvent( new ClockEvent( ClockEvent.TIMESTEP, _time ) );
		
					// advance discrete time		
					_accumulator -= _integrationTimestep;
					_time++;
				}
		        
				// TODO: use this value to create an adaptive framerate for the simulation rendering
				// ie. feedback this value to the Timer.
				dispatchEvent( new ClockEvent( ClockEvent.RENDER, _time ) );
			}
		}
	}
}

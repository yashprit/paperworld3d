package com.paperworld.objects 
{
	import com.paperworld.core.BaseClass;
	import com.paperworld.data.*;
	import com.paperworld.input.Input;	

	/**
	 * @author Trevor
	 */
	public class SyncObject extends BaseClass
	{
		public var defaultTightness : Number = 0.1;

		public var smoothTightness : Number = 0.01;

		public var tightness : Number;

		public var input : Input;

		public var previous : State;

		public var current : State;

		public function get state() : State
		{
			return current;	
		}

		public var time : int;

		public var replaying : Boolean;

		public function update(t : int) : void
		{
			tightness += (defaultTightness - tightness) * 0.01;
			
			time++;
		}

		public function synchronise(t : int, state : State, input : Input) : void
		{
		}

		public function snap(state : State) : void
		{
			previous = current;
			current = state;
		}

		public function smooth() : void
		{
			tightness = smoothTightness;
		}

		override public function initialise() : void
		{
			tightness = defaultTightness;	
			time = 0;
			replaying = false;
			
			input = new Input( );
			current = new State( );
			previous = new State( );
		}

		override public function destroy() : void 
		{
			time = NaN;
			tightness = NaN;
			defaultTightness = NaN;
			smoothTightness = NaN;
			
			input.destroy( );
			state.destroy( );	
		}

		public function equals(other : SyncObject) : Boolean
		{				
			return  tightness == other.tightness && 
					time == other.time && 
					input.equals( other.input ) && 
					state.equals( other.state );	
		}
	}
}

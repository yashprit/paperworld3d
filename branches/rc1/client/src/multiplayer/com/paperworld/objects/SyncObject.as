package com.paperworld.objects 
{
	import com.paperworld.core.BaseClass;
	import com.paperworld.core.interfaces.Equalable;
	import com.paperworld.data.*;		
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
		}

		public function synchronise() : void
		{
		}

		public function snap(state : State) : void
		{
			previous = current;
			current = state;
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

		override public function equals(other : Equalable) : Boolean
		{
			if (!super.equals( other )) return false;

			var o : SyncObject = SyncObject( other );
				
			return tightness == o.tightness && time == o.time && input.equals( o.input ) && state.equals( o.state );	
		}
	}
}

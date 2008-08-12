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

		public var state : State;

		public var time : int = 0;

		public function update() : void
		{
		}

		public function synchronise() : void
		{
		}

		override public function initialise() : void
		{
			tightness = defaultTightness;	
			time = 0;
			
			input = new Input( );
			state = new State( );
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

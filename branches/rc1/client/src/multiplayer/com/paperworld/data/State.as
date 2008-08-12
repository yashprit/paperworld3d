package com.paperworld.data 
{
	import com.paperworld.core.BaseInterface;	

	import flash.utils.IDataInput;	import flash.utils.IDataOutput;	import flash.utils.IExternalizable;
	import com.paperworld.core.BaseClass;	import com.paperworld.util.math.Matrix3D;		

	/**
	 * @author Trevor
	 */
	public class State extends BaseClass implements IExternalizable
	{
		public var transform : Matrix3D;

		public var speed : Number;
		
		override public function initialise():void
		{
			transform = Matrix3D.IDENTITY;
			speed = 0;	
		}

		public function readExternal(input : IDataInput) : void
		{
			transform = input.readObject( );
			speed = input.readDouble( );
		}

		public function writeExternal(output : IDataOutput) : void
		{
			output.writeObject( transform );
			output.writeObject( speed );
		}
		
		override public function equals(other : BaseInterface) : Boolean
		{
			if (other is State)
			{
				var o : State = State(other);
				
				return transform == o.transform && speed == o.speed; 	
			}

			return false;	
		}

		override public function clone() : BaseInterface
		{
			var state : State = new State( );
			state.transform = Matrix3D( transform.clone( ) );
			state.speed = speed;
			
			return state;	
		}
		
		override public function destroy():void
		{
			transform.destroy();
			speed = NaN;	
		}
	}
}

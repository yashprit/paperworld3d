package  
{
	import com.paperworld.flash.IRegisteredClass;	

	import flash.utils.IExternalizable;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;	

	/**
	 * @author Trevor
	 */
	public class Move implements IExternalizable, IRegisteredClass
	{
		public var left : Number = 0;		
		public var right : Number = 0;
		public var up : Number = 0;
		public var down : Number = 0;
		public var angle : Number = 0;
		public var fire : Boolean = false;
		public var time : int = 0;

		public function Move()
		{
		}

		public function readExternal(input : IDataInput) : void
		{
			left = input.readDouble();
			right = input.readDouble();
			up = input.readDouble();
			down = input.readDouble();
			angle = input.readDouble();
			fire = input.readBoolean();
			time = input.readInt();
		}

		public function writeExternal(output : IDataOutput) : void
		{
			output.writeDouble(left);
			output.writeDouble(right);
			output.writeDouble(up);
			output.writeDouble(down);
			output.writeDouble(angle);
			output.writeInt(time);
		}

		public function get aliasName() : String
		{
			return "com.paperworld.examples.hellopaperworld.Move";
		}
		
		public function destroy():void
		{
		}
	}
}

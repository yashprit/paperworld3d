package  
{
	import com.paperworld.api.NetObject;
	
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;		

	/**
	 * @author Trevor
	 */
	public class Move extends NetObject
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

		override public function readExternal(input : IDataInput) : void
		{
			super.readExternal(input);
			
			left = input.readDouble();
			right = input.readDouble();
			up = input.readDouble();
			down = input.readDouble();
			angle = input.readDouble();
			fire = input.readBoolean();
			time = input.readInt();
		}

		override public function writeExternal(output : IDataOutput) : void
		{
			super.writeExternal(output);
			
			output.writeDouble(left);
			output.writeDouble(right);
			output.writeDouble(up);
			output.writeDouble(down);
			output.writeDouble(angle);
			output.writeBoolean(fire);
			output.writeInt(time);
		}

		override public function get aliasName() : String
		{
			return "com.paperworld.examples.hellopaperworld.Move";
		}
		
		public function destroy():void
		{
		}
	}
}

package com.paperworld.data 
{
	import com.paperworld.core.BaseInterface;	

	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;

	import com.paperworld.core.BaseClass;	

	/**
	 * @author Trevor
	 */
	public class Input extends BaseClass implements IExternalizable
	{
		public var forward : Boolean;

		public var back : Boolean;

		public var turnRight : Boolean;

		public var turnLeft : Boolean;

		public var moveRight : Boolean;

		public var moveLeft : Boolean;

		public var turnUp : Boolean;

		public var turnDown : Boolean;

		public var moveUp : Boolean;

		public var moveDown : Boolean;

		public var fire : Boolean;

		public var jump : Boolean;

		override public function initialise() : void
		{
			forward = false;
			back = false;
			turnRight = false;
			turnLeft = false;
			moveRight = false;
			moveLeft = false;
			turnUp = false;
			turnDown = false;
			moveUp = false;
			moveDown = false;
			fire = false;
			jump = false;
		}

		override public function destroy() : void
		{
			initialise( );
		}

		override public function equals(other : BaseInterface) : Boolean
		{
			if (other is Input)
			{
				var o : Input = Input( other );
				return forward == o.forward && back == o.back && turnRight == o.turnRight && turnLeft == o.turnLeft && moveRight == o.moveRight && moveLeft == o.moveLeft && turnUp == o.turnUp && turnDown == o.turnDown && moveUp == o.moveUp && moveDown == o.moveDown && fire == o.fire && jump == o.jump;
			}
			
			return false;
		}

		public function readExternal(input : IDataInput) : void
		{
			forward = input.readBoolean( );
			back = input.readBoolean( );
			turnRight = input.readBoolean( );
			turnLeft = input.readBoolean( );
			moveRight = input.readBoolean( );
			moveLeft = input.readBoolean( );
			turnUp = input.readBoolean( );
			turnDown = input.readBoolean( );
			moveUp = input.readBoolean( );
			moveDown = input.readBoolean( );
			fire = input.readBoolean( );
			jump = input.readBoolean( );
		}

		public function writeExternal(output : IDataOutput) : void
		{
			output.writeBoolean( forward );
			output.writeBoolean( back );
			output.writeBoolean( turnRight );
			output.writeBoolean( turnLeft );
			output.writeBoolean( moveRight );
			output.writeBoolean( moveLeft );
			output.writeBoolean( turnUp );
			output.writeBoolean( turnDown );
			output.writeBoolean( moveUp );
			output.writeBoolean( moveDown );
			output.writeBoolean( fire );
			output.writeBoolean( jump );
		}
	}
}

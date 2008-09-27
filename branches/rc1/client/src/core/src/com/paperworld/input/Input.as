package com.paperworld.input 
{
	import com.paperworld.core.interfaces.Cloneable;	
	import com.paperworld.core.BaseClass;
	import com.paperworld.core.interfaces.Equalable;
	import com.paperworld.core.interfaces.Equivalentable;
	
	import flexunit.framework.Assert;		

	/**
	 * @author Trevor
	 */
	public class Input extends BaseClass
	{		
		public var forward:Boolean;
	
		public function setForward(forward:Boolean):void
		{
			this.forward = forward;
		}
		
		public function getForward():Boolean
		{
			return forward;
		}
		
		public var back:Boolean;
		
		public function setBack(back:Boolean):void
		{
			this.back = back;
		}
		
		public function getBack():Boolean
		{
			return back;
		}
		
		public var turnRight:Boolean;
		
		public function setTurnRight(turnRight:Boolean):void
		{
			this.turnRight = turnRight;
		}
		
		public function getTurnRight():Boolean
		{
			return turnRight;
		}
	
		public var turnLeft:Boolean;
		
		public function setTurnLeft(turnLeft:Boolean):void
		{
			this.turnLeft = turnLeft;
		}
		
		public function getTurnLeft():Boolean
		{
			return turnLeft;
		}
	
		public var moveRight:Boolean;
		
		public function setMoveRight(moveRight:Boolean):void
		{
			this.moveRight = moveRight;
		}
		
		public function getMoveRight():Boolean
		{
			return moveRight;
		}
	
		public var moveLeft:Boolean;
		
		public function setMoveLeft(moveLeft:Boolean):void
		{
			this.moveLeft = moveLeft;
		}
		
		public function getMoveLeft():Boolean
		{
			return moveLeft;
		}
	
		public var turnUp:Boolean;
		
		public function setTurnUp(turnUp:Boolean):void
		{
			this.turnUp = turnUp;
		}
		
		public function getTurnUp():Boolean
		{
			return turnUp;
		}
	
		public var turnDown:Boolean;
		
		public function setTurnDown(turnDown:Boolean):void
		{
			this.turnDown = turnDown;
		}
		
		public function getTurnDown():Boolean
		{
			return turnDown;
		}
	
		public var moveUp:Boolean;
		
		public function setMoveUp(moveUp:Boolean):void
		{
			this.moveUp = moveUp;
		}
		
		public function getMoveUp():Boolean
		{
			return moveUp;
		}
	
		public var moveDown:Boolean;
		
		public function setMoveDown(moveDown:Boolean):void
		{
			this.moveDown = moveDown;
		}
		
		public function getMoveDown():Boolean
		{
			return moveDown;
		}
	
		public var fire:Boolean;
		
		public function setFire(fire:Boolean):void
		{
			this.fire = fire;
		}
		
		public function getFire():Boolean
		{
			return fire;
		}
	
		public var jump:Boolean;
		
		public function setJump(jump:Boolean):void
		{
			this.jump = jump;
		}
		
		public function getJump():Boolean
		{
			return jump;
		}
		
		public var mouseX:Number;
		
		public function setMouseX(mouseX:Number):void
		{
			this.mouseX = mouseX;
		}
		
		public function getMouseX():Number
		{
			return mouseX;
		}
		
		public var mouseY:Number;
		
		public function setMouseY(mouseY:Number):void
		{
			this.mouseY = mouseY;
		}
		
		public function getMouseY():Number
		{
			return mouseY;
		}

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
			
			mouseX = 0;
			mouseY = 0;
		}

		override public function destroy() : void
		{
			initialise( );
		}

		override public function equals(other : Equalable) : Boolean
		{
			if (!super.equals( other )) return false;
			
			var o : Input = Input( other );
			
			return forward == o.forward && back == o.back && turnRight == o.turnRight && turnLeft == o.turnLeft && moveRight == o.moveRight && moveLeft == o.moveLeft && turnUp == o.turnUp && turnDown == o.turnDown && moveUp == o.moveUp && moveDown == o.moveDown && fire == o.fire && jump == o.jump && mouseX == o.mouseX && mouseY == o.mouseY;
		}

		override public function equivalentTo(other : Equivalentable) : Boolean
		{
			var o : Input = Input( other );
			
			Assert.assertNotNull( o, "Expecting other to be an instance of Input" );
			
			return forward == o.forward || back == o.back || turnRight == o.turnRight || turnLeft == o.turnLeft || moveRight == o.moveRight || moveLeft == o.moveLeft || turnUp == o.turnUp || turnDown == o.turnDown || moveUp == o.moveUp || moveDown == o.moveDown || fire == o.fire || jump == o.jump;
		}
		
		public function copyFrom(other:Input):void
		{
			forward = other.forward;
			back = other.back;
			turnRight = other.turnRight;
			turnLeft = other.turnLeft;
			moveRight = other.moveRight;
			moveLeft = other.moveLeft;
			turnUp = other.turnUp;
			turnDown = other.turnDown;
			moveUp = other.moveUp;
			moveDown = other.moveDown;
			fire = other.fire;
			jump = other.jump;
			
			mouseX = other.mouseX;
			mouseY = other.mouseY;
		}
	}
}

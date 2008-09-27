package com.paperworld.multiplayer.data;


public class Input
{	
	protected boolean forward;
	
	public void setForward(boolean forward)
	{
		this.forward = forward;
	}
	
	public boolean getForward()
	{
		return forward;
	}
	
	public boolean back;
	
	public void setBack(boolean back)
	{
		this.back = back;
	}
	
	public boolean getBack()
	{
		return back;
	}
	
	public boolean turnRight;
	
	public void setTurnRight(boolean turnRight)
	{
		this.turnRight = turnRight;
	}
	
	public boolean getTurnRight()
	{
		return turnRight;
	}

	public boolean turnLeft;
	
	public void setTurnLeft(boolean turnLeft)
	{
		this.turnLeft = turnLeft;
	}
	
	public boolean getTurnLeft()
	{
		return turnLeft;
	}

	public boolean moveRight;
	
	public void setMoveRight(boolean moveRight)
	{
		this.moveRight = moveRight;
	}
	
	public boolean getMoveRight()
	{
		return moveRight;
	}

	public boolean moveLeft;
	
	public void setMoveLeft(boolean moveLeft)
	{
		this.moveLeft = moveLeft;
	}
	
	public boolean getMoveLeft()
	{
		return moveLeft;
	}

	public boolean turnUp;
	
	public void setTurnUp(boolean turnUp)
	{
		this.turnUp = turnUp;
	}
	
	public boolean getTurnUp()
	{
		return turnUp;
	}

	public boolean turnDown;
	
	public void setTurnDown(boolean turnDown)
	{
		this.turnDown = turnDown;
	}
	
	public boolean getTurnDown()
	{
		return turnDown;
	}

	public boolean moveUp;
	
	public void setMoveUp(boolean moveUp)
	{
		this.moveUp = moveUp;
	}
	
	public boolean getMoveUp()
	{
		return moveUp;
	}

	public boolean moveDown;
	
	public void setMoveDown(boolean moveDown)
	{
		this.moveDown = moveDown;
	}
	
	public boolean getMoveDown()
	{
		return moveDown;
	}

	public boolean fire;
	
	public void setFire(boolean fire)
	{
		this.fire = fire;
	}
	
	public boolean getFire()
	{
		return fire;
	}

	public boolean jump;
	
	public void setJump(boolean jump)
	{
		this.jump = jump;
	}
	
	public boolean getJump()
	{
		return jump;
	}
	
	public double mouseX;
	
	public void setMouseX(double mouseX)
	{
		this.mouseX = mouseX;
	}
	
	public double getMouseX()
	{
		return mouseX;
	}
	
	public double mouseY;
	
	public void setMouseY(double mouseY)
	{
		this.mouseY = mouseY;
	}
	
	public double getMouseY()
	{
		return mouseY;
	}
	
	public Input()
	{
		clear();
	}
	
	public void clear() 
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
		
		mouseX = 0.0;
		mouseY = 0.0;
	}
}

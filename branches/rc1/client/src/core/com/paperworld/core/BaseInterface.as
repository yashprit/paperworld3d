package com.paperworld.core 
{

	/**
	 * @author Trevor
	 */
	public interface BaseInterface extends Destroyable
	{
		function initialise() : void;

		function clone() : BaseInterface;

		function equals(other : BaseInterface) : Boolean;

		function notEquals(other : BaseInterface) : Boolean
	}
}

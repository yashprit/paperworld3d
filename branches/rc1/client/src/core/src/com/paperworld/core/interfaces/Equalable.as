package com.paperworld.core.interfaces 
{

	/**
	 * @author Trevor
	 */
	public interface Equalable 
	{
		function equals(other : Equalable) : Boolean;

		function notEquals(other : Equalable) : Boolean;
	}
}

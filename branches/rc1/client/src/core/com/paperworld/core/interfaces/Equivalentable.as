package com.paperworld.core.interfaces 
{
	/**
	 * @author Trevor
	 */
	public interface Equivalentable 
	{
		function equivalentTo(other : Equivalentable) : Boolean;

		function notEquivalentTo(other : Equivalentable) : Boolean;
	}
}

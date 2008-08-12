package com.paperworld.core 
{
	import com.paperworld.core.interfaces.*;
	
	import flash.utils.getQualifiedClassName;	

	/**
	 * @author Trevor
	 */
	public class BaseClass implements Cloneable, Comparable, Copyable, Destroyable, Equalable, Initialisable
	{
		public function BaseClass()
		{
			initialise( );	
		}

		public function initialise() : void
		{
		}

		public function destroy() : void
		{
		}

		public function clone() : Cloneable
		{
			return null;
		}

		public function equals(other : Equalable) : Boolean
		{
			return getQualifiedClassName( this ) == getQualifiedClassName( other );
		}

		public function notEquals(other : Equalable) : Boolean
		{
			return !( this.equals( other ) );
		}

		public function compare(other : Comparable) : Boolean
		{
			return false;
		}

		public function copy(other : Copyable) : void
		{
		}
	}
}

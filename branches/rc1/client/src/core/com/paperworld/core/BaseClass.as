package com.paperworld.core 
{
	import flash.utils.getQualifiedClassName;
	
	import com.paperworld.core.interfaces.*;	
	/**
	 * @author Trevor
	 */
	public class BaseClass implements Cloneable, Comparable, Copyable, Destroyable, Equalable, Initialisable, Equivalentable
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
		
		public function equivalentTo(other : Equivalentable) : Boolean
		{
			return false;
		}
		
		public function notEquivalentTo(other : Equivalentable) : Boolean
		{
			return !( this.equivalentTo( other ) );
		}
	}
}

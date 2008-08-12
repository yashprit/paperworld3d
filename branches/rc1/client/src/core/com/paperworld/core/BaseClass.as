package com.paperworld.core 
{

	/**
	 * @author Trevor
	 */
	public class BaseClass implements BaseInterface
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

		public function clone() : BaseInterface
		{
			return null;
		}

		public function equals(other : BaseInterface) : Boolean
		{
			return false;
		}

		public function notEquals(other : BaseInterface) : Boolean
		{
			return !( this.equals( other ) );
		}
	}
}

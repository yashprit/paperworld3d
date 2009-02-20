package com.paperworld.flash 
{
	import com.paperworld.client.flash.GhostObject;	

	/**
	 * @author Trevor
	 */
	public class DummyNetObject extends GhostObject 
	{		
		public static const MOVE_MASK : int = 0x01;
		public static const POSITION_MASK : int = 0x02;

		override public function get aliasName() : String
		{
			return "com.paperworld.flash.DummyNetObject";
		}

		public function DummyNetObject()
		{
			super( );
		}
	}
}

package com.paperworld.lod 
{
	import com.paperworld.action.Action;
	import com.paperworld.objects.Avatar;		

	/**
	 * @author Trevor
	 */
	public class LodConstraint extends Action
	{
		public function testConstraint(pov : Avatar, other : Avatar) : int
		{
			return 0;
		}
	}
}

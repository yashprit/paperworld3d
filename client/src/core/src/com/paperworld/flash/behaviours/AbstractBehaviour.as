package com.paperworld.flash.behaviours 
{
	import com.paperworld.api.IBehaviour;
	import com.paperworld.api.ISynchronisedAvatar;	

	/**
	 * @author Trevor
	 */
	public class AbstractBehaviour implements IBehaviour 
	{
		protected var _next : IBehaviour;

		public function get next() : IBehaviour
		{
			return _next;
		}

		public function set next(behaviour : IBehaviour) : void 
		{
			_next = behaviour;
		}

		public function apply(avatar : ISynchronisedAvatar) : void
		{
			if (next) 
			{
				next.apply( avatar );	
			}
		}
	}
}

package com.paperworld.multiplayer.player 
{
	import com.paperworld.core.EventDispatchingBaseClass;
	import com.paperworld.objects.Avatar;		

	/**
	 * @author Trevor
	 */
	public class Player extends EventDispatchingBaseClass 
	{
		protected var _avatar : Avatar;

		public function get avatar() : Avatar
		{
			return _avatar;	
		}

		public function set avatar(value : Avatar) : void
		{
			_avatar = value;	
		}

		public function Player()
		{
			super( this );
		}

		override public function initialise() : void
		{
			_avatar = new Avatar( );
		}
	}
}

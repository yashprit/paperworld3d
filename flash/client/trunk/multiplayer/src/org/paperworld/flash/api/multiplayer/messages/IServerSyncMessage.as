package org.paperworld.flash.api.multiplayer.messages
{
	import org.paperworld.flash.api.IState;
		
	public interface IServerSyncMessage extends IPlayerSyncMessage
	{
		function get state():IState;	
		function set state(state:IState):void;
	}
}
package com.paperworld.flash.api.multiplayer
{
	import com.paperworld.flash.util.input.IInput;
	
	public interface ISyncManager
	{
		function register(avatar:ISynchronisedAvatar):void;
		
		function unRegister(avatar:ISynchronisedAvatar):void;
		
		function handleAvatarMove(id:String, time:int, input:IInput):void;
	}
}
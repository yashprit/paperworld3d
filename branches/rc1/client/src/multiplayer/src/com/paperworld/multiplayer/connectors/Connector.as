package com.paperworld.multiplayer.connectors 
{
	import flash.events.IEventDispatcher;	

	import com.paperworld.input.UserInput;	

	/**
	 * @author Trevor
	 */
	public interface Connector extends IEventDispatcher
	{
		function connect(scene : String = null, context : String = null) : void;

		function disconnect() : void

		function set input(value : UserInput) : void;

		function get id() : String;
	}
}

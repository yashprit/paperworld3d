package com.paperworld.util.keys 
{
	import com.paperworld.core.patterns.Command;
	import com.paperworld.input.UserInput;	

	/**
	 * @author Trevor
	 */
	public class KeyCommand implements Command 
	{
		protected var _input : UserInput;
		
		protected var _property : String;
		
		public function set property(value:String):void
		{
			_property = value;
		}	

		public function KeyCommand(input : UserInput)
		{
			_input = input;
		}

		public function execute() : void
		{
		}
	}
}

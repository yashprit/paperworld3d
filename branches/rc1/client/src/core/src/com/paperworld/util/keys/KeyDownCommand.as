package com.paperworld.util.keys
{
	import com.paperworld.input.UserInput;	

	/**
	 * @author Trevor
	 */
	public class KeyDownCommand extends KeyCommand 
	{
		public function KeyDownCommand(input : UserInput)
		{
			super( input );
		}
		
		override public function execute():void
		{	
			_input.input[_property] = true;
		}
	}
}

package com.paperworld.util.keys
{
	import com.paperworld.input.UserInput;	

	/**
	 * @author Trevor
	 */
	public class KeyUpCommand extends KeyCommand 
	{
		public function KeyUpCommand(input : UserInput)
		{
			super( input );
		}
		
		override public function execute():void
		{	
			_input.input[_property] = false;
		}
	}
}

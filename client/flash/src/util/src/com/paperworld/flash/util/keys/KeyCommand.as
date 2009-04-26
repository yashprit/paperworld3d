/* --------------------------------------------------------------------------------------
 * PaperWorld3D - building better worlds
 * --------------------------------------------------------------------------------------
 * Real-Time Multi-User Application Framework for the Flash Platform.
 * --------------------------------------------------------------------------------------
 * Copyright (C) 2008 Trevor Burton [worldofpaper@googlemail.com]
 * --------------------------------------------------------------------------------------
 * 
 * This library is free software; you can redistribute it and/or modify it under the 
 * terms of the GNU Lesser General Public License as published by the Free Software 
 * Foundation; either version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT ANY 
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A 
 * PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License along with 
 * this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, 
 * Suite 330, Boston, MA 02111-1307 USA 
 * 
 * -------------------------------------------------------------------------------------- */
package com.paperworld.flash.util.keys 
{
	import com.paperworld.flash.util.input.IUserInput;
	import com.paperworld.flash.util.patterns.command.ICommand;	

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class KeyCommand implements ICommand 
	{
		protected var _input : IUserInput;
		
		protected var _property : String;
		
		public function set property(value:String):void
		{
			_property = value;
		}	

		public function KeyCommand(input : IUserInput)
		{
			_input = input;
		}

		public function execute() : void
		{
			_input.updateListeners();
		}
	}
}

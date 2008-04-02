/*
 * --------------------------------------------------------------------------------------
 * PaperWorld3D - building better worlds
 * --------------------------------------------------------------------------------------
 * Realtime 3D Multi-User Application Framework for the Flash Platform.
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
 * --------------------------------------------------------------------------------------
 */
package com.paperworld.rpc.player 
{
	import com.paperworld.rpc.input.IUserInput;	
	
	import flash.net.NetConnection;
	import flash.net.Responder;
	
	import com.paperworld.framework.constants.ErrorMessages;
	import com.paperworld.rpc.input.AbstractUserInput;
	import com.paperworld.rpc.input.KeyboardInput;
	import com.paperworld.rpc.timer.GameTimer;
	import com.paperworld.rpc.timer.events.IntegrationEvent;	

	public class GamePlayer extends AbstractPlayer
	{		
		public var $connection : NetConnection;

		public var userInput : AbstractUserInput;

		public var inputResponder : Responder;

		public function set connection(value : NetConnection) : void
		{
			$connection = value;
		}

		/**
		 * The singleton instance of this class.
		 */
		private static var $instance : GamePlayer;

		/**
		 * Constructor, private to prevent instantiation.
		 * Always set the default currency symbol - this will be over-ridden
		 * by genuine currencies if available.
		 */
		public function GamePlayer( caller : Function )
		{
			super( );
			
			if ( caller != GamePlayer.getInstance )
                throw new Error( ErrorMessages.SINGLETON_GET_INSTANCE_ERROR );
			
			if ( GamePlayer.$instance != null )
                throw new Error( ErrorMessages.MULTIPLE_SINGLETON_ERROR );	

			username = createUniqueName( );
			
			inputResponder = new Responder( inputResponse );
			
			userInput = new KeyboardInput( );
			GameTimer.getInstance( ).input = userInput;			
		}

		override public function createVehicle() : void
		{
			super.createVehicle( );
			
			GameTimer.getInstance( ).addEventListener( IntegrationEvent.INTEGRATION_EVENT, handleInput );
		}

		/**
		 * Return an instance of this class.
		 */
		public static function getInstance() : GamePlayer
		{
			if ($instance == null)
			{
				$instance = new GamePlayer( arguments.callee );
			}

			return $instance;
		}	

		/**
		 * Does this user have a valid chat name?
		 */
		public function hasValidUsername() : Boolean
		{
			if ( username.length == 0 || username == null )
				return false;
		
			return true;
		}	

		public function setUID(obj : Object) : void 
		{
			logger.info( "Setting UID " + obj );
			uid = obj as String;
			vehicle.uid = uid;
		}

		public function createUniqueName() : String 
		{
			// Set the timeDate stamp.
			var currentDate : Date = new Date( );
			return String( currentDate.getFullYear( ) ) + String( currentDate.getMonth( ) ) + String( currentDate.getDay( ) ) + String( currentDate.getHours( ) ) + String( currentDate.getMinutes( ) ) + String( currentDate.getMilliseconds( ) );
		}

		public function inputResponse(obj : Object) : void
		{
		}

		public function handleInput(event : IntegrationEvent) : void 
		{		
			var userInput : IUserInput = event.input;
			
			if (userInput.hasChanged)
			{			
				vehicle.character.input.left = userInput.A;
				vehicle.character.input.right = userInput.D;
				vehicle.character.input.forward = userInput.W;
				vehicle.character.input.back = userInput.S;
				vehicle.character.input.up = userInput.K;
				vehicle.character.input.down = userInput.M;
				vehicle.character.input.firing = userInput.space;
				vehicle.character.input.yawNegative = userInput.right;
				vehicle.character.input.yawPositive = userInput.left;
				vehicle.character.input.pitchNegative = userInput.up;
				vehicle.character.input.pitchPositive = userInput.down;
				vehicle.character.input.rollNegative = userInput.ONE;
				vehicle.character.input.rollPositive = userInput.TWO;
				vehicle.character.input.mouseX = userInput.mouseX;
				vehicle.character.input.mouseY = userInput.mouseY;
				
				/*logger.info("\nConnection: " + connection + 
				"\ninputResponder: " + inputResponder + 
				"\nuid: " + uid + 
				"\ncharacter.time: " + character.time + 
				"\ncharacter.input: " + character.input);*/
				if($connection)
				{			
					$connection.call( "handleInput", inputResponder, uid, vehicle.character.time, vehicle.character.input.left, vehicle.character.input.right, vehicle.character.input.forward, vehicle.character.input.back, vehicle.character.input.up, vehicle.character.input.down, vehicle.character.input.yawNegative, vehicle.character.input.yawPositive, vehicle.character.input.pitchNegative, vehicle.character.input.pitchPositive, vehicle.character.input.rollNegative, vehicle.character.input.rollPositive, vehicle.character.input.mouseX, vehicle.character.input.mouseY, vehicle.character.input.firing );
				}
			}
		}
	}
}
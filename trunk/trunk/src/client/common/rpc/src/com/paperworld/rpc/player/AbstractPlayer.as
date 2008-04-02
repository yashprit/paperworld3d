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
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.system.ApplicationDomain;
	import flash.utils.getDefinitionByName;
	
	import com.paperworld.logging.ILogger;
	import com.paperworld.logging.LoggerFactory;
	import com.paperworld.rpc.objects.Vehicle;
	import com.paperworld.rpc.timer.GameTimer;
	import com.paperworld.rpc.timer.events.IntegrationEvent;		

	/**
	 * @author Trevor
	 */
	public class AbstractPlayer extends EventDispatcher 
	{
		public var logger : ILogger;

		public var modelKey : String = "com.paperworld.games.objects.StarFighter";

		public var vehicle : Vehicle;

		/**
		 * The individual identifier for the player. Username may be changed during a session, uid cannot
		 * so is used during any interaction with the server so the server knows which player is making the request.
		 */
		public var uid : String;

		/**
		 * The username for the player, used in any chat communications etc. Can be changed during a play session.
		 */
		public var username : String;

		public function AbstractPlayer(target : IEventDispatcher = null)
		{
			super( target );
			
			logger = LoggerFactory.getLogger( this );
			
			//createVehicle();
		}

		public function createVehicle() : void
		{
			logger.info("Creating player Vehicle " + modelKey + ", " + ApplicationDomain.currentDomain.hasDefinition( modelKey ));
			
			if (ApplicationDomain.currentDomain.hasDefinition( modelKey ))
			{
				var VehicleClass : Class = getDefinitionByName( modelKey ) as Class;
				vehicle = new VehicleClass( ) as Vehicle;
				GameTimer.getInstance( ).addEventListener( IntegrationEvent.INTEGRATION_EVENT, vehicle.update );
			}
		}

		public function start() : void
		{
			vehicle.start( );
		}

		/**
		 * toString for debug purposes.
		 */
		override public function toString() : String
		{
			var p : String = "Player\n";
			p += "---------\n";
			p += "id " + username + "\n";
			return p;
		}
	}
}

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
package com.paperworld.multiplayer.scenes 
{
	import org.papervision3d.core.proto.MaterialObject3D;
	import org.papervision3d.materials.WireframeMaterial;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.primitives.Plane;
	
	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.action.Action;
	import com.paperworld.action.IntervalAction;
	import com.paperworld.multiplayer.connectors.RTMPConnector;
	import com.paperworld.multiplayer.events.ServerSyncEvent;
	import com.paperworld.multiplayer.lod.LodConstraint;
	import com.paperworld.multiplayer.objects.Avatar;
	import com.paperworld.multiplayer.objects.Client;
	import com.paperworld.multiplayer.objects.RemoteAvatar;
	import com.paperworld.multiplayer.objects.SyncObject;
	import com.paperworld.multiplayer.objects.SynchronisableObject;
	import com.paperworld.multiplayer.player.Player;
	import com.paperworld.util.Synchronizable;
	import com.paperworld.util.clock.Clock;
	import com.paperworld.multiplayer.data.SyncData;	

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class AbstractSynchronisedScene extends IntervalAction
	{
		private var logger : XrayLog = new XrayLog( );

		/**
		 * The Clock instance used as a timer for this scene.
		 */
		//public var clock : Clock;

		/**
		 * The 'point of view' object for Level of Detail heuristics - if no pov is defined then LOD will not be activated.
		 */
		public var pov : Avatar;

		/**
		 * The list of avatars in this scene.
		 */
		public var avatars : Avatar;

		public var avatarsByName : Array;
		
		public var player:Player;

		/**
		 * The list of Level of Detail heuristics used in this scene.
		 */
		public var lodConstraints : LodConstraint;

		protected var _connector : RTMPConnector;
		
		public function set connector(value : RTMPConnector):void
		{			
			_connector = value;
			_connector.addEventListener( ServerSyncEvent.AVATAR_SYNC, onAvatarSync);
		}
		
		public function get connector() : RTMPConnector
		{
			return _connector;
		}

		/**
		 * Adds a LOD Heuristic to the list. Implicit setter used in order to allow heuristics to be set via prana.
		 */
		public function addLodConstraint(lc : LodConstraint) : void
		{
			lc.next = lodConstraints;
			lodConstraints = lc;
		}

		/**
		 * Constructor.
		 */
		public function AbstractSynchronisedScene()
		{
			super( );			
		}

		/**
		 * Initialise implementation - initialises linked lists.
		 */
		override public function initialise() : void
		{			
			// Create a new Clock to keep time.
			//clock = new Clock( );
			
			avatarsByName = new Array( );			
		}
		
		public function connect(scene:String, context:String):void
		{
			connector.connect(scene, context);	
		}

		public function onAvatarSync(event:ServerSyncEvent):void
		{
			var avatar : Avatar = Avatar( avatarsByName[event.id] );

			//logger.info("e " + event.data.state.orientation.w);
			if (!avatar)
			{
				logger.info(connector.clientID + "\navatar not found - creating a new one");
				avatar = new RemoteAvatar( );
				var material : MaterialObject3D = new WireframeMaterial( 0xff0000 );
				material.doubleSided = true;
				var object : SynchronisableObject = new SynchronisableObject( new Plane( material, 100, 100 ) );
				avatar.syncObject = object;
				avatar.input = event.data.input;
				avatar.state = event.data.state;
				avatar.time = event.data.t;
				addRemoteChild(object);
				avatarsByName[event.id] = avatar;
			}
			logger.info(connector.clientID + " synchronising " + event.id);
			avatar.synchronise(event);
			//logger.info(connector.clientID + " : " + event.id + " avatar rotation " + event.data.input + "\n" + avatar.client.input + "\n" + DisplayObject3D(avatar.client.syncObject.getObject()).localRotationY);
			
		}
		

		public function addPlayer(player : Player, isLocal : Boolean = true) : void
		{
			if (isLocal) pov = player.avatar;
			
			//addEventListener( ConnectorEvent.CONNECTED_TO_SERVER, player.onSceneConnected );	
			
			player.avatar.next = avatars;
			avatars = player.avatar;
					
			avatarsByName[connector.clientID] = player.avatar;
			addRemoteChild(player.avatar.syncObject);

			player.avatar.userInput = connector.input;
			
			this.player = player;
		}

		/**
		 * Add a simple object to the scene.
		 */
		public function addChild(child : *) : *
		{
			// Nothing here, implementation specific to a particular 3D engine in child classes.
			return child;
		}

		/**
		 * Adds an object to the scene that can be synchronised across clients.
		 * 
		 * @param child The object that will be synced across clients and added to the 3D scene.
		 * @param pov Flags whether or not this object should be used as the 'point of view' for the Level of Detail heuristics.
		 */
		public function addRemoteChild(child : Synchronizable, pov : Boolean = false) : Synchronizable
		{
			// Create a new Avatar to handle synchronisation.
			//var avatar : Avatar = new Avatar( );
			//avatar.syncObject = child;
			
			// Add this avatar to the local list.
			//avatar.next = avatars;
			//avatars = avatar;
			
			// If this SyncObject is the local player then set as pov.
			//if (pov) this.pov = avatar;
			
			// Finally, add the object to the 3D scene.
			addChild( child );
			
			return child;
		}

		public function removeChild(child : * ) : *
		{
			return child;
		}

		public function removeRemoteChild(child : Synchronizable) : Synchronizable
		{
			var previous : Avatar;
			var next : Avatar = avatars;
			
			// Loop through each avatar in the list.
			while (next)
			{			
				// When we find the avatar that's handling the child passed.	
				if (next.syncObject == child)
				{
					// Link the previous avatar with the next one - removing the current one from the list.
					previous.next = next.next;
					next.destroy( );					
					break;	
				}	
				
				// Move to the next avatar in the list.
				previous = next;
				next = Avatar( next.next );				
			}	
			
			return child;
		}

		
		
		
	}
}


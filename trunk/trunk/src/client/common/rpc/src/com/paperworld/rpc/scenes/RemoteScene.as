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
package com.paperworld.rpc.scenes 
{
	import flash.events.SyncEvent;
	import flash.net.Responder;
	import flash.net.SharedObject;
	import flash.utils.getDefinitionByName;
	
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.scenes.Scene3D;
	
	import com.paperworld.logging.ILogger;
	import com.paperworld.logging.LoggerFactory;
	import com.paperworld.rpc.connector.GameConnector;
	import com.paperworld.rpc.connector.GameConnectorEvent;
	import com.paperworld.rpc.objects.Avatar;
	import com.paperworld.rpc.player.AbstractPlayer;
	import com.paperworld.rpc.player.GamePlayer;
	import com.paperworld.rpc.player.PlayerManager;	

	/**
	 * <p>Handles synchronisation of a <i>local</i> and a <i>remote</i> scene.</p> 
	 * 
	 * <p>When an object is added to a <code>RemoteScene</code> on the server it's <i>local</i> counterpart on each client is 
	 * informed about the event and each client creates an instance of the correct object and adds it to itself. Each object
	 * is then kept synchronised with its <i>remote</p> counterpart through the <code>RemoteScene</code>.</p>
	 * 
	 * @author Trevor
	 */
	public class RemoteScene extends Scene3D
	{
		private static var ID_LIST : Array = new Array( );

		private var $playerManager : PlayerManager;

		private var $connector : GameConnector;

		private var $logger : ILogger;

		public var playerRegistered : Boolean = false;

		private var $roomId : String;

		public var objectQueue : Array;

		public var so : SharedObject;

		public var inScene : Boolean = false;

		public function get roomId() : String
		{
			return $roomId;
		}

		public function RemoteScene(connector : GameConnector = null, id : Number = NaN, autoConnect : Boolean = true, animated : Boolean = false)
		{
			super( animated );
			
			$logger = LoggerFactory.getLogger( this );

			objectQueue = new Array( );
			
			$playerManager = new PlayerManager( );
			
			$connector = connector || createConnector( id );
			
			if (autoConnect)
				$connector.connect( );
		}

		/**
		 * No connector was passed to the constructor so we need to create one.
		 * If no id was passed to the constructor we need to find the next available one.
		 * The constructor we create (if one isn't already available for the room id) is
		 * placed in that slot so that room can't be connected to again by accident.
		 */
		private function createConnector(id : Number = NaN) : GameConnector
		{
			var connector : GameConnector;
			
			$roomId = "spacezone";//(!isNaN( id )) ? id : getNextAvailableId( );

			if (ID_LIST[$roomId] != null)
			{
				return ID_LIST[$roomId] as GameConnector;
			}
			else
			{	
				connector = new GameConnector( );
				connector.addEventListener( GameConnectorEvent.CONNECTED, connectToRemoteScene );
				
				ID_LIST[$roomId] = connector;
			}
			
			return connector;
		}

		/**
		 * Find the lowest available free slot in the List of room ids.
		 */
		private function getNextAvailableId() : int
		{
			var nullEntry:Boolean = false;
			var i : int = 0;
			
			while(nullEntry)
			{
				nullEntry = (ID_LIST[i] == null);
				i++;
			}
			
			return i;	
		}

		/**
		 * <p>This callback method is called when this <i>local</i> <code>RemoteScene</code> has successfully connected to
		 * it's <i>remote</i> counterpart on the server.</p>
		 * 
		 * <p>A <code>PlayerManager</code> instance is created to handle the list of players connected to the same scene.</p>
		 * 
		 * <p>Both the <code>PlayerManager</code> and the <code>RemoteScene</code> instances are connected to the Remote Shared Objects 
		 * on the server.</p>
		 */
		private function connectionHandler(obj : Object) : void 
		{
			$playerManager.createRoomSO( $connector, roomId );
			createRoomSO( $connector );		
			
			inScene = true;
			//registerObjects();
			addQueuedObjectsToScene( );
		}

		/**
		 * <p>Handles connecting to the <code>RemoteScene</code>'s <i>remote</i> counterpart on the server.</p>
		 * 
		 * <p>If no <code>roomId</p> has been set then we connect to the next available number to make sure there's no collision
		 * with other <code>roomId</code> for other <code>RemoteScene</code> instances that may be available.</p>
		 */
		private function connectToRemoteScene(event : GameConnectorEvent = null) : void 
		{									
			$logger.info("Connecting to remote scene");
			$connector.connection.call( "paperworld.connectToZone", new Responder( connectionHandler ), GamePlayer.getInstance().uid, "spacezone" );		
		}

		/**
		 * Check if this scene contains a <code>PaperworldObject</code> with the name supplied.
		 */
		public function containsObject(id : String) : Boolean
		{
			for (var i : int = 0; i < objects.length ; i++)
			{
				if (objects[i] is Avatar)
				{
					var	object : Avatar = objects[i] as Avatar;
					
					if (object.name == id)
					{
						return true;
					}
				}
			}
			
			return false;
		}

		/**
		 * Connects to the Remote Shared Object on the server that contains the data about this scene.
		 */
		public function createRoomSO(connection : GameConnector) : void 
		{
			so = SharedObject.getRemote( roomId, connection.uri, false );
			so.addEventListener( SyncEvent.SYNC, onSync );
			so.connect( connection.connection );	
		}

		/**
		 * <p>Receives a SYNC event from the Remote Shared Object that contains the details of the 
		 * objects in the scene.</p>
		 * 
		 * <p>If the object that has changed doesn't already exist in the scene, then it's created and inserted
		 * into the scene. If it already exists then the new data is pushed through to the object's <code>synchronise()</code>
		 * method in order for it to sync with the server</p>
		 * 
		 * <p>This process means that the <code>PaperworldObject</code> instances know nothing about the Shared Objects
		 * on the server. This is currently due to an issue in Red5 that prevents the same client connecting to 
		 * the same Remote Shared Object. So we have to have a single point of contact - this is probably a good thing
		 * as having several SYNC handlers being called on the same client several times a second is the best
		 * way to crash the browser. It also means that the <code>PaperworldObject</code> instances can be 
		 * synchronised from other sources if necessary (i'm not sure how this could be useful at this point in time
		 * but it's always nice to have the option!)</p>
		 */
		public function onSync(event : SyncEvent) : void 
		{			
			var length : int = event.changeList.length;
			
			for (var j : int = 0; j < length ; j++)
			{
				var item : Object = event.changeList[j];
				var name : String = item["name"];
				var obj : Avatar;
				
				switch (item["code"])
				{
					case "clear":
					
						for (var i:String in so.data)
						{
							if (i != GamePlayer.getInstance().uid)
								createPaperworldObject( so.data[i]["modelKey"], i );
						}
						
						break;

					case "change":
												
						obj = getChildByName( name ) as Avatar;
						
						if (obj != null)
						{
							obj.synchronise( so.data[name] );
						}
						else
						{
							createPaperworldObject( so.data[name]["modelKey"], name );
						}
						
						break;
						
					case "delete":
					
						obj = getChildByName( name ) as Avatar;
						
						if (obj != null)
						{
							obj.destroy();
							removeChild(obj);
						}
						break;
					default:
						$logger.info("CODE: " + item["code"]);
						break;
				}
			}
		}

		private function createPaperworldObject(key : String, name : String) : void 
		{			
			$logger.info("CREATING PAPERWORLD OBJECT: " + key);
			
			var ObjectClass : Class = getDefinitionByName( key ) as Class;
			var object : Avatar = new ObjectClass( ) as Avatar;
			object.name = name;
			
			super.addChild( object, name );	
		}

		public override function addChild( child : DisplayObject3D, name : String = null ) : DisplayObject3D
		{						
			if (child is Avatar)
			{
				if (inScene)
				{
					var po : Avatar = child as Avatar;
					
					if (po.uid == GamePlayer.getInstance( ).uid)
					{
						//$connector.connection.call( "addPlayerToScene", new Responder( addingObjectHandler ), po.uid, roomId );
						child.name = GamePlayer.getInstance( ).uid;
					}
				}
				else
				{
					$logger.info( "not in scene - adding to queue" );
					objectQueue.push( child );
				}
			}
			
			return super.addChild( child );
		}

		/**
		 * If a <code>PaperworldObject</code> is added to this scene before it's connected to its <i>remote</i> counterpart then 
		 * it's added to the <code>objectQueue</code>. When a successful connection is established, this queue of objects are then added
		 * to the scene.
		 */
		private function addQueuedObjectsToScene() : void 
		{
			if (objectQueue.length > 0)
			{
				for (var i : int = 0; i < objectQueue.length ; i++)
				{
					var object : Avatar = objectQueue[i] as Avatar;
					//object.registered = true;
					addChild( object, object.name );
				}
			}
		}	
		/*
		private function registerObjects():void 
		{
			for (var i:int = 0; i < objects.length; i++)
			{
				if (objects[i] is Avatar)
				{
					(objects[i] as Avatar).registered = true;
				}	
			}
		}*/

		public function addingObjectHandler(obj : Object) : void 
		{
			$logger.info( "Object added to scene: " + obj );	
		}
/*
		public function addRemoteObject(key : String, id : String) : void 
		{
			logger.info( "Adding remote object\n" + key + "\n" + id + " == " + GamePlayer.getInstance( ).uid );
			
			if (!containsObject( id ))
			{
				var remoteObject : PaperworldObject = new PaperworldObject( );
				remoteObject.name = id;
				
				//remoteObject.setSharedObject($connection.connection);

				addChild( remoteObject, id );
			}
		}

		public function removeRemoteObject(uid : String) : void 
		{
			logger.info( "Removing " + uid );
			
			var remoteObject : PaperworldObject = getChildByName( uid ) as PaperworldObject;
			removeChild( remoteObject );
		}*/
	}
}

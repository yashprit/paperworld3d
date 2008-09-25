package com.paperworld.objects 
{
	import flash.events.SyncEvent;

	import com.paperworld.behaviours.Behaviour;
	import com.paperworld.core.BaseClass;
	import com.paperworld.interpolators.Interpolator;
	import com.paperworld.scenes.SynchronisedScene;
	import com.paperworld.util.Synchronizable;

	import jedai.net.rpc.RemoteSharedObject;	

	/**
	 * @author Trevor
	 */
	public class Avatar extends BaseClass
	{
		public var next : Avatar;

		/**
		 * The unique name of this Avatar in the scene.
		 */
		public var name : String;

		/**
		 * The scene this Avatar is currently in.
		 */
		public var scene : SynchronisedScene;

		/**
		 * The Synchronizable object that this Avatar represents in the 3D scene.
		 */
		public var syncObject : Synchronizable;

		/**
		 * A reference to the RemoteSharedObject that this Avatar is listening to. 
		 * This is stored here so that the destroy() method can remove itself from the event listener list when this Avatar is killed.
		 */
		public var remoteSharedObject : RemoteSharedObject;

		/**
		 * Interpolator used to smooth between states.
		 */
		public var interpolator : Interpolator;

		/**
		 * Behaviour used to interpret user input.
		 */
		public var behaviour : Behaviour;

		/**
		 * The Proxy object - this is a direct representation of the object on the server.
		 */
		public var proxy : ProxyObject;

		/**
		 * The Local object - this object responds directly to user input - it represents the client-side prediction.
		 */
		public var local : SyncObject;

		/**
		 * The state the user sees - the state of this object is applied to the object in the 3D engine.
		 */
		public var user : SyncObject;

		/**
		 * Sets the RemoteSharedObject on this avatar - we register for SyncEvent.SYNC events from it.
		 */
		public function set sharedObject(so : RemoteSharedObject) : void
		{
			remoteSharedObject = so;
			remoteSharedObject.addEventListener( SyncEvent.SYNC, synchronise );	
		}

		public function Avatar()
		{
			super( );
		}

		override public function initialise() : void
		{
			local = new SyncObject( );
			proxy = new ProxyObject( );
		}

		/**
		 * Handles a sync event from the RemoteSharedObject.
		 * Checks if the avatar is able to sync yet - if so, perform the sync action.
		 * If not then store the action so it can be performed when sync is available.
		 */
		public function synchronise(event : SyncEvent) : void
		{
			var list : Array = event.changeList;
			var length : int = list.length;
			
			// Iterate over event.changelist to check if this Avatar is in the list.
			for (var i : int = 0; i < length ; i++)
			{
				// If this object has changed.
				if (list[i].name == name)
				{
					// Decide which action to perform depending on what's happened to the SharedObject.
					switch (list[i].code)
					{
						case "change":
							break;
							
						default:
							break;	
					}
				}
			}
		}

		/**
		 * Allows the scene to remove an Avatar from the linked list.
		 */
		public function remove(syncObject : Synchronizable) : void
		{
			//if (this.syncObject == syncObject)
		}

		/**
		 * Destroy implementation.
		 * Remove listener from RemoteSharedObject.
		 */
		override public function destroy() : void
		{
			remoteSharedObject.removeEventListener( SyncEvent.SYNC, synchronise );
			remoteSharedObject = null;	
			
			syncObject.destroy( );
		}
	}
}

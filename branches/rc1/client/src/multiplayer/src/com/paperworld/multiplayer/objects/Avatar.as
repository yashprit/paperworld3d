package com.paperworld.multiplayer.objects 
{
	import com.paperworld.core.BaseClass;
	import com.paperworld.input.Input;
	import com.paperworld.interpolators.Interpolator;
	import com.paperworld.multiplayer.behaviours.AvatarBehaviour;
	import com.paperworld.multiplayer.data.State;
	import com.paperworld.multiplayer.scenes.AbstractSynchronisedScene;
	import com.paperworld.util.Synchronizable;	

	/**
	 * @author Trevor
	 */
	public class Avatar extends BaseClass
	{
		public var next : Avatar;

		/**
		 * The unique name of this Avatar in the scene.
		 */
		//public var name : String;

		/**
		 * The scene this Avatar is currently in.
		 */
		public var scene : AbstractSynchronisedScene;

		/**
		 * The Synchronizable object that this Avatar represents in the 3D scene.
		 */
		//public var syncObject : Synchronizable;
		public function set syncObject(value : Synchronizable) : void
		{
			client.syncObject = value;
		}
		
		public function get syncObject() : Synchronizable
		{
			return client.syncObject;
		}

		/**
		 * A reference to the RemoteSharedObject that this Avatar is listening to. 
		 * This is stored here so that the destroy() method can remove itself from the event listener list when this Avatar is killed.
		 */
		//public var remoteSharedObject : RemoteSharedObject;

		/**
		 * Interpolator used to smooth between states.
		 */
		public var interpolator : Interpolator;

		/**
		 * Behaviour used to interpret user input.
		 */
		public function set behaviour(value : AvatarBehaviour) : void
		{
			client.behaviour = value;
			proxy.behaviour = value;
		}

		/**
		 * The Proxy object - this is a direct representation of the object on the server.
		 */
		public var proxy : Proxy;

		/**
		 * The Local object - this object responds directly to user input - it represents the client-side prediction.
		 */
		public var client : Client;

		/**
		 * The state the user sees - the state of this object is applied to the object in the 3D engine.
		 */
		//public var user : SyncObject;

		/**
		 * Sets the RemoteSharedObject on this avatar - we register for SyncEvent.SYNC events from it.
		 */
		/*public function set sharedObject(so : RemoteSharedObject) : void
		{
			remoteSharedObject = so;
			remoteSharedObject.addEventListener( SyncEvent.SYNC, synchronise );	
		}*/

		public function Avatar()
		{
			super( );
		}

		override public function initialise() : void
		{
			client = new Client( );
			proxy = new Proxy( );
		}

		/**
		 * Handles a sync event from the RemoteSharedObject.
		 * Checks if the avatar is able to sync yet - if so, perform the sync action.
		 * If not then store the action so it can be performed when sync is available.
		 */
		public function synchronise(t : int, input : Input, state : State) : void
		{
			client.synchronise( t, state, input );
			proxy.synchronise( t, state, input );
		}

		public function update(t : int) : void
		{
			client.update( t );
			//proxy.update( t );	
		}

		/**
		 * Destroy implementation.
		 * Remove listener from RemoteSharedObject.
		 */
		override public function destroy() : void
		{
			//remoteSharedObject.removeEventListener( SyncEvent.SYNC, synchronise );
			//remoteSharedObject = null;	
			
			client.destroy( );
			proxy.destroy( );
		}
	}
}

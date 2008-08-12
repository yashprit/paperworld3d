package com.paperworld.scenes 
{
	import flash.events.SyncEvent;
	import flash.net.registerClassAlias;
	
	import com.paperworld.action.IntervalAction;
	import com.paperworld.data.Input;
	import com.paperworld.data.State;
	import com.paperworld.data.SyncData;
	import com.paperworld.lod.LodConstraint;
	import com.paperworld.objects.Avatar;
	import com.paperworld.util.Synchronizable;
	import com.paperworld.util.clock.Clock;
	
	import de.polygonal.ds.SLinkedList;	

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class SynchronisedScene extends IntervalAction
	{
		/**
		 * The 3D scene - cast to correct type using implicit getter in child classes.
		 */
		public var scene : *;

		/**
		 * The Clock instance used as a timer for this scene.
		 */
		public var clock : Clock;

		/**
		 * The 'point of view' object for Level of Detail heuristics - if no pov is defined then LOD will not be activated.
		 */
		public var pov : Avatar;

		/**
		 * The list of avatars in this scene.
		 */
		public var avatars : Avatar;

		/**
		 * The list of Level of Detail heuristics used in this scene.
		 */
		public var heuristics : SLinkedList;

		/**
		 * Adds a LOD Heuristic to the list. Implicit setter used in order to allow heuristics to be set via prana.
		 */
		public function set heuristic(h : LodConstraint) : void
		{
			heuristics.append( h );	
		}

		/**
		 * Constructor.
		 */
		public function SynchronisedScene()
		{
			super( );
		}

		/**
		 * Initialise implementation - initialises linked lists.
		 */
		override public function initialise() : void
		{
			heuristics = new SLinkedList( );
			
			// Create a new Clock to keep time.
			clock = new Clock( );
			
			// Register class aliases.
			registerClassAlias( "com.paperworld.data.input", Input );
			registerClassAlias( "com.paperworld.data.state", State );
			registerClassAlias( "com.paperworld.data.SyncData", SyncData );
		}

		/**
		 * Connect this scene to the server and synchronise with it's remote counterpart.
		 */
		public function connect() : void
		{
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
			var avatar : Avatar = new Avatar( );
			avatar.syncObject = child;
			
			// Add this avatar to the local list.
			avatars.append( avatar );
			
			// If this SyncObject is the local player then set as pov.
			if (pov) this.pov = avatar;
			
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
				next = next.next;				
			}	
			
			return child;
		}

		/**
		 * Handles a sync event from the RemoteSharedObject.
		 * Iterate over the list of avatars in this scene and apply the LOD heuristics.
		 */
		public function synchronise(event : SyncEvent) : void
		{
			if (canAct)
			{
				// Iterate over heuristics for each avatar to set lod interval.	
				var avatar : Avatar = avatars;
			}
		}
	}
}


package com.paperworld.client.flash 
{
	import com.paperworld.flash.BaseConnection;
	
	import flash.utils.Dictionary;	

	/**
	 * @author Trevor
	 */
	public class GhostConnection extends BaseConnection 
	{
		protected var _objects : Array;

		protected var _ghostLookupTable : Dictionary;
		
		protected var _scopeObject : GhostObject;
		
		public function get scopeObject() : GhostObject
		{
			return _scopeObject;
		}
		
		public function set scopeObject(value:GhostObject):void
		{
			_scopeObject = value;
		}

		public function GhostConnection()
		{
			super( );
			
			_objects = new Array( );
			_ghostLookupTable = new Dictionary( );
		}

		public function addObject(object : GhostObject) : void 
		{
			var info : GhostInfo = new GhostInfo( object );
			
			_ghostLookupTable[object] = info;
			_objects.push( info );
		}

		public function removeObject(info : GhostInfo) : Boolean
		{
			var object : GhostObject = GhostObject( _ghostLookupTable[info] );
			
			for (var i : int = 0; i < _objects.length ; i++)
			{
				var o : GhostObject = GhostObject( _objects[i] );
				
				if (o == object) 
				{
					_objects.splice( i, 1 );
					return true;
				}
			}
			
			return false;
		}
	}
}

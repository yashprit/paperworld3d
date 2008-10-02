package com.paperworld.multiplayer.scenes 
{
	import com.paperworld.multiplayer.objects.SynchronisableObject;	
	
	import org.papervision3d.objects.DisplayObject3D;	
	import org.papervision3d.scenes.Scene3D;
	
	import com.paperworld.scenes.AbstractSynchronisedScene;		

	/**
	 * @author Trevor
	 */
	public class SynchronisedScene extends AbstractSynchronisedScene 
	{
		protected var _scene : Scene3D;
		
		public function get scene():Scene3D
		{
			return _scene;
		}
		
		public function set scene(value:Scene3D):void
		{
			_scene = value;
		}

		public function SynchronisedScene()
		{
			super( );
		}

		override public function initialise() : void
		{
			super.initialise( );
			
			_scene = new Scene3D( );	
		}

		override public function addChild(child : *) : *
		{
			if (child is DisplayObject3D)
			{
				return _scene.addChild( child );	
			}
			else if (child is SynchronisableObject)
			{
				return _scene.addChild( SynchronisableObject(child).object );
			}
			else
			{
				// error - not a valid type.
			}
			
			return null;	
		}

		override public function removeChild(child : *) : *
		{
			return _scene.removeChild( child );
		}
	}
}

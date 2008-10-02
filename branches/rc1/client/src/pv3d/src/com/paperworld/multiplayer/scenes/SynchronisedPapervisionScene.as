package com.paperworld.multiplayer.scenes 
{
	import org.papervision3d.scenes.Scene3D;

	import com.paperworld.scenes.SynchronisedScene;	

	/**
	 * @author Trevor
	 */
	public class SynchronisedPapervisionScene extends SynchronisedScene 
	{
		protected var _scene : Scene3D;

		public function SynchronisedPapervisionScene()
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
			return _scene.addChild( child );	
		}

		override public function removeChild(child : *) : *
		{
			return _scene.removeChild( child );
		}
	}
}

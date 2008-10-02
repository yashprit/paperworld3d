package com.paperworld.multiplayer.objects 
{
	import org.papervision3d.core.proto.GeometryObject3D;
	import org.papervision3d.objects.DisplayObject3D;
	
	import com.paperworld.data.State;
	import com.paperworld.util.Synchronizable;	

	/**
	 * @author Trevor
	 */
	public class SynchronisableDisplayObject3D extends DisplayObject3D implements Synchronizable 
	{
		public function SynchronisableDisplayObject3D(name : String = null, geometry : GeometryObject3D = null)
		{
			super( name, geometry );
		}
		
		public function synchronise(state : State) : void
		{
			x = state.position.x;
			y = state.position.y;
			z = state.position.z;
		}

		public function destroy() : void
		{
		}
	}
}

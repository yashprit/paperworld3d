package com.paperworld.multiplayer.objects 
{
	import org.papervision3d.objects.DisplayObject3D;

	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.multiplayer.data.State;
	import com.paperworld.util.Synchronizable;
	import com.paperworld.util.math.Quaternion;		

	/**
	 * @author Trevor
	 */
	public class SynchronisableObject implements Synchronizable 
	{
		public var object : DisplayObject3D;

		private var logger : XrayLog = new XrayLog( );

		public function SynchronisableObject(object : DisplayObject3D = null)
		{
			super( );
			
			this.object = object;
		}
		
		public function getObject():*
		{
			return object;
		}

		public function synchronise(state : State) : void
		{			
			//logger.info("synchronising object " + state.orientation.w);
			this.object.x = state.position.x;
			this.object.y = state.position.y;
			this.object.z = state.position.z;

			object.localRotationY = state.orientation.w;
		}

		public function destroy() : void
		{
		}
	}
}

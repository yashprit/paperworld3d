package com.paperworld.multiplayer.objects 
{
	import org.papervision3d.objects.DisplayObject3D;
	
	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.multiplayer.data.State;
	import com.paperworld.util.Synchronizable;		

	/**
	 * @author Trevor
	 */
	public class SynchronisableObject implements Synchronizable 
	{
		public var object : DisplayObject3D;
		
		private var logger : XrayLog = new XrayLog();

		public function SynchronisableObject(object : DisplayObject3D = null)
		{
			super( );
			
			this.object = object;
		}
		
		public function synchronise(state : State) : void
		{			
			//logger.info("z " + state.position.z);
			this.object.x = state.position.x;
			this.object.y = state.position.y;
			this.object.z = state.position.z;
		}

		public function destroy() : void
		{
		}
	}
}

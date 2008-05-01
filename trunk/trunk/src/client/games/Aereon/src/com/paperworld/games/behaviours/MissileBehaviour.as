package com.paperworld.games.behaviours 
{
	import com.paperworld.logging.LoggerFactory;	
	
	import org.papervision3d.core.math.Quaternion;
	import org.papervision3d.objects.DisplayObject3D;
	
	import com.paperworld.logging.ILogger;
	import com.paperworld.rpc.data.AvatarInput;
	import com.paperworld.rpc.data.AvatarState;
	import com.paperworld.rpc.objects.IAvatarBehaviour;	
	/**
	 * @author Trevor
	 */
	public class MissileBehaviour implements IAvatarBehaviour 
	{
		public var maxSpeed : Number = 50;
		
		public var logger:ILogger;
		
		public function MissileBehaviour() {
			logger = LoggerFactory.getLogger(this);
		}

		public function update(input : AvatarInput, state : AvatarState, displayObject : DisplayObject3D) : void
		{
			input.forward = true;
			
			displayObject.moveForward( maxSpeed );
			
			logger.info("displayObject: " + displayObject);
			
			state.transform.copy( displayObject.transform );
			state.orientation = Quaternion.createFromMatrix( state.transform );
		}

		public function destroy() : void
		{
		}
	}
}

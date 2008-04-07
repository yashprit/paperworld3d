package com.paperworld.games.cameras 
{
	import org.papervision3d.cameras.FreeCamera3D;
	import org.papervision3d.core.render.AbstractRenderEngine;
	import org.papervision3d.events.RendererEvent;
	
	import com.paperworld.logging.ILogger;
	import com.paperworld.logging.LoggerFactory;
	import com.paperworld.rpc.objects.Avatar;		

	/**
	 * @author Trevor
	 */
	public class FollowCamera extends FreeCamera3D 
	{
		private var $target : Avatar;

		private var $renderer : AbstractRenderEngine;
		
		public function FollowCamera(zoom : Number = 2, focus : Number = 100, initObject : Object = null)
		{
			super( zoom, focus, initObject );
		}

		public function set target(value : Avatar) : void 
		{
			$target = value;
		}

		public function set renderer(value : AbstractRenderEngine) : void 
		{
			$renderer = value;
			$renderer.addEventListener( RendererEvent.RENDER_DONE, updateCamera );
		}

		public function updateCamera(event : RendererEvent) : void
		{			
			transform.copy( $target.avatar.current.transform );
			moveBackward( 750 );
			moveUp( -( $target.character.input.mouseY * 30 ) + 270 );
			moveLeft( -( $target.character.input.mouseX * 15 ) );
			roll( ( $target.character.input.mouseX * 5 ) );	
			pitch( 10 );
		}
	}
}

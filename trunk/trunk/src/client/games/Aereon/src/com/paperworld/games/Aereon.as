package com.paperworld.games 
{
	import flash.display.Sprite;
	
	import org.papervision3d.materials.special.ParticleMaterial;
	import org.papervision3d.objects.special.StarField;
	import org.papervision3d.render.BasicRenderEngine;
	import org.papervision3d.scenes.Scene3D;
	import org.papervision3d.view.Viewport3D;
	
	import com.paperworld.framework.module.AbstractModule;
	import com.paperworld.games.cameras.FollowCamera;
	import com.paperworld.logging.ILogger;
	import com.paperworld.logging.LoggerFactory;
	import com.paperworld.rpc.player.GamePlayer;
	import com.paperworld.rpc.scenes.RemoteScene;
	import com.paperworld.rpc.timer.GameTimer;
	import com.paperworld.rpc.timer.events.RenderEvent;	

	/**
	 * @author Trevor
	 */
	public class Aereon extends AbstractModule
	{
		private var logger : ILogger;

		private var renderer : BasicRenderEngine;

		private var camera : FollowCamera;

		private var starsViewport : Viewport3D;

		private var starsScene : Scene3D;

		private var playerViewport : Viewport3D;

		private var playerScene : RemoteScene;		

		public function Aereon()
		{
			super( );
			
			logger = LoggerFactory.getLogger( this );
		}

		override public function initialise(target : Sprite) : void 
		{
			super.initialise( target );
			
			logger = LoggerFactory.getLogger(this);
			
			GamePlayer.getInstance( ).createVehicle( );
			
			initScene( );
			createStars( );

			initTimer( );
		}

		private function initScene() : void
		{
			renderer = new BasicRenderEngine( );
			
			starsScene = new Scene3D( );
			
			playerScene = new RemoteScene();	
			playerScene.addChild( GamePlayer.getInstance( ).vehicle );

			starsViewport = new Viewport3D( 0, 0, true, false );
			target.addChild( starsViewport );
			
			playerViewport = new Viewport3D( 0, 0, true, true );
			target.addChild( playerViewport );			
			
			camera = new FollowCamera( );
			camera.zoom = 11;
			camera.focus = 100;
			camera.target = GamePlayer.getInstance( ).vehicle;
			camera.renderer = renderer;
		}

		protected function createStars() : void
		{
			// Create a new particle material;
			var pm : ParticleMaterial = new ParticleMaterial( 0xFFFFFF, 1 );
			
			// Create a new particlefield.
			var particleField : StarField = new StarField( pm, 1000, 1000000, 1000000, 1000000, false, 1 );
									
			starsScene.addChild( particleField );
		}

		private function initTimer() : void 
		{			
			var gameTimer : GameTimer = GameTimer.getInstance( );			
			gameTimer.addEventListener( RenderEvent.RENDER_EVENT, render );			
			gameTimer.start( );
		}

		private function render(event : RenderEvent) : void 
		{
			renderer.renderScene( starsScene, camera, starsViewport );
			renderer.renderScene( playerScene, camera, playerViewport );
		}
	}
}

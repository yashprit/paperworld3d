package com.paperworld.games.hud
{
	import flash.display.Sprite;
	import flash.display.Stage;
	
	import org.papervision3d.cameras.FreeCamera3D;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.render.BasicRenderEngine;
	import org.papervision3d.scenes.Scene3D;
	import org.papervision3d.view.Viewport3D;
	
	import com.paperworld.PaperWorld;
	import com.paperworld.rpc.timer.GameTimer;
	import com.paperworld.rpc.timer.events.IntegrationEvent;	
	
	public class RadarView
	{
		public static var RADAR_SCALE : Number = 10;

		public static var FRAME_WIDTH : int = 200;

		public static var FRAME_HEIGHT : int = 200;

		public var camera : FreeCamera3D;

		public var scene : Scene3D;

		private var $radarObjects : Array;

		public var playerVehicle : DisplayObject3D;

		public function RadarView(target : Sprite)
		{						
			createAssets( target );
			
			GameTimer.getInstance( ).addEventListener( IntegrationEvent.INTEGRATION_EVENT, integrate );
		}

		private function createAssets( target : Sprite ) : void
		{
			createFrame( target );	
  			
			createCamera( );
			createPlayerVehicle( );
		}

		private function createFrame( target : Sprite ) : void 
		{
			var stage : Stage = PaperWorld.getInstance( ).stage;
		}

		private var renderer : BasicRenderEngine;

		private var viewport : Viewport3D;

		private function createScene( target : Sprite ) : void 
		{

		}

		private function createCamera() : void 
		{
			camera = new FreeCamera3D( 5 );
		}

		private function createPlayerVehicle() : void 
		{
			
		}

		public function updateCamera() : void 
		{

		}

		private function integrate( event : IntegrationEvent ) : void 
		{
		}
	}
}
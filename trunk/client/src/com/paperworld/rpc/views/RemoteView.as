package com.paperworld.rpc.views
{
	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.cameras.FollowCamera3D;
	import com.paperworld.rpc.scenes.RemoteScene;
	import com.paperworld.rpc.timer.GameTimer;
	import com.paperworld.rpc.timer.events.RenderEvent;
	
	import jedai.net.rpc.Red5Connection;
	
	import org.papervision3d.cameras.*;
	import org.papervision3d.render.BasicRenderEngine;
	import org.papervision3d.view.AbstractView;
	import org.papervision3d.view.Viewport3D;

	public class RemoteView extends AbstractView
	{
		private var gameTimer:GameTimer = GameTimer.getInstance();
		
		private var logger:XrayLog = new XrayLog();
		
		public function get connection():Red5Connection
		{
			return (scene as RemoteScene).connection;
		}
		
		public function get remoteScene():RemoteScene
		{
			return scene as RemoteScene;
		}
		
		public function set zone(value:String):void 
		{
			logger.info("Setting zone in remoteView: " + value);
			remoteScene.zone = value;
		}
		
		public function RemoteView(zone:String = null, viewportWidth:Number=640, viewportHeight:Number=320, scaleToStage:Boolean=true, interactive:Boolean=true, cameraType:String = "FREECAMERA3D")
		{
			super();
						
			scene = new RemoteScene(zone);
			viewport = new Viewport3D(viewportWidth, viewportHeight, scaleToStage, interactive);
			addChild(viewport);
			renderer = new BasicRenderEngine();
			
			switch(cameraType){
				case Camera3D.TYPE:
					_camera = new Camera3D();
				break;
				case FreeCamera3D.TYPE:
					_camera = new FreeCamera3D();
				break;
				case FrustumCamera3D.TYPE:
					_camera = new FrustumCamera3D(viewport);
				break;
				case FollowCamera3D.TYPE:
					_camera = new FollowCamera3D(renderer);
				break;
				default:
					_camera = new Camera3D();
				break;
			}
		}
		
		override public function startRendering():void
		{			
			gameTimer.addEventListener(RenderEvent.RENDER_EVENT, onRenderTick);
			gameTimer.start();
			viewport.containerSprite.cacheAsBitmap = false;
		}
		
		override public function stopRendering(reRender:Boolean = false, cacheAsBitmap:Boolean = false):void
		{
			gameTimer.removeEventListener(RenderEvent.RENDER_EVENT, onRenderTick);
			gameTimer.stop();
			
			if(reRender){
				onRenderTick();	
			}
			if(cacheAsBitmap){
				viewport.containerSprite.cacheAsBitmap = true;
			}else{
				viewport.containerSprite.cacheAsBitmap = false;
			}
		}
		
		public function get cameraAsCamera3D():Camera3D
		{
			return _camera as Camera3D;
		}
		
		public function get cameraAsFreeCamera3D():FreeCamera3D
		{
			return _camera as FreeCamera3D;
		}
		
		public function get cameraAsFrustrumCamera3D():FrustumCamera3D
		{
			return _camera as FrustumCamera3D;
		}
		
		public function get cameraAsFollowCamera3D():FollowCamera3D
		{
			return camera as FollowCamera3D;
		}
	}
}
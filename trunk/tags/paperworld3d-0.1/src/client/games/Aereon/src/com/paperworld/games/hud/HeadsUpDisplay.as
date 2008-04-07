package com.paperworld.games.hud
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	
	import com.paperworld.PaperWorld;
	import com.paperworld.framework.module.AbstractModule;
	import com.paperworld.managers.LibraryManager;	

	public class HeadsUpDisplay
	{
		private static var $instance : HeadsUpDisplay

		public var target : Sprite

		private var $outerHud : MovieClip

		private var $innerHud : MovieClip

		private var $maxSliderScale : Number = 70.0

		public var radarView : RadarView

		public static var COCKPIT_VIEW : Boolean = false

		public function HeadsUpDisplay( target : Sprite )
		{
			this.target = new Sprite( )
			target.addChild( this.target )
			
			createAssets( )
			alignAssets( )
			
			PaperWorld.getInstance( ).stage.addEventListener( Event.RESIZE, alignAssets )
		}

		public static function getInstance( target : Sprite = null ) : HeadsUpDisplay
		{
			if ($instance == null)
				$instance = new HeadsUpDisplay( target )
				
			return $instance
		}

		private function createAssets() : void 
		{
			var currentModule : AbstractModule = PaperWorld.getInstance( ).currentModule
			
			$outerHud = LibraryManager.getInstance( ).getMovieClip( currentModule.getProperty( "name" ), "OuterHud" );
			target.addChild( $outerHud )
			
			$innerHud = LibraryManager.getInstance( ).getMovieClip( currentModule.getProperty( "name" ), "InnerHud" );
			$outerHud.addChild( $innerHud )
			
			$outerHud.visible = COCKPIT_VIEW
			
			createRadarView( )
		}

		private function createRadarView() : void 
		{
			//$radarView = new RadarView( $target )
		}

		public function toggleView() : void 
		{
			COCKPIT_VIEW = !COCKPIT_VIEW
			
			toggleHud( )
		}

		public function toggleHud() : void 
		{
			var target : Number = COCKPIT_VIEW ? 1 : 0
			
			/*Tweener.addTween( $outerHud, {
										 alpha: target, time:0.5, transition:"easeoutsine", onComplete:setHudVisible, onCompleteParams: new Array( COCKPIT_VIEW )
										} )*/
		}

		public function setHudVisible(visible : Boolean) : void 
		{
			$outerHud.visible = visible
		}

		public function setSpeed(value : Number) : void 
		{
			$outerHud.slider.height = ( value / 500 ) * $maxSliderScale
			
			//$radarView.updateCamera()
		}

		public function alignAssets( event : Event = null ) : void 
		{
			var stage : Stage = PaperWorld.getInstance( ).stage
			
			$outerHud.x = -( $outerHud.width / 2 )
			$outerHud.y = -( $outerHud.height / 2 )
		}

		public function destroy() : void 
		{
		}
	}	
}
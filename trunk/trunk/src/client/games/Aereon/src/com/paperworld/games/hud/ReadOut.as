package com.paperworld.games.hud 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.text.TextField;
	
	import com.paperworld.PaperWorld;
	import com.paperworld.logging.ILogger;
	import com.paperworld.logging.LoggerFactory;
	import com.paperworld.managers.LibraryManager;	

	/**
	 * @author Trevor
	 */
	public class ReadOut 
	{
		private var speedReadOut : MovieClip;

		private var logger : ILogger;

		public function ReadOut(target : Sprite)
		{
			logger = LoggerFactory.getLogger( this );
			
			createAssets( target );
		}

		private function createAssets(target : Sprite) : void 
		{
			speedReadOut = LibraryManager.getInstance( ).getMovieClip( "FITCDemo", "LayeredText" );
			PaperWorld.getInstance( ).stage.addEventListener( Event.RESIZE, handleStageResize );
			handleStageResize( );
			target.addChild( speedReadOut );
		}

		public function setSpeed(value : int) : void 
		{
			logger.info( "Setting Speed: " + value );
			
			for (var i : int = 1; i < 15 ; i++)
			{
				var layer : MovieClip = speedReadOut.getChildByName( "layer" + i ) as MovieClip;
				logger.info( "Layer: " + layer );
				var textField : TextField = layer.getChildByName( "textField" ) as TextField;
				logger.info( "TextField: " + textField );
				textField.text = value as String;
			}
		}

		public function handleStageResize(event : Event = null) : void 
		{
			var stage : Stage = PaperWorld.getInstance( ).stage;
			speedReadOut.x = stage.stageWidth - (speedReadOut.width / 2);
			speedReadOut.y = stage.stageHeight - (speedReadOut.height / 2); 
		}
	}
}

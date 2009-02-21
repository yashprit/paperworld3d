package  
{
	import flash.display.Sprite;		

	/**
	 * @author Trevor
	 */
	public class Circle extends Sprite
	{
		protected var _view : Sprite;

		public function Circle(colour:Number)
		{
			super();
			
			draw(colour);
		}
		
		public function draw(colour:Number):void 
		{
			graphics.lineStyle(1, colour);
			graphics.drawCircle(0, 0, 10);
		}
	}
}

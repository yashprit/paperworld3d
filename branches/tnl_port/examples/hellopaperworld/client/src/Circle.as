package  
{
	import flash.display.Sprite;		

	/**
	 * @author Trevor
	 */
	public class Circle
	{
		protected var _view : Sprite;

		public function Circle(view:Sprite)
		{
			_view = view;
		}
		
		public function draw():void 
		{
			_view.graphics.lineStyle(1, 0xff0000);
			_view.graphics.drawCircle(0, 0, 10);
		}
	}
}

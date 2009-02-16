package  
{
	import com.paperworld.flash.NetObject;
	
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;	

	/**
	 * @author Trevor
	 */
	public class GameObject extends NetObject 
	{
		public static const MOVE_MASK:int = 1 << 0;
		public static const POSITION_MASK:int = 1 << 1;
		
		protected var _pendingMoves:Array;
		
		public function GameObject()
		{
			super();
			
			_pendingMoves = new Array();
		}
		
		override public function readExternal(input : IDataInput) : void
		{
			super.readExternal( input );
		}

		override public function writeExternal(output : IDataOutput) : void
		{
			super.writeExternal( output );
			
			_pendingMoves = new Array();
		}
		
		protected function clearPendingMoves():void 
		{
			for each (var move:Move in _pendingMoves) 
			{
				move.destroy();
			}
			
			_pendingMoves = new Array();
		}
	}
}

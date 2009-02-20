package  
{

	/**
	 * @author Trevor
	 */
	public class MoveObject extends GameObject 
	{
		public static const moveTimeEpsilon : Number = 0.000001;
		public static const velocityEpsilon : Number = 0.00001;

		public static const MaxVelocity : Number = 10;
		public static const Acceleration : Number = 2;

		public static const ActualState : int = 0;
		public static const RenderState : int = 1;
		public static const LastProcessState : int = 2;

		protected var _moveState : Array;

		public function MoveObject()
		{
			super( );
			
			_moveState = new Array( );
		}

		override public function idle(path : int) : void 
		{
		}

		protected function processMove(stateIndex : int) : void 
		{
			var sTime : int = _currentMove.time;
			
			_moveState[LastProcessState] = _moveState[stateIndex];
			
			var time : int = _currentMove.time * 0.001;
			
			var requestVel : Vector2 = new Vector2( _currentMove.right - _currentMove.left, _currentMove.down - _currentMove.up );
			
			requestVel.multiplyEquals( MaxVelocity );
			var len : Number = requestVel.len( );
			
			if (len > MaxVelocity)
			{
				requestVel.multiplyEquals( MaxVelocity / len );
			}
			
			var velDelta : Vector2 = requestVel.minus( MoveState( _moveState[stateIndex] ).vel );
			var accRequested : Number = velDelta.len( );

			var maxAccel : Number = Acceleration * time;
			if(accRequested > maxAccel)
			{
				velDelta.multiplyEquals( maxAccel / accRequested );
				MoveState( _moveState[stateIndex] ).vel.plusEquals( velDelta );
			}
			else
			{
				MoveState( _moveState[stateIndex] ).vel = requestVel;
			}
		
			MoveState( _moveState[stateIndex] ).angle = _currentMove.angle;
			move( time, stateIndex, false );
		}

		public function move(moveTime : int, stateIndex : int, displacing : Boolean) : void
		{
			var tryCount : int = 0;
			while(moveTime > moveTimeEpsilon && tryCount < 8)
			{
				tryCount++;
				if(!displacing && MoveState( _moveState[stateIndex] ).vel.len( ) < velocityEpsilon)
		         return;
				
				MoveState( _moveState[stateIndex] ).pos.plusEquals( MoveState( _moveState[stateIndex] ).vel.multiply( moveTime ) );
			}
		}
	}
}

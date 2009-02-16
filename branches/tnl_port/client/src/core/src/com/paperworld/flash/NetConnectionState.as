package com.paperworld.flash 
{
	import org.pranaframework.utils.Assert;	

	/**
	 * @author Trevor
	 */
	public class NetConnectionState 
	{
		public static const NotConnected : NetConnectionState = new NetConnectionState( NotConnected_val );
		public static const ConnectTimedOut : NetConnectionState = new NetConnectionState( ConnectTimedOut_val );
		public static const ConnectRejected : NetConnectionState = new NetConnectionState( ConnectRejected_val );
		public static const Connected : NetConnectionState = new NetConnectionState( Connected_val );
		public static const Disconnected : NetConnectionState = new NetConnectionState( Disconnected_val );
		public static const TimedOut : NetConnectionState = new NetConnectionState( TimedOut_val );

		public static const NotConnected_val : int = 0;
		public static const ConnectTimedOut_val : int = 1;
		public static const ConnectRejected_val : int = 2;
		public static const Connected_val : int = 3;
		public static const Disconnected_val : int = 4;
		public static const TimedOut_val : int = 5;

		private static var _enumCreated : Boolean = false;

		private var _val : int;

		{
			_enumCreated = true;
		}

		/**
		 * Creates a new NetClassTypes object.
		 * This constructor is only used internally to set up the enum and all
		 * calls will fail.
		 * 
		 * @param val the value (int) of the type
		 */
		public function NetConnectionState(val : int) 
		{
			Assert.state( (false == _enumCreated), "The NetConnectionState enum has already been created." );
			_val = val;
		}

		/**
		 * 
		 */
		public static function fromValue(val : int) : NetConnectionState 
		{
			var result : NetConnectionState;
			
			// check if the val is a valid value in the enum
			switch (val) 
			{
				case NotConnected_val:
					result = NotConnected;
					break;
				case ConnectTimedOut_val:
					result = ConnectTimedOut;
					break;
				case ConnectRejected_val:
					result = ConnectRejected;
					break;
				case Connected_val:
					result = Connected;
					break;
				case Disconnected_val:
					result = Disconnected;
					break;
				case TimedOut_val:
					result = TimedOut;
					break;
				default:
					result = NotConnected;
			}
			return result;
		}

		/**
		 * Returns the name of the scope.
		 * 
		 * @returns the name of the scope
		 */
		public function get value() : int 
		{
			return _val;
		}
		
		public function toString():String
		{
			return _val.toString();
		}
	}
}

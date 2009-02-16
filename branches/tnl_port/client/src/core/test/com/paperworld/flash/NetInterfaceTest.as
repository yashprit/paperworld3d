package com.paperworld.flash 
{
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;

	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;		

	/**
	 * @author Trevor
	 */
	public class NetInterfaceTest extends TestCase 
	{
		private var $netInterface : NetInterface;

		private var $netConnection : BaseConnection;

		public function NetInterfaceTest(methodName : String = null)
		{
			super( methodName );
		}

		override public function setUp() : void 
		{
			$netInterface = new NetInterface( );
			$netConnection = new BaseConnection( );
		}

		override public function tearDown() : void 
		{
			$netInterface.destroy( );
			$netInterface = null;
			
			$netConnection.destroy( );
			$netConnection = null;
		}

		public function testConnect() : void 
		{
			$netInterface.addConnection( $netConnection );
			$netInterface.addEventListener( NetStatusEvent.NET_STATUS, addAsync( onTestConnect, 2000 ) );
			$netInterface.connect( TestConstants.TEST_URI );
		}

		private function onTestConnect(event : NetStatusEvent) : void 
		{
			assertTrue( "Expecting $netInterface.connected == true", $netInterface.connected );
			assertEquals( "Expecting $netConnection.connectionState == NetConnectionState.Connected", $netConnection.connectionState, NetInterface.Connected );
		}

		public function testAddConnection() : void 
		{
			$netInterface.addConnection( $netConnection );
			
			assertTrue( "Expecting $netInterface.connections[0] == connection", $netInterface.connections[0] == $netConnection );
		}

		public function testRemoveConnection() : void
		{
			$netInterface.addConnection( $netConnection );			
			$netInterface.removeConnection( $netConnection );
			
			assertEquals("Expecting $netInterface.connections.length == 0", $netInterface.connections.length, 0);
			assertEquals("Expecting $netConnection.connectionState == NetConnectionState.Disconnected", $netConnection.connectionState, NetInterface.Disconnected );
		}

		/**
		 * Setup the flexunit suite
		 **/
		public static function suite() : TestSuite 
		{
			var suite : TestSuite = new TestSuite( );
			
			suite.addTest( new NetInterfaceTest( "testAddConnection" ) );
			suite.addTest( new NetInterfaceTest( "testRemoveConnection" ) );
			suite.addTest( new NetInterfaceTest( "testConnect" ) );									
			return suite;
		}
	}
}

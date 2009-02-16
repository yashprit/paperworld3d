package com.paperworld.flash
{
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	import com.blitzagency.xray.logger.XrayLog;
	
	import flash.events.NetStatusEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;import flash.utils.setTimeout;	

	/**
	 * @author Trevor
	 */
	public class GhostConnectionTest extends TestCase
	{		
		private var $netInterface : NetInterface;

		private var $ghostConnection : DummyGhostConnection;
		
		private var $netObject : DummyNetObject;
		
		private var logger : XrayLog = new XrayLog();

		public function GhostConnectionTest(method : String)
		{
			super( method );
		}

		override public function setUp() : void 
		{
			$netInterface = new NetInterface( );
			$ghostConnection = new DummyGhostConnection( );
			
			$netInterface.addConnection( $ghostConnection );
		}

		override public function tearDown() : void 
		{
			$netInterface.destroy( );
			$netInterface = null;
			
			$ghostConnection.destroy( );
			$ghostConnection = null;
		}

		public function testCheckPacketSend() : void 
		{
			$netInterface.addConnection( $ghostConnection );
			$netInterface.addEventListener( NetStatusEvent.NET_STATUS, addAsync( onConnected, 2000 ) );
			$netInterface.connect( TestConstants.TEST_URI );
		}

		private function onConnected(event : NetStatusEvent) : void 
		{
			assertTrue( "Expecting $netInterface.connected == true", $netInterface.connected );
			assertEquals( "Expecting $netConnection.connectionState == NetConnectionState.Connected", $ghostConnection.connectionState, NetInterface.Connected );
			
			$netObject = new DummyNetObject();
			//setTimeout(onTestCheckPacketSend, 2000);
			
			$ghostConnection.checkPacketSend(false, 0);
			
		}
		
		public function onTestCheckPacketSend():void 
		{
			logger.info("testing check packet send");
			assertTrue("Expecting $ghostConnection.packetSent == true", $ghostConnection.packetSent );
		}

		/**
		 * Setup the flexunit suite
		 **/
		public static function suite() : TestSuite 
		{
			var suite : TestSuite = new TestSuite( );
			
			suite.addTest( new GhostConnectionTest( "testCheckPacketSend" ) );
			
			return suite;
		} 
	}
}

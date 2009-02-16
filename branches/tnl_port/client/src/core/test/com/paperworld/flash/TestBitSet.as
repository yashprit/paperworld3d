package com.paperworld.flash 
{
	import com.blitzagency.xray.logger.XrayLog;	
	
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;	

	/**
	 * @author Trevor
	 */
	public class TestBitSet extends TestCase 
	{
		public static const TEST_BIT_0:int = 1 << 0;
		public static const TEST_BIT_1:int = 1 << 1;
		public static const TEST_BIT_2:int = 1 << 2;
		public static const TEST_BIT_3:int = 1 << 3;
		
		private var options:BitSet;
		
		private var logger : XrayLog = new XrayLog();

		public function TestBitSet(methodName : String = null)
		{
			super( methodName );
		}
		
		override public function setUp() :void 
		{
			options = new BitSet();
			options.set( TEST_BIT_0 | TEST_BIT_1 | TEST_BIT_3 );	
			logger.info("options: " + options.bits );
		}

		override public function tearDown():void 
		{
			options.set(0);
			options = null;
		}
		
		public function testTest():void 
		{						
			assertFalse("Expecting bitSet.test(TEST_BIT_2) == false", options.test(TEST_BIT_2));
			assertTrue("Expecting bitSet.test(TEST_BIT_3) == true", options.test(TEST_BIT_3));
			assertTrue("Expecting bitSet.test(TEST_BIT_0 | TEST_BIT_1) == true", options.test(TEST_BIT_0 | TEST_BIT_1));
		}
		
		public static function suite() : TestSuite 
		{
			var suite : TestSuite = new TestSuite( );
			
			suite.addTest( new TestBitSet( "testTest" ) );
			
			return suite;
		} 
	}
}

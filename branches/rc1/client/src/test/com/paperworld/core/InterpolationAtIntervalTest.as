package com.paperworld.core 
{
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;	

	/**
	 * @author Trevor
	 */
	public class InterpolationAtIntervalTest extends TestCase 
	{
		public function InterpolationAtIntervalTest(methodName : String = null)
		{
			super( methodName );
		}

		public function testCanSync() : void
		{
			var sync : InterpolateAtInterval = new InterpolateAtInterval( );
			sync.time = 5;
			sync.interval = 10;
			
			assertTrue( "Expecting sync.canSync() == true", sync.canInterpolate( ) );
			assertFalse( "Expecting sync.canSync() == false", sync.canInterpolate( ) );			
		}

		/**
		 * Setup the flexunit suite
		 **/
		public static function suite() : TestSuite 
		{
			var suite : TestSuite = new TestSuite( );
			
			suite.addTest( new InterpolationAtIntervalTest( "testCanSync" ) );
			
			return suite;
		}
	}
}

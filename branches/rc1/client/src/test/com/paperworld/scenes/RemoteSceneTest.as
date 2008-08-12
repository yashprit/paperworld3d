package com.paperworld.scenes 
{
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;	

	/**
	 * @author Trevor
	 */
	public class RemoteSceneTest extends TestCase 
	{
		public function RemoteSceneTest(methodName : String = null)
		{
			super( methodName );
		}
		
		public function testConnect():void
		{
				
		}
		
		/**
		 * Setup the flexunit suite
		 **/
		public static function suite() : TestSuite 
		{
			var suite : TestSuite = new TestSuite( );
			
			suite.addTest( new RemoteSceneTest( "testConnect" ) );
			
			return suite;
		}
	}
}

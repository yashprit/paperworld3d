package com.paperworld.util.number 
{

	/**
	 * @author Trevor
	 */
	public class RandomUtils 
	{
		public static function randomBinomial() : Number
		{
			return 0;	
		}

		public static function randomBoolean() : Boolean
		{
			return Math.random() * 10 < 5;	
		}

		public static function randomInt(min : int, max : int) : int
		{
			return (Math.random() * (max - min)) + min;	
		}
	}
}

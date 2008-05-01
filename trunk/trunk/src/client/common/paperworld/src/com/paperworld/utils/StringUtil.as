package com.paperworld.utils
{ 
	public class StringUtil
	{
		public function StringUtil()
		{
		}

		/**
		 * Extract all numbers from a string, combine and return
		 * as a complete number.
		 */
		public static function extractNumber(s : String) : Number
		{
			var ns : String = "";
			for (var i : Number = 0; i < s.length ; i++)
			{
				var v : Number = parseInt( s.charAt( i ) );
				
				if (!isNaN( v ))
				{
					ns += String( v );
				}
			}		
			
			return parseInt( ns );
		}

		/**
		 * Replaces any instances of the findToken with the replaceToken.  
		 */
		public static function replace(originalString : String,findToken : String,replaceWithToken : String) : String
		{	
			// Avoids infinite loop caused by passing the following params -> replace("Hellojojom","jojo","jojojo");
			var lastFoundIndex : Number = 0;
			
			while(originalString.indexOf( findToken, lastFoundIndex ) >= 0)
			{
				var foundIndex : Number = originalString.indexOf( findToken, 0 );
				originalString = originalString.substr( 0, foundIndex ) + replaceWithToken + originalString.substring( foundIndex + findToken.length, originalString.length );
				lastFoundIndex = foundIndex + replaceWithToken.length;
			}	
			
			return originalString;
		}

		/**
		 * Returns the reverse of a string
		 */
		public static function reverse(input : String) : String
		{
			var rev : Array = new Array( );
		
			for(var i : Number = 0; i < input.length ; i++)
			{
				rev.push( input.charAt( i ) );
			}
			rev.reverse( );
			
			return rev.join( "" );
		}

		/**
		 * Counts the number of occurances of a char in a string
		 */
		public static function charCount(s : String, char : String) : Number
		{
			var count : Number = 0;
			for (var i : Number = 0; i < s.length ; i++)
			{
				if (s.charAt( i ) == char)
				{
					count++;
				}
			}
			
			return count;
		}

		public static function trim(s : String) : String
		{
			return s.replace( RegExp( /\A\s+/ ), "" ).replace( RegExp( /\s+\Z/ ), "" );
		}
	}
}
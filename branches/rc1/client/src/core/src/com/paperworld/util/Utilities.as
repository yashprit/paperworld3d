package com.paperworld.util
{

	/**
	 * Various utility methods kept here for convenience. 
	 * 
	 * @author Trevor Burton [trevor@infrared5.com]
	 */
	public class Utilities 
	{
		/**
		 * Is the supplied object defined?
		 */
		public static function isDefined(v : *) : Boolean
		{
			return v != null && v != undefined;
		}

		/**
		 * Test whether the supplied value is an even number.
		 */
		public static function isEvenNumber(n : Number) : Boolean
		{
			return 0 == (n % 2);
		}	

		/**
		 * Test whether the supplied value is an odd number.
		 */
		public static function isOddNumber(n : Number) : Boolean
		{
			return 1 == (n % 2);
		}

		/**
		 * Mask the number field data so it is of constant length.
		 */
		public static function maskNumberData(numberData : Number, maskLength : Number, maskValue : String) : String
		{
			var remaining : Number = maskLength - numberData.toString( ).length;
			
			if (remaining > 0)
			{
				var mask : String = "";
				
				for (var i : Number = 0; i < remaining ; i++)
				{
					mask += maskValue;
				}
				
				return (mask + numberData);
			}
	
			return numberData.toString( );
		}	

		/**
		 * Time stamp.
		 */
		public static function getTimeStamp() : String
		{
			// Construct a new date object.
			var currentDate : Date = new Date( );
			
			/// Get and mask individual fields.
			var hours : String = maskNumberData( currentDate.getHours( ), 2, "0" );
			var minutes : String = maskNumberData( currentDate.getMinutes( ), 2, "0" );
			var seconds : String = maskNumberData( currentDate.getSeconds( ), 2, "0" );
			var milliseconds : String = maskNumberData( currentDate.getMilliseconds( ), 3, "0" );
			
			// Return the masked data.
			return hours + ":" + minutes + ":" + seconds + ":" + milliseconds;
		}	
	}	
}

package com.paperworld.util.string 
{

	/**
	 * @author Trevor
	 */
	public class StringUtils 
	{
		public static function getFileEnding(file : String) : String
		{
			return file.substr( file.lastIndexOf( "." ), file.length );	
		}

		public static function splitFilePath(path : String) : Array
		{
			return path.split( "/" );
		}

		public static function getFileNameFromPath(path : String) : String
		{
			var splitPath : Array = splitFilePath( path );
			
			return splitPath[ splitPath.length - 1 ] as String;	
		}
	}
}

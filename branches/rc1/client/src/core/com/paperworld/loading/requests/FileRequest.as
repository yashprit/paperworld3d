package com.paperworld.loading.requests 
{
	import com.paperworld.core.EventDispatchingBaseClass;
	import com.paperworld.loading.FileTypes;
	import com.paperworld.loading.loaders.FileLoader;	

	/**
	 * @author Trevor
	 */
	public class FileRequest extends EventDispatchingBaseClass 
	{
		protected var _loader : FileLoader;

		public var url : String;

		public function FileRequest(url : String, type : String)
		{
			super( this );
			
			this.url = url;
			
			_loader = FileTypes.getLoader( type );
		}

		public function load() : void
		{
			
		}

		public function getBytesLoaded() : Number
		{
			return _loader.getBytesLoaded( );	
		}

		public function getBytesTotal() : Number
		{
			return _loader.getBytesTotal( );	
		}

		public function getData() : *
		{
			return _loader.getData( );
		}
	}
}

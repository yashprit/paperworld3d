package com.paperworld.flash.core.persistence
{
	import com.joeberkovitz.moccasin.model.ModelRoot;
	import com.joeberkovitz.moccasin.persistence.IDocumentDecoder;
	import com.paperworld.flash.core.model.Space;

	public class GameDocumentDecoder implements IDocumentDecoder
	{
		public function decodeDocument(data:*):ModelRoot
		{
			return new ModelRoot(new Space());
		}
		
	}
}
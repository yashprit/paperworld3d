package com.paperworld.games.objects 
{
	import com.paperworld.rpc.objects.Proxy;	
	
	import flash.display.BitmapData;
	
	import org.papervision3d.materials.BitmapMaterial;
	import org.papervision3d.materials.utils.MaterialsList;
	import org.papervision3d.objects.DisplayObject3D;
	
	import com.paperworld.PaperWorld;
	import com.paperworld.games.behaviours.SpacecraftBehaviour;
	import com.paperworld.managers.LibraryManager;
	import com.paperworld.rpc.models.ModelFactory;
	import com.paperworld.rpc.objects.RemoteObject;
	import com.paperworld.rpc.objects.Vehicle;	

	/**
	 * @author Trevor
	 */
	public class StarFighter extends Vehicle 
	{
		public function StarFighter() 
		{
			super( );
		}

		override protected function initialise() : void
		{
			logger.info( "INITIALISING STARFIGHTER" );
			
			behaviour = new SpacecraftBehaviour( );
			
			var skinAsset : BitmapData = LibraryManager.getInstance( ).getBitmapData( PaperWorld.getInstance( ).currentModule, "starfighter" );
			var shipMaterial : BitmapMaterial = new BitmapMaterial( skinAsset );
			
			var materialsList : MaterialsList = new MaterialsList( );
			materialsList.addMaterial( shipMaterial, "shipMaterial" );

			var model : DisplayObject3D = ModelFactory.getModel( "starfighter", materialsList, 0.01 );
			avatar = new RemoteObject( model );
			
			//var proxyModel : DisplayObject3D = ModelFactory.getModel( "starfighter", null, 0.01);
			//proxy = new Proxy( proxyModel );

			addChild( model );
			//addChild( proxyModel );
			
			super.initialise( );
		}
	}
}

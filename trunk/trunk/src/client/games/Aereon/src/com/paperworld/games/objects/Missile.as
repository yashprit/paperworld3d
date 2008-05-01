package com.paperworld.games.objects 
{
	import flash.display.MovieClip;	
	
	import org.papervision3d.materials.MovieMaterial;	
	import org.papervision3d.objects.primitives.Plane;	
	import org.papervision3d.materials.BitmapMaterial;
	import org.papervision3d.materials.utils.MaterialsList;
	import org.papervision3d.objects.DisplayObject3D;

	import com.paperworld.PaperWorld;
	import com.paperworld.framework.module.AbstractModule;
	import com.paperworld.games.behaviours.MissileBehaviour;
	import com.paperworld.managers.LibraryManager;
	import com.paperworld.rpc.models.ModelFactory;
	import com.paperworld.rpc.objects.RemoteObject;
	import com.paperworld.rpc.objects.Vehicle;		
	/**
	 * @author Trevor
	 */
	public class Missile extends Vehicle 
	{
		public function Missile()
		{
			super( );
		}

		override protected function initialise() : void 
		{
			behaviour = new MissileBehaviour( );
			
			var matsList : MaterialsList = new MaterialsList( );
            
			var libraryManager : LibraryManager = LibraryManager.getInstance( );
			var module : AbstractModule = PaperWorld.getInstance( ).currentModule;
            
			/*var coneMaterial : BitmapMaterial = new BitmapMaterial( libraryManager.getBitmapData( module, "ConeMaterial" ) );
			matsList.addMaterial( coneMaterial, "coneMaterial" ); 
            
			var bodyMaterial : BitmapMaterial = new BitmapMaterial( libraryManager.getBitmapData( module, "BodyMaterial" ) );
			matsList.addMaterial( bodyMaterial, "bodyMaterial" );
            
			var engineMaterial : BitmapMaterial = new BitmapMaterial( libraryManager.getBitmapData( module, "EngineMaterial" ) );
			matsList.addMaterial( engineMaterial, "engineMaterial" );
            
			var finMaterial : BitmapMaterial = new BitmapMaterial( libraryManager.getBitmapData( module, "FinMaterial" ) );
			matsList.addMaterial( finMaterial, "finMaterial" );
            
			var flareMaterial : BitmapMaterial = new BitmapMaterial( libraryManager.getBitmapData( module, "FlareMaterial" ) );
			matsList.addMaterial( flareMaterial, "flareMaterial" );
            
			var ringMaterial : BitmapMaterial = new BitmapMaterial( libraryManager.getBitmapData( module, "RingMaterial" ) );        
			matsList.addMaterial( ringMaterial, "ringMaterial" );
			
			var model : DisplayObject3D = ModelFactory.getModel( "missile", matsList, 0.01 );
			pitch(90);*/
			
			var graphic : MovieClip = libraryManager.getMovieClip( PaperWorld.getInstance().module, "GreenMissile");
			var material : MovieMaterial = new MovieMaterial(graphic, true);
			var model : Plane = new Plane(material, 100, 100, 2, 2);
			
			avatar = new RemoteObject( model );

			addChild( model );
			
			super.initialise( );
            
			//var coneMaterial:BitmapFileMaterial = new BitmapFileMaterial("textures/coneMaterial.png"); 
			//var bodyMaterial:BitmapFileMaterial = new BitmapFileMaterial("textures/bodyMaterial.png");
			// var engineMaterial:BitmapFileMaterial = new BitmapFileMaterial("textures/engineMaterial.png"); 
			//var finMaterial:BitmapFileMaterial = new BitmapFileMaterial("textures/finMaterial.png");
			//var flareMaterial:BitmapFileMaterial = new BitmapFileMaterial("textures/flareMaterial.png"); 
			//flareMaterial.oneSide = false;
			//var ringMaterial:BitmapFileMaterial = new BitmapFileMaterial("textures/ringMaterial.png");

			//matsList.addMaterial( bodyMaterial, "bodyMaterial" );
			//matsList.addMaterial( engineMaterial, "engineMaterial" );
			//matsList.addMaterial( finMaterial, "finMaterial" ); 
			//matsList.addMaterial( flareMaterial, "flareMaterial" );
			//matsList.addMaterial( ringMaterial, "ringMaterial" );
		}
	}
}

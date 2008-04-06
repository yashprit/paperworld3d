/*
 * --------------------------------------------------------------------------------------
 * PaperWorld3D - building better worlds
 * --------------------------------------------------------------------------------------
 * Realtime 3D Multi-User Application Framework for the Flash Platform.
 * --------------------------------------------------------------------------------------
 * Copyright (C) 2008 Trevor Burton [worldofpaper@googlemail.com]
 * --------------------------------------------------------------------------------------
 * 
 * This library is free software; you can redistribute it and/or modify it under the 
 * terms of the GNU Lesser General Public License as published by the Free Software 
 * Foundation; either version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT ANY 
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A 
 * PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License along with 
 * this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, 
 * Suite 330, Boston, MA 02111-1307 USA 
 * 
 * --------------------------------------------------------------------------------------
 */
package com.paperworld.rpc.models.factories
{
	import org.papervision3d.materials.utils.MaterialsList;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.parsers.DAE;
	
	import com.blitzagency.xray.logger.XrayLog;
	import com.paperworld.managers.ModelManager;
	import com.paperworld.rpc.models.ModelFactory;	

	public class DAEModelFactory extends ModelFactory
	{
		private var $logger : XrayLog = new XrayLog( );

		private static var $instance : DAEModelFactory;

		public function DAEModelFactory()
		{
			super( );
		}

		public static function getInstance() : ModelFactory
		{
			if ($instance == null)
			{
				$instance = new DAEModelFactory( );
			}
			
			return $instance;
		}

		override public function returnModel( key : String, materials : MaterialsList = null, scale : Number = 1.0 ) : DisplayObject3D
		{
			var model : DAE = new DAE( );		
			model.scale = scale;	
			model.load( ModelManager.getInstance( ).getModel( key, "DAE" ), materials );
			model.scale = scale;
			return model;
		}
	}
}
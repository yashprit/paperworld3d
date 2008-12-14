/* --------------------------------------------------------------------------------------
 * PaperWorld3D - building better worlds
 * --------------------------------------------------------------------------------------
 * Real-Time Multi-User Application Framework for the Flash Platform.
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
 * -------------------------------------------------------------------------------------- */
package com.paperworld.pv3d.scenes 
{
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.scenes.Scene3D;
	
	import com.paperworld.flash.connectors.IConnector;
	import com.paperworld.flash.scenes.AbstractSynchronisedScene;
	import com.paperworld.pv3d.objects.SynchronisableObject;	

	/**
	 * @author Trevor Burton [worldofpaper@googlemail.com]
	 */
	public class SynchronisedScene extends AbstractSynchronisedScene 
	{
		public function SynchronisedScene(connector : IConnector = null)
		{
			super( );
		}

		override public function initialise() : void
		{
			super.initialise( );
			
			_scene = new Scene3D( );	
		}

		override public function addChild(child : *) : *
		{
			if (child is DisplayObject3D)
			{
				return scene.addChild( child );	
			}
			else if (child is SynchronisableObject)
			{
				return scene.addChild( SynchronisableObject( child ).object );
			}
			else
			{
				// error - not a valid type.
			}
			
			return null;	
		}

		override public function removeChild(child : *) : *
		{
			return scene.removeChild( child );
		}
		
		public function get scene() : Scene3D
		{
			return Scene3D( _scene );
		}
	}
}

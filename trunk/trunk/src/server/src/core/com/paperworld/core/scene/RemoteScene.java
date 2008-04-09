/*
 * --------------------------------------------------------------------------------------
 * PaperWorld3D - building better worlds
 * --------------------------------------------------------------------------------------
 * Realtime 3D Multi-User Application Framework for the Flash Platform.
 * --------------------------------------------------------------------------------------
 * Copyright (C) 2008 Influxis [http://www.influxis.com]
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
package com.paperworld.core.scene;

import java.util.ArrayList;

import org.red5.server.api.IScope;
import org.red5.server.api.ScopeUtils;
import org.red5.server.api.so.ISharedObject;
import org.red5.server.api.so.ISharedObjectService;

import com.paperworld.core.Application;
import com.paperworld.core.room.Room;
import com.paperworld.objects.AbstractPaperworldObject;

public class RemoteScene extends AbstractPaperworldObject
{		
	private Room room;
	
	public ISharedObject so;
	
	private IScope scope;
	
	public ArrayList<AbstractPaperworldObject> objects;
	
	public RemoteScene(IScope scope, Room room, Integer uid)
	{
		super();
		
		this.room = room;
		this.uid = uid.toString();
		this.scope = scope;
		
		objects = new ArrayList<AbstractPaperworldObject>();
	}
	
	private ISharedObject getSharedObject(IScope scope, String name) {
		ISharedObjectService service = (ISharedObjectService) ScopeUtils
				.getScopeService(scope,
						ISharedObjectService.class,
						false);
		return service.getSharedObject(scope, name, false);
	}
	
	private void createSharedObject()
	{
		so = getSharedObject(scope, "Room" + room.id + "Scene" + uid);
	}
	
	@Override
	public AbstractPaperworldObject addChild(AbstractPaperworldObject child)
	{	
		if (objects.size() == 0)
		{
			createSharedObject();
		}
		
		objects.add(child);
		
		child.scene = this;
		
		so.setAttribute(child.uid, child.getAvatarData());
		
		return child;
	}
	
	@Override
	public AbstractPaperworldObject removeChild(AbstractPaperworldObject child)
	{
		objects.remove(child);
		
		child.scene = null;
		
		so.removeAttribute(child.uid);
		
		if (objects.size() < 1)
		{
			so.close();
		}
		
		return child;
	}
	/*
	@Override
	@SuppressWarnings ("unchecked")
	public void update()
	{
		if (objects.size() > 0)
		{
			ArrayList<AbstractPaperworldObject> temp = (ArrayList<AbstractPaperworldObject>) objects.clone();
			
			for (AbstractPaperworldObject child : temp)
			{ 
			    child.update();
			}
		}
	}
	
	@SuppressWarnings ("unchecked")
	public void broadcastUpdates()
	{
		if (objects.size() > 0)
		{
			ArrayList<AbstractPaperworldObject> temp = (ArrayList<AbstractPaperworldObject>) objects.clone();
			
			so.beginUpdate();
			
			for (AbstractPaperworldObject child : temp)
			{ 
			    so.setAttribute(child.uid, child.getAvatarData());
			}
			
			so.endUpdate();
		}
	}*/
}

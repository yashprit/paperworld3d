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
package com.paperworld.objects;

import java.util.ArrayList;

import org.red5.server.api.so.ISharedObject;

import com.paperworld.core.Application;
import com.paperworld.core.avatar.AvatarData;
import com.paperworld.core.avatar.AvatarInput;
import com.paperworld.core.avatar.AvatarState;
import com.paperworld.core.scene.RemoteScene;
import com.paperworld.core.util.DisplayObject3D;

public abstract class AbstractPaperworldObject extends DisplayObject3D
{	
	public String uid;	
	
	public AvatarInput input = new AvatarInput();
	
	public AvatarState state = new AvatarState();
	
	public String modelKey = "com.paperworld.demo.objects.StarFighter";
	
	public ISharedObject so;
	
	public AbstractPaperworldObject parent;
	
	public ArrayList<AbstractPaperworldObject> children;
	
	public RemoteScene scene;
	
	public int time;
	
	public AbstractPaperworldObject()
	{
		super();
		
		children = new ArrayList<AbstractPaperworldObject>();
	}
	
	public AvatarData getAvatarData()
	{
		AvatarData avatarData = new AvatarData(uid, time, modelKey, state, input);
		
		return avatarData;
	}
	
	public AbstractPaperworldObject addChild(AbstractPaperworldObject child)
	{
		Application.log.debug("creating shared object Room {}", so );
		Application.log.debug("adding Child {}", child.uid);
		//child.uid = uid + "_" + children.size();
		children.add(child);

		//child.parent = this;
		
		child.so = so;
		
		//Application.log.debug("adding {} to RemoteScene", child.uid);
		//Application.log.debug("adding details to {}", so);
		//so.setAttribute(child.uid, new Object[]{child.uid, child.modelKey});
		
		return child;
	}
	
	public AbstractPaperworldObject removeChild(AbstractPaperworldObject child)
	{
		Application.log.debug("removing child {} from {}", new Object[]{child.uid, uid});
		
		children.remove(child);
		so.removeAttribute(child.uid);
		
		return child;
	}
	
	public ArrayList<AbstractPaperworldObject> getChildren()
	{
		return children;
	}
	
	public AbstractPaperworldObject getChildAtIndex(int index){
		return getChildren().get(index);
	}
	
	public AbstractPaperworldObject getParent()
	{
		return parent;
	}
	
	public void update()
	{
		for (AbstractPaperworldObject object : children)
		{
			object.update();
		}
	}
}

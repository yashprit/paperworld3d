package com.paperworld.core.events;

import com.paperworld.core.PaperworldService;

public interface IPaperworldEventListener {

	public void updateEvent(PaperworldService service);
	
	public void broadcastEvent(PaperworldService service);
}

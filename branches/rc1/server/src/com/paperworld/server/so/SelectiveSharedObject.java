package com.paperworld.server.so;

import java.util.concurrent.ConcurrentLinkedQueue;

import org.red5.server.api.event.IEventListener;
import org.red5.server.net.rtmp.Channel;
import org.red5.server.net.rtmp.RTMPConnection;
import org.red5.server.so.ISharedObjectEvent;
import org.red5.server.so.SharedObject;
import org.red5.server.so.SharedObjectMessage;

public class SelectiveSharedObject extends SharedObject {

	/**
     * Send update notification over data channel of RTMP connection
     */
	@Override
    protected void sendUpdates() {
    	//get the current version
    	int currentVersion = version.get();
    	//
    	boolean persist = isPersistentObject();
    	//get read-only version of events
    	ConcurrentLinkedQueue<ISharedObjectEvent> events = new ConcurrentLinkedQueue<ISharedObjectEvent>(ownerMessage.getEvents());   	
    	//clear out previous events
    	ownerMessage.getEvents().clear();
    	//
		if (!events.isEmpty()) {
			// Send update to "owner" of this update request
			SharedObjectMessage syncOwner = new SharedObjectMessage(null, name,	currentVersion, persist);
			syncOwner.addEvents(events);
			if (source != null) {
				// Only send updates when issued through RTMP request
				Channel channel = ((RTMPConnection) source).getChannel((byte) 3);
				if (channel != null) {
					//ownerMessage.acquire();
					channel.write(syncOwner);
					log.debug("Owner: {}", channel);
				} else {
					log.warn("No channel found for owner changes!?");
				}
			}
		}
		//clear owner events
		events.clear();		
		//get read-only version of sync events
		events.addAll(syncEvents);   	
    	//clear out previous events
		syncEvents.clear();
		if (!events.isEmpty()) {
			// Synchronize updates with all registered clients of this shared
			for (IEventListener listener : listeners) {
				if (listener == source) {
					// Don't re-send update to active client
					log.debug("Skipped {}", source);
					continue;
				}
				if (!(listener instanceof RTMPConnection)) {
					log.warn("Can't send sync message to unknown connection {}", listener);
					continue;
				}
				// Create a new sync message for every client to avoid
				// concurrent access through multiple threads
				// TODO: perhaps we could cache the generated message
				SharedObjectMessage syncMessage = new SharedObjectMessage(null,	name, currentVersion, persist);
				syncMessage.addEvents(events);

				Channel channel = ((RTMPConnection) listener).getChannel((byte) 3);
				log.debug("Send to {}", channel);
				channel.write(syncMessage);
			}

		}
	}
}

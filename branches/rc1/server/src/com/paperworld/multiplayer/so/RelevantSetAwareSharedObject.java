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
package com.paperworld.multiplayer.so;

import org.red5.server.api.event.IEventListener;
import org.red5.server.net.rtmp.Channel;
import org.red5.server.net.rtmp.RTMPConnection;
import org.red5.server.so.SharedObject;
import org.red5.server.so.SharedObjectMessage;

public class RelevantSetAwareSharedObject extends SharedObject {

	@Override
	protected void sendUpdates() {
		if (!ownerMessage.getEvents().isEmpty()) {
			// Send update to "owner" of this update request
			SharedObjectMessage syncOwner = new SharedObjectMessage(null, name,
					version, isPersistentObject());
			syncOwner.addEvents(ownerMessage.getEvents());

			if (source != null) {
				// Only send updates when issued through RTMP request
				Channel channel = ((RTMPConnection) source)
						.getChannel((byte) 3);

				if (channel != null) {
					// ownerMessage.acquire();

					channel.write(syncOwner);
					log.debug("Owner: " + channel);
				} else {
					log.warn("No channel found for owner changes!?");
				}
			}
			ownerMessage.getEvents().clear();
		}

		if (!syncEvents.isEmpty()) {
			// Synchronize updates with all registered clients of this shared

			for (IEventListener listener : listeners) {

				if (listener == source) {
					// Don't re-send update to active client
					log.debug("Skipped " + source);
					continue;
				}

				if (!(listener instanceof RTMPConnection)) {
					log.warn("Can't send sync message to unknown connection "
							+ listener);
					continue;
				}

				// Create a new sync message for every client to avoid
				// concurrent access through multiple threads
				// TODO: perhaps we could cache the generated message
				SharedObjectMessage syncMessage = new SharedObjectMessage(null,
						name, version, isPersistentObject());
				syncMessage.addEvents(syncEvents);

				Channel c = ((RTMPConnection) listener).getChannel((byte) 3);
				log.debug("Send to " + c);
				c.write(syncMessage);
			}
			// Clear list of sync events
			syncEvents.clear();
		}
	}
}

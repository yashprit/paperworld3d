package com.paperworld.server.api;


public interface INetEvent {

	public void notifyPosted();

	public void notifySent();

	public void notifyReceived();
	
	public void setEventDirection(EventDirection eventDirection);
	
	public EventDirection getEventDirection();
	
	public void setGuaranteeType(GuaranteeType guaranteeType);
	
	public GuaranteeType getGuaranteeType();

	public enum EventDirection {
		DirUnset, // /< Default value - NetConnection will Assert if an event is
					// posted without a valid direction set.
		DirAny, // /< This event can be sent from the server or the client
		DirServerToClient, // /< This event can only be sent from the server to
							// the client
		DirClientToServer, // /< This event can only be sent from the client to
							// the server
	}

	public enum GuaranteeType {
		GuaranteedOrdered, // /< Event delivery is guaranteed and will be
							// processed in the order it
		// / was sent relative to other ordered events.
		Guaranteed, // /< Event delivery is guaranteed and will be processed in
					// the order it
		// / was received.
		Unguaranteed
		// /< Event delivery is not guaranteed - however, the event will remain
		// / ordered relative to other unguaranteed events.
	}
}

package com.paperworld.server.api.base;

import com.paperworld.server.api.INetEvent.EventDirection;
import com.paperworld.server.api.INetEvent.GuaranteeType;
import com.paperworld.server.flash.Packet;


public class BaseNetEvent extends Packet {

	protected EventDirection eventDirection;

	protected GuaranteeType guaranteeType;

	public BaseNetEvent() {
		eventDirection = EventDirection.DirUnset;
		guaranteeType = GuaranteeType.GuaranteedOrdered;
	}

	public BaseNetEvent(EventDirection eventDirection, GuaranteeType guaranteeType) {
		this.eventDirection = eventDirection;
		this.guaranteeType = guaranteeType;
	}

	public void notifyPosted() {

	}

	public void notifySent() {

	}

	public void notifyReceived() {

	}
	
	public void setEventDirection(EventDirection eventDirection) {
		this.eventDirection = eventDirection;
	}
	
	public EventDirection getEventDirection() {
		return eventDirection;
	}
	
	public void setGuaranteeType(GuaranteeType guaranteeType) {
		this.guaranteeType = guaranteeType;
	}
	
	public GuaranteeType getGuaranteeType() {
		return guaranteeType;
	}
}

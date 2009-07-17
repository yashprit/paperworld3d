package com.paperworld.java.multiplayer.messages.processors;

import com.paperworld.java.api.IPaperworldService;
import com.paperworld.java.api.message.IServerSyncMessage;

public class ServerSyncMessageProcessor extends BaseMessageProcessor {

	public ServerSyncMessageProcessor(IPaperworldService messageService) {
		super(messageService, IServerSyncMessage.class);
	}
}

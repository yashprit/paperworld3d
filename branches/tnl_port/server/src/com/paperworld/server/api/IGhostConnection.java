package com.paperworld.server.api;



public interface IGhostConnection {
	
	public void objectInScope(IGhostObject ghost);
	
	public void ghostPushNonZero(IGhostObject ghost);
	
	public void ghostPushToZero(IGhostObject ghost);
	
	public void setGhosting(boolean ghosting);
}

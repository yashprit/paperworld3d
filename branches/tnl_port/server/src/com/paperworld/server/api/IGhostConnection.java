package com.paperworld.server.api;

import com.paperworld.server.flash.NetObject;

public interface IGhostConnection {
	
	public void objectInScope(NetObject object);
	
	public class GhostConstants {
		
		public static final byte InScope 			= 1 << 0;		
		public static final byte ScopeLocalAlways 	= 1 << 1;		
		public static final byte NotYetGhosted 		= 1 << 2;		
		public static final byte Ghosting 			= 1 << 3;		
		public static final byte KillGhost 			= 1 << 4;		
		public static final byte KillingGhost 		= 1 << 5;		
		public static final byte NotAvailable 		= NotYetGhosted | Ghosting | KillGhost | KillingGhost;

	}
}

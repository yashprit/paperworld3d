package com.paperworld.multiplayer;

import org.red5.server.adapter.IApplication;
import org.red5.server.api.IClient;
import org.red5.server.api.IConnection;
import org.red5.server.api.IScope;

public class MultiplayerService implements IApplication {

	@Override
	public boolean appConnect(IConnection arg0, Object[] arg1) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void appDisconnect(IConnection arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public boolean appJoin(IClient arg0, IScope arg1) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void appLeave(IClient arg0, IScope arg1) {
		// TODO Auto-generated method stub

	}

	@Override
	public boolean appStart(IScope arg0) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void appStop(IScope arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public boolean roomConnect(IConnection arg0, Object[] arg1) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void roomDisconnect(IConnection arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public boolean roomJoin(IClient arg0, IScope arg1) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void roomLeave(IClient arg0, IScope arg1) {
		// TODO Auto-generated method stub

	}

	@Override
	public boolean roomStart(IScope arg0) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void roomStop(IScope arg0) {
		// TODO Auto-generated method stub

	}

}

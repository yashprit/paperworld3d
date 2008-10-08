package com.paperworld.multiplayer.connectors;

import java.util.HashMap;

import org.red5.server.adapter.IApplication;
import org.red5.server.adapter.MultiThreadedApplicationAdapter;
import org.red5.server.api.IClient;
import org.red5.server.api.IConnection;
import org.red5.server.api.IScope;

import com.paperworld.multiplayer.player.Player;

public class AbstractConnector implements IApplication, IService {

	protected HashMap<String, Player> players;

	protected IScope scope;

	protected MultiThreadedApplicationAdapter application;

	public AbstractConnector() {
		players = new HashMap<String, Player>();
	}

	public void setApplication(MultiThreadedApplicationAdapter application) {
		this.application = application;
		application.addListener(this);
	}

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

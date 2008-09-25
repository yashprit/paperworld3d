package com.paperworld.multiplayer;

import org.red5.server.adapter.IApplication;
import org.red5.server.adapter.MultiThreadedApplicationAdapter;
import org.red5.server.api.IClient;
import org.red5.server.api.IConnection;
import org.red5.server.api.IScope;

import com.paperworld.core.math.Vector3;


public class MultiplayerService implements IApplication {

	protected MultiThreadedApplicationAdapter application;
	
	public MultiplayerService()
	{
		System.out.println("MultiplayerService starting");
	}
	
	public void setApplication(MultiThreadedApplicationAdapter application)
	{
		this.application = application;
	}
	
	public boolean appConnect(IConnection arg0, Object[] arg1) {
		// TODO Auto-generated method stub
		return false;
	}

	public void appDisconnect(IConnection arg0) {
		// TODO Auto-generated method stub

	}

	public boolean appJoin(IClient arg0, IScope arg1) {
		// TODO Auto-generated method stub
		return false;
	}

	public void appLeave(IClient arg0, IScope arg1) {
		// TODO Auto-generated method stub

	}

	public boolean appStart(IScope arg0) {
		// TODO Auto-generated method stub
		return false;
	}

	public void appStop(IScope arg0) {
		// TODO Auto-generated method stub

	}

	public boolean roomConnect(IConnection arg0, Object[] arg1) {
		// TODO Auto-generated method stub
		return false;
	}

	public void roomDisconnect(IConnection arg0) {
		// TODO Auto-generated method stub

	}

	public boolean roomJoin(IClient arg0, IScope arg1) {
		// TODO Auto-generated method stub
		return false;
	}

	public void roomLeave(IClient arg0, IScope arg1) {
		// TODO Auto-generated method stub

	}

	public boolean roomStart(IScope arg0) {
		// TODO Auto-generated method stub
		return false;
	}

	public void roomStop(IScope arg0) {
		// TODO Auto-generated method stub

	}

}

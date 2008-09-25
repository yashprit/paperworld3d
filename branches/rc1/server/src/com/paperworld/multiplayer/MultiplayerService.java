package com.paperworld.multiplayer;

import java.util.HashMap;

import org.red5.server.adapter.IApplication;
import org.red5.server.adapter.MultiThreadedApplicationAdapter;
import org.red5.server.api.IClient;
import org.red5.server.api.IConnection;
import org.red5.server.api.IScope;
import org.red5.server.api.scheduling.IScheduledJob;
import org.red5.server.api.scheduling.ISchedulingService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.paperworld.ai.steering.Kinematic;
import com.paperworld.multiplayer.data.Input;

public class MultiplayerService implements IApplication, IScheduledJob {

	/**
	 * Logger
	 */
	//protected static Logger log = LoggerFactory.getLogger(MultiplayerService.class);
	
	protected HashMap<String, Kinematic> players;

	protected MultiThreadedApplicationAdapter application;

	protected int time = 0;

	// protected ISchedulingService schedulingService = new
	// QuartzSchedulingService();

	public MultiplayerService() {
		System.out.println("MultiplayerService");

		players = new HashMap<String, Kinematic>();

		// schedulingService.addScheduledJob(1000, this);
	}

	public void receiveInput(String uid, int time, Input input) {
		System.out.println("receiving " + input + " from " + uid);

		Kinematic kinematic = players.get(uid);
		kinematic.update(time, input);
	}

	public void setApplication(MultiThreadedApplicationAdapter application) {
		this.application = application;
		application.addListener(this);
	}

	public boolean appConnect(IConnection connection, Object[] params) {
		players.put(connection.getClient().getId(), new Kinematic());
		
		return true;
	}

	public void appDisconnect(IConnection arg0) {
		System.out.println("appDisconnect");

	}

	public boolean appJoin(IClient client, IScope params) {
		System.out.println("appJoin");

		return false;
	}

	public void appLeave(IClient arg0, IScope arg1) {
		System.out.println("appLeave");

	}

	public boolean appStart(IScope arg0) {
		System.out.println("appStart");
		return false;
	}

	public void appStop(IScope arg0) {
		System.out.println("appStop");

	}

	public boolean roomConnect(IConnection arg0, Object[] arg1) {
		System.out.println("roomConnect");
		return false;
	}

	public void roomDisconnect(IConnection arg0) {
		System.out.println("roomDisconnect");

	}

	public boolean roomJoin(IClient arg0, IScope arg1) {
		System.out.println("roomJoin");
		return false;
	}

	public void roomLeave(IClient arg0, IScope arg1) {
		System.out.println("roomLeave");

	}

	public boolean roomStart(IScope arg0) {
		System.out.println("roomStart");
		return false;
	}

	public void roomStop(IScope arg0) {
		System.out.println("roomStop");

	}

	public void execute(ISchedulingService arg0)
			throws CloneNotSupportedException {

		time++;
	}

}

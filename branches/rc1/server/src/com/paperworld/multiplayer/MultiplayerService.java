package com.paperworld.multiplayer;

import java.util.HashMap;

import org.red5.server.adapter.IApplication;
import org.red5.server.adapter.MultiThreadedApplicationAdapter;
import org.red5.server.api.IClient;
import org.red5.server.api.IConnection;
import org.red5.server.api.IScope;
import org.red5.server.api.ScopeUtils;
import org.red5.server.api.scheduling.IScheduledJob;
import org.red5.server.api.scheduling.ISchedulingService;
import org.red5.server.api.so.ISharedObject;
import org.red5.server.api.so.ISharedObjectService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.paperworld.ai.steering.Kinematic;
import com.paperworld.multiplayer.data.Input;
import com.paperworld.multiplayer.objects.Avatar;

public class MultiplayerService implements IApplication, IScheduledJob {

	/**
	 * Logger
	 */
	protected static Logger log = LoggerFactory.getLogger(MultiplayerService.class);
	
	protected HashMap<String, Player> players;

	protected MultiThreadedApplicationAdapter application;

	protected int time = 0;

	protected ISharedObject sharedObject;
	
	protected IScope scope;

	protected ISchedulingService schedulingService;// = new QuartzSchedulingService();

	public MultiplayerService() {
		System.out.println("MultiplayerService");

		players = new HashMap<String, Player>();

		// schedulingService.addScheduledJob(1000, this);
	}

	protected ISharedObject getSharedObject(IScope scope, String name, boolean persistent) {
		ISharedObjectService service = (ISharedObjectService) ScopeUtils
				.getScopeService(scope, ISharedObjectService.class, false);
		return service.getSharedObject(scope, name, persistent);
	}
	
	public int receiveInput(String uid, int time, Input input) {
		System.out.println("receiving " + input + " from " + uid);

		Player player = players.get(uid);
		Avatar avatar = player.getAvatar();
		avatar.update(time, input);

		return time;
	}

	public void setApplication(MultiThreadedApplicationAdapter application) {
		this.application = application;
		application.addListener(this);
		
		createScheduleService();
	}
	
	protected void createScheduleService()
	{
		//schedulingService = application.getContext().lookupService(arg0)
	}

	public boolean appConnect(IConnection connection, Object[] params) {
		String name = (String) params[0];
		
		log.debug("{} connecting", name);
		
		Player player = new Player(name, connection);
		Kinematic kinematic = new Kinematic();
		Avatar avatar = new Avatar(kinematic);	
		avatar.sharedObject = getSharedObject(connection.getScope(), "avatars", false);
		avatar.setKinematic(kinematic);
		
		player.setAvatar(avatar);
		
		players.put(connection.getClient().getId(), player);

		return true;
	}

	public void appDisconnect(IConnection arg0) {
		System.out.println("appDisconnect");

	}

	public boolean appJoin(IClient client, IScope scope) {
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

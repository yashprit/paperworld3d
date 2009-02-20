package com.paperworld.examples.hellopaperworld;

import org.red5.server.adapter.ApplicationAdapter;
import org.red5.server.api.scheduling.IScheduledJob;
import org.red5.server.api.scheduling.ISchedulingService;

import com.paperworld.server.api.INetInterface;
import com.paperworld.server.api.base.BaseSimulation;

public class GameSimulation extends BaseSimulation {

	private ApplicationAdapter application;

	private String timer;

	public GameSimulation(ApplicationAdapter application) {
		this.application = application;
	}

	public void start() {
		timer = application.addScheduledJob(500, new StepSimulationJob());
	}

	public void stop() {
		application.removeScheduledJob(timer);
	}

	public void step() {
		//processObjects();
		processConnections();
	}
	
	/*private void processObjects() {
		
	}*/
	
	private void processConnections() {
		for (String key : interfaces.keySet()) {
			interfaces.get(key).processConnections();
		}
	}

	public class StepSimulationJob implements IScheduledJob {

		public void execute(ISchedulingService service)
				throws CloneNotSupportedException {

			step();
		}

	}
}

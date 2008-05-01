package com.paperworld.ai.steering;

import java.util.List;

import com.paperworld.ai.core.steering.AbstractSteeringBehaviour;


public class BlendedSteering extends AbstractSteeringBehaviour {

	private List<WeightedBehaviour> behaviours;

	public BlendedSteering() {

	}

	public void run() {
		/*SteeringOutput steering = new SteeringOutput();

		for (WeightedBehaviour behaviour : behaviours) {
			SteeringOutput output = behaviour.getBehaviour().getSteering();
			output.scale(behaviour.getWeight());

			steering.add(output);
		}

		return steering;*/
	}

}

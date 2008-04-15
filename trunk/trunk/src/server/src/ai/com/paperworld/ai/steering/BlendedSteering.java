package com.paperworld.ai.steering;

import java.util.List;

public class BlendedSteering extends AbstractSteeringBehaviour {

	private List<WeightedBehaviour> behaviours;

	public BlendedSteering() {

	}

	@Override
	public void getSteering(SteeringOutput output) {

	}

	@Override
	public SteeringOutput getSteering() {
		SteeringOutput steering = new SteeringOutput();

		for (WeightedBehaviour behaviour : behaviours) {
			SteeringOutput output = behaviour.getBehaviour().getSteering();
			output.scale(behaviour.getWeight());

			steering.add(output);
		}

		return steering;
	}

}

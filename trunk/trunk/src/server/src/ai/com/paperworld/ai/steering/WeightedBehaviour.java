package com.paperworld.ai.steering;

import com.paperworld.ai.core.steering.AbstractSteeringBehaviour;


public class WeightedBehaviour {

	private AbstractSteeringBehaviour behaviour;

	private Double weight;

	public WeightedBehaviour() {

	}

	public AbstractSteeringBehaviour getBehaviour() {
		return behaviour;
	}

	public void setBehaviour(AbstractSteeringBehaviour b) {
		behaviour = b;
	}

	public Double getWeight() {
		return weight;
	}

	public void setWeight(Double w) {
		weight = w;
	}
}

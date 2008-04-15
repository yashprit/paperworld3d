package com.paperworld.ai.steering.steerpipe;

import com.paperworld.ai.steering.SteeringOutput;

/**
 * Actuators generate forcess and torques that are required to achieve the
 * current goal state from the current actor state. The default behaviour is to
 * generate forces to move towards the goal and align the orientation with the
 * goal kinematic, as well as adjust the target speed to match the goal
 * kinematic. The goal velocity direction is ignored.
 */
public class Actuator {
	/**
	 * Pointer to the SteerPipe class, where details about the actor and the
	 * goal are stored. This is set by the SteerPipe class when the actuator is
	 * added to it.
	 */
	protected SteerPipe steering;

	/**
	 * The steering output which the actuator updates.
	 */
	protected SteeringOutput steer;

	/**
	 * True if the steering output was created and should be destroyed by this
	 * instance.
	 */
	protected boolean localSteer;

	/**
	 * The maximum acceleration (as output in the steer member) that an agent is
	 * allowed to apply. Default is 1 distance unit per second per second. It
	 * assumes the agent has a mass of 1 unit.
	 */
	public Double maxAcceleration;

	/**
	 * The maximum speed the agent is allowed to do. The default value is 1;
	 */
	public Double maxSpeed;

	/**
	 * The maximum angular acceleration (as output in the steer member) that an
	 * agent is allowed to apply. Default is 1 radian per second per second. It
	 * assumes the agent has a moment of inertia of 1 unit.
	 */
	public Double maxAngular;

	/**
	 * The maximum rotation the agent is allowed to do. The default value is 1;
	 */
	public Double maxRotation;

	/**
	 * Controls how aggressive the steering is at turning. The higher this value
	 * the sharper the turning will be. Allowed range [0, oo). Default value 1.
	 */
	public Double angularSharpness;

	/**
	 * Controls how aggressive the steering is. The higher this value the
	 * sharper the transition between accelerating and braking. Allowed range
	 * [0, oo). Default value 1.
	 */
	public Double sharpness;

	/**
	 * Creates a new actuator.
	 * 
	 * @param steer
	 *            Pointer to a steer object. If this is NULL then a default
	 *            object will be created.
	 */
	public Actuator(SteeringOutput s) {
		localSteer = false;
		maxAcceleration = 1.0;
		maxSpeed = 1.0;
		maxAngular = 1.0;
		maxRotation = 1.0;
		angularSharpness = 1.0;
		sharpness = 1.0;

		setSteeringOutput(s);
	}

	/**
	 * Copy constructor.
	 */
	public Actuator(Actuator other) {
		steering = other.steering;
		steer = other.steer;
		localSteer = false; // Steering output created by other
		maxAcceleration = other.maxAcceleration;
		maxSpeed = other.maxSpeed;
		maxAngular = other.maxAngular;
		maxRotation = other.maxRotation;
		angularSharpness = other.angularSharpness;
		sharpness = other.sharpness;
	}

	public Actuator() {
		localSteer = false;
		maxAcceleration = 1.0;
		maxSpeed = 1.0;
		maxAngular = 1.0;
		maxRotation = 1.0;
		angularSharpness = 1.0;
		sharpness = 1.0;

		setSteeringOutput(null);
	}

	/**
	 * Sets the steer instance used to output steering actions to take. If the
	 * given steer is null or no steer is given, then a new local steer is used,
	 * otherwise the given steer is considered non-local.
	 */
	public void setSteeringOutput(SteeringOutput s) {
		if (s != null) {
			steer = s;
			localSteer = false;
		} else {
			steer = new SteeringOutput();
			localSteer = true;
		}
	}

	/**
	 * Gets the current steering output.
	 */
	public SteeringOutput getSteeringOutput() {
		return steer;
	}

	/**
	 * Returns the steering object owning this actuator.
	 */
	public SteerPipe getSteering() {
		return steering;
	}

	/**
	 * Sets the steer force and torque to the values required to achieve the
	 * current goal.
	 */
	public void run() {

	}
}

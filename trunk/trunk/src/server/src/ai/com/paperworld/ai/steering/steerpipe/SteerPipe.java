package com.paperworld.ai.steering.steerpipe;

import com.paperworld.core.avatar.Avatar;
import com.paperworld.core.util.math.Vector3D;

/**
 * The steering system, uses a targeter, an actuator and an optional set of
 * decomposers and constraints, to create steering outputs to guide an agent to
 * its goal. See the user guide for a detailed discussion of the steering
 * algorithm.
 */
public class SteerPipe {
	/**
	 * The targeter used to generate the top level goal.
	 */
	protected Targeter targeter;

	/**
	 * True if the targeter was created and should be destroyed by this
	 * instance.
	 */
	protected boolean localTargeter;

	/**
	 * The actor that is doing the steering.
	 */
	protected Avatar actor;

	/**
	 * True if the actor was created by the constructor and should be destroyed
	 * by this instance.
	 */
	protected boolean localActor;

	/**
	 * The actuator used for generating output
	 */
	protected Actuator actuator;

	/**
	 * True if the actuator was created by the constructor and should be
	 * destroyed by this instance.
	 */
	protected boolean localActuator;

	/**
	 * A list of decomposers.
	 */
	protected Decomposer decomposers;

	/**
	 * A list of constraints.
	 */
	protected SteeringConstraint constraints;

	/**
	 * The current speed.
	 * 
	 * The current speed, squared speed and orientation vector of the actor are
	 * recalculated at the beginning of each invocation of the run method, so
	 * that subcomponents do not need to perform the same calculations. If a
	 * subclass overrides the run method it must compute these values as well,
	 * as many standard constraints depend on them being up to date. The x and y
	 * components of the orientation vector are cosine and sine of the actor's
	 * orientation respectively; the z component is always zero.
	 */
	protected Double speed;

	/**
	 * The current speed squared.
	 * 
	 * The current speed, squared speed and orientation vector of the actor are
	 * recalculated at the beginning of each invocation of the run method, so
	 * that subcomponents do not need to perform the same calculations. If a
	 * subclass overrides the run method it must compute these values as well,
	 * as many standard constraints depend on them being up to date. The x and y
	 * components of the orientation vector are cosine and sine of the actor's
	 * orientation respectively; the z component is always zero.
	 */
	protected Double speed2;

	/**
	 * The current orientation vector.
	 * 
	 * The current speed, squared speed and orientation vector of the actor are
	 * recalculated at the beginning of each invocation of the run method, so
	 * that subcomponents do not need to perform the same calculations. If a
	 * subclass overrides the run method it must compute these values as well,
	 * as many standard constraints depend on them being up to date. The x and y
	 * components of the orientation vector are cosine and sine of the actor's
	 * orientation respectively; the z component is always zero.
	 */
	protected Vector3D orientation;

	/**
	 * Called when constraints could not be resolved after a number of passes
	 * through the list. The maximum number of passes is specified by the
	 * relaxationSteps member variable. If in the last pass at least one
	 * constraint still triggers then this method is called as a special measure
	 * to resolve the deadlock. The default action is to do nothing, but the
	 * client application may for instance invoke a planner here.
	 */
	protected void constraintDeadlock() {

	}

	/**
	 * The current goal or subgoal being sought.
	 */
	public Avatar currentGoal;

	/**
	 * The maximum number of passes through the constraint list. See the
	 * constraintDeadlock() method for more details. The default value is 1.
	 */
	public int relaxationSteps;

	/**
	 * Creates a new steering system. If no targeter is given then the default
	 * targeter will create its own target at the origin, which will never
	 * change.
	 * 
	 * @param targeter
	 *            Pointer to a Targeter object generating targets for this
	 *            steering object. If equal to NULL, a default Targeter is
	 *            created.
	 * 
	 * @param actor
	 *            Pointer to a Kinematic object describing the agent being
	 *            controlled. If equal to NULL, a default actor object is
	 *            created.
	 * 
	 * @param actuator
	 *            Pointer to an Actuator object which generates output forces.
	 *            If equal to NULL, a default inertial actuator is created.
	 */
	public SteerPipe(Targeter targeter, Avatar actor, Actuator actuator) {
		localTargeter = false;
		localActor = false;
		localActuator = false;
		relaxationSteps = 1;
		setActor(actor);
		setTargeter(targeter); // must be called after setActor()
		setActuator(actuator);
	}

	public SteerPipe() {

	}

	/**
	 * Creates a copy of the given steering system. This shares all data with
	 * the given steering, making targeter, actor and steer non-local.
	 */
	public SteerPipe(SteerPipe other) {
		targeter = other.targeter;
		localTargeter = false;
		actor = other.actor;
		localActor = false;
		actuator = other.actuator;
		localActuator = false;
		decomposers = other.decomposers;
		constraints = other.constraints;
		relaxationSteps = other.relaxationSteps;
	}

	/**
	 * Sets the actor to be the given kinematic. If the given kinematic is null
	 * or no kinematic is given, it creates a new, local, kinematic. If the
	 * given kinematic is non null, it is considered non-local.
	 */
	public void setActor(Avatar a) {
		if (localActor)
			actor = null;

		if (a != null) {
			actor = a;
			localActor = false;
		} else {
			actor = new Avatar();
			localActor = true;
		}
		if (localTargeter)
			setTargeter(null);
	}

	/**
	 * Gets the current actor.
	 */
	public Avatar getActor() {
		return actor;
	}

	/**
	 * Returns the current speed of the actor.
	 */
	public Double getSpeed() {
		return speed;
	}

	/**
	 * Returns the current squared speed of the actor.
	 */
	public Double getSpeed2() {
		return speed2;
	}

	/**
	 * Returns the current orientation of the actor as a normalised vector in
	 * the XY plane, i.e. x = cos(orientation), y = sin(orientation), and z = 0.
	 */
	public Vector3D getOrientation() {
		return orientation;
	}

	/**
	 * Sets the targeter used to generate top level goals. If no targeter is
	 * given, or the targeter is null, then a new targeter is created, otherwise
	 * the given targeter is considered to be non-local.
	 */
	public void setTargeter(Targeter t) {
		if (localTargeter)
			targeter = null;

		if (t != null) {
			targeter = t;
			localTargeter = false;
		} else {
			targeter = new Targeter(actor);
			localTargeter = true;
		}
		targeter.steering = this;
	}

	public Targeter getTargeter() {
		return targeter;
	}

	/**
	 * Changes the current actuator.
	 */
	public void setActuator(Actuator a) {
		if (localActuator)
			actuator = null;
		if (a != null) {
			actuator = a;
			localActuator = false;
		} else {
			actuator = new Actuator();
			localActuator = true;
		}
		actuator.steering = this;
	}

	/**
	 * Returns the current actuator.
	 */
	public Actuator getActuator() {
		return actuator;
	}

	/**
	 * Adds the given decomposer to the steering pipeline.
	 */
	public void addDecomposer(Decomposer d) {
		d.next = decomposers;
		decomposers = d;
		d.steering = this;
	}

	/**
	 * Adds the given constraint to the steering pipeline.
	 */
	public void addConstraint(SteeringConstraint c) {
		c.next = constraints;
		constraints = c;
		c.steering = this;
	}

	/**
	 * Runs the steering system. When this function returns, the steering output
	 * can be retrieved from getSteeringOutput (or by holding a pointer to the
	 * steer structure in which it is written).
	 */
	public void run() {/*
		Vector3D v = actor.velocity;
		speed2 = v.lengthSquared();
		speed = Math.sqrt(speed2);
		orientation.x = cosf(actor.orientation);
		orientation.y = sinf(actor.orientation);

		targeter.run();
		currentGoal = targeter.getGoal();

		// run decomposers
		Decomposer decomp = decomposers;
		while (decomp != null) {
			decomp.run();
			decomp = decomp.next;
		}

		// Constraint satisfaction algorithm. Works by gradually expanding the
		// "no-go" angle in front of the actor.
		Avatar leftGoal, rightGoal = actor, previousGoal = currentGoal;
		Double leftSine = 0.0, rightSine = 0.0, currentSine = 0.0;
		int priority = 0;
		while (true) {
			boolean violation = false, refinement = false;
			SteeringConstraint constraint = constraints;
			while (constraint != null) {
				if (constraint.priority < priority)
					continue;
				constraint.violated = false;
				constraint.run();
				if (constraint.violated) {
					Avatar sg = constraint.suggestedGoal;
					Vector3D w = new Vector3D(actor.position, sg.position);
					Double normFactor = Math.sqrt((v.x * v.x + v.y * v.y)
							* (w.x * w.x + w.y * w.y));
					Double sine, cosine;
					if (normFactor != null) {
						sine = (v.x * w.y - v.y * w.x) / normFactor;
						cosine = (v.x * w.x + v.y * w.y) / normFactor;
					} else {
						sine = cosine = 0.0;
					}

					if (cosine < 0) { // make the sine monotonic
						if (sine > 0) {
							sine += 2 * (1 - sine);
						} else {
							sine -= 2 * (1 + sine);
						}
					}

					if (constraint.priority > priority) { // ignore earlier
															// constraints
						leftGoal.clear();
						rightGoal = actor;
						leftSine = rightSine = currentSine = 0;
						priority = constraint.priority;
					}

					if (sine > leftSine) {
						leftSine = sine;
						leftGoal = sg;
						refinement = true;
					} else if (sine < rightSine) {
						rightSine = sine;
						rightGoal = sg;
						refinement = true;
					}
					violation = true;
				}

				constraint = constraint.next;
			}
			if (!violation)
				break;
			if (refinement) {
				// Choose the smaller of the two no go angles for the
				// next pass.
				if ((rightSine != null) || (leftSine != null)
						&& leftSine < -rightSine) {
					currentGoal = leftGoal;
					currentSine = leftSine;
				} else {
					currentGoal = rightGoal;
					currentSine = rightSine;
				}
				previousGoal = currentGoal;
				continue;
			}

			// If the goal hasn't changed some constraint must be
			// firing even though its suggested goal has already been
			// taken into account.
			if (currentGoal == previousGoal)
				break;

			// This side didn't yield a workable solution. Try the
			// other. But first check if we haven't done that
			// already.
			if (-currentSine > leftSine || -currentSine < rightSine) {
				constraintDeadlock();
				break;
			}

			if (currentSine == leftSine) {
				currentGoal = rightGoal;
				currentSine = rightSine;
			} else {
				currentGoal = leftGoal;
				currentSine = leftSine;
			}
		}
		actuator.run();*/
	}

	public void update() {
		// TODO Auto-generated method stub
		
	}
}

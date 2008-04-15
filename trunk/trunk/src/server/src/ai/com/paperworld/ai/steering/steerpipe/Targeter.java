package com.paperworld.ai.steering.steerpipe;

import com.paperworld.core.avatar.Avatar;

/**
 * Generates goals in the form of a kinematic (position, orientation, velocity
 * and rotation) that can be sought by the steering system. This class can be
 * used as is, to specify the target, or it may be extended to provide more
 * sophisticated targeting behaviour. Targeters are intended to work only when
 * installed in a SteerPipe class.
 */
public class Targeter {
	/**
	 * Pointer to the SteerPipe class, where details about the actor and the
	 * goal are stored. This is set by the SteerPipe class when the targeter is
	 * installed.
	 */
	protected SteerPipe steering;

	/**
	 * Pointer to the generated goal. This pointer is returned by the inline
	 * function getGoal.
	 */
	protected Avatar goal;

	/**
	 * Creates a new targeter seeking the given goal.
	 */
	public Targeter(Avatar g) {
		setGoal(g);
	}

	/**
	 * Gets the goal to the given kinematic.
	 */
	public void setGoal(Avatar g) {
		goal = g;
	}

	/**
	 * Gets the current goal for this targeter. For efficiency, this method is
	 * inline and cannot be overloaded. The pointer stored in this class can be
	 * set when the targeter receives execution time (in the normal manner,
	 * through its run function), or by calling setGoal explicitly.
	 * 
	 * @returns The current goal, always the pointer stored in the goal member.
	 */
	public Avatar getGoal() {
		return goal;
	}

	/**
	 * Returns the kinematick of the agent's actor.
	 */
	public Avatar getActor() {
		if (steering == null)
			return null;
		return steering.getActor();
	}

	/**
	 * Runs the targeter. The default implementation does nothing, because the
	 * goal is assumed to be explicit.
	 */
	public void run(){
		
	}
}

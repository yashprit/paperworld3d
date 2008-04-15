package com.paperworld.ai.steering.steerpipe;

/**
 * Decomposes a target to an immediate target (subgoal). For example, a planning
 * decomposer takes a target position to move to, produces a plan to get there
 * from the current location, and returns a subgoal at the first node of the
 * plan. This class should be extended to provide the needed decomposition.
 * Decomposers are intended to work only when installed in a SteerPipe class.
 */
abstract public class Decomposer {
	/**
	 * Pointer to the SteerPipe class, where details about the actor and the
	 * goal are stored. This is set by the SteerPipe class when the decomposer
	 * is installed.
	 */
	protected SteerPipe steering;

	/**
	 * Decomposers can be structured in a list. This points to the next item.
	 */
	public Decomposer next;

	/**
	 * Creates a new decomposer.
	 */
	public Decomposer() {
	}

	/**
	 * Runs the decomposer.
	 */
	abstract public void run();
}

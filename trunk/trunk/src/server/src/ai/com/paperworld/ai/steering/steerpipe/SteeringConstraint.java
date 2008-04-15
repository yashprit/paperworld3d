package com.paperworld.ai.steering.steerpipe;

import com.paperworld.core.avatar.Avatar;

/**
 * Constrains what the steering system can do in order to achieve its goals. It
 * is provided with the actor and goal (or subgoal, if it has been decomposed),
 * and can register a corrective action that should be taken to avoid violating
 * the constraint. Constraints are intended to work only when installed in a
 * SteerPipe class.
 */
abstract public class SteeringConstraint {
	/**
	 * Pointer to the SteerPipe class, where details about the actor and the
	 * goal are stored. This is set by the SteerPipe class when the constraint
	 * is added to it.
	 */
	protected SteerPipe steering;

	/**
	 * Steering constraints can be held in a list. This points to the next item
	 * in the list.
	 */
	public SteeringConstraint next;

	/**
	 * True if the constraint is or is about about to be violated. In such case
	 * the time member gives the time remaining until the violation occurs and
	 * suggestedGoal specifies the suggested evasive action.
	 */
	public boolean violated;

	/**
	 * The suggested goal to head for to avoid violating this constraint.
	 * Subclasses should write to this variable each time they receive their
	 * processing budget (through the run function in the normal way).
	 */
	public Avatar suggestedGoal;

	/**
	 * Time left until the constaint is violated, if no corrective action is
	 * taken. If no constraint is detected then this should be set to FLT_MAX or
	 * any value greater than lookAheadTime. The constraint resolution algorithm
	 * in the SteerPipe class picks the constraint with the highest priority,
	 * then the lowest time. Subclasses should write to this variable each time
	 * this they receives their processing budget (through the run function in
	 * the normal way).
	 */
	public int time;

	/**
	 * The priority of this constraint. The constraint resolution algorithm in
	 * the SteerPipe class picks the constraint with the highest priority, then
	 * the lowest time (see above). The default priority is zero.
	 */
	public int priority;

	/**
	 * If this parameter is true then the constraint checks for collisions in
	 * two stages: first with agent's path projected along current velocity, up
	 * to the apex of the turning arc, and second from the apex to the current
	 * goal. If the parameter is false then the constraint checks for collisions
	 * between the current position and the goal. The default value is true.
	 */
	public boolean inertial;

	/**
	 * Creates a new constraint.
	 */
	SteeringConstraint() {
		violated = false;
		priority = 0;
		inertial = true;
	}

	/**
	 * Runs the constraint.
	 */
	abstract public void run();
}

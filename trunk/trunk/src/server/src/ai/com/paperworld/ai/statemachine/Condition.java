package com.paperworld.ai.statemachine;

/**
 * The condition interface offsets the problem of whether transitions should
 * fire by having a separate set of condition instances that can be combined
 * together with boolean operators.
 */
public interface Condition {
	/**
	 * Performs the test for this condition.
	 */
	public boolean test();
}

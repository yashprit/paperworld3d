package com.paperworld.ai.statemachine.condition;

public class IntegerMatchCondition {
	/**
	 * A pointer to the integer value we should try to match.
	 */
	public int watch;

	/**
	 * The target value for the integer. If this is matched, then the condition
	 * will be true.
	 */
	public int target;

	/**
	 * Checks if the target matches the watch value.
	 */
	public boolean test() {
		return watch == target;
	}
}

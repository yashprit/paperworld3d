package com.paperworld.ai.statemachine;

/**
 * A mixin intended for use with a base transition derived
 * class. Uses an external condition instances to determine if the
 * transition is triggered.
 */
public class ConditionalTransitionMixin {
	/**
     * Holds the condition used to determine if the transition
     * should trigger.
     */
    public Condition condition;

    /**
     * Returns true if the transition wants to fire.
     */
    public boolean isTriggered() {
    	return condition.test();
    }
}

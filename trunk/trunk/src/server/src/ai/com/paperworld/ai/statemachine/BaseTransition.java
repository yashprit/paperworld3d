package com.paperworld.ai.statemachine;

import com.paperworld.ai.action.Action;

/**
 * The base transition is used for any kind of state machine. It doesn't force a
 * representation for the states or their transitions, but does give values for
 * the actions to be carried out and the triggering.
 */
public class BaseTransition {
	/**
	 * Points to the next transition in the sequence. Transitions are arranged
	 * in a singly linked list.
	 */
	public BaseTransition next;

	/**
	 * The transition needs to decide if it can be triggered or not. This will
	 * depend on the sub-class of transition we're dealing with.
	 */
	public boolean isTriggered() {
		return false;
	}

	/**
	 * The transition can also optionally return a list of actions that need to
	 * be performed during the transition.
	 * 
	 * Note that this method should return one or more newly created action
	 * instances, and the caller of this method should be responsible for the
	 * deletion. In the default implementation, it returns nothing.
	 */
	public Action getActions() {
		return null;
	}

}

package com.paperworld.ai.statemachine;

import com.paperworld.ai.action.Action;

abstract public class StateMachineState
{
	/**
	 * Returns the first in a sequence of actions that should be performed while
	 * the character is in this state.
	 * 
	 * Note that this method should return one or more newly created action
	 * instances, and the caller of this method should be responsible for the
	 * deletion. In the default implementation, it returns nothing.
	 */
	abstract public Action getActions();
	
	/**
	 * Returns the sequence of actions to perform when arriving in this state.
	 * 
	 * Note that this method should return one or more newly created action
	 * instances, and the caller of this method should be responsible for the
	 * deletion. In the default implementation, it returns nothing.
	 */
	abstract public Action getEntryActions();
	
	/**
	 * Returns the sequence of actions to perform when leaving this state.
	 * 
	 * Note that this method should return one or more newly created action
	 * instances, and the caller of this method should be responsible for the
	 * deletion. In the default implementation, it returns nothing.
	 */
	abstract public Action getExitActions();
	
	/**
	 * The first in the sequence of transitions that can leave this state.
	 */
	public Transition	firstTransition;
}

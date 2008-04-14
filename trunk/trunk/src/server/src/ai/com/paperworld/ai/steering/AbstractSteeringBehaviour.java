package com.paperworld.ai.steering;

import com.paperworld.core.avatar.Avatar;

/**
 * The steering behaviour is the base class for all dynamic
 * steering behaviours.
 */
abstract public class AbstractSteeringBehaviour {
	/**
     * The character who is moving.
     */
    public Avatar character;

    /**
     * Works out the desired steering and writes it into the given
     * steering output structure.
     */
    abstract public void getSteering(SteeringOutput output);
}

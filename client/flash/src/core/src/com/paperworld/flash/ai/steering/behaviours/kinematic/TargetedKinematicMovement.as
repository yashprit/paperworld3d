/*
 * Part of the Artificial Intelligence for Games system.
 *
 * Copyright (c) Ian Millington 2003-2006. All Rights Reserved.
 *
 * This software is distributed under licence. Use of this software
 * implies agreement with all terms and conditions of the accompanying
 * software licence.
 * 
 * Actionscript port - Trevor Burton [worldofpaper@googlemail.com]
 */
package com.paperworld.flash.ai.steering.behaviours.kinematic
{
	import com.paperworld.flash.util.number.Vector3;
	
	/**
	 * This is a base class that adds a target vector to its parent
     * class definition.
     * 
     * @author Trevor
     */
	public class TargetedKinematicMovement extends KinematicMovement 
	{
		/**
         * The target may be any vector (i.e. it might be something
         * that has no orientation, such as a point in space).
         */
        public var target : Vector3;
	}
}

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
	import com.paperworld.flash.ai.steering.Location;
	import com.paperworld.flash.ai.steering.SteeringOutput;	

	/**
	 * The base class for all kinematic movement behaviours.
     * 
     * @author Trevor
     */
	public class KinematicMovement 
	{
		/**
         * The character who is moving.
         */
        public var character:Location;

        /**
         * The maximum movement speed of the character.
         */
        public var maxSpeed:Number;

        /**
         * Works out the desired steering and writes it into the given
         * steering output structure.
         */
        public function getSteering(output:SteeringOutput):void
        {
        }
		
	}
}

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
package com.paperworld.ai.steering 
{
	import com.paperworld.core.BaseClass;	
	
	/**
	 * The steering behaviour is the base class for all dynamic
	 * steering behaviours.
	 * 
	 * @author Trevor
	 */
	public class SteeringBehaviour extends BaseClass
	{
		/**
		 * The character who is moving.
		 */
		public var character : Kinematic;

		/**
		 * Works out the desired steering and writes it into the given
		 * steering output structure.
		 */
		public function getSteering(output : SteeringOutput) : void
		{
		}
	}
}

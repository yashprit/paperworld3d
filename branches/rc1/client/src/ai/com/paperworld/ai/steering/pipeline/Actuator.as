package com.paperworld.ai.steering.pipeline 
{
	import com.paperworld.ai.steering.SteeringOutput;
	import com.paperworld.core.BaseClass;		

	/**
	 * Actuators generate forcess and torques that are required to
     * achieve the current goal state from the current actor
     * state. The default behaviour is to generate forces to move
     * towards the goal and align the orientation with the goal
     * kinematic, as well as adjust the target speed to match the goal
     * kinematic. The goal velocity direction is ignored.
     * 
     * @author Trevor
     */
	public class Actuator extends BaseClass
	{
        /**
         * Pointer to the SteerPipe class, where details about the
         * actor and the goal are stored. This is set by the SteerPipe
         * class when the actuator is added to it.
         */
        public var steering:SteeringPipeline;

        /**
         * The steering output which the actuator updates.
         */
        protected var _steer:SteeringOutput;

        /**
         * True if the steering output was created and should be
         * destroyed by this instance.
         */
        public var localSteer:Boolean;

        /**
         * The maximum acceleration (as output in the steer member)
         * that an agent is allowed to apply. Default is 1 distance
         * unit per second per second.  It assumes the agent has a
         * mass of 1 unit.
         */
        public var maxAcceleration:Number;

        /**
         * The maximum speed the agent is allowed to do.
         * The default value is 1;
         */
        public var maxSpeed:Number;

        /**
         * The maximum angular acceleration (as output in the steer
         * member) that an agent is allowed to apply. Default is 1
         * radian per second per second.  It assumes the agent has a
         * moment of inertia of 1 unit.
         */
        public var maxAngular:Number;

        /**
         * The maximum rotation the agent is allowed to do.
         * The default value is 1;
         */
        public var maxRotation:Number;

        /**
         * Controls how aggressive the steering is at turning. The
         * higher this value the sharper the turning will be. Allowed
         * range [0, oo). Default value 1.
         */
        public var angularSharpness:Number;

        /**
         * Controls how aggressive the steering is. The higher this
         * value the sharper the transition between accelerating and
         * braking. Allowed range [0, oo). Default value 1.
         */
        public var sharpness:Number;

        /**
         * Creates a new actuator.
         *
         * @param steer Pointer to a steer object. If this is NULL
         * then a default object will be created.
         */
        public function Actuator(steer:SteeringOutput = null)
        {
        	super();
        }
        
        override public function initialise():void
        {
            localSteer = false; 
            maxAcceleration = 1;
            maxSpeed = 1; 
            maxAngular = 1; 
            maxRotation = 1;
            angularSharpness = 1;
            sharpness = 1;	
        }

        /**
         * Sets the steer instance used to output steering actions to
         * take. If the given steer is null or no steer is given, then
         * a new local steer is used, otherwise the given steer is
         * considered non-local.
         */
        public function set steeringOutput(s:SteeringOutput):void
        {
        	if (localSteer) _steer;
        	
	        if (s)
	        {
	            _steer = s;
	            localSteer = false;
	        }
	        else
	        {
	            _steer = new SteeringOutput();
	            localSteer = true;
	        }	
        }

        /**
         * Gets the current steering output.
         */
        public function get steeringOutput():SteeringOutput
        {
            return _steer;
        }

        /**
         * Sets the steer force and torque to the values required to
         * achieve the current goal.
         */
        public function run():void
        {
        }
	}
}

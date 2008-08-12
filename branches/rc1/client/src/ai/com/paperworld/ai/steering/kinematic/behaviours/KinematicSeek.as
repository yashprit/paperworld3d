package com.paperworld.ai.steering.kinematic.behaviours 
{
	import com.paperworld.ai.steering.SteeringOutput;		

	/**
	 * @author Trevor
	 */
	public class KinematicSeek extends TargetedKinematicMovement 
	{
		override public function getSteering(output : SteeringOutput) : void
		{
			// First work out the direction
			output.linear = target;
			output.linear.minusEq( character.position );

			// If there is no direction, do nothing
			if (output.linear.squareMagnitude > 0)
			{
				output.linear.normalise( );
				output.linear.multiplyEq( maxSpeed );
			}
		}
	}
}

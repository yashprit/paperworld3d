package com.paperworld.avatar.behaviour;

import com.paperworld.ai.core.steering.AbstractSteeringBehaviour;
import com.paperworld.core.avatar.Avatar;
import com.paperworld.core.avatar.AvatarState;
import com.paperworld.core.util.DisplayObject3D;
import com.paperworld.core.util.math.Matrix3D;
import com.paperworld.core.util.math.Quaternion;
import com.paperworld.core.util.math.Vector3D;

public class MissileBehaviour extends AbstractSteeringBehaviour {

	public Double maxSpeed = 50.0;
	
	public Avatar target;
	
	public Quaternion baseOrientation = new Quaternion();

	public MissileBehaviour() {

	}
	
	private Quaternion calculateOrientation(Vector3D vector){
		Vector3D baseZVector = baseOrientation.clone().multiplyVector(new Vector3D(0,0,1));
		
		if (baseZVector.equals(vector))
			return baseOrientation.clone();
		
		if (baseZVector.equals(vector.returnNegative()))
			return baseOrientation.clone().returnConjugate();
		
		Vector3D change = baseZVector.returnCross(vector);
		
		double angle = Math.asin(change.length());
		Vector3D axis = change.copy();
		axis.normalise();
		
		return new Quaternion(Math.cos(angle/2),
								Math.sin(angle/2)*axis.x,
								Math.sin(angle/2)*axis.y,
								Math.sin(angle/2)*axis.z);
	}

	@Override
	public void run() {
		//Application.log.debug("running missile behaviour");
		AvatarState state = character.getState();
		DisplayObject3D displayObject = character.getDisplayObject();
		
		/*Vector3D direction = target.getPosition().returnSubtraction(character.getPosition());
		
		if (direction.length() == 0)
		{
			
		}
		
		Quaternion orientation = Quaternion.createFromMatrix(displayObject.transform);
		Quaternion targetOrientation = calculateOrientation(direction);
		
		Vector3D position = character.getPosition();
		
		Quaternion newOrientation = orientation.returnAddition(targetOrientation);
		
		Matrix3D transform = newOrientation.toMatrix();
		
		transform.n14 = position.x;
		transform.n24 = position.y;
		transform.n34 = position.z;
		
		displayObject.transform.copy(transform);
		*/
		displayObject.moveForward(maxSpeed);

		state.setTransform(displayObject.transform);
		state.setOrientation(Quaternion.createFromMatrix(state
				.returnTransform()));
	}

}

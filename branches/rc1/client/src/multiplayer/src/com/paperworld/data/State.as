package com.paperworld.data 
{
	import com.paperworld.core.BaseClass;	import com.paperworld.util.math.Matrix3D;	import com.paperworld.util.math.Quaternion;	import com.paperworld.util.math.Vector3;	
	/**
	 * @author Trevor
	 */
	public class State extends BaseClass
	{
		public var transform : Matrix3D;

		public var position : Vector3;

		public var orientation : Quaternion;		

		public var velocity : Vector3;

		public var rotation : Number;

		override public function initialise() : void
		{
			transform = Matrix3D.IDENTITY;
			position = new Vector3( );
			orientation = new Quaternion( );
			velocity = new Vector3( );	
			rotation = 0;
		}

		public function equals(other : State) : Boolean
		{
			return  transform == other.transform && 
					position.equals( other.position ) && 
					orientation.equals( other.orientation ) && 
					velocity.equals( other.velocity ) && 
					rotation == other.rotation; 	
		}

		public function notEquals(other : State) : Boolean
		{
			return !equals( other );
		}

		public function clone() : State
		{
			var state : State = new State( );
			
			state.transform 	= Matrix3D( transform.clone( ) );
			state.position 		= Vector3( position.clone( ) );
			state.orientation 	= Quaternion( orientation.clone( ) );
			state.velocity 		= Vector3( velocity.clone( ) );
			state.rotation 		= rotation;
			
			return state;	
		}

		override public function destroy() : void
		{
			transform.destroy( );
			position.destroy( );
			orientation.destroy( );
			velocity.destroy( );	
			rotation = 0;
		}

		// GETTERS / SETTERS for sending this object over the wire.

		public function getTransform() : Matrix3D
		{
			return transform;
		}

		public function setTransform(transform : Matrix3D) : void
		{
			this.transform = transform;	
		}

		public function getPosition() : Vector3
		{
			return position;
		}

		public function setPosition(position : Vector3) : void
		{
			this.position = position;
		}

		public function getOrientation() : Quaternion
		{
			return orientation;
		}

		public function setOrientation(orientation : Quaternion) : void
		{
			this.orientation = orientation;
		}

		public function getVelocity() : Vector3
		{
			return velocity;
		}

		public function setVelocity(velocity : Vector3) : void
		{
			this.velocity = velocity;	
		}

		public function getRotation() : Number
		{
			return rotation;
		}

		public function setRotation(rotation : Number) : void
		{
			this.rotation = rotation;	
		}
	}
}

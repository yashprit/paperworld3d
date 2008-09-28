package com.paperworld.data 
{
	import com.paperworld.core.BaseClass;
	import com.paperworld.core.interfaces.Cloneable;
	import com.paperworld.core.interfaces.Equalable;
	import com.paperworld.util.math.Matrix3D;
	import com.paperworld.util.math.Quaternion;
	import com.paperworld.util.math.Vector3;	

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

		override public function equals(other : Equalable) : Boolean
		{
			if (!super.equals( other )) return false;
			
			var o : State = State( other );
				
			return transform == o.transform && position.equals( o.position ) && orientation.equals( o.orientation ) && velocity.equals( o.velocity ) && rotation == o.rotation; 	
		}

		override public function clone() : Cloneable
		{
			var state : State = new State( );
			state.transform = Matrix3D( transform.clone( ) );
			state.position = Vector3( position.clone( ) );
			state.orientation = Quaternion( orientation.clone( ) );
			state.velocity = Vector3( velocity.clone( ) );
			state.rotation = rotation;
			
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

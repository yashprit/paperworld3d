﻿/**
	import com.paperworld.core.BaseClass;

	/**
		/**
		/**
		/**
		/**
		/**
		/**
		/**
		/**
		/**
		/**
		/**
		/**
		/**
		/**
		/**
		// temp objects to save constant instantiation of objects. 
		static private var n3Di : Vector3 = Vector3.ZERO; 
		static private var n3Dj : Vector3 = Vector3.ZERO; 
		static private var n3Dk : Vector3 = Vector3.ZERO; 
		// _________________________________________________________________________________ Matrix3D
		// sets the properties of the Matrix without creating a new one. 
		// _________________________________________________________________________________ IDENTITY
		// _________________________________________________________________________________ trace
		// _________________________________________________________________________________ OPERATIONS
		public static function multiply( a : Matrix3D, b : Matrix3D ) : Matrix3D
		public function calculateMultiply3x3( a : Matrix3D, b : Matrix3D ) : void
		public function calculateMultiply4x4( a : Matrix3D, b : Matrix3D ) : void
		public static function multiply3x3( a : Matrix3D, b : Matrix3D ) : Matrix3D
		public function calculateAdd( a : Matrix3D, b : Matrix3D ) : void
		public static function add( a : Matrix3D, b : Matrix3D ) : Matrix3D
		public function calculateInverse( m : Matrix3D ) : void
		public static function inverse( m : Matrix3D ) : Matrix3D
		public function invert() : void
		public function get det() : Number
		/*public function get trace():Number
		public function copy3x3( m : Matrix3D ) : Matrix3D
		override public function clone( ) : Cloneable
		// _________________________________________________________________________________ VECTOR
		public static function multiplyVector3x3( m : Matrix3D, v : Vector3 ) : void
		public static function multiplyVector4x4( m : Matrix3D, v : Vector3 ) : void
		public static function rotateAxis( m : Matrix3D, v : Vector3 ) : void
		/*
		public static function euler2matrix( deg : Vector3 ) : Matrix3D
		// _________________________________________________________________________________ ROTATION
		public static function rotationY( rad : Number ) : Matrix3D
		public static function rotationZ( rad : Number ) : Matrix3D
		public static function rotationMatrix( x : Number, y : Number, z : Number, rad : Number, targetmatrix : Matrix3D = null ) : Matrix3D
		public static function rotationMatrixWithReference( axis : Vector3, rad : Number, ref : Vector3 ) : Matrix3D
		// _________________________________________________________________________________ TRANSFORM
		public static function scaleMatrix( x : Number, y : Number, z : Number ) : Matrix3D
		// _________________________________________________________________________________ QUATERNIONS
		public static function normalizeQuaternion( q : Object ) : Object
		public static function axis2quaternion( x : Number, y : Number, z : Number, angle : Number ) : Object
		public static function euler2quaternion( ax : Number, ay : Number, az : Number, targetquat : Quaternion = null  ) : Quaternion
		// TODO (LOW) rewrite so that this takes an actual Quaternion object
		public static function multiplyQuaternion( a : Object, b : Object ) : Object
		override public function destroy() : void
		override public function equals(other : Equalable) : Boolean
		// _________________________________________________________________________________ TRIG
		static private var toRADIANS : Number = Math.PI / 180;
		static private var _sin : Function = Math.sin;
		static private var _cos : Function = Math.cos;
		public function readExternal(input : IDataInput) : void
		public function writeExternal(output : IDataOutput) : void
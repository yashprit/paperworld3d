package  
{

	/**
	 * @author Trevor
	 */
	public class Vector2 
	{
		public var x : Number;

		public var y : Number;

		public function Vector2(x : Number = 0, y : Number = 0)
		{
		}

		public function plus(other : Vector2) : Vector2
		{ 
			return new Vector2( x + other.x, y + other.y ); 
		}

		public function minus(other : Vector2) : Vector2
		{ 
			return new Vector2( x - other.x, y - other.y ); 
		}

		public function negate() : Vector2 
		{ 
			return new Vector2( -x, -y ); 
		}

		public function plusEquals(other : Vector2) : Vector2 
		{ 
			return new Vector2( x += other.x, y += other.y ); 
		}

		public function minusEquals(other : Vector2) : Vector2 
		{ 
			return new Vector2( x -= other.x, y -= other.y ); 
		}

		public function multiply(s : Number) : Vector2 
		{ 
			return new Vector2( x * s, y * s ); 
		}

		public function multiplyEquals(s : Number) : Vector2 
		{ 
			return new Vector2( x *= s, y *= s );  
		}

		public function multiplyVector(other : Vector2) : Vector2 
		{ 
			return new Vector2( x * other.x, y * other.y ); 
		}

		//Point &operator=(const Point &pt) { x = pt.x; y = pt.y; return *this; }
		public function equals(other : Vector2) : Boolean 
		{ 
			return x == other.x && y == other.y; 
		}

		public function len() : Number 
		{ 
			return Math.sqrt( x * x + y * y ); 
		}

		public function lenSquared() : Number 
		{ 
			return x * x + y * y; 
		}

		public function normalize() : void 
		{ 
			var l : Number = len( ); 
			if(l == 0) 
			{ 
				x = 1; 
				y = 0; 
			} 
			else 
			{ 
				l = 1 / l; 
				x *= l; 
				y *= l; 
			} 
		}

		public function normalizeTo(newLen : Number) : void 
		{ 
			var l : Number = len( ); 
			if(l == 0) 
			{ 
				x = newLen; 
				y = 0; 
			} 
			else 
			{ 
				l = newLen / l; 
				x *= l; 
				y *= l; 
			} 
		}

		public function scaleFloorDiv(scaleFactor : Number, divFactor : Number) : void
		{
			x = Math.floor( x * scaleFactor + 0.5 ) * divFactor;
			y = Math.floor( y * scaleFactor + 0.5 ) * divFactor;
		}

		public function dot(other : Vector2) : Number 
		{ 
			return x * other.x + y * other.y; 
		}
	}
}

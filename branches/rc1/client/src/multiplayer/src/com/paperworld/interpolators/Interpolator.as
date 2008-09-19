package com.paperworld.interpolators 
{
	import com.paperworld.data.State;	

	/**
	 * @author Trevor
	 */
	public interface Interpolator 
	{
		function interpolate(from : State, to : State, tightness : Number) : void
	}
}

package com.paperworld.core.util;

import java.util.Random;

public class RandomUtils {

	public static Random generator = new Random();
	
	public static int randomBinomial(int max) {
		return generator.nextInt(max) - generator.nextInt(max);		
	}
}

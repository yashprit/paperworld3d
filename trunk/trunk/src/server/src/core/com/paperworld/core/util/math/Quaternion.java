/*
 * --------------------------------------------------------------------------------------
 * PaperWorld3D - building better worlds
 * --------------------------------------------------------------------------------------
 * Realtime 3D Multi-User Application Framework for the Flash Platform.
 * --------------------------------------------------------------------------------------
 * Copyright (C) 2008 Influxis [http://www.influxis.com]
 * --------------------------------------------------------------------------------------
 * 
 * This library is free software; you can redistribute it and/or modify it under the 
 * terms of the GNU Lesser General Public License as published by the Free Software 
 * Foundation; either version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT ANY 
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A 
 * PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License along with 
 * this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, 
 * Suite 330, Boston, MA 02111-1307 USA 
 * 
 * --------------------------------------------------------------------------------------
 */
package com.paperworld.core.util.math;

import com.paperworld.core.constants.Constants;

public class Quaternion {
	/** */
	public double x;

	/** */
	public double y;

	/** */
	public double z;

	/** */
	public double w;

	public Quaternion() {
		clear();
	}

	public Quaternion(double x, double y, double z, double w) {
		this.x = x;
		this.y = y;
		this.z = z;
		this.w = w;
	}

	/**
	 * Creates a Quaternion from a matrix.
	 * 
	 * @param matrix
	 *            a matrix.
	 * @see org.papervision3d.core.Matrix3D
	 * 
	 * @return the created Quaternion
	 */
	public static Quaternion createFromMatrix(Matrix3D matrix) {
		Quaternion quat = new Quaternion();

		Double s;
		Double q[] = new Double[4];
		Integer i;
		Integer j;
		Integer k;

		Double tr = matrix.n11 + matrix.n22 + matrix.n33;

		// check the diagonal
		if (tr > 0.0) {
			s = Math.sqrt(tr + 1.0);
			quat.w = s / 2.0;
			s = 0.5 / s;

			quat.x = (matrix.n32 - matrix.n23) * s;
			quat.y = (matrix.n13 - matrix.n31) * s;
			quat.z = (matrix.n21 - matrix.n12) * s;
		} else {
			// diagonal is negative
			Integer nxt[] = { 1, 2, 0 };

			Double m[][] = {
					{ matrix.n11, matrix.n12, matrix.n13, matrix.n14 },
					{ matrix.n21, matrix.n22, matrix.n23, matrix.n24 },
					{ matrix.n31, matrix.n32, matrix.n33, matrix.n34 } };

			i = 0;

			if (m[1][1] > m[0][0])
				i = 1;
			if (m[2][2] > m[i][i])
				i = 2;

			j = nxt[i];
			k = nxt[j];
			s = Math.sqrt((m[i][i] - (m[j][j] + m[k][k])) + 1.0);

			q[i] = s * 0.5;

			if (s != 0.0)
				s = 0.5 / s;

			q[3] = (m[k][j] - m[j][k]) * s;
			q[j] = (m[j][i] + m[i][j]) * s;
			q[k] = (m[k][i] + m[i][j]) * s;

			quat.x = q[0];
			quat.y = q[1];
			quat.z = q[2];
			quat.w = q[3];
		}

		return quat;
	}

	public Double getModulo() {
		return Math.sqrt(x * x + y * y + z * z + w * w);
	}

	public void normalize() {
		Double len = getModulo();

		if (Math.abs(len) < Constants.EPSILON) {
			x = y = z = 0.0;
			w = 1.0;
		} else {
			Double m = 1 / len;
			x *= m;
			y *= m;
			z *= m;
			w *= m;
		}
	}

	public void clear() {
		x = 0.0;
		y = 0.0;
		z = 0.0;
		w = 1.0;
	}

	public boolean equals(Quaternion other) {
		return x == other.x && y == other.y && z == other.z && w == other.w;
	}

	public boolean notEquals(Quaternion other) {
		return x != other.x || y != other.y || z != other.z || w != other.w;
	}
	
	public void scale(Double s){
		x *= s;
		y *= s;
		z *= s;
		w *= s;
	}
	
	public void add(Quaternion other){
		x += other.x;
		y += other.y;
		z += other.z;
		w += other.w;
	}

	public String toString() {
		return "x: " + x + " y: " + y + " z: " + z + " w: " + w;
	}
}

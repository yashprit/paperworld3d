package org.flashmonkey.java.adaptor.jmonkey.behaviour;

import org.flashmonkey.java.api.IInput;
import org.flashmonkey.java.core.objects.BasicState;

import com.jme.math.Quaternion;
import com.jme.math.Vector3f;

public class AvatarForwardBehaviour extends AbstractAvatarBehaviour {

	// temporary vector for the rotation
	private static final Vector3f tempVa = new Vector3f();

	public AvatarForwardBehaviour() {

	}

	public AvatarForwardBehaviour(float speed) {
		super(speed);
	}

	@Override
	public void update(int time, IInput input, BasicState state) {
		if (input.getMoveForward()) {
			Vector3f loc = new Vector3f(state.px, state.py, state.pz);
			Quaternion orientation = new Quaternion(state.ox, state.oy, state.oz, state.ow);
			loc.addLocal(orientation.getRotationColumn(2, tempVa)
					.multLocal(speed));
			state.px = loc.x;
	        state.py = loc.y;
	        state.pz = loc.z;
		}
	}
}

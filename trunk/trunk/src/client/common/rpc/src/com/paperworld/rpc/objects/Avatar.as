/*
 * --------------------------------------------------------------------------------------
 * PaperWorld3D - building better worlds
 * --------------------------------------------------------------------------------------
 * Realtime 3D Multi-User Application Framework for the Flash Platform.
 * --------------------------------------------------------------------------------------
 * Copyright (C) 2008 Trevor Burton [worldofpaper@googlemail.com]
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
package com.paperworld.rpc.objects {
	import org.papervision3d.core.math.Matrix3D;
	import org.papervision3d.core.math.Number3D;
	import org.papervision3d.core.math.Quaternion;
	import org.papervision3d.objects.DisplayObject3D;
	
	import com.paperworld.logging.ILogger;
	import com.paperworld.logging.LoggerFactory;
	import com.paperworld.rpc.data.AvatarInput;
	import com.paperworld.rpc.data.AvatarState;
	import com.paperworld.rpc.input.Move;
	import com.paperworld.rpc.timer.events.IntegrationEvent;
	import com.paperworld.rpc.util.History;	

	/**
	 * <p><code>Avatar</code> handles syncing an object on a client with it's duplicate on the server.</p>
	 * 
	 * <p>By keeping a set of 3 objects the <code>Avatar</code> can handle keeping in sync with the server while
	 * smoothing out any jitter in the receipt of updates from the server.</p>
	 * 
	 * <ul>
	 * 		<li><i>Proxy</i> - is a direct representation of the data recieved from the server. When an update is receive the 
	 * 							Proxy is 'snapped' instantly to that state.
	 * 		</li>
	 * 		<li><i>Character</i> - represents the result of the user's input. This object is directly manipulated by UserInput.
	 * 		</li>
	 * 		<li><i>Avatar</i> - is a result of smoothing the Character towards the Proxy. This Avatar object is the smoothed towards the Character.
	 * 		</li>
	 * 	</ul>
	 * 	
	 * 	<p>This object listens to the <code>GameTimer</code> and updates each of the 3 objects on each tick it receives.</p>
	 * 	
	 * 	<p>It also listens to the <code>RemoteScene</code> that it's a part of. When server updates are received and passed to it the Avatar:</p>
	 * 	
	 * 	<ul>
	 * 		<li>Synchronises the Proxy</li>
	 * 		<li>Smooths the Character towards the Proxy</li>
	 * 		<li>Smooths the Avatar towards the Character</li>
	 * 		<li>Corrects the history of moves recorded for this Avatar, ensuring that 
	 * 		playback results in the user seeing a replica of the server's view of events</li>
	 * 	</ul>
	 * 
	 * @author Trevor
	 */
	public class Avatar extends DisplayObject3D 
	{
		public var time : int = 0;

		/**
		 * <p>The modelKey is a reference to the name of the model used to represent this object in the scene.
		 * It should be the same name as that used to reference the model in the module config file if you're
		 * using the full framework, or the name of the custom model if you're just using the RPC library.</p>
		 * 
		 * <p>The key is passed to the server and stored for this object - then passed to all the other clients (as well as those
		 * that connect to the scene in future) allowing them to create the correct object in their local scenes.</p>
		 */
		public var modelKey : String;

		public var uid : String;

		public var proxy : Proxy;

		public var character : RemoteObject;

		public var avatar : RemoteObject;

		public var logger : ILogger;

		public var updating : Boolean = false;

		protected var inScene : Boolean = false;

		protected var history : History;

		public var lastSyncTime : int = 0;

		public var registered : Boolean = true;

		public var behaviour : IAvatarBehaviour;

		public function Avatar()
		{
			super( );
			
			logger = LoggerFactory.getLogger( this );
			
			character = new RemoteObject( new DisplayObject3D( ) );
			proxy = new Proxy( new DisplayObject3D( ) );
			
			history = new History( );
		}
		
		public function destroy():void 
		{
			time = 0;
			modelKey = null;
			uid = null;
			
			logger = null;
			updating = false;
			inScene = false;
			lastSyncTime = 0;
			registered = false;
			
			history.destroy();
			history = null;
			
			behaviour.destroy();
			behaviour = null;
			
			proxy.destroy();
			proxy = null;
			
			character.destroy();
			character = null;
			
			avatar.destroy();
			avatar = null;			
		}

		protected function createDisplayObject(key : String) : void 
		{
		}

		public function set displayObject(value : RemoteObject) : void 
		{
			character = value;
		}

		public function update(event : IntegrationEvent) : void 
		{						
			var move : Move = new Move( );
			move.time = time;
			move.state = proxy.current.copy( );
			move.input = character.input.copy( );
			
			history.add( move );	
			
			character.update( event.time, behaviour );
			proxy.update( event.time, behaviour );

			time++;
			
			character.smooth( proxy, character.tightness );
			avatar.smooth( character, avatar.tightness );
		}

		public function synchronise(data : Object) : void 
		{
			if (data["input"] != null)
			{
				var state : AvatarState = getStateFromObject( data["state"] );
				//var input : AvatarInput = getInputFromObject( data["input"] );

				var t : int = data["time"];

				proxy.synchronise( t, state, new AvatarInput( ) );
				character.synchronise( t, state, new AvatarInput( ) );
			}
		}

		public function getStateFromObject(obj : Object) : AvatarState
		{
			var state : AvatarState = new AvatarState( );
			
			if (obj != null)
			{
				state.transform = new Matrix3D( new Array( obj.n11, obj.n12, obj.n13, obj.n14, obj.n21, obj.n22, obj.n23, obj.n24, obj.n31, obj.n32, obj.n33, obj.n34, obj.n41, obj.n42, obj.n43, obj.n44 ) );
															 
				state.orientation = new Quaternion( obj.qx, obj.qy, obj.qz, obj.qw );
				state.position = new Number3D( obj.px, obj.py, obj.pz );
				state.speed = obj.speed;
			}
			
			return state;
		}

		public function getInputFromObject(obj : Object) : AvatarInput
		{
			var input : AvatarInput = new AvatarInput( );
			
			input.back = obj["back"];
			input.forward = obj["forward"];
			input.down = obj["down"];
			input.firing = obj["firing"];
			input.left = obj["left"];
			input.mouseX = obj["mouseX"];
			input.mouseY = obj["mouseY"];
			input.pitchNegative = obj["pitchNegative"];
			input.pitchPositive = obj["pitchPositive"];
			input.right = obj["right"];
			input.rollNegative = obj["rollNegative"];
			input.rollPositive = obj["rollPositive"];
			input.up = obj["up"];
			input.yawNegative = obj["yawNegative"];
			input.yawPositive = obj["yawPositive"];
			
			return input;
		}
	}
}

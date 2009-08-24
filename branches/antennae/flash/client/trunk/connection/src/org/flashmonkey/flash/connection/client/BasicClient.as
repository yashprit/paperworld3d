package org.paperworld.flash.connection.client
{
	import com.joeberkovitz.moccasin.service.IOperation;
	import org.paperworld.flash.api.connection.IClient;
	import org.paperworld.flash.api.connection.INetConnection;
	import org.paperworld.flash.api.connection.ISharedObject;
	import org.paperworld.flash.api.connection.messages.IGroupMessage;
	import org.paperworld.flash.api.connection.messages.IMessage;
	import org.paperworld.flash.api.connection.messages.IPlayerMessage;
	import org.paperworld.flash.connection.handshake.BasicHandshake;
	import org.paperworld.flash.connection.messages.SendMessageOperation;
	import org.paperworld.flash.utils.IProcessor;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.SyncEvent;
	import flash.net.SharedObject;

	/**
	 * A simple implementation of the IClient interface. This client wraps a single Red5Connection/RemoteSharedObject
	 * pair. It uses the NetConnection to send messages to the server and the RemoteSharedObject to receive
	 * Synchronisation messages from the server.
	 */
	public class BasicClient extends EventDispatcher implements IClient
	{
		/**
		 * @private
		 */
		private var _id:String;
		
		/**
		 * The unique id assigned to this client's connection by the server.
		 */
		public function get id():String 
		{
			return _id;
		}
		
		/**
		 * @private
		 */
		public function set id(value:String):void
		{
			_id = value;
		}
		
		/**
		 * @private
		 */
		private var _connection:INetConnection;
		
		/**
		 * The underlying NetConnection this client uses to send/receive messages.
		 */
		public function get connection():INetConnection
		{
			return _connection;
		}
		
		/**
		 * @private.
		 */
		public function set connection(value:INetConnection):void 
		{
			_connection = value;
			connection.client = this;
			
			if (sharedObject)
			{
				sharedObject.connection = connection;
			}
		}
		
		private var _sharedObject:ISharedObject;
		
		public function get sharedObject():ISharedObject
		{
			return _sharedObject;
		}
		
		public function set sharedObject(value:ISharedObject):void 
		{
			if (value != null)
			{
				_sharedObject = value;
				
				if (connection)
				{
					sharedObject.connection = connection;
				}
				
				sharedObject.addEventListener(SyncEvent.SYNC, onSync);
			}
		}
		
		private var messageProcessors:Array = [];
				
		public function BasicClient(connection:INetConnection = null, sharedObject:ISharedObject = null)
		{
			super(this);
			
			this.connection = connection;
			this.sharedObject = sharedObject;
		}
		
		/**
		 * Begins the quick handshake procedure - extend the handshake class to 
		 * implement a custom handshake for your game.
		 */
		public function connect():IOperation 
		{
			trace("BasicClient connecting " + connection.rtmpURI);
			
			var handshake:IOperation = new BasicHandshake(this);
			handshake.addEventListener(Event.COMPLETE, onConnectionEstablished);
			
			return handshake;
		}
		
		/**
		 * Once the connection with the server is established we need
		 * to set the connection's client property back to this object
		 * so we can catch incoming calls to receiveMessage.
		 */
		private function onConnectionEstablished(e:Event):void 
		{
			connection.client = this;
		}
		
		public function sendToServer(message:IMessage):IOperation 
		{
			return _sendMessage(message);
		}
		
		public function sendToPlayer(message:IPlayerMessage):IOperation
		{
			return _sendMessage(message);
		}
		
		public function sendToGroup(message:IGroupMessage):IOperation 
		{
			return _sendMessage(message);
		}
		
		private function _sendMessage(message:IMessage):IOperation 
		{
			message.senderId = _id || "*";

			return new SendMessageOperation(message, connection);
		}
		
		/**
		 * Receives a message - either from the server or from a 
		 * SharedObject.SYNC event.
		 * 
		 * Iterate over all message handlers and let them process
		 * the message if they're able. We don't break on the first handler
		 * that can handle the message because we want all the handlers
		 * that are able to handle the message to do so.
		 */
		public function receiveMessage(message:IMessage):void 
		{
			for each (var processor:IProcessor in messageProcessors)
			{
				if (processor.canProcess(message))
				{
					processor.process(message);
				}
			}
		}
		
		/**
		 * Handles SyncEvent.SYNC events from the remote shared object.
		 * If a new message has been added to the shared object then
		 * we need to handle it.
		 */
		private function onSync(event:SyncEvent):void 
		{
			var changeList:Array = event.changeList;
			var so:SharedObject = sharedObject.sharedObject;
			
			// Iterate over each client whose properties have changed.
			for (var i:int; i < changeList.length; i++)
			{
				var id:String = changeList[i].name;

				// Grab the object related to the client.
				var object:Object = so.data[id];
				var message:IMessage = IMessage(so.data[id]);

				// If the object is of type IMessage then process it.
				if (message)
				{
					receiveMessage(message);
				}
			}
		}
		
		public function addMessageProcessor(processor:IProcessor):void 
		{
			messageProcessors.push(processor);
		}
	}
}
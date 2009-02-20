package com.paperworld.client.flash 
{
	import com.paperworld.flash.BitSet;
	import com.paperworld.flash.util.IRegisteredClass;
	import com.paperworld.flash.util.Registration;
	
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;	

	/**
	 * @author Trevor
	 */
	public class GhostInfo implements IRegisteredClass, IExternalizable
	{
		public static const InScope : int = 1 << 0;		
		public static const ScopeLocalAlways : int = 1 << 1;		
		public static const NotYetGhosted : int = 1 << 2;		
		public static const Ghosting : int = 1 << 3;		
		public static const KillGhost : int = 1 << 4;		
		public static const KillingGhost : int = 1 << 5;		
		public static const NotAvailable : int = NotYetGhosted | Ghosting | KillGhost | KillingGhost;

		public var flags : BitSet;

		public var index : int;

		public var object : GhostObject;

		public function GhostInfo(object : GhostObject) 
		{
			Registration.registerClass( this );
			
			this.object = object;
			flags = new BitSet( );
		}

		public function get aliasName() : String
		{
			return "com.paperworld.server.flash.GhostInfo";
		}

		public function readExternal(input : IDataInput) : void
		{
			index = input.readInt( );
			flags = BitSet( input.readObject( ) );
		}

		public function writeExternal(output : IDataOutput) : void
		{
			output.writeObject( index );
			output.writeObject( flags );
		}
	}
}

package com.paperworld.multiplayer.data;

import org.red5.io.amf3.IDataInput;
import org.red5.io.amf3.IDataOutput;


public class MyClass /*implements IExternalizable*/ {
	 
	//private static final long serialVersionUID = 11520080920;
 
	public String l;
	/*public Integer x;
	public Byte b;
	public Boolean bool;
	public String str;*/
	
	/*public void readExternal(IDataInput input)
	{
		l = input.readDouble();
		x = input.readInt();
		b = input.readByte();
		bool = input.readBoolean();
		str = input.readUTF();
	}
	
	public void writeExternal(IDataOutput output)
	{
		output.writeDouble(l);
		output.writeInt(x);
		output.writeInt(b);
		output.writeBoolean(bool);
		output.writeUTF(str);
	}*/
 
	public String getL() {
	    return l;
	}
 
	public void setL(String l) {
	    this.l = l;
	}
 
	/*public Integer getX() {
	    return x;
	}
 
	public void setX(Integer x) {
	    this.x = x;
	}
 
	public Byte getB() {
	    return b;
	}
 
	public void setB(Byte b) {
	    this.b = b;
	}
 
	public Boolean getBool() {
	    return bool;
	}
 
	public Boolean isBool() {
	    return bool;
	}
 
	public void setBool(Boolean bool) {
	    this.bool = bool;
	}
 
	public String getStr() {
	    return str;
	}
 
	public void setStr(String str) {
	    this.str = str;
	}*/
}

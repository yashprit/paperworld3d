package com.paperworld.server.udp;

import java.io.UnsupportedEncodingException;
import java.nio.ByteOrder;

import org.apache.mina.common.ByteBuffer;
import org.red5.io.amf3.IDataInput;
import org.red5.io.amf3.IDataOutput;

import utils.ByteUtils;
import utils.Transcoder;

public class BitStream implements IDataInput, IDataOutput {

	private static final String DEFAULT_CHARSET = "UTF-8";

	protected String charset = DEFAULT_CHARSET;

	protected byte[] buffer;

	protected int bitNum; // /< The current bit position for reading/writing in
	// the bit stream.
	protected boolean error; // /< Flag set if a user operation attempts to read
	// or write past the max read/write sizes.
	protected boolean mCompressRelative; // /< Flag set if the bit stream should
	// compress points relative to a
	// compression point.
	// Point3F mCompressPoint; ///< Reference point for relative point
	// compression.
	protected long maxReadBitNum; // /< Last valid read bit position.
	protected long maxWriteBitNum; // /< Last valid write bit position.

	protected Transcoder transcoder;

	protected int stringBufferLength = 256;

	// ConnectionStringTable *mStringTable; ///< String table used to compress
	// StringTableEntries over the network.
	// / String buffer holds the last string written into the stream for
	// substring compression.
	// protected char mStringBuffer[256];

	public BitStream() {
		reset();
		transcoder = new Transcoder();
	}

	public BitStream(ByteBuffer buffer) {
		this.buffer = buffer.array();
		bitNum = 0;
		System.out.println("buffer: " + this.buffer.length);
	}

	public void reset() {
		buffer = new byte[1024];
		bitNum = 0;
	}

	public byte[] getBuffer() {
		return buffer;
	}

	public ByteBuffer getByteBuffer() {
		return ByteBuffer.wrap(buffer);
	}

	public byte readByte() {
		byte val = buffer[bitNum];
		bitNum++;
		return val;
	}

	public boolean readBoolean() {
		return (readByte() == 1) ? true : false;
	}

	public int readInt() {
		int val = ByteUtils.byteArrayToInt(buffer, bitNum, false);
		bitNum += 4;
		return val;
	}

	public float readFloat() {
		float val = readFloat(bitNum);
		bitNum += 4;
		return val;
	}

	public float readFloat(int index) {
		return ByteUtils.byteArrayToFloat(buffer, index, false);
	}

	public void writeByte(byte input) {
		buffer[bitNum] = input;
		bitNum++;
	}

	public void writeInt(int input) {
		byte[] inArray = ByteUtils.intToByteArray(input, false);

		for (int i = 0; i < inArray.length; i++) {
			buffer[bitNum] = inArray[i];
			bitNum++;
		}
	}

	public void writeBoolean(boolean bool) {
		writeByte((byte) (bool ? 1 : 0));
	}

	public void write(byte[] input) {

	}

	public ByteOrder getEndian() {
		// TODO Auto-generated method stub
		return null;
	}

	public void readBytes(byte[] arg0) {
		// TODO Auto-generated method stub

	}

	public void readBytes(byte[] arg0, int arg1) {
		// TODO Auto-generated method stub

	}

	public void readBytes(byte[] arg0, int arg1, int arg2) {
		// TODO Auto-generated method stub

	}

	public double readDouble() {
		// TODO Auto-generated method stub
		return 0;
	}

	public String readMultiByte(int arg0, String arg1) {
		// TODO Auto-generated method stub
		return null;
	}

	public Object readObject() {
		// TODO Auto-generated method stub
		return null;
	}

	public short readShort() {
		// TODO Auto-generated method stub
		return 0;
	}

	public String readUTF() {		
		byte[] array = new byte[256];
		System.arraycopy(buffer, bitNum, array, 0, 256);

		try {
			String output = new String(array, "UTF8");
			return output.trim();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		return null;
	}

	public String readUTFBytes(int arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	public int readUnsignedByte() {
		// TODO Auto-generated method stub
		return 0;
	}

	public long readUnsignedInt() {
		// TODO Auto-generated method stub
		return 0;
	}

	public int readUnsignedShort() {
		// TODO Auto-generated method stub
		return 0;
	}

	public void setEndian(ByteOrder arg0) {
		// TODO Auto-generated method stub

	}

	public void writeBytes(byte[] arg0) {
		// TODO Auto-generated method stub

	}

	public void writeBytes(byte[] arg0, int arg1) {
		// TODO Auto-generated method stub

	}

	public void writeBytes(byte[] arg0, int arg1, int arg2) {
		// TODO Auto-generated method stub

	}

	public void writeDouble(double arg0) {
		// TODO Auto-generated method stub

	}

	public void writeFloat(float arg0) {
		// TODO Auto-generated method stub

	}

	public void writeMultiByte(String arg0, String arg1) {
		// TODO Auto-generated method stub

	}

	public void writeObject(Object arg0) {
		// TODO Auto-generated method stub

	}

	public void writeShort(short arg0) {
		// TODO Auto-generated method stub

	}

	public void writeUTF(String input) {
		try {
			byte[] utf8Bytes = input.getBytes("UTF8");
			System.arraycopy(utf8Bytes, 0, buffer, bitNum, 256);
			bitNum += 256;
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}

	public void writeUTFBytes(String arg0) {
		// TODO Auto-generated method stub

	}

	public void writeUnsignedInt(long arg0) {
		// TODO Auto-generated method stub

	}
}

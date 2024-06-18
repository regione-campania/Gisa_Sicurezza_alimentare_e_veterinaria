package org.aspcfs.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.spec.SecretKeySpec;

import sun.misc.BASE64Encoder;

public class tokenLoginUtil {
	
	public  String generate( String username )
	{
		String ret = null;

		String			originalToken	= System.currentTimeMillis() + "@" + username;
		byte[]			encryptedToken	= null;
		KeyGenerator	kgen			= null;
		
		try
		{
			kgen						= KeyGenerator.getInstance("AES");
			kgen.init(128);
		//	SecretKeySpec	skeySpec	= new SecretKeySpec(asBytes( Application.get( "KEY" ) ), "AES");
			SecretKeySpec skeySpec = getKeySpec( this.getClass().getResource("aes_key").getPath());
			Cipher 			cipher		= Cipher.getInstance("AES");
			cipher.init( Cipher.ENCRYPT_MODE, skeySpec );
			BASE64Encoder enc = new BASE64Encoder();
			encryptedToken = enc.encode(cipher.doFinal(originalToken.getBytes())).getBytes() ;
		}
		catch ( Exception e )
		{
			e.printStackTrace();
		}
  
		ret = "&encryptedToken="+asHex(encryptedToken);

		return ret;
	}
	
	public static String asHex( byte buf[] )
	{
		StringBuffer sb = new StringBuffer(buf.length * 2);
		for( int i = 0; i < buf.length; i++ )
		{
			if( ((int) buf[i] & 0xff) < 0x10 )
			{
				sb.append("0");
			}
			sb.append(Long.toString((int) buf[i] & 0xff, 16));
		}
		
		return sb.toString();
	}
	
	  public static SecretKeySpec getKeySpec(String path) throws IOException, NoSuchAlgorithmException,FileAesKeyException {
		    byte[] bytes = new byte[16];
		    File f = new File(path.replaceAll("%20", " "));
		   
		    SecretKeySpec spec = null;
		    if (f.exists()) 
		    {
		      new FileInputStream(f).read(bytes);
		      
		    } else {
		      /* KeyGenerator kgen = KeyGenerator.getInstance("AES");
		       kgen.init(128);
		       key = kgen.generateKey();
		       bytes = key.getEncoded();
		       new FileOutputStream(f).write(bytes);*/
		    	throw new FileAesKeyException("File aes_key not found");
		    	
		    }
		    spec = new SecretKeySpec(bytes,"AES");
		    return spec;
		  }

}

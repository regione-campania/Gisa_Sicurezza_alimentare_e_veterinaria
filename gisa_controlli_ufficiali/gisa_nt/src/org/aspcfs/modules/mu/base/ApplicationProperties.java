package org.aspcfs.modules.mu.base;


import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class ApplicationProperties {
	
	private static Properties applicationProperties = null;
	
	private ApplicationProperties(){ }
	
	static{
		InputStream is = ApplicationProperties.class.getResourceAsStream( "mu.properties" );
		applicationProperties = new Properties();
		try {
			applicationProperties.load( is );
		} catch (IOException e) {
			applicationProperties = null;
		}
	}
	
	
	public static Properties getApplicationProperties() {
		return applicationProperties;
	}


	public static String getProperty( String property ){
		return (applicationProperties != null) ? applicationProperties.getProperty( property ) : "";
	}
}
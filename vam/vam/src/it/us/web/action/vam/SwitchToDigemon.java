package it.us.web.action.vam;

import java.net.InetAddress;
import java.sql.Connection;

import javax.naming.Context;
import javax.naming.InitialContext;

import it.us.web.action.GenericAction;
import it.us.web.bean.BGuiView;
import it.us.web.bean.BUtente;
import it.us.web.dao.GuiViewDAO;
import it.us.web.dao.hibernate.Persistence;
import it.us.web.dao.hibernate.PersistenceFactory;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.properties.Application;
import it.us.web.util.vam.CaninaRemoteUtil;
import it.us.web.util.vam.Token;

public class SwitchToDigemon extends GenericAction
{

	@Override
	public void can() throws AuthorizationException
	{
	}
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}

	@Override
	public void execute() throws Exception
	{
		String DIGEMON_PORTALE_URL 		= "http://";
		//String DIGEMON_URL 		  		= Application.get("DIGEMON_URL_PUBLIC");
		String DIGEMON_URL 		  		=InetAddress.getByName("srvDIGEMONW").getHostAddress();
	    //InetAddress iadd = InetAddress.getByName(DIGEMON_URL);
	    //System.out.println(iadd.getHostName());
		//String DIGEMON_URL_ALIAS = iadd.getHostName();
		String DIGEMON_PORT 		  		= Application.get("DIGEMON_PORT");
		String DIGEMON_APPLICATION_NAME 	= Application.get("DIGEMON_APPLICATION_NAME");
		DIGEMON_PORTALE_URL = DIGEMON_PORTALE_URL + DIGEMON_URL + ":" + DIGEMON_PORT + "/" + DIGEMON_APPLICATION_NAME;
		
		String username = utente.getUsername();
		String ret = DIGEMON_PORTALE_URL + "/Login.do?command=LoginNoPassword" + Token.generateOLD( username );
		
		System.out.println("Login DIGEMON: " + ret);
		
		redirectTo(ret);
	}

	@Override
	public void setSegnalibroDocumentazione() {
		// TODO Auto-generated method stub
		
	}
	
}

package it.us.web.action.cambiopassword;

import java.security.Key;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import javax.mail.MessagingException;
import javax.mail.SendFailedException;
import javax.xml.crypto.Data;

import org.apache.tomcat.util.codec.binary.Base64;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;
import it.us.web.action.GenericAction;
import it.us.web.bean.endpointconnector.EndPoint;
import it.us.web.bean.endpointconnector.EndPointConnector;
import it.us.web.bean.endpointconnector.EndPointConnectorList;
import it.us.web.bean.endpointconnector.Operazione;
import it.us.web.bean.gucinterazioni.GucInterazioni;
import it.us.web.bean.mail.PecMailSender;
import it.us.web.dao.UtenteDAO;
import it.us.web.db.ApplicationProperties;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.guc.DbUtil;

public class DecriptaPassword extends GenericAction
{

	private String pwdDaDecriptare ="";
	private String pwdDecriptata = "";
	
	
	public DecriptaPassword() {		
	}
	
	@Override
	public void can() throws AuthorizationException
	{

	}

	@Override
	public void execute() throws Exception
	{
			
		pwdDaDecriptare = stringaFromRequest( "pwdDaDecriptare" );
		req.setAttribute("pwdDaDecriptare", pwdDaDecriptare);
		
		if (pwdDaDecriptare !=null){
			
			try {
			pwdDecriptata = EseguiCambioPassword.decrypt(pwdDaDecriptare, EseguiCambioPassword.keyValue);
			req.setAttribute("pwdDecriptata", pwdDecriptata);
			}
			catch (Exception e){
				req.setAttribute("pwdDecriptata", "----ERROR----");
			}
		}
		gotoPage("/jsp/cambiopassword/decriptaPassword.jsp" );
		
	}



	
}
	

package it.us.web.action.login;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpSession;

import it.us.web.action.GenericAction;
import it.us.web.bean.BUtente;
import it.us.web.bean.SuperUtente;
import it.us.web.bean.UserOperation;
import it.us.web.dao.UtenteDAO;
import it.us.web.exceptions.AuthorizationException;
import it.us.web.util.Md5;
import it.us.web.util.bean.Bean;

public class Ballot extends GenericAction {

	Boolean flag = false;
	
	
	@Override
	public void canClinicaCessata() throws AuthorizationException
	{
	}
	
	
	@Override
	public void can() throws AuthorizationException
	{
		if( session.getAttribute( "su" ) == null )
		{
			throw new AuthorizationException( "Rieseguire il login per cambiare clinica" );
		} else {
			SuperUtente su = (SuperUtente) session.getAttribute("su");
			HashMap utenti = (HashMap<String, HttpSession>)req.getSession().getServletContext().getAttribute("utenti");
			if (utenti !=null){ 
				HttpSession sessioneUtente = ((HashMap<String, HttpSession>)req.getSession().getServletContext().getAttribute("utenti")).get(su.getUsername());
				if (sessioneUtente != null) {
					req.setAttribute("utente", su.getUsername());
					req.setAttribute("password", req.getSession().getAttribute("password"));
					req.setAttribute("id", interoFromRequest( "id" ));
					flag=true;
				}
			}
		}
		
		
	}
	
	@Override
	public void setSegnalibroDocumentazione()
	{
		setSegnalibroDocumentazione("login");
	}

	@SuppressWarnings("unchecked")
	@Override
	public void execute() throws Exception
	{
		Context ctx = new InitialContext();
		javax.sql.DataSource ds = (javax.sql.DataSource)ctx.lookup("java:comp/env/jdbc/vamM");
		connection = ds.getConnection();
		GenericAction.aggiornaConnessioneApertaSessione(req);
		
		SuperUtente su = (SuperUtente) session.getAttribute( "su" );
		
		BUtente bu = UtenteDAO.getUtente(interoFromRequest( "id" ), connection);
		
		ArrayList<UserOperation> op = (ArrayList<UserOperation>)session.getAttribute("operazioni");
		String ambienteSirv = (String)session.getAttribute("ambienteSirv");
		
		Enumeration<String> e = session.getAttributeNames();
		while( e.hasMoreElements() )
		{
			session.removeAttribute( e.nextElement() );
		}
		
		boolean test = false;
		for( BUtente u: su.getUtenti() )
		{
			if( u.getId() == bu.getId() )
			{
				test = true;
			}
		}
		
		if (flag == false && interoFromRequest( "id" )>0 ){
		if( test )
		{
			utente = bu;
			
			/**
			 * GESTIONE GEOLOCALIZZAZIONE
			 */
			utente.setAccessPositionErr(su.getAccessPositionErr());
			
			if (su.getAccessPositionErr() == null || ("").equals(su.getAccessPositionErr()))
				utente.setAccessPositionErr("Comunicazione RealTime");		
			utente.setAccessPositionLat(su.getAccessPositionLat());
			utente.setAccessPositionLon(su.getAccessPositionLon());
			
			//Flusso 342
			try {
				System.out.println("##### set qualifica profilo - inizio ####");
				String qualifica = (String) req.getParameter("qualifica");
				String profilo_professionale = (String) req.getParameter("profilo_professionale");

				if(qualifica != null && profilo_professionale != null){
					System.out.println("##### set qualifica profilo - not null ####");
					utente.setQualifica(qualifica);
					utente.setProfilo_professionale(profilo_professionale);
				}
				System.out.println("##### set qualifica profilo - fine ####");
				
				session.setAttribute( "utente", utente );
			} catch (Exception e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			//settaSessionFunzioniConcesse(utente , session);
			
			String system = (String) session.getAttribute( "system" );
			session.setAttribute( "system", (system == null) ? ("vam") : (system) );
			session.setAttribute("operazioni",op);
			inserisciUtenteContext(su, session,ambienteSirv);
			
			
		}
		else
		{
			setErrore( "Selezione non consentita" );
		}

		redirectTo( "Index.us?entrypointSinantropi=urlDiretto" );
		} 
		else 	
		{ 
			session.setAttribute("ambienteSirv", ambienteSirv);
			gotoPage( "public", "/jsp/gestioneUtenteContext.jsp" );
		}

		
	}
}

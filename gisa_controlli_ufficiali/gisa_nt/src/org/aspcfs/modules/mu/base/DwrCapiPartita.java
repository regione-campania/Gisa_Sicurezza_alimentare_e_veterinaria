package org.aspcfs.modules.mu.base;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Hashtable;

import javax.servlet.http.HttpServletRequest;

import org.aspcfs.controller.SystemStatus;
import org.aspcfs.utils.GestoreConnessioni;
import org.directwebremoting.WebContext;
import org.directwebremoting.WebContextFactory;

import com.darkhorseventures.database.ConnectionElement;

public class DwrCapiPartita { 


	
	public static ArrayList<CapoUnivoco> listaCapiDaPartita(int idPartita) throws SQLException
	{
		
		Connection db = null ;
		WebContext ctx = WebContextFactory.get();
		ConnectionElement ce = (ConnectionElement) ctx.getSession().getAttribute("ConnectionElement");
		SystemStatus systemStatus = (SystemStatus) ((Hashtable) ctx.getServletContext().getAttribute("SystemStatus")).get(ce.getUrl());
		HttpServletRequest req = ctx.getHttpServletRequest();
		
		try {
			db = GestoreConnessioni.getConnection();
			PartitaUnivoca partita = new PartitaUnivoca(db, idPartita);
			return partita.getListaCapi();
			
		} catch (SQLException e) {
			throw e ;
		}
		catch (NumberFormatException g) {
			throw g ;
		}	
		finally
		{
			GestoreConnessioni.freeConnection(db);
		}
	}
	
	public static ArrayList<CapoUnivoco> listaCapiMacellabiliDaPartita(int idPartita) throws SQLException
	{
		
		Connection db = null ;
		WebContext ctx = WebContextFactory.get();
		ConnectionElement ce = (ConnectionElement) ctx.getSession().getAttribute("ConnectionElement");
		SystemStatus systemStatus = (SystemStatus) ((Hashtable) ctx.getServletContext().getAttribute("SystemStatus")).get(ce.getUrl());
		HttpServletRequest req = ctx.getHttpServletRequest();
		
		try {
			db = GestoreConnessioni.getConnection();
			PartitaUnivoca partita = new PartitaUnivoca(db, idPartita);
			return partita.getListaCapiMacellabili();
			
		} catch (SQLException e) {
			throw e ;
		}
		catch (NumberFormatException g) {
			throw g ;
		}	
		finally
		{
			GestoreConnessioni.freeConnection(db);
		}
	}
}



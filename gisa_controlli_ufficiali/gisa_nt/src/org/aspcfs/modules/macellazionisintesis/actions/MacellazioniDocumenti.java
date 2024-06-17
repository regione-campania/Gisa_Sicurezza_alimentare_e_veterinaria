package org.aspcfs.modules.macellazionisintesis.actions;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.Vector;

import org.apache.commons.beanutils.RowSetDynaClass;
import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.login.beans.UserBean;
import org.aspcfs.modules.macellazioninewsintesis.utils.ConfigTipo;
import org.aspcfs.modules.macellazionisintesis.base.Art17;
import org.aspcfs.modules.macellazionisintesis.base.Art17ErrataCorrige;
import org.aspcfs.modules.macellazionisintesis.base.Capo;
import org.aspcfs.modules.sintesis.base.SintesisStabilimento;
import org.aspcfs.modules.stabilimenti.base.Organization;
import org.aspcfs.modules.stabilimenti.base.OrganizationAddress;
import org.aspcfs.modules.troubletickets.base.Ticket;
import org.aspcfs.utils.DatabaseUtils;
import org.aspcfs.utils.web.LookupList;
import org.jmesa.facade.TableFacade;
import org.jmesa.facade.TableFacadeFactory;
import org.jmesa.limit.Limit;
import org.jmesa.view.editor.CellEditor;
import org.jmesa.view.html.component.HtmlColumn;
import org.jmesa.view.html.editor.HtmlCellEditor;

import com.darkhorseventures.framework.actions.ActionContext;

public final class MacellazioniDocumenti extends CFSModule
{
	
	private static final SimpleDateFormat sdf  = new SimpleDateFormat( "dd/MM/yyyy" );
	private static final SimpleDateFormat sdf2 = new SimpleDateFormat( "yyyy-MM-dd" );
	ConfigTipo configTipo = null;
	
	public String executeCommandDefault(ActionContext context)
	{		
		if (!hasPermission(context, "stabilimenti-stabilimenti-macellazioni-view"))
		{
			return ("PermissionError");
		}
		
		return executeCommandToRegistroMacellazioni(context);
	}

	public String executeCommandToRegistroMacellazioni(ActionContext context)
	{		
		if (!hasPermission(context, "stabilimenti-stabilimenti-macellazioni-view"))
		{
			return ("PermissionError");
		}
		
		
		
		Connection db = null;
		
		try
		{
			db = this.getConnection( context );
			SintesisStabilimento org = new SintesisStabilimento( db, Integer.parseInt( context.getParameter( "altId" ) ), true );
			context.getRequest().setAttribute( "OrgDetails", org );
			
			//Recupero date di macellazione per riempire la combo
			ArrayList<String> listaDateMacellazione = null;
			
			//	listaDateMacellazione = Capo.loadDateMacellazioneByStabilimento( context.getParameter( "altId" ), db );
			listaDateMacellazione = Capo.loadDateMacellazioneByStabilimentoNoPregresse( context.getParameter( "altId" ), db );
			context.getRequest().setAttribute( "listaDateMacellazione", listaDateMacellazione );
			
		}
		catch (Exception e1)
		{
			context.getRequest().setAttribute("Error", e1);
			e1.printStackTrace();
		} 
		finally
		{
			this.freeConnection(context, db);
		}
		return "ToRegistroMacellazioniOK";
	}
	
public String executeCommandToArt17(ActionContext context)
	{
		if (!hasPermission(context, "stabilimenti-stabilimenti-macellazioni-view"))
		{
			return ("PermissionError");
		}
		
		Connection db = null;
	
		try
		{
			db = this.getConnection( context );
			SintesisStabilimento org = new SintesisStabilimento( db, Integer.parseInt( context.getParameter( "altId" ) ) , true);
			context.getRequest().setAttribute( "OrgDetails", org );
			
			//Recupero date di macellazione per riempire la combo
		//	ArrayList<String> listaDateMacellazione = Capo.loadDateMacellazioneByStabilimento( context.getParameter( "altId" ), db );
			ArrayList<String> listaDateMacellazione = Capo.loadDateMacellazioneByStabilimentoNoPregresse( context.getParameter( "altId" ), db );
			context.getRequest().setAttribute( "listaDateMacellazione", listaDateMacellazione );
		}
		catch (Exception e1)
		{
			context.getRequest().setAttribute("Error", e1);
			e1.printStackTrace();
		} 
		finally
		{
			this.freeConnection(context, db);
		}
		return "ToArt17OK";
	}
	
	
	public String executeCommandToMod10(ActionContext context)
	{
		if (!hasPermission(context, "stabilimenti-stabilimenti-macellazioni-view"))
		{
			return ("PermissionError");
		}
		
		Connection db = null;
		
		try
		{
			db = this.getConnection( context );
			SintesisStabilimento org = new SintesisStabilimento( db, Integer.parseInt( context.getParameter( "altId" ) ) , true);
			context.getRequest().setAttribute( "OrgDetails", org );
			
			//Recupero date di macellazione per riempire la combo
			//ArrayList<String> listaDateMacellazione = Capo.loadDateMacellazioneByStabilimento( context.getParameter( "altId" ), db );
			ArrayList<String> listaDateMacellazione = Capo.loadDateMacellazioneByStabilimentoTamponi( context.getParameter( "altId" ), db );
			context.getRequest().setAttribute( "listaDateMacellazione", listaDateMacellazione );
		}
		catch (Exception e1)
		{
			context.getRequest().setAttribute("Error", e1);
			e1.printStackTrace();
		} 
		finally
		{
			this.freeConnection(context, db);
		}
		return "ToMod10OK";
	}
	
	public String executeCommandEsercentiArt17(ActionContext context)
	{
		if (!hasPermission(context, "stabilimenti-stabilimenti-macellazioni-view"))
		{
			return ("PermissionError");
		}
		
		getConfigTipo(context);
		
		Connection db = null;
		
		try
		{
			db = this.getConnection( context );
			SintesisStabilimento org = new SintesisStabilimento( db, Integer.parseInt( context.getParameter( "altId" ) ) , true);
			context.getRequest().setAttribute( "OrgDetails", org );
			
			String data = context.getParameter( "comboDateMacellazione" );
			Timestamp d = null;
			try
			{
				d = new Timestamp( sdf.parse( data ).getTime() );
			}
			catch ( Exception e )
			{
				e.printStackTrace();
				context.getRequest().setAttribute( "messaggio", "Selezionare una data valida" );
				return executeCommandToArt17(context);
			}
			
			String suffissoVista = configTipo.getSuffissoViste();
			String select = "SELECT * FROM m_esercenti_macellazioni" + suffissoVista + " WHERE id_macello = ? AND data_macellazione = ?";
			PreparedStatement stat = db.prepareStatement( select );
					
			stat.setInt( 1, org.getAltId() );
			stat.setTimestamp( 2, d );
					
			ResultSet		res		= stat.executeQuery();
			RowSetDynaClass	rsdc	= new RowSetDynaClass( res );
			
			if( rsdc.getRows().size() == 0 )
			{
				context.getRequest().setAttribute( "messaggio", "Nessun capo macellato il " + data );
				return executeCommandToArt17(context);
			}
			
			TableFacade tf = TableFacadeFactory.createTableFacade( "2", context.getRequest() );
			tf.setItems( rsdc.getRows() );
			tf.setColumnProperties( "esercente", "numero_capi"  );
			tf.setStateAttr("restore");

			Limit limit = tf.getLimit();
			if( limit.isExported() )
			{
				tf.render();
				return null;
			}
			else
			{
				HtmlColumn cg = (HtmlColumn) tf.getTable().getRow().getColumn("esercente");
				cg.setTitle( "Destinatario Carni" );
				cg.getCellRenderer().setCellEditor( 
		        		new CellEditor()
		        		{	
		        			public Object getValue(Object item, String property, int rowCount)
		        			{
		        				String ret = "";
		        				String temp		= (String) (new HtmlCellEditor()).getValue(item, property, rowCount);
		        				String id_eserc	= (String) (new HtmlCellEditor()).getValue(item, "id_esercente", rowCount);
		        				String id_mac	= (String) (new HtmlCellEditor()).getValue(item, "id_macello", rowCount);
		        				String data		= (String) (new HtmlCellEditor()).getValue(item, "data_macellazione", rowCount);
		        				try
		        				{
									data = sdf.format( sdf2.parse( data ) );
								}
		        				catch (ParseException e)
		        				{
									e.printStackTrace();
								}
		        				//COSA ZOZZA APPARATA
		        				temp = (temp == null || "".equals(temp.trim())) ? ("-") : (temp);
//		        				if(id_eserc.equals("-999")){
//		        						
//		        						
//										ret = "<a target=\"_blank\" href=\"GestioneDocumenti.do?command=GeneraPDFMacelli&tipo=Macelli_17&esercente=" + id_eserc + "&nomeEsercente=" + temp.replaceAll("&amp;", "u38") +"&altId=" + id_mac + "&data=" 
//										+ data + "\">" + temp + "</a></div>";
//		        				}
//		        				else{
//		        					ret = "<a target=\"_blank\" href=\"GestioneDocumenti.do?command=GeneraPDFMacelli&tipo=Macelli_17&esercente=" + id_eserc + "&altId=" + id_mac + "&data=" 
//		        							+ data + "\">" + temp + "</a></div>";
//		        				}
		        				
//		        				if(id_eserc.equals("-999")){
//	        						
//	        						
//									ret = "<a target=\"_blank\" href=\"MacellazioniDocumenti.do?command=Art17&esercente=" + id_eserc + "&nomeEsercente=" + temp.replaceAll("&amp;", "u38") +"&altId=" + id_mac + "&data=" 
//									+ data + "\">" + temp + "</a></div>";
//	        				}
//	        				else{
//	        					ret = "<a target=\"_blank\" href=\"MacellazioniDocumenti.do?command=Art17&esercente=" + id_eserc + "&altId=" + id_mac + "&data=" 
//	        							+ data + "\">" + temp + "</a></div>";
//	        				}
		        		// aggiunti link nuova gestione		
		        				if(id_eserc.equals("-999")){
        						
        						
								ret = ret+ "<a target=\"_blank\" href=\"GestioneDocumenti.do?command=GeneraPDFMacelli&tipo=Macelli_17&esercente=" + id_eserc + "&nomeEsercente=" + temp.replaceAll("&amp;", "u38") +"&altId=" + id_mac + "&data=" 
								+ data + "\">" +  temp + " </a></div>";
        				}
        				else{
        					ret = ret + "<a target=\"_blank\" href=\"GestioneDocumenti.do?command=GeneraPDFMacelli&tipo=Macelli_17&esercente=" + id_eserc + "&altId=" + id_mac + "&data=" 
        							+ data + "\">"+ temp + " </a></div>";
        				}
		        		//fine nuova gestione		
		        				return ret;
		        			}
		        		}
		        
		        	);
				
				cg = (HtmlColumn) tf.getTable().getRow().getColumn("numero_capi");
				cg.setTitle( "Capi Macellati" );
				
				cg.setFilterable( false );
			}

			String tabella = tf.render();
			context.getRequest().setAttribute( "tabella", tabella );
			
		}
		catch (Exception e1)
		{
			context.getRequest().setAttribute("Error", e1);
			e1.printStackTrace();
		} 
		finally
		{
			this.freeConnection(context, db);
		}
				
		return "EsercentiArt17OK";
	}

	
	public String executeCommandViewModuleErrataCorrigeArt17(ActionContext context) {
		
		String idCapo = context.getRequest().getParameter("idCapo");
		int altId = -1;
		String tipoMacello = context.getRequest().getParameter("tipoMacello");
		if (tipoMacello == null)
			tipoMacello = (String) context.getRequest().getAttribute("tipoMacello");
		
		Capo c = null;
		
		
		String altIdString = context.getRequest().getParameter("altId");
		if (altIdString == null)
			 altIdString = (String) context.getRequest().getAttribute("altId");
		
		if (altIdString!=null && !altIdString.equals(""))
			altId = Integer.parseInt(altIdString);
		
		Connection db = null;
		try
		{
			db = this.getConnection( context );
			SintesisStabilimento org = new SintesisStabilimento (db, altId, true);
			context.getRequest().setAttribute("OrgDetails", org);
			
			
				c = Capo.load(idCapo, db);
			
			context.getRequest().setAttribute("Capo", c);
			
			if (c.getErrata_corrige_generati()>=10){
				context.getRequest().setAttribute("Error", "Numero massimo moduli Errata Corrige generati raggiunto per questo capo.");
				return "errorPage";
				}
			
			LookupList aslList	= new LookupList( db, "lookup_site_id" );
			context.getRequest().setAttribute("aslList", aslList);
			
			LookupList specieList	= new LookupList( db, "m_lookup_specie" );
			specieList.removeElementByValue("Ovini");
			specieList.removeElementByValue("Caprini");
		//	String specieAttuale = specieList.getSelectedValue(c.getCd_specie());
			//specieList.removeElementByValue(specieAttuale);
			context.getRequest().setAttribute("specieList", specieList);
			
			UserBean user = (UserBean) context.getSession().getAttribute("User");
			String ip = context.getIpAddress();
			String user_name = user.getUserRecord().getUsername();
			context.getRequest().setAttribute("userIp", ip);
			context.getRequest().setAttribute("userName", user_name);
			
			DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
			Date date = new Date();
			context.getRequest().setAttribute("timeNow",dateFormat.format(date));
			
			Art17 art17 = Art17.find( org.getAltId(), c.getDestinatario_1_id(), c.getDestinatario_1_nome(),c.getVpm_data(),  db);
			context.getRequest().setAttribute("art17", art17);
			
			
			int idMacello = -1;
			String nomeMacello = "";
			String comuneMacello = "";
			int aslMacello = -1;
			String approvalNumber = "";
			int orgId = -1;
		
				idMacello = altId;
				SintesisStabilimento macello = new SintesisStabilimento(db, idMacello, true);
				nomeMacello = macello.getOperatore().getRagioneSociale();
				approvalNumber = macello.getApprovalNumber();
				aslMacello = macello.getIdAsl();
				comuneMacello = macello.getIndirizzo().getDescrizioneComune() + " ("+  macello.getIndirizzo().getDescrizioneComune()+")";
			
			context.getRequest().setAttribute("nomeMacello", nomeMacello);	
			context.getRequest().setAttribute("approvalNumber", approvalNumber);	
			context.getRequest().setAttribute("comuneMacello", comuneMacello);	
			context.getRequest().setAttribute("aslMacello", String.valueOf(aslMacello));
				
			String nomeEsercente ="";
			String indirizzoEsercente="";
			
			if (art17.getId_esercente()>0 && DatabaseUtils.getTipologiaPartizione(db, art17.getId_esercente()) == Ticket.ALT_OPU){
				Organization esercente = new Organization(db, art17.getId_esercente());
				nomeEsercente = esercente.getName();
				Iterator iaddressM = esercente.getAddressList().iterator();
			    while (iaddressM.hasNext()) {
			      OrganizationAddress thisAddress = (OrganizationAddress)iaddressM.next();
			      if (thisAddress.getType()==5)
			    	  indirizzoEsercente = " - "+ thisAddress.getStreetAddressLine1()+", "+  thisAddress.getCity() + " ("+ thisAddress.getState()+")";
			}
			}
			else if(art17.getId_esercente()>0 && DatabaseUtils.getTipologiaPartizione(db, art17.getId_esercente()) == Ticket.ALT_SINTESIS){
				SintesisStabilimento esercente = new SintesisStabilimento(db, art17.getId_esercente(), true);
				nomeEsercente =esercente.getOperatore().getRagioneSociale();
		    	  indirizzoEsercente = " - "+ esercente.getIndirizzo().getDescrizioneToponimo() + " " + esercente.getIndirizzo().getVia()+ " "+esercente.getIndirizzo().getCivico()+", "+  esercente.getIndirizzo().getDescrizione_provincia() + " ("+ esercente.getIndirizzo().getDescrizione_provincia()+")";
			}
			context.getRequest().setAttribute("nomeEsercente", nomeEsercente);
			context.getRequest().setAttribute("indirizzoEsercente", indirizzoEsercente);
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally
		{
			this.freeConnection(context, db);
		}
		
		if (context.getRequest().getAttribute("ErrataCorrige")!=null)
			return "art17erratacorrigeStampaOk";
		
		return "art17erratacorrigeOk";
		
	}
	
	public String executeCommandSalvaModuleErrataCorrigeArt17(ActionContext context) throws SQLException{
		
		Art17ErrataCorrige ErrataCorrige = new Art17ErrataCorrige(context);
		UserBean user = (UserBean) context.getSession().getAttribute("User");
		String ip = context.getIpAddress();
		Connection db = null;
		int result1 = -1;
		int result2 = -1;
		try
		{
			db = this.getConnection( context );
			
			db.setAutoCommit(false);
			
			ErrataCorrige.setIdUtente(user.getUserId());
			ErrataCorrige.setIpUtente(ip);
			ErrataCorrige.setNomeUtente(user.getUsername());
			result1 = ErrataCorrige.insert(db);
			result2 = ErrataCorrige.aggiornaCapo(db);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			db.rollback();
			e.printStackTrace();
			String errore = "Errore su ";
			if (result1==-1)
				errore = errore + "inserimento modulo Errata Corrige.";
			if (result2==-1)
				errore = errore + "modifica capo. Modulo errata corrige NON inserito.";
				
			context.getRequest().setAttribute("Error", errore);
			return "errorPage";
		}
		finally
		{
			db.setAutoCommit(true);
			db.close();
			this.freeConnection(context, db);
		}
		context.getRequest().setAttribute("definitivoDocumentale", "true");
		context.getRequest().setAttribute("tipoMacello", "1");
		context.getRequest().setAttribute("altId", context.getRequest().getParameter("idMacello"));
		context.getRequest().setAttribute("idCapo", context.getRequest().getParameter("idCapo"));
		
		context.getRequest().setAttribute("ErrataCorrige", ErrataCorrige);
		context.getRequest().setAttribute("idErrataCorrige", ErrataCorrige.getId());
		
		// return executeCommandViewModuleErrataCorrigeArt17(context);
		return "art17erratacorrigeSalvaOk";
	}
	
public String executeCommandViewListaModuleErrataCorrigeArt17(ActionContext context){
		
		String idCapo = context.getRequest().getParameter("idCapo");
		int altId = -1;
		String tipoMacello = context.getRequest().getParameter("tipoMacello");
		if (tipoMacello == null)
			tipoMacello = (String) context.getRequest().getAttribute("tipoMacello");
		
		Capo c = null;
		
		
		String altIdString = context.getRequest().getParameter("altId");
		if (altIdString == null)
			 altIdString = (String) context.getRequest().getAttribute("altId");
		
		if (altIdString!=null && !altIdString.equals(""))
			altId = Integer.parseInt(altIdString);
		
		Connection db = null;
		try
		{
			db = this.getConnection( context );
			SintesisStabilimento org = new SintesisStabilimento (db, altId, true);
			context.getRequest().setAttribute("OrgDetails", org);
			
			
				c = Capo.load(idCapo, db);
			
			context.getRequest().setAttribute("Capo", c);
			
			Art17ErrataCorrige ec = new Art17ErrataCorrige();
			ec.setIdMacello(altId);
			ec.setIdCapo(idCapo);
			
			Vector ecList = new Vector();
			ecList = ec.load(db);
			context.getRequest().setAttribute("ecList", ecList);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally
		{
			this.freeConnection(context, db);
		}
		
			return "art17erratacorrigeListaOk";
		}

public String executeCommandViewErrataCorrigeArt17(ActionContext context){
	
	String idErrataCorrige = context.getRequest().getParameter("idErrataCorrige");
	String idCapo = context.getRequest().getParameter("idCapo");
	int altId = Integer.parseInt(context.getRequest().getParameter("altId"));
	
	Connection db = null;
	Capo c = null;
	try
	{
		db = this.getConnection( context );
		SintesisStabilimento org = new SintesisStabilimento (db, altId, true);
		context.getRequest().setAttribute("OrgDetails", org);
		
			c = Capo.load(idCapo, db);
		
		context.getRequest().setAttribute("Capo", c);
		
		String nomeEsercente ="";
		String indirizzoEsercente="";
		
		if (c.getDestinatario_1_id()>0 && DatabaseUtils.getTipologiaPartizione(db, c.getDestinatario_1_id()) == Ticket.ALT_ORGANIZATION){
			Organization esercente = new Organization(db, c.getDestinatario_1_id());
			nomeEsercente = esercente.getName();
			Iterator iaddressM = esercente.getAddressList().iterator();
		    while (iaddressM.hasNext()) {
		      OrganizationAddress thisAddress = (OrganizationAddress)iaddressM.next();
		      if (thisAddress.getType()==5)
		    	  indirizzoEsercente = " - "+ thisAddress.getStreetAddressLine1()+", "+  thisAddress.getCity() + " ("+ thisAddress.getState()+")";
		}
		}
		else if (c.getDestinatario_1_id()>0 && DatabaseUtils.getTipologiaPartizione(db, c.getDestinatario_1_id()) == Ticket.ALT_SINTESIS){
			SintesisStabilimento esercente = new SintesisStabilimento(db, c.getDestinatario_1_id(), true);
			nomeEsercente =esercente.getOperatore().getRagioneSociale();
	    	  indirizzoEsercente = " - "+ esercente.getIndirizzo().getDescrizioneToponimo() + " " + esercente.getIndirizzo().getVia()+ " "+esercente.getIndirizzo().getCivico()+", "+  esercente.getIndirizzo().getDescrizione_provincia() + " ("+ esercente.getIndirizzo().getDescrizione_provincia()+")";
		}
		context.getRequest().setAttribute("nomeEsercente", nomeEsercente);
		context.getRequest().setAttribute("indirizzoEsercente", indirizzoEsercente);
		
		LookupList aslList	= new LookupList( db, "lookup_site_id" );
		context.getRequest().setAttribute("aslList", aslList);
		
		LookupList specieList	= new LookupList( db, "m_lookup_specie" );
		specieList.removeElementByValue("Ovini");
		specieList.removeElementByValue("Caprini");
	//	String specieAttuale = specieList.getSelectedValue(c.getCd_specie());
		//specieList.removeElementByValue(specieAttuale);
		context.getRequest().setAttribute("specieList", specieList);
		
		UserBean user = (UserBean) context.getSession().getAttribute("User");
		String ip = context.getIpAddress();
		String user_name = user.getUserRecord().getUsername();
		context.getRequest().setAttribute("userIp", ip);
		context.getRequest().setAttribute("userName", user_name);
		
		DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
		Date date = new Date();
		context.getRequest().setAttribute("timeNow",dateFormat.format(date));
		
		Art17 art17 = Art17.find( org.getAltId(), c.getDestinatario_1_id(), c.getDestinatario_1_nome(),c.getDataSessioneMacellazione(),  db);
		context.getRequest().setAttribute("art17", art17);
		
		int idMacello = -1;
		String nomeMacello = "";
		String comuneMacello = "";
		int aslMacello = -1;
		String approvalNumber = "";
		
			idMacello = altId;
			SintesisStabilimento macello = new SintesisStabilimento(db, idMacello, true);
			nomeMacello = macello.getOperatore().getRagioneSociale();
			approvalNumber = macello.getApprovalNumber();
			aslMacello = macello.getIdAsl();
			comuneMacello = macello.getIndirizzo().getDescrizioneComune() + " ("+  macello.getIndirizzo().getDescrizioneComune()+")";
		
			context.getRequest().setAttribute("nomeMacello", nomeMacello);	
			context.getRequest().setAttribute("approvalNumber", approvalNumber);	
			context.getRequest().setAttribute("comuneMacello", comuneMacello);	
			context.getRequest().setAttribute("aslMacello", String.valueOf(aslMacello));	
		
		int id = Integer.parseInt(idErrataCorrige);
		Art17ErrataCorrige ec = new Art17ErrataCorrige(db, id);
		context.getRequest().setAttribute("ErrataCorrige", ec);
		
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	finally
	{
		this.freeConnection(context, db);
	}
		return "art17erratacorrigeStampaOk";
}


private void getConfigTipo(ActionContext context)
{
	if(context.getSession().getAttribute("configTipo")!=null){
		Object o = context.getSession().getAttribute("configTipo");
		
		try {
			configTipo = (ConfigTipo) context.getSession().getAttribute("configTipo");
			}
		catch (Exception e){
			org.aspcfs.modules.macellazioninewsintesis.utils.ConfigTipo configTipo2 = (org.aspcfs.modules.macellazioninewsintesis.utils.ConfigTipo) context.getSession().getAttribute("configTipo");
			final int tipo = configTipo2.getIdTipo();
			configTipo = new ConfigTipo(tipo);
			context.getSession().setAttribute("configTipo", configTipo);
		}
}
}	
}

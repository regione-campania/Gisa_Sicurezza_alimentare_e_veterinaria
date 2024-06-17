package org.aspcfs.modules.nonconformita.actions;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;

import org.aspcf.modules.controlliufficiali.action.Followup;
import org.aspcfs.controller.SystemStatus;
import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.admin.base.Role;
import org.aspcfs.modules.admin.base.User;
import org.aspcfs.modules.base.Constants;
import org.aspcfs.modules.lineeattivita.base.LineeAttivita;
import org.aspcfs.modules.login.beans.UserBean;
import org.aspcfs.modules.nonconformita.base.Ticket;
import org.aspcfs.modules.sintesis.base.SintesisOperatoreMercato;
import org.aspcfs.utils.DatabaseUtils;
import org.aspcfs.utils.web.LookupList;

import com.darkhorseventures.framework.actions.ActionContext;
//import org.aspcfs.modules.troubletickets.base.TicketCategoryList;

public final class AccountNonConformitaAlt extends CFSModule {
	
	private int tipoOperatore = -1;
	
	public int getTipoOperatore() {
		return tipoOperatore;
	}

	public void setTipoOperatore(int tipoOperatore) {
		this.tipoOperatore = tipoOperatore;
	}

	public String executeCommandAdd(ActionContext context,Connection db){

		org.aspcfs.modules.nonconformita.base.Ticket newTic = null;
		try {
			Followup f = new Followup();
			f.executeCommandAdd(context);
			if (context.getRequest().getParameter("idMacchinetta")!=null)
			{
				context.getRequest().setAttribute("idMacchinetta", context.getRequest().getParameter("idMacchinetta"));
			}
			else
			{
				context.getRequest().setAttribute("idMacchinetta", context.getRequest().getAttribute("idMacchinetta"));
			}
			
			SystemStatus systemStatus = this.getSystemStatus(context);
			UserBean user = (UserBean) context.getSession().getAttribute("User");
			 if (user.getUserRecord().getGruppo_ruolo()==Role.GRUPPO_ALTRE_AUTORITA )
				 context.getRequest().setAttribute("View", "AutoritaNonCompetenti");
			
			
			LookupList Provvedimenti = new LookupList(db, "lookup_provvedimenti");
			Provvedimenti.addItem(-1, "-- SELEZIONA UNA TIPOLOGIA DI NC --");
			Provvedimenti.removeElementByLevel(9);
			context.getRequest().setAttribute("Provvedimenti", Provvedimenti);
			
			
			LookupList macrocategorie = new LookupList(db, "lookup_ispezione_macrocategorie");
			
			context.getRequest().setAttribute("Macrocategorie", macrocategorie);
			
			context.getRequest().setAttribute("idIspezione", context.getRequest().getParameter("idIspezione"));
			context.getRequest().setAttribute("dataC", context.getRequest().getParameter("dataC"));
			LookupList NonConformitaAmministrative = new LookupList(db, "lookup_nonconformita_amministrative");
			NonConformitaAmministrative.addItem(-1, "-- SELEZIONA VOCE --");
			context.getRequest().setAttribute("NonConformitaAmministrative", NonConformitaAmministrative);

			LookupList NonConformitaPenali = new LookupList(db, "lookup_nonconformita_penali");
			NonConformitaPenali.addItem(-1, "-- SELEZIONA VOCE --");
			context.getRequest().setAttribute("NonConformitaPenali", NonConformitaPenali);
			
			LookupList NonConformita = new LookupList(db, "lookup_nonconformita");
			NonConformita.addItem(-1, "-- SELEZIONA VOCE --");
			context.getRequest().setAttribute("NonConformita", NonConformita);

			String idControlloUfficiale = context.getRequest().getParameter("idControllo");
			String idC = context.getRequest().getParameter("idC");
			context.getRequest().setAttribute("idControllo",idControlloUfficiale);
			context.getRequest().setAttribute("idC",idC);

			org.aspcfs.modules.vigilanza.base.Ticket cu = new org.aspcfs.modules.vigilanza.base.Ticket();
			cu.queryRecord(db, Integer.parseInt(idC));
			context.getRequest().setAttribute("CU", cu);
			context.getRequest().setAttribute("id_asl",cu.getSiteId());
			
			LookupList SiteIdList = new LookupList(db, "lookup_site_id");
			SiteIdList.addItem(-1, "-- SELEZIONA VOCE --");
			SiteIdList.addItem(Constants.INVALID_SITE,  "-- TUTTI --");
			context.getRequest().setAttribute("SiteIdList", SiteIdList);
			
			
			LookupList ProvvedimentiBenessereMacellazione = new LookupList(db, "lookup_provvedimenti_benessere_macellazione");
			ProvvedimentiBenessereMacellazione.addItem(-1, "-- SELEZIONA UNA TIPOLOGIA BENESSERE--");
			context.getRequest().setAttribute("ProvvedimentiBenessereMacellazione", ProvvedimentiBenessereMacellazione);
			
			LookupList ProvvedimentiBenessereTrasporto = new LookupList(db, "lookup_provvedimenti_benessere_trasporto");
			ProvvedimentiBenessereTrasporto.addItem(-1, "-- SELEZIONA UNA TIPOLOGIA BENESSERE--");
			context.getRequest().setAttribute("ProvvedimentiBenessereTrasporto", ProvvedimentiBenessereTrasporto);


			newTic = new Ticket();
			
			//Ricerco le linee del controllo
			
			if (DatabaseUtils.getTipologiaPartizione(db, cu.getAltId())== Ticket.ALT_SINTESIS) {
				ArrayList<LineeAttivita> listaLineeCU = null;
				listaLineeCU = LineeAttivita.sin_load_linea_attivita_per_cu(idControlloUfficiale, db );
				//Ricerco le linee sull'anagrafica
				if (listaLineeCU.size()==0) 
					listaLineeCU = LineeAttivita.load_linee_attivita_per_alt_id_sintesis (String.valueOf(cu.getAltId()), db );
				context.getRequest().setAttribute("listaLineeCU", listaLineeCU);
			}
			else if (DatabaseUtils.getTipologiaPartizione(db, cu.getAltId())== Ticket.ALT_ANAGRAFICA_STABILIMENTI) {
				ArrayList<LineeAttivita> listaLineeCU = null;
				listaLineeCU = LineeAttivita.anagrafica_load_linea_attivita_per_cu(idControlloUfficiale, db );
				//Ricerco le linee sull'anagrafica
				if (listaLineeCU.size()==0) 
					listaLineeCU = LineeAttivita.load_linee_attivita_per_alt_id_anagrafica (String.valueOf(cu.getAltId()), db );
				context.getRequest().setAttribute("listaLineeCU", listaLineeCU);
			}

			//Ricerco gli operatori mercato associati al controllo
			ArrayList<SintesisOperatoreMercato> listaOperatoriMercatoCU = null;
			listaOperatoriMercatoCU = SintesisOperatoreMercato.load_operatori_mercato_per_cu(Integer.parseInt(idControlloUfficiale), db );
			context.getRequest().setAttribute("listaOperatoriMercatoCU", listaOperatoriMercatoCU);
			
			String currentDate = getCurrentDateAsString(context);
			context.getRequest().setAttribute("currentDate", currentDate);
			context.getRequest().setAttribute(
					"systemStatus", this.getSystemStatus(context));
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
			return ("SystemError");
		} 
		
		addModuleBean(context, "AddTicket", "Ticket Add");
		if (context.getRequest().getParameter("actionSource") != null) {
			context.getRequest().setAttribute("actionSource", context.getRequest().getParameter("actionSource"));
			return "AddTicketOK";
		}
		context.getRequest().setAttribute(
				"systemStatus", this.getSystemStatus(context));
		return ("AddOK");
	}

	public String executeCommandInsert(ActionContext context,Connection db) throws SQLException 
	{
		boolean recordInserted = false;
		boolean contactRecordInserted = false;
		boolean isValid = true;
		SystemStatus systemStatus = this.getSystemStatus(context);
		Ticket newTicket = null;
		Ticket newTic = (Ticket) context.getFormBean();
		UserBean user = (UserBean) context.getSession().getAttribute("User");
		
	    String ip = user.getUserRecord().getIp();
	    newTic.setIpEntered(ip);
	    newTic.setIpModified(ip);
		String site =  context.getRequest().getParameter("siteId");
		String idControllo = context.getRequest().getParameter("idControlloUfficiale");
		String idC = context.getRequest().getParameter("idC");
		String idCU = context.getRequest().getParameter("idC");
		context.getRequest().setAttribute("idIspezione", context.getRequest().getParameter("idIspezione"));
		context.getRequest().setAttribute("idC",idCU);
		context.getRequest().setAttribute("idIspezione", context.getRequest().getAttribute("idIspezione"));
		newTic.setNcFormaliValutazioni(context.getRequest().getParameter("nonConformitaFormali_valutazione"));
		newTic.setNcSignificativeValutazioni(context.getRequest().getParameter("nonConformitaSignificativeValuazione"));
		newTic.setNcGraviValutazioni(context.getRequest().getParameter("nonConformitaGraviValutazione"));
		
		if (context.getRequest().getParameter("idMacchinetta")!=null)
		{
			context.getRequest().setAttribute("idMacchinetta", context.getRequest().getParameter("idMacchinetta"));
		}
		else
		{
			context.getRequest().setAttribute("idMacchinetta", context.getRequest().getAttribute("idMacchinetta"));
		}

		 if(site.equals("201")){
				site = "AV";	
			}else if(site.equals("202")){
				site = "BN";
			}else if(site.equals("203")){
				site = "CE";
			}else if(site.equals("204")){
				site = "NA1";
			}else if(site.equals("205")){
				site = "NA2N";
			}else if(site.equals("206")){
				site = "NA3S";
			}else if(site.equals("207")){
				site = "SA";
			}else{
				 if(site.equals("16")){
						site = "FuoriRegione";
					}

				}

		newTic.setIdControlloUfficiale(context.getRequest().getParameter("idControlloUfficiale"));
		newTic.setTipo_richiesta( context.getRequest().getParameter( "tipo_richiesta" ) );
		newTic.setEnteredBy(getUserId(context));
		newTic.setModifiedBy(getUserId(context));

		try {

			LookupList SiteIdList = new LookupList(db, "lookup_site_id");
			SiteIdList.addItem(-1, "-- SELEZIONA VOCE --");
			context.getRequest().setAttribute("SiteIdList", SiteIdList);
			
			LookupList Provvedimenti = new LookupList(db, "lookup_provvedimenti");
			Provvedimenti.addItem(-1, "-- SELEZIONA UNA TIPOLOGIA DI NC --");
			Provvedimenti.removeElementByLevel(9);
			context.getRequest().setAttribute("Provvedimenti", Provvedimenti);
			if (newTic.getAltId() > 0) 
			{
				newTic.setAltId(Integer.parseInt(context.getParameter("altId")));
			}
			isValid = this.validateObject(context, db, newTic) && isValid;
			if (isValid) 
			{
				newTic.setTestoAppoggio("Inserimento"); 
				recordInserted = newTic.insert(db,context);
				}


			if (recordInserted) {
				
				boolean cuaggiornato = newTic.updateControllo(db, Integer.parseInt(idControllo));
				newTic.setPunteggio(context.getRequest().getParameter("punteggio"));
				org.aspcfs.modules.vigilanza.base.Ticket controlloUff = new org.aspcfs.modules.vigilanza.base.Ticket(db, Integer.parseInt(idC));
				int puntiV = controlloUff.getPunteggio();
				int puntiN = puntiV + newTic.getPunteggio();
				if(controlloUff.getTipoCampione()!=5)
				{
				controlloUff.setPunteggio(puntiN);
				controlloUff.update(db);
				}
				//Prepare the ticket for the response
				newTicket = new Ticket(db, newTic.getId());
				String elementi_formali 	= context.getRequest().getParameter("elementi_nc_formali");
				int num_elementi_formali 	= Integer.parseInt(elementi_formali) 	;
				int progressivo = 1;
				for (int i = 0 ; i <= num_elementi_formali-1;i++)
				{
					String note = context.getRequest().getParameter("nonConformitaFormali_"+(i+1));
					String nc = context.getRequest().getParameter("Provvedimenti1_"+(i+1)+"_selezionato");
					String ncBenessereMacellazione = context.getRequest().getParameter("ProvvedimentiBenessereMacellazione1_"+(i+1));
					String ncBenessereTrasporto = context.getRequest().getParameter("ProvvedimentiBenessereTrasporto1_"+(i+1));
					String idLineaNc = context.getRequest().getParameter("Linea1_"+(i+1));
					String idOperatoreMercatoNc = context.getRequest().getParameter("OperatoreMercato1_"+(i+1));


					if (!(nc!=null && nc.equals("-1")) && !note.equals(""))
					{
						newTicket.insertTipiNonConformita(db, nc,1, note,context.getRequest().getParameter("formali"), idLineaNc, ncBenessereMacellazione, ncBenessereTrasporto, idOperatoreMercatoNc);
						progressivo++ ;
					}
					
				}
				progressivo = 1;
				String elementi_signi 	= context.getRequest().getParameter("elementi_nc_significative");
				int num_elementi_signi 	= Integer.parseInt(elementi_signi) 	;
				for (int i = 0 ; i <= num_elementi_signi-1;i++)
				{
					String note = context.getRequest().getParameter("nonConformitaSignificative_"+(i+1));
					String nc = context.getRequest().getParameter("Provvedimenti2_"+(i+1)+"_selezionato");
					String ncBenessereMacellazione = context.getRequest().getParameter("ProvvedimentiBenessereMacellazione2_"+(i+1));
					String ncBenessereTrasporto = context.getRequest().getParameter("ProvvedimentiBenessereTrasporto2_"+(i+1));
					String idLineaNc = context.getRequest().getParameter("Linea2_"+(i+1));
					String idOperatoreMercatoNc = context.getRequest().getParameter("OperatoreMercato2_"+(i+1));

					if (!(nc!=null && nc.equals("-1")) && !note.equals(""))
					{
						newTicket.insertTipiNonConformita(db, nc, 2, note, context.getRequest().getParameter("formali"), idLineaNc, ncBenessereMacellazione, ncBenessereTrasporto, idOperatoreMercatoNc);
						progressivo++ ;
					}
					
				}
				progressivo = 1;
				String elementi_gravi 	= context.getRequest().getParameter("elementi_nc_gravi");
				int num_elementi_gravi 	= Integer.parseInt(elementi_gravi) 	;
				for (int i = 0 ; i <= num_elementi_gravi-1;i++)
				{
					String note = context.getRequest().getParameter("nonConformitaGravi_"+(i+1));
					String nc = context.getRequest().getParameter("Provvedimenti3_"+(i+1)+"_selezionato");
					String ncBenessereMacellazione = context.getRequest().getParameter("ProvvedimentiBenessereMacellazione3_"+(i+1));
					String ncBenessereTrasporto = context.getRequest().getParameter("ProvvedimentiBenessereTrasporto3_"+(i+1));
					String idLineaNc = context.getRequest().getParameter("Linea3_"+(i+1));
					String idOperatoreMercatoNc = context.getRequest().getParameter("OperatoreMercato3_"+(i+1));

					if (!(nc!=null && nc.equals("-1")) && !note.equals(""))
					{
						newTicket.insertTipiNonConformita(db, nc, 3, note, context.getRequest().getParameter("formali"), idLineaNc, ncBenessereMacellazione, ncBenessereTrasporto, idOperatoreMercatoNc);
						progressivo ++ ;
					}
					
				}
				//newTicket.delAttivitaAppese(db,context.getRequest().getParameter("formali"));
				context.getRequest().setAttribute("TicketDetails", newTicket);
				context.getRequest().setAttribute("altId", newTicket.getAltId());
				addRecentItem(context, newTicket);

				processInsertHook(context, newTicket);
			} else {
				if (newTic.getOrgId() != -1) {

					newTic.setCompanyName((String)context.getRequest().getAttribute("companyname"));
				}
			}
			

			context.getRequest().setAttribute("recordInserted", recordInserted);
			context.getRequest().setAttribute("isValid", isValid);

		
		} catch (Exception e) 
		{
			e.printStackTrace();
			context.getRequest().setAttribute("Error", e);
			return ("SystemError");
		} 
		addModuleBean(context, "ViewTickets", "Ticket Insert ok");
		return "-none-";
	}



	public String executeCommandTicketDetails(ActionContext context,Connection db){ 

		if(context.getRequest().getAttribute("Messaggio2")!=null)
		{

			context.getRequest().setAttribute("Messaggio2", context.getRequest().getAttribute("Messaggio2"));
		}
		if (context.getRequest().getParameter("idMacchinetta")!=null)
		{
			context.getRequest().setAttribute("idMacchinetta", context.getRequest().getParameter("idMacchinetta"));
		}
		else
		{
			context.getRequest().setAttribute("idMacchinetta", context.getRequest().getAttribute("idMacchinetta"));
		}
		//Parameters
		String ticketId = context.getRequest().getParameter("id");
		String tickId = context.getRequest().getParameter("ticketId");

		String idControlloUfficiale = context.getRequest().getParameter("idControllo");
		String idC = context.getRequest().getParameter("idC");
		context.getRequest().setAttribute("idControllo",
				idControlloUfficiale);
		context.getRequest().setAttribute("idC",
				idC);

		try {
			// Load the ticket
			Ticket newTic = new Ticket();
			SystemStatus systemStatus = this.getSystemStatus(context);
			newTic.setSystemStatus(systemStatus);
			
			if(tickId == null)
				newTic.queryRecord(db, Integer.parseInt(ticketId));
			else
				newTic.queryRecord(db, Integer.parseInt(tickId));

			if (tipoOperatore > 0)
				newTic.setTipologia_operatore(tipoOperatore);
			
			if (context.getRequest().getParameter("idIspezione")!=null)
			{
				context.getRequest().setAttribute("idIspezione", context.getRequest().getParameter("idIspezione"));
			}
			else
			{
				context.getRequest().setAttribute("idIspezione", context.getRequest().getAttribute("idIspezione"));
			}
			org.aspcfs.modules.vigilanza.base.Ticket cu = new org.aspcfs.modules.vigilanza.base.Ticket(db,Integer.parseInt(newTic.getIdControlloUfficiale()));
			context.getRequest().setAttribute("CU", cu);
			int passedId = newTic.getAltId();
			
			org.aspcfs.modules.sanzioni.base.TicketList sanzioniList = new org.aspcfs.modules.sanzioni.base.TicketList();
			int passId = newTic.getAltId();
			
			if(passId>0)
				passedId=passId;
			
			sanzioniList.setAltId(newTic.getAltId());
			sanzioniList.buildListControlliAlt(db, passId, ticketId,8);
			context.getRequest().setAttribute("SanzioniList", sanzioniList);

			org.aspcfs.modules.reati.base.TicketList reatiList = new org.aspcfs.modules.reati.base.TicketList();
			int passIdR = newTic.getAltId();
			reatiList.setAltId(newTic.getAltId());
			reatiList.buildListControlliAlt(db, passIdR, ticketId,8);
			context.getRequest().setAttribute("ReatiList", reatiList);


			org.aspcfs.modules.followup.base.TicketList followupList = new org.aspcfs.modules.followup.base.TicketList();
			int passIdF = newTic.getAltId();
			followupList.setAltId(newTic.getAltId());
			followupList.buildListControlliAlt(db, passIdF, ticketId,8);
			context.getRequest().setAttribute("FollowupList", followupList);

			org.aspcfs.modules.sequestri.base.TicketList seqList = new org.aspcfs.modules.sequestri.base.TicketList();
			int passIdS = newTic.getAltId();
			seqList.setAltId(newTic.getAltId());
			seqList.buildListControlliAlt(db, passIdS, ticketId,8);
			context.getRequest().setAttribute("SequestriList", seqList);

			 org.aspcfs.modules.diffida.base.TicketList difList = new org.aspcfs.modules.diffida.base.TicketList();
			 difList.setAltId(newTic.getAltId());
			 difList.buildListControlliAlt(db, passedId, ticketId);
			 context.getRequest().setAttribute("DiffideList", difList);
				
			LookupList SiteIdList = new LookupList(db, "lookup_site_id");
			SiteIdList.addItem(-1, "-- SELEZIONA VOCE --");
			context.getRequest().setAttribute("SiteIdList", SiteIdList);

			LookupList Provvedimenti = new LookupList(db, "lookup_provvedimenti");
			Provvedimenti.addItem(-1, "-- SELEZIONA UNA TIPOLOGIA DI NC --");
			Provvedimenti.removeElementByLevel(9);
			context.getRequest().setAttribute("Provvedimenti", Provvedimenti);
			
			LookupList ProvvedimentiBenessereMacellazione = new LookupList(db, "lookup_provvedimenti_benessere_macellazione");
			ProvvedimentiBenessereMacellazione.addItem(-1, "-- SELEZIONA UNA TIPOLOGIA BENESSERE--");
			context.getRequest().setAttribute("ProvvedimentiBenessereMacellazione", ProvvedimentiBenessereMacellazione);
			
			LookupList ProvvedimentiBenessereTrasporto = new LookupList(db, "lookup_provvedimenti_benessere_trasporto");
			ProvvedimentiBenessereTrasporto.addItem(-1, "-- SELEZIONA UNA TIPOLOGIA BENESSERE--");
			context.getRequest().setAttribute("ProvvedimentiBenessereTrasporto", ProvvedimentiBenessereTrasporto);


			LookupList NonConformitaAmministrative = new LookupList(db, "lookup_nonconformita_amministrative");
			NonConformitaAmministrative.addItem(-1, "-- SELEZIONA VOCE --");
			context.getRequest().setAttribute("NonConformitaAmministrative", NonConformitaAmministrative);

			LookupList NonConformitaPenali = new LookupList(db, "lookup_nonconformita_penali");
			NonConformitaPenali.addItem(-1, "-- SELEZIONA VOCE --");
			context.getRequest().setAttribute("NonConformitaPenali", NonConformitaPenali);

			LookupList NonConformita = new LookupList(db, "lookup_nonconformita");
			NonConformita.addItem(-1, "-- SELEZIONA VOCE --");
			context.getRequest().setAttribute("NonConformita", NonConformita);

			org.aspcfs.modules.vigilanza.base.Ticket CU = new org.aspcfs.modules.vigilanza.base.Ticket(db,Integer.parseInt(newTic.getIdControlloUfficiale()));
			context.getRequest().setAttribute("CU",CU);
			String id_controllo=newTic.getIdControlloUfficiale();

			while(id_controllo.startsWith("0")){

				id_controllo=id_controllo.substring(1);
			}
			 UserBean user = (UserBean)context.getSession().getAttribute("User");
			 String nameContext=context.getRequest().getServletContext().getServletContextName();
			 if (user.getUserRecord().getGruppo_ruolo()==Role.GRUPPO_ALTRE_AUTORITA )
				 context.getRequest().setAttribute("View", "AutoritaNonCompetenti");
			context.getRequest().setAttribute("idC", id_controllo);
			newTic.setPermission();
			context.getRequest().setAttribute("TicketDetails", newTic);
			
			//Ricerco le linee del controllo
			if (DatabaseUtils.getTipologiaPartizione(db, cu.getAltId())== Ticket.ALT_SINTESIS) {
				ArrayList<LineeAttivita> listaLineeCU = null;
				listaLineeCU = LineeAttivita.sin_load_linea_attivita_per_cu(newTic.getIdControlloUfficiale(), db );
				//Ricerco le linee sull'anagrafica
				if (listaLineeCU.size()==0) 
					listaLineeCU = LineeAttivita.load_linee_attivita_per_alt_id_sintesis (String.valueOf(cu.getAltId()), db );
				context.getRequest().setAttribute("listaLineeCU", listaLineeCU);
			}
			else if (DatabaseUtils.getTipologiaPartizione(db, cu.getAltId())== Ticket.ALT_ANAGRAFICA_STABILIMENTI) {
				ArrayList<LineeAttivita> listaLineeCU = null;
				listaLineeCU = LineeAttivita.anagrafica_load_linea_attivita_per_cu(newTic.getIdControlloUfficiale(), db );
				//Ricerco le linee sull'anagrafica
				if (listaLineeCU.size()==0) 
					listaLineeCU = LineeAttivita.load_linee_attivita_per_alt_id_anagrafica (String.valueOf(cu.getAltId()), db );
				context.getRequest().setAttribute("listaLineeCU", listaLineeCU);
			}
			
			//Ricerco gli operatori mercato associati al controllo
			ArrayList<SintesisOperatoreMercato> listaOperatoriMercatoCU = null;
			listaOperatoriMercatoCU = SintesisOperatoreMercato.load_operatori_mercato_per_cu(Integer.parseInt(newTic.getIdControlloUfficiale()), db );
			context.getRequest().setAttribute("listaOperatoriMercatoCU", listaOperatoriMercatoCU);

			addRecentItem(context, newTic);
			addModuleBean(context, "View Accounts", "View Tickets");
			// Reset any pagedLists since this could be a new visit to this ticket
			deletePagedListInfo(context, "AccountTicketsFolderInfo");
			deletePagedListInfo(context, "AccountTicketDocumentListInfo");
			deletePagedListInfo(context, "AccountTicketTaskListInfo");
			deletePagedListInfo(context, "accountTicketPlanWorkListInfo");

		} catch (Exception errorMessage) {
			context.getRequest().setAttribute("Error", errorMessage);
			errorMessage.printStackTrace();
			return ("SystemError");
		}
		//return getReturn(context, "TicketDetails");
		return "";
	}

	/**
	 * Loads the ticket for modification
	 *
	 * @param context Description of Parameter
	 * @return Description of the Returned Value
	 */
	public String executeCommandModifyTicket(ActionContext context,Connection db){

		Ticket newTic = new Ticket ();
		//Parameters
		String ticketId = context.getRequest().getParameter("id");
		SystemStatus systemStatus = this.getSystemStatus(context);
		try 
		{
			User user = this.getUser(context, this.getUserId(context));
			//Load the ticket
			
			if (context.getRequest().getParameter("idMacchinetta")!=null)
			{
				context.getRequest().setAttribute("idMacchinetta", context.getRequest().getParameter("idMacchinetta"));
			}
			else
			{
				context.getRequest().setAttribute("idMacchinetta", context.getRequest().getAttribute("idMacchinetta"));
			}
			LookupList macrocategorie = new LookupList(db, "lookup_ispezione_macrocategorie");
			
			context.getRequest().setAttribute("Macrocategorie", macrocategorie);
			String sql = "select ticketid from ticket where trashed_date is null and id_nonconformita = ?";
			PreparedStatement pst = db.prepareStatement(sql);
			pst.setInt(1,Integer.parseInt(ticketId));
			ResultSet rs = pst.executeQuery();
			String idAttivita = "" ;
			while (rs.next())
			{
				idAttivita +=rs.getInt(1)+";";
			}
			 if (user.getGruppo_ruolo()==Role.GRUPPO_ALTRE_AUTORITA )
				 context.getRequest().setAttribute("View", "AutoritaNonCompetenti");
			newTic.queryRecord(db, Integer.parseInt(ticketId));
			newTic.setSottoAttivita(idAttivita);
			context.getRequest().setAttribute("idIspezione", context.getRequest().getParameter("idIspezione"));
			
			String id =newTic.getIdControlloUfficiale();
			while(id.startsWith("0"))
			{
				id=id.substring(1);
			}
			String id_controllo = context.getRequest().getParameter("idC");
			while(id_controllo.startsWith("0"))
			{

				id_controllo=id_controllo.substring(1);
			}
			int passedId = newTic.getAltId();
			org.aspcfs.modules.sanzioni.base.TicketList sanzioniList = new org.aspcfs.modules.sanzioni.base.TicketList();
			int passId = newTic.getAltId();
			sanzioniList.setAltId(newTic.getAltId());
			sanzioniList.buildListControlliAlt(db, passId, ticketId,8);
			context.getRequest().setAttribute("SanzioniList", sanzioniList);

			org.aspcfs.modules.reati.base.TicketList reatiList = new org.aspcfs.modules.reati.base.TicketList();
			int passIdR = newTic.getAltId();
			reatiList.setAltId(newTic.getAltId());
			reatiList.buildListControlliAlt(db, passIdR, ticketId,8);
			context.getRequest().setAttribute("ReatiList", reatiList);


			
			org.aspcfs.modules.diffida.base.TicketList diffidaList = new org.aspcfs.modules.diffida.base.TicketList();
			passId = newTic.getAltId();
			diffidaList.setAltId(newTic.getAltId());
			diffidaList.buildListControlliAlt(db, passId, ticketId);
			context.getRequest().setAttribute("DiffidaList", diffidaList);
			
			org.aspcfs.modules.followup.base.TicketList followupList = new org.aspcfs.modules.followup.base.TicketList();
			int passIdF = newTic.getAltId();
			followupList.setAltId(newTic.getAltId());
			followupList.buildListControlliAlt(db, passIdF, ticketId,8);
			context.getRequest().setAttribute("FollowupList", followupList);

			org.aspcfs.modules.sequestri.base.TicketList seqList = new org.aspcfs.modules.sequestri.base.TicketList();
			int passIdS = newTic.getAltId();
			seqList.setAltId(newTic.getAltId());
			seqList.buildListControlliAlt(db, passIdS, ticketId,8);
			context.getRequest().setAttribute("SequestriList", seqList);
			String formali = "" ;
			String attivita_formali 		= "" ;
			String attivita_significative 	= "" ;
			String attivita_gravi 			= "" ;
			
			for (int i = 0 ; i<followupList.size(); i++)
			{
				
				formali += ((org.aspcfs.modules.followup.base.Ticket)followupList.get(i)).getId() + ";";
				if (((org.aspcfs.modules.followup.base.Ticket)followupList.get(i)).getTipo_nc()==1 )
				{
					attivita_formali += ((org.aspcfs.modules.followup.base.Ticket)followupList.get(i)).getId() + ";";
				}
				else
				{
					if (((org.aspcfs.modules.followup.base.Ticket)followupList.get(i)).getTipo_nc()==2 )
					{
						attivita_significative += ((org.aspcfs.modules.followup.base.Ticket)followupList.get(i)).getId() + ";";
					}
					else
					{
						if (((org.aspcfs.modules.followup.base.Ticket)followupList.get(i)).getTipo_nc()==3 )
						{
							attivita_gravi += ((org.aspcfs.modules.followup.base.Ticket)followupList.get(i)).getId() + "-fol;";
						}
					}
					
				}
			}
			
			for (int i = 0 ; i<diffidaList.size(); i++)
			{
				
				formali += ((org.aspcfs.modules.diffida.base.Ticket)diffidaList.get(i)).getId()+ ";";
				if (((org.aspcfs.modules.diffida.base.Ticket)diffidaList.get(i)).getTipo_nc()== 3 )
				{
					attivita_gravi += ((org.aspcfs.modules.diffida.base.Ticket)diffidaList.get(i)).getId() + "-dif;";
				}
				
			}
			
			for (int i = 0 ; i<sanzioniList.size(); i++)
			{
				
				formali += ((org.aspcfs.modules.sanzioni.base.Ticket)sanzioniList.get(i)).getId()+ ";";
				if (((org.aspcfs.modules.sanzioni.base.Ticket)sanzioniList.get(i)).getTipo_nc()== 3 )
				{
					attivita_gravi += ((org.aspcfs.modules.sanzioni.base.Ticket)sanzioniList.get(i)).getId() + "-san;";
				}
				
			}
			for (int i = 0 ; i<reatiList.size(); i++)
			{
				
				formali += ((org.aspcfs.modules.reati.base.Ticket)reatiList.get(i)).getId()+ ";";
				if (((org.aspcfs.modules.reati.base.Ticket)reatiList.get(i)).getTipo_nc()== 3 )
				{
					attivita_gravi += ((org.aspcfs.modules.reati.base.Ticket)reatiList.get(i)).getId() + "-rea;";
				}
			}
			for (int i = 0 ; i<seqList.size(); i++)
			{
				
				formali += ((org.aspcfs.modules.sequestri.base.Ticket)seqList.get(i)).getId()+ ";";
				if (((org.aspcfs.modules.sequestri.base.Ticket)seqList.get(i)).getTipo_nc()== 3 )
				{
					attivita_gravi += ((org.aspcfs.modules.sequestri.base.Ticket)seqList.get(i)).getId() + "-seq;";
				}
			}
			if (!formali.equals(""))
				formali = formali.substring(0, formali.length()-1);
			
			context.getRequest().setAttribute("Formali", formali);
			
			if (!attivita_formali.equals(""))
				attivita_formali 				= attivita_formali.substring(0,attivita_formali.length()-1);
			
			if (!attivita_significative.equals(""))
				attivita_significative 			= attivita_significative.substring(0,attivita_significative.length()-1);
			
			if (!attivita_gravi.equals(""))
				attivita_gravi 					= attivita_gravi.substring(0,attivita_gravi.length()-1);
			context.getRequest().setAttribute("attivita_formali", attivita_formali);
			context.getRequest().setAttribute("attivita_significative", attivita_significative);
			context.getRequest().setAttribute("attivita_gravi", attivita_gravi);
			String abilita_formali 			= "false";
			String abilita_significative 	= "false";
			String abilita_gravi 			= "false";
			if (newTic.getNon_conformita_formali().size()>=1 && newTic.getNon_conformita_formali().get(0).getId_nc()!=-1 && newTic.getNon_conformita_formali().get(0).getId_nc()!=0)
			{
				abilita_formali = "true";
			}
			if (newTic.getNon_conformita_significative().size()>=1 && newTic.getNon_conformita_significative().get(0).getId_nc()!=-1 && newTic.getNon_conformita_significative().get(0).getId_nc()!=0)
			{
				abilita_significative = "true";
			}
			if (newTic.getNon_conformita_gravi().size()>=1 && newTic.getNon_conformita_gravi().get(0).getId_nc()!=-1 && newTic.getNon_conformita_gravi().get(0).getId_nc()!=0)
			{
				abilita_gravi = "true";
			}
			
			context.getRequest().setAttribute("abilita_formali", abilita_formali);
			context.getRequest().setAttribute("abilita_significative", abilita_significative);
			context.getRequest().setAttribute("abilita_gravi", abilita_gravi);

			org.aspcfs.modules.vigilanza.base.Ticket CU = new org.aspcfs.modules.vigilanza.base.Ticket(db,Integer.parseInt(id));
			context.getRequest().setAttribute("idIspezione",""+CU.getTipoIspezione());

			context.getRequest().setAttribute("idC", id_controllo);
		
			LookupList Provvedimenti = new LookupList(db, "lookup_provvedimenti");
			Provvedimenti.addItem(-1, "-- SELEZIONA UNA TIPOLOGIA DI NC --");
			Provvedimenti.removeElementByLevel(9);
			context.getRequest().setAttribute("Provvedimenti", Provvedimenti);
			
			LookupList ProvvedimentiBenessereMacellazione = new LookupList(db, "lookup_provvedimenti_benessere_macellazione");
			ProvvedimentiBenessereMacellazione.addItem(-1, "-- SELEZIONA UNA TIPOLOGIA BENESSERE--");
			context.getRequest().setAttribute("ProvvedimentiBenessereMacellazione", ProvvedimentiBenessereMacellazione);
			
			LookupList ProvvedimentiBenessereTrasporto = new LookupList(db, "lookup_provvedimenti_benessere_trasporto");
			ProvvedimentiBenessereTrasporto.addItem(-1, "-- SELEZIONA UNA TIPOLOGIA BENESSERE--");
			context.getRequest().setAttribute("ProvvedimentiBenessereTrasporto", ProvvedimentiBenessereTrasporto);
		
		
			LookupList NonConformitaAmministrative = new LookupList(db, "lookup_nonconformita_amministrative");
			NonConformitaAmministrative.addItem(-1, "-- SELEZIONA VOCE --");
			context.getRequest().setAttribute("NonConformitaAmministrative", NonConformitaAmministrative);
			
			LookupList NonConformitaPenali = new LookupList(db, "lookup_nonconformita_penali");
			NonConformitaPenali.addItem(-1, "-- SELEZIONA VOCE --");
			context.getRequest().setAttribute("NonConformitaPenali", NonConformitaPenali);
			
			LookupList NonConformita = new LookupList(db, "lookup_nonconformita");
			NonConformita.addItem(-1, "-- SELEZIONA VOCE --");
			context.getRequest().setAttribute("NonConformita", NonConformita);

			LookupList SiteIdList = new LookupList(db, "lookup_site_id");
			SiteIdList.addItem(-1, "-- SELEZIONA VOCE --");
			SiteIdList.addItem(Constants.INVALID_SITE,  "-- TUTTI --");
			context.getRequest().setAttribute("SiteIdList", SiteIdList);
			//Put the ticket in the request
			addRecentItem(context, newTic);
			context.getRequest().setAttribute("TicketDetails", newTic);
			addModuleBean(context, "View Accounts", "View Tickets");

			//getting current date in mm/dd/yyyy format
			String currentDate = getCurrentDateAsString(context);
			context.getRequest().setAttribute("currentDate", currentDate);
			org.aspcfs.modules.vigilanza.base.Ticket cu = new org.aspcfs.modules.vigilanza.base.Ticket();
			cu.queryRecord(db, Integer.parseInt(id_controllo));
			context.getRequest().setAttribute("CU", cu);
			
			
			//Ricerco le linee del controllo
			if (DatabaseUtils.getTipologiaPartizione(db, cu.getAltId())== Ticket.ALT_SINTESIS) {
				ArrayList<LineeAttivita> listaLineeCU = null;
				listaLineeCU = LineeAttivita.sin_load_linea_attivita_per_cu(newTic.getIdControlloUfficiale(), db );
				//Ricerco le linee sull'anagrafica
				if (listaLineeCU.size()==0) 
					listaLineeCU = LineeAttivita.load_linee_attivita_per_alt_id_sintesis (String.valueOf(cu.getAltId()), db );
				context.getRequest().setAttribute("listaLineeCU", listaLineeCU);
			}
			else if (DatabaseUtils.getTipologiaPartizione(db, cu.getAltId())== Ticket.ALT_ANAGRAFICA_STABILIMENTI) {
				ArrayList<LineeAttivita> listaLineeCU = null;
				listaLineeCU = LineeAttivita.anagrafica_load_linea_attivita_per_cu(newTic.getIdControlloUfficiale(), db );
				//Ricerco le linee sull'anagrafica
				if (listaLineeCU.size()==0) 
					listaLineeCU = LineeAttivita.load_linee_attivita_per_alt_id_anagrafica (String.valueOf(cu.getAltId()), db );
				context.getRequest().setAttribute("listaLineeCU", listaLineeCU);
			}
			
			//Ricerco gli operatori mercato associati al controllo
			ArrayList<SintesisOperatoreMercato> listaOperatoriMercatoCU = null;
			listaOperatoriMercatoCU = SintesisOperatoreMercato.load_operatori_mercato_per_cu(Integer.parseInt(newTic.getIdControlloUfficiale()), db );
			context.getRequest().setAttribute("listaOperatoriMercatoCU", listaOperatoriMercatoCU);

		} catch (Exception errorMessage) {
			errorMessage.printStackTrace();
			context.getRequest().setAttribute("Error", errorMessage);
			errorMessage.printStackTrace();
			return ("SystemError");
		} 
		return "";

	}

	public String executeCommandUpdateTicket(ActionContext context,Connection db){

		int resultCount = 0;

		int catCount = 0;
		
		boolean catInserted = false;
		boolean isValid = true;
		if (context.getRequest().getParameter("idMacchinetta")!=null)
		{
			context.getRequest().setAttribute("idMacchinetta", context.getRequest().getParameter("idMacchinetta"));
		}
		else
		{
			context.getRequest().setAttribute("idMacchinetta", context.getRequest().getAttribute("idMacchinetta"));
		}
		Ticket newTic = (Ticket) context.getFormBean();
		UserBean user = (UserBean) context.getSession().getAttribute("User");
	    String ip = user.getUserRecord().getIp();
	    newTic.setIpEntered(ip);
	    newTic.setIpModified(ip);
		newTic.setTipo_richiesta( context.getRequest().getParameter( "tipo_richiesta" ) );
		newTic.setNcFormaliValutazioni(context.getRequest().getParameter("nonConformitaFormali_valutazione"));
		newTic.setNcSignificativeValutazioni(context.getRequest().getParameter("nonConformitaSignificativeValuazione"));
		newTic.setIdentificativo(context.getRequest().getParameter("identificativoNC"));
		newTic.setNcGraviValutazioni(context.getRequest().getParameter("nonConformitaGraviValutazione"));
		
		

		try {

			Ticket oldTic = new Ticket(db, newTic.getId());
			SystemStatus systemStatus = this.getSystemStatus(context);
			context.getRequest().setAttribute("idIspezione", context.getRequest().getParameter("idIspezione"));
			//Get the previousTicket, update the ticket, then send both to a hook
			Ticket previousTicket = new Ticket(db, Integer.parseInt(context.getParameter("id")));
			newTic.setModifiedBy(getUserId(context));
			
			newTic.setSiteId(Integer.parseInt(context.getRequest().getParameter("siteId")));
			isValid = this.validateObject(context, db, newTic) && isValid;
			if (isValid) {
				newTic.setTestoAppoggio("Modifica"); //aggiunto da d.dauria  
				resultCount = newTic.update(db);
				newTic.delAllNc(db);
				String elementi_formali 	= context.getRequest().getParameter("elementi_nc_formali");
				int num_elementi_formali 	= Integer.parseInt(elementi_formali) 	;
				int progressivo = 1;
				for (int i = 0 ; i <= num_elementi_formali-1;i++)
				{
					String note = context.getRequest().getParameter("nonConformitaFormali_"+(i+1));
					String nc = context.getRequest().getParameter("Provvedimenti1_"+(i+1)+"_selezionato");
					String ncBenessereMacellazione = context.getRequest().getParameter("ProvvedimentiBenessereMacellazione1_"+(i+1));
					String ncBenessereTrasporto = context.getRequest().getParameter("ProvvedimentiBenessereTrasporto1_"+(i+1));
					String idLineaNc = context.getRequest().getParameter("Linea1_"+(i+1));
					String idOperatoreMercatoNc = context.getRequest().getParameter("OperatoreMercato1_"+(i+1));

					if (!(nc!=null && nc.equals("-1")) && !note.equals(""))
					{
						oldTic.insertTipiNonConformita(db, nc,1, note,context.getRequest().getParameter("formali"), idLineaNc, ncBenessereMacellazione, ncBenessereTrasporto, idOperatoreMercatoNc);
						progressivo++ ;
					}
					
				}
				progressivo = 1;
				String elementi_signi 	= context.getRequest().getParameter("elementi_nc_significative");
				int num_elementi_signi 	= Integer.parseInt(elementi_signi) 	;
				for (int i = 0 ; i <= num_elementi_signi-1;i++)
				{
					String note = context.getRequest().getParameter("nonConformitaSignificative_"+(i+1));
					String nc = context.getRequest().getParameter("Provvedimenti2_"+(i+1)+"_selezionato");
					String ncBenessereMacellazione = context.getRequest().getParameter("ProvvedimentiBenessereMacellazione2_"+(i+1));
					String ncBenessereTrasporto = context.getRequest().getParameter("ProvvedimentiBenessereTrasporto2_"+(i+1));
					String idLineaNc = context.getRequest().getParameter("Linea2_"+(i+1));
					String idOperatoreMercatoNc = context.getRequest().getParameter("OperatoreMercato2_"+(i+1));

					if (!(nc!=null && nc.equals("-1")) && !note.equals(""))
					{
						oldTic.insertTipiNonConformita(db, nc, 2, note, context.getRequest().getParameter("formali"), idLineaNc, ncBenessereMacellazione, ncBenessereTrasporto, idOperatoreMercatoNc);
						progressivo++ ;
					}
					
				}
				progressivo = 1;
				String elementi_gravi 	= context.getRequest().getParameter("elementi_nc_gravi");
				int num_elementi_gravi 	= Integer.parseInt(elementi_gravi) 	;
				for (int i = 0 ; i <= num_elementi_gravi-1;i++)
				{
					String note = context.getRequest().getParameter("nonConformitaGravi_"+(i+1));
					String nc = context.getRequest().getParameter("Provvedimenti3_"+(i+1)+"_selezionato");
					String ncBenessereMacellazione = context.getRequest().getParameter("ProvvedimentiBenessereMacellazione3_"+(i+1));
					String ncBenessereTrasporto = context.getRequest().getParameter("ProvvedimentiBenessereTrasporto3_"+(i+1));
					String idLineaNc = context.getRequest().getParameter("Linea3_"+(i+1));
					String idOperatoreMercatoNc = context.getRequest().getParameter("OperatoreMercato3_"+(i+1));

					if (!(nc!=null && nc.equals("-1")) && !note.equals(""))
					{
						oldTic.insertTipiNonConformita(db, nc, 3, note, context.getRequest().getParameter("formali"), idLineaNc, ncBenessereMacellazione, ncBenessereTrasporto, idOperatoreMercatoNc);
						progressivo ++ ;
					}
					
				}
				

			}

			if (resultCount == 1) {
				newTic.queryRecord(db, newTic.getId());
				processUpdateHook(context, previousTicket, newTic);
			
			}



		} catch (Exception e) {
			context.getRequest().setAttribute("Error", e);
			return ("SystemError");
		}


		return "";
	}

	public String executeCommandChiudi(ActionContext context,Connection db)
	{
		

		int resultCount = -1;
		Ticket thisTicket = null;
		try {
			thisTicket = new Ticket(
					db, Integer.parseInt(context.getRequest().getParameter("id")));
			Ticket oldTicket = new Ticket(db, thisTicket.getId());
						String ticketId = context.getRequest().getParameter("id");

			int passedId = thisTicket.getAltId();
			org.aspcfs.modules.sanzioni.base.TicketList sanzioniList = new org.aspcfs.modules.sanzioni.base.TicketList();
			int passId = thisTicket.getAltId();
			sanzioniList.setAltId(thisTicket.getAltId());
			sanzioniList.buildListControlliAlt(db, passId, ticketId,8);
			context.getRequest().setAttribute("SanzioniList", sanzioniList);

			org.aspcfs.modules.reati.base.TicketList reatiList = new org.aspcfs.modules.reati.base.TicketList();
			int passIdR = thisTicket.getAltId();
			reatiList.setAltId(passedId);
			reatiList.buildListControlliAlt(db, passIdR, ticketId,8);
			context.getRequest().setAttribute("ReatiList", reatiList);


			org.aspcfs.modules.followup.base.TicketList followupList = new org.aspcfs.modules.followup.base.TicketList();
			int passIdF = thisTicket.getAltId();
			followupList.setAltId(passedId);
			followupList.buildListControlliAlt(db, passIdF, ticketId,8);
			context.getRequest().setAttribute("FollowupList", followupList);

			org.aspcfs.modules.sequestri.base.TicketList seqList = new org.aspcfs.modules.sequestri.base.TicketList();
			int passIdS = thisTicket.getAltId();
			seqList.setAltId(passedId);
			seqList.buildListControlliAlt(db, passIdS, ticketId,8);
			context.getRequest().setAttribute("SequestriList", seqList);
			
			org.aspcfs.modules.diffida.base.TicketList diffidaList = new org.aspcfs.modules.diffida.base.TicketList();
			diffidaList.setAltId(passedId);
			diffidaList.buildListControlliAlt(db, passIdS, ticketId);
			context.getRequest().setAttribute("DiffideList", diffidaList);
			
			Iterator sanzionilIterator=sanzioniList.iterator();
			Iterator seqlIterator=seqList.iterator();
			Iterator reatilIterator=reatiList.iterator();
			Iterator followupIterator=followupList.iterator();
			Iterator diffideIterator =diffidaList.iterator();
			

			int flag=0;
			int numSottoAttivita = 0;
			if(! thisTicket.getNon_conformita_gravi().isEmpty())
			{
			
			while(sanzionilIterator.hasNext()){

				org.aspcfs.modules.sanzioni.base.Ticket tic = (org.aspcfs.modules.sanzioni.base.Ticket) sanzionilIterator.next();
				numSottoAttivita ++ ;
				if(tic.getClosed()==null){
					flag=1;

					break;

				}

			}

			while(reatilIterator.hasNext()){
				numSottoAttivita ++ ;
				org.aspcfs.modules.reati.base.Ticket tic = (org.aspcfs.modules.reati.base.Ticket) reatilIterator.next();

				if(tic.getClosed()==null){
					flag=1;
					break;

				}


			}
			
			while(diffideIterator.hasNext()){

				org.aspcfs.modules.diffida.base.Ticket tic = (org.aspcfs.modules.diffida.base.Ticket) diffideIterator.next();
				numSottoAttivita ++ ;
				if(tic.getClosed()==null){
					flag=1;

					break;

				}
			}
			

			while(seqlIterator.hasNext()){
				numSottoAttivita ++ ;
				org.aspcfs.modules.sequestri.base.Ticket tic = (org.aspcfs.modules.sequestri.base.Ticket) seqlIterator.next();
				if(tic.getClosed()==null){
					flag=1;
					break;

				}

			}

			while(followupIterator.hasNext()){
				numSottoAttivita ++ ;
				org.aspcfs.modules.followup.base.Ticket tic = (org.aspcfs.modules.followup.base.Ticket) followupIterator.next();
				if(tic.getClosed()==null){
					flag=1;

					break;
				}
			}
			
		

			}
			



			context.getRequest().setAttribute("flag", flag);
			if(flag==1  ){
				context.getRequest().setAttribute("Chiudi", "1");
				return "";

			}

			if(numSottoAttivita == 0 ){

				context.getRequest().setAttribute("numSottoAttivita", 0);
				return "";

			}
			else
			{
				context.getRequest().setAttribute("numSottoAttivita", numSottoAttivita);
			}


			thisTicket.setModifiedBy(getUserId(context));
			resultCount = thisTicket.chiudi(db);
			context.getRequest().setAttribute("resultCount",resultCount);

			String id_controllo=thisTicket.getIdControlloUfficiale();
			while(id_controllo.startsWith("0")){

				id_controllo=id_controllo.substring(1);
			}

			context.getRequest().setAttribute("idC", id_controllo);


			org.aspcfs.modules.vigilanza.base.Ticket thisTicketV = new org.aspcfs.modules.vigilanza.base.Ticket(
					db, Integer.parseInt(id_controllo));

			org.aspcfs.modules.campioni.base.TicketList ticList = new org.aspcfs.modules.campioni.base.TicketList();
			int passedId1 = thisTicketV.getAltId();
			ticList.setAltId(passedId1);
			ticList.buildListControlliAlt(db, passedId, id_controllo);


			org.aspcfs.modules.tamponi.base.TicketList tamponiList = new org.aspcfs.modules.tamponi.base.TicketList();
			int pasId = thisTicketV.getAltId();
			tamponiList.setAltId(passedId1);
			tamponiList.buildListControlliAlt(db, pasId, id_controllo);




			Iterator campioniIterator=ticList.iterator();
			Iterator tamponiIterator=tamponiList.iterator();



			int flag1=0;
			while(campioniIterator.hasNext()){

				org.aspcfs.modules.campioni.base.Ticket tic = (org.aspcfs.modules.campioni.base.Ticket) campioniIterator.next();

				if(tic.getClosed()==null){
					flag1=1;

					break;

				}

			}


			while(tamponiIterator.hasNext()){

				org.aspcfs.modules.tamponi.base.Ticket tic = (org.aspcfs.modules.tamponi.base.Ticket) tamponiIterator.next();

				if(tic.getClosed()==null){
					flag1=1;

					break;
				}

			}


			if(thisTicketV.isNcrilevate()==true){
				org.aspcfs.modules.nonconformita.base.TicketList nonCList = new org.aspcfs.modules.nonconformita.base.TicketList();
				int passIdN = thisTicketV.getAltId();
				nonCList.setAltId(passedId);
				nonCList.buildListControlliAlt(db, passIdN, id_controllo);

				Iterator ncIterator=nonCList.iterator();

				while(ncIterator.hasNext()){

					org.aspcfs.modules.nonconformita.base.Ticket tic = (org.aspcfs.modules.nonconformita.base.Ticket) ncIterator.next();

					if(tic.getClosed()==null){
						flag1=1;

						break;

					}

				}

			}



			if(thisTicketV.getTipoCampione()==5){

				org.aspcfs.modules.audit.base.AuditList audit = new org.aspcfs.modules.audit.base.AuditList();
				int AuditOrgId = thisTicketV.getOrgId();
				String idTi = thisTicketV.getPaddedId();
				audit.setOrgId(AuditOrgId);
				if(thisTicketV.getIdApiario() > 0){
					AuditOrgId=thisTicketV.getIdApiario();
				}
				
				audit.buildListControlli(db, AuditOrgId, idTi);

				Iterator itAudit=audit.iterator();

				if(!itAudit.hasNext()){

					flag=2;

				}else{

					while(itAudit.hasNext()){

						org.aspcfs.modules.audit.base.Audit auditTemp = (org.aspcfs.modules.audit.base.Audit) itAudit.next();

						if(thisTicketV.isCategoriaisAggiornata()==false){
							flag=2;

							break;

						}

					}}
			}



			String attivitaCollegate=context.getRequest().getParameter("altro");
			context.getRequest().setAttribute("attivitaCollegate", attivitaCollegate);
			if(attivitaCollegate==null){
				if(flag==1 || flag==2){
					context.getRequest().setAttribute("Chiudi", ""+flag);
					return "";

				}
			}



			String chiudiCu = context.getRequest().getParameter("chiudiCu");
			if(flag1==0 ){
				if(chiudiCu !=null)
				{
					thisTicketV.setModifiedBy(getUserId(context));
					resultCount = thisTicketV.chiudi(db);
				}else
				{
					context.getRequest().setAttribute("Messaggio2", "Attivita collegate al cu chiuse");
				}
			}

			context.getRequest().setAttribute("resultCount", resultCount);


			 if (resultCount == -1) {
				 return "";
			 } else if (resultCount == 1) {
				 thisTicket.queryRecord(db, thisTicket.getId());
				 this.processUpdateHook(context, oldTicket, thisTicket);
				 return "";
			 }
		} catch (Exception errorMessage) {
			errorMessage.printStackTrace();
			context.getRequest().setAttribute("Error", errorMessage);
			return ("SystemError");
		} 
		context.getRequest().setAttribute("Error", NOT_UPDATED_MESSAGE);
		return ("UserError");


	}
}
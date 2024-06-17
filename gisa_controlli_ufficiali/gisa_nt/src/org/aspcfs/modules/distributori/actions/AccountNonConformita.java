/*
 *  Copyright(c) 2004 Dark Horse Ventures LLC (http://www.centriccrm.com/) All
 *  rights reserved. This material cannot be distributed without written
 *  permission from Dark Horse Ventures LLC. Permission to use, copy, and modify
 *  this material for internal use is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies. DARK HORSE
 *  VENTURES LLC MAKES NO REPRESENTATIONS AND EXTENDS NO WARRANTIES, EXPRESS OR
 *  IMPLIED, WITH RESPECT TO THE SOFTWARE, INCLUDING, BUT NOT LIMITED TO, THE
 *  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR ANY PARTICULAR
 *  PURPOSE, AND THE WARRANTY AGAINST INFRINGEMENT OF PATENTS OR OTHER
 *  INTELLECTUAL PROPERTY RIGHTS. THE SOFTWARE IS PROVIDED "AS IS", AND IN NO
 *  EVENT SHALL DARK HORSE VENTURES LLC OR ANY OF ITS AFFILIATES BE LIABLE FOR
 *  ANY DAMAGES, INCLUDING ANY LOST PROFITS OR OTHER INCIDENTAL OR CONSEQUENTIAL
 *  DAMAGES RELATING TO THE SOFTWARE.
 */
package org.aspcfs.modules.distributori.actions;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Iterator;

import org.aspcfs.controller.SystemStatus;
import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.base.DependencyList;
import org.aspcfs.modules.distributori.base.Distrubutore;
import org.aspcfs.modules.distributori.base.Organization;
import org.aspcfs.modules.nonconformita.base.Ticket;
import org.aspcfs.utils.web.HtmlDialog;
import org.aspcfs.utils.web.LookupList;
import org.aspcfs.utils.web.RequestUtils;

import com.darkhorseventures.framework.actions.ActionContext;

/**
 * Maintains Tickets related to an Account
 *
 * @author chris
 * @version $Id: AccountTickets.java,v 1.13 2002/12/24 14:53:03 mrajkowski Exp
 *          $
 * @created August 15, 2001
 */
public final class AccountNonConformita extends CFSModule {

  /**
   * Sample action for prototyping, by including a specified page
   *
   * @param context Description of Parameter
   * @return Description of the Returned Value
   */
  public String executeCommandDefault(ActionContext context) {
    String module = context.getRequest().getParameter("module");
    String includePage = context.getRequest().getParameter("include");
    context.getRequest().setAttribute("IncludePage", includePage);
    addModuleBean(context, module, module);
    return getReturn(context, "Include");
  }
  
  /**
   * Re-opens a ticket
   *
   * @param context Description of the Parameter
   * @return Description of the Return Value
   */
  public String executeCommandReopenTicket(ActionContext context) {
    if (!hasPermission(context, "distributori-distributori-nonconformita-edit")) {
      return ("PermissionError");
    }
    int resultCount = -1;
    Connection db = null;
    Ticket thisTicket = null;
    Ticket oldTicket = null;
    try {
      db = this.getConnection(context);
      thisTicket = new Ticket(
          db, Integer.parseInt(context.getRequest().getParameter("id")));
      oldTicket = new Ticket(db, thisTicket.getId());
      //check permission to record
      if (!isRecordAccessPermitted(context, db, thisTicket.getOrgId())) {
        return ("PermissionError");
      }
      thisTicket.setModifiedBy(getUserId(context));
      resultCount = thisTicket.reopen(db);
      thisTicket.queryRecord(db, thisTicket.getId());
 context.getRequest().setAttribute("idMacchinetta", context.getRequest().getParameter("idMacchinetta"));
      
      Distrubutore d=new Distrubutore();
      Distrubutore dd=d.loadDistributore(thisTicket.getOrgId(), Integer.parseInt(context.getRequest().getParameter("idMacchinetta")), db);
      
      if(dd!=null){
    	 
    	  context.getRequest().setAttribute("aslMacchinetta",""+dd.getAslMacchinetta());
    	  
      }
    } catch (Exception errorMessage) {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    if (resultCount == -1) {
      return (executeCommandTicketDetails(context));
    } else if (resultCount == 1) {
      this.processUpdateHook(context, oldTicket, thisTicket);
      return (executeCommandTicketDetails(context));
    } else {
      context.getRequest().setAttribute("Error", NOT_UPDATED_MESSAGE);
      return ("UserError");
    }
  }


  /**
   * Prepares a ticket form
   *
   * @param context Description of Parameter
   * @return Description of the Returned Value
   */
  public String executeCommandAddTicket(ActionContext context) {
    if (!hasPermission(context, "distributori-distributori-nonconformita-add")) {
      return ("PermissionError");
    }
    
    if(context.getRequest().getParameter("idMacchinetta")!=null)
		context.getRequest().setAttribute("idMacchinetta", context.getRequest().getParameter("idMacchinetta"));
		else
			context.getRequest().setAttribute("idMacchinetta", context.getRequest().getAttribute("idMacchinetta"));
    Connection db = null;
    Ticket newTic = null;
    Organization newOrg = null;
    String retPag = "";
    //Parameters
    String temporgId = context.getRequest().getParameter("orgId");
    int tempid = Integer.parseInt(temporgId);
    try {
      db = this.getConnection(context);
      //find record permissions for portal users
      if (!isRecordAccessPermitted(context, db, tempid)) {
        return ("PermissionError");
      }
      //Organization for header
      newOrg = new Organization(db, tempid);
      //Ticket
      newTic = (Ticket) context.getFormBean();
      if (context.getRequest().getParameter("refresh") != null ||
          (context.getRequest().getParameter("contact") != null &&
              context.getRequest().getParameter("contact").equals("on"))) {
      } else {
        newTic.setOrgId(tempid);
      }
      addModuleBean(context, "View Accounts", "Add a Ticket");
      context.getRequest().setAttribute("OrgDetails", newOrg);

      //getting current date in mm/dd/yyyy format
      String currentDate = getCurrentDateAsString(context);
      context.getRequest().setAttribute("currentDate", currentDate);
      context.getRequest().setAttribute(
          "systemStatus", this.getSystemStatus(context));
      String tipo_richiesta = context.getRequest().getParameter( "tipo_richiesta" );
      retPag = "Add_" + tipo_richiesta + "OK";
    } catch (Exception errorMessage) {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    //return getReturn(context, "AddTicket");
    return retPag;
  }


  /**
   * Inserts a submitted ticket
   *
   * @param context Description of Parameter
   * @return Description of the Returned Value
 * @throws SQLException 
   */
  public String executeCommandInsertTicket(ActionContext context) throws SQLException {
	  if (!hasPermission(context, "distributori-distributori-nonconformita-add")) {
		  return ("PermissionError");
	  }
	  int idMacc=-1;
	  if(context.getRequest().getParameter("idMacchinetta")!=null){
		  context.getRequest().setAttribute("idMacchinetta", context.getRequest().getParameter("idMacchinetta"));
		  idMacc=Integer.parseInt(context.getRequest().getParameter("idMacchinetta"));
	  }	else
		  context.getRequest().setAttribute("idMacchinetta", context.getRequest().getAttribute("idMacchinetta"));
	  Connection db = null ;
	  boolean recordInserted = false ;
	  try { db = this.getConnection(context);
		  org.aspcfs.modules.nonconformita.actions.AccountNonConformita nonConformita = new org.aspcfs.modules.nonconformita.actions.AccountNonConformita();
		  nonConformita.executeCommandInsert(context,db);
		 

		  String temporgId = context.getRequest().getParameter("orgId");
		  int tempid = Integer.parseInt(temporgId);
		  Organization newOrg = new Organization(db, tempid);
		  context.getRequest().setAttribute("OrgDetails", newOrg);

	  } catch (Exception e) {
		  context.getRequest().setAttribute("Error", e);
		  return ("SystemError");
	  } finally {
		  this.freeConnection(context, db);
	  }
	  if (recordInserted) {
		  String tipoRichiesta = (String) context.getRequest().getAttribute("TipoRichiesta");
		  return "Details_" + tipoRichiesta + "OK";
	  }
	  return (executeCommandAddTicket(context));
  }


  /**
   * Load the ticket details tab
   *
   * @param context Description of Parameter
   * @return Description of the Returned Value
   */
  public String executeCommandTicketDetails(ActionContext context) {
	  if (!hasPermission(context, "distributori-distributori-nonconformita-view")) {
		  return ("PermissionError");
	  }
	  int idMacc=-1;
	  if(context.getRequest().getParameter("idMacchinetta")!=null && ! "null".equals(context.getRequest().getParameter("idMacchinetta"))){
		  context.getRequest().setAttribute("idMacchinetta", context.getRequest().getParameter("idMacchinetta"));
		  idMacc=Integer.parseInt(context.getRequest().getParameter("idMacchinetta") );

	  }	else
		  context.getRequest().setAttribute("idMacchinetta", context.getRequest().getAttribute("idMacchinetta"));
	  Connection db = null;

	  String retPag = null;
	  try {
		  db = this.getConnection(context);
		  org.aspcfs.modules.nonconformita.actions.AccountNonConformita nonconformita = new org.aspcfs.modules.nonconformita.actions.AccountNonConformita();
		  nonconformita.executeCommandTicketDetails(context,db);
		  Ticket newTic = (Ticket)context.getRequest().getAttribute("TicketDetails");
		 
		  retPag = "DettaglioOK";


		  // Load the organization for the header
		  Organization thisOrganization = new Organization(db, newTic.getOrgId());
		  context.getRequest().setAttribute("OrgDetails", thisOrganization);

	  } catch (Exception errorMessage) {
		  context.getRequest().setAttribute("Error", errorMessage);
		  return ("SystemError");
	  } finally {
		  this.freeConnection(context, db);
	  }
	  //return getReturn(context, "TicketDetails");
	  return retPag;
  }

  /**
   * Confirm the delete operation showing dependencies
   *
   * @param context Description of the Parameter
   * @return Description of the Return Value
   */
  public String executeCommandConfirmDelete(ActionContext context) {
    if (!hasPermission(context, "nonconformita-nonconformita-delete")) {
      return ("PermissionError");
    }
    if(context.getRequest().getParameter("idMacchinetta")!=null)
		context.getRequest().setAttribute("idMacchinetta", context.getRequest().getParameter("idMacchinetta"));
		else
			context.getRequest().setAttribute("idMacchinetta", context.getRequest().getAttribute("idMacchinetta"));
    Connection db = null;
    //Parameters
    String id = context.getRequest().getParameter("id");
    //int orgId = Integer.parseInt(context.getRequest().getParameter("orgId"));
    try {
      db = this.getConnection(context);
      SystemStatus systemStatus = this.getSystemStatus(context);
      Ticket ticket = new Ticket(db, Integer.parseInt(id));
      int orgId = ticket.getOrgId();
      //check permission to record
      if (!isRecordAccessPermitted(context, db, ticket.getOrgId())) {
        return ("PermissionError");
      }
      DependencyList dependencies = ticket.processDependencies(db);
      //Prepare the dialog based on the dependencies
      HtmlDialog htmlDialog = new HtmlDialog();
      dependencies.setSystemStatus(systemStatus);
      htmlDialog.setTitle(systemStatus.getLabel("confirmdelete.title"));
      htmlDialog.addMessage(
          systemStatus.getLabel("confirmdelete.caution") + "\n" + dependencies.getHtmlString());
      /*htmlDialog.setHeader(systemStatus.getLabel("confirmdelete.header"));*/
      htmlDialog.addButton(
          systemStatus.getLabel("global.button.delete"), "javascript:window.location.href='AccountNonConformita.do?command=DeleteTicket&id=" + id + "&orgId=" + orgId + "&forceDelete=true" + RequestUtils.addLinkParams(
          context.getRequest(), "popup|popupType|actionId") + "'");
      htmlDialog.addButton(
          systemStatus.getLabel("button.cancel"), "javascript:parent.window.close()");
      context.getSession().setAttribute("Dialog", htmlDialog);
      return ("ConfirmDeleteOK");
    } catch (Exception errorMessage) {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
  }


  /**
   * Delete the specified ticket
   *
   * @param context Description of Parameter
   * @return Description of the Returned Value
   */
  public String executeCommandDeleteTicket(ActionContext context) {
    if (!hasPermission(context, "distributori-distributori-nonconformita-delete")) {
      return ("PermissionError");
    }
    if(context.getRequest().getParameter("idMacchinetta")!=null)
		context.getRequest().setAttribute("idMacchinetta", context.getRequest().getParameter("idMacchinetta"));
		else
			context.getRequest().setAttribute("idMacchinetta", context.getRequest().getAttribute("idMacchinetta"));
    boolean recordDeleted = false;
    Connection db = null;
    //Parameters
    int orgId = Integer.parseInt(context.getRequest().getParameter("orgId"));
    String passedId = context.getRequest().getParameter("id");
    try {
      db = this.getConnection(context);
      Organization newOrg = new Organization(db, orgId);
      Ticket thisTic = new Ticket(db, Integer.parseInt(passedId));
      //check permission to record
      if (!isRecordAccessPermitted(context, db, thisTic.getOrgId())) {
        return ("PermissionError");
      }
      recordDeleted = thisTic.delete(db, getDbNamePath(context));
      if (recordDeleted) {
        processDeleteHook(context, thisTic);
        //del
        String inline = context.getRequest().getParameter("popupType");
        context.getRequest().setAttribute("OrgDetails", newOrg);
        context.getRequest().setAttribute(
            "refreshUrl", "Distributori.do?command=ViewRichieste&orgId=" + orgId +
            (inline != null && "inline".equals(inline.trim()) ? "&popup=true" : ""));
      }
    } catch (Exception errorMessage) {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    if (recordDeleted) {
      return ("DeleteTicketOK");
    } else {
      return (executeCommandTicketDetails(context));
    }
  }


  /**
   * Update the specified ticket
   *
   * @param context Description of Parameter
   * @return Description of the Returned Value
   */
  public String executeCommandUpdateTicket(ActionContext context) {
    if (!hasPermission(context, "distributori-distributori-nonconformita-edit")) {
      return ("PermissionError");
    }
    int idMacc=-1;
    if(context.getRequest().getParameter("idMacchinetta")!=null){
		context.getRequest().setAttribute("idMacchinetta", context.getRequest().getParameter("idMacchinetta"));
		idMacc=Integer.parseInt(context.getRequest().getParameter("idMacchinetta"));
    }	else
			context.getRequest().setAttribute("idMacchinetta", context.getRequest().getAttribute("idMacchinetta"));
    Connection db = null;
    try {db = this.getConnection(context);
    	org.aspcfs.modules.nonconformita.actions.AccountNonConformita nonConformita = new org.aspcfs.modules.nonconformita.actions.AccountNonConformita();
		nonConformita.executeCommandUpdateTicket(context,db);
		
		Organization orgDetails = new Organization(db, Integer.parseInt(context.getParameter("orgId")));
		context.getRequest().setAttribute("OrgDetails", orgDetails);
    } catch (Exception e) {
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }

   
    return (executeCommandTicketDetails(context));
  }


  //aggiunto da d.dauria
  public String executeCommandAdd(ActionContext context) {

	  if (!hasPermission(context, "distributori-distributori-nonconformita-add")) {
		  return ("PermissionError");
	  }

	  context.getRequest().setAttribute("aslCU", context.getRequest().getParameter("aslMacchinetta"));
	  if(context.getRequest().getParameter("idMacchinetta")!=null)
		  context.getRequest().setAttribute("idMacchinetta", context.getRequest().getParameter("idMacchinetta"));
	  else
		  context.getRequest().setAttribute("idMacchinetta", context.getRequest().getAttribute("idMacchinetta"));
	  Connection db = null;
	 
	  try 
	  {db = this.getConnection(context);
		  	String idControlloUfficiale = context.getRequest().getParameter("idControllo");
			String idC = context.getRequest().getParameter("idC");
			context.getRequest().setAttribute("idControllo",idControlloUfficiale);
			context.getRequest().setAttribute("idC",idC);
			org.aspcfs.modules.nonconformita.actions.AccountNonConformita nonConformita = new org.aspcfs.modules.nonconformita.actions.AccountNonConformita();
			nonConformita.executeCommandAdd(context,db);
			
			Organization thisOrganization = new Organization(db, Integer.parseInt(context.getParameter("orgId")));
			context.getRequest().setAttribute("OrgDetails", thisOrganization);
	  } 
	  catch (Exception e) 
	  {
		  context.getRequest().setAttribute("Error", e);
		 
		  return ("SystemError");
	  } finally {
		  this.freeConnection(context, db);
	  }
	  addModuleBean(context, "AddTicket", "Ticket Add");
	  if (context.getRequest().getParameter("actionSource") != null) {
		  context.getRequest().setAttribute(
				  "actionSource", context.getRequest().getParameter("actionSource"));
		  return "AddTicketOK";
	  }
	  context.getRequest().setAttribute(
			  "systemStatus", this.getSystemStatus(context));
	  return ("AddOK");
  }

  
  public String executeCommandInsert(ActionContext context) throws SQLException {
		if (!(hasPermission(context, "accounts-accounts-nonconformita-add"))) {
			return ("PermissionError");
		}
		Connection db = null;
		Ticket newTicket = null;
		Ticket newTic = (Ticket) context.getFormBean();
		boolean recordInserted = false;
		boolean contactRecordInserted = false;
		boolean isValid = true;
		try {
			db = this.getConnection(context);
			
			Organization thisOrg = new Organization(db, newTic.getOrgId());
			org.aspcfs.modules.nonconformita.actions.AccountNonConformita nc = new org.aspcfs.modules.nonconformita.actions.AccountNonConformita();
			nc.executeCommandInsert(context,db);


		} catch (Exception e) 
		{
			e.printStackTrace();
			context.getRequest().setAttribute("Error", e);
			return ("SystemError");
		} finally 
		{
			this.freeConnection(context, db);
		}
		recordInserted 	= (Boolean) context.getRequest().getAttribute("recordInserted");
		isValid 		= (Boolean) context.getRequest().getAttribute("isValid");
		
		if (recordInserted && isValid) 
		{
			String retPage = "DettaglioOK";
			String tipo_richiesta = newTic.getTipo_richiesta();
			tipo_richiesta = (tipo_richiesta == null) ? ("") : (tipo_richiesta);

			retPage = "InsertOK";



			return ( retPage );//("InsertOK"); 
		}
		return (executeCommandAdd(context));
	}
  
  

  /**
   * Loads the ticket for modification
   *
   * @param context Description of Parameter
   * @return Description of the Returned Value
   */
  public String executeCommandModifyTicket(ActionContext context) {
    if (!hasPermission(context, "distributori-distributori-nonconformita-edit")) {
      return ("PermissionError");
    }				
    if(context.getRequest().getParameter("idMacchinetta")!=null)
		context.getRequest().setAttribute("idMacchinetta", context.getRequest().getParameter("idMacchinetta"));
		else
			context.getRequest().setAttribute("idMacchinetta", context.getRequest().getAttribute("idMacchinetta"));
    Connection db = null;
    
	try {
		db = this.getConnection(context);
		org.aspcfs.modules.nonconformita.actions.AccountNonConformita nonConformita = new org.aspcfs.modules.nonconformita.actions.AccountNonConformita();
		nonConformita.executeCommandModifyTicket(context,db);
		Ticket newTic = (Ticket)context.getRequest().getAttribute("TicketDetails");
		
		Organization thisOrganization = new Organization(db, newTic.getOrgId());
		context.getRequest().setAttribute("OrgDetails", thisOrganization);
  

    } catch (Exception errorMessage) {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    //return "ModifyautorizzazionetrasportoanimaliviviOK";
    return "ModifyOK";
    //return getReturn(context, "ModifyTicket");
  }
  
  
  
  public String executeCommandDettaglio(ActionContext context) {
	    if (!hasPermission(context, "distributori-distributori-view")) {
	      return ("PermissionError");
	    }
	    Connection db = null;
	    Ticket newTic = null;
	    String ticketId = null;
	    SystemStatus systemStatus = this.getSystemStatus(context);
	    try {
	      String fromDefectDetails = context.getRequest().getParameter("defectCheck");
	      if (fromDefectDetails == null || "".equals(fromDefectDetails.trim())) {
	        fromDefectDetails = (String) context.getRequest().getAttribute("defectCheck");
	      }

	      // Parameters
	      ticketId = context.getRequest().getParameter("id");
	      // Reset the pagedLists since this could be a new visit to this ticket
	      deletePagedListInfo(context, "TicketDocumentListInfo");
	      deletePagedListInfo(context, "SunListInfo");
	      deletePagedListInfo(context, "TMListInfo");
	      deletePagedListInfo(context, "CSSListInfo");
	      deletePagedListInfo(context, "TicketsFolderInfo");
	      deletePagedListInfo(context, "TicketTaskListInfo");
	      deletePagedListInfo(context, "ticketPlanWorkListInfo");
	      db = this.getConnection(context);
	      // Load the ticket
	      newTic = new Ticket();
	      newTic.queryRecord(db, Integer.parseInt(ticketId));

	      //find record permissions for portal users
	      if (!isRecordAccessPermitted(context, db, newTic.getOrgId())) {
	        return ("PermissionError");
	      }

	      Organization orgDetails = new Organization(db, newTic.getOrgId());
	    
	   
	      
	      LookupList Provvedimenti = new LookupList(db, "lookup_provvedimenti");
	      Provvedimenti.addItem(-1, "-- SELEZIONA VOCE --");
	      Provvedimenti.removeElementByLevel(9);
	      context.getRequest().setAttribute("Provvedimenti", Provvedimenti);
	      
	      LookupList NonConformitaAmministrative = new LookupList(db, "lookup_nonconformita_amministrative");
	      NonConformitaAmministrative.addItem(-1, "-- SELEZIONA VOCE --");
	      context.getRequest().setAttribute("NonConformitaAmministrative", NonConformitaAmministrative);
	      
	      LookupList SiteIdList = new LookupList(db, "lookup_site_id");
	      SiteIdList.addItem(-1, "-- SELEZIONA VOCE --");
	      context.getRequest().setAttribute("SiteIdList", SiteIdList);
	      
	      LookupList NonConformitaPenali = new LookupList(db, "lookup_nonconformita_penali");
	      NonConformitaPenali.addItem(-1, "-- SELEZIONA VOCE --");
	      context.getRequest().setAttribute("NonConformitaPenali", NonConformitaPenali);
	      
	      LookupList NonConformita = new LookupList(db, "lookup_nonconformita");
	      NonConformita.addItem(-1, "-- SELEZIONA VOCE --");
	      context.getRequest().setAttribute("NonConformita", NonConformita);
	    
	    } catch (Exception e) {
	      context.getRequest().setAttribute("Error", e);
	      return ("SystemError");
	    } finally {
	      this.freeConnection(context, db);
	    }
	    context.getRequest().setAttribute("TicketDetails", newTic);
	    addRecentItem(context, newTic);
	    addModuleBean(context, "ViewTickets", "View Tickets");
	    
	    String retPage = "DettaglioOK";
	    String tipo_richiesta = newTic.getTipo_richiesta();
	    tipo_richiesta = (tipo_richiesta == null) ? ("") : (tipo_richiesta);
	    
	    retPage = "DettaglioOK";
	    
	
	    
	    return ( retPage );
	  }
  
  
  
  
  
  
  public String executeCommandChiudi(ActionContext context)
  {
	  	    if (!(hasPermission(context, "distributori-distributori-nonconformita-edit"))){
	      return ("PermissionError");
	    }
	  	    
	  	    
	  	 
	  	  if(context.getRequest().getParameter("idMacchinetta")!=null)
				context.getRequest().setAttribute("idMacchinetta", context.getRequest().getParameter("idMacchinetta"));
				else
					context.getRequest().setAttribute("idMacchinetta", context.getRequest().getAttribute("idMacchinetta"));   
	  	    
	    int resultCount = -1;
	    Connection db = null;
	    Ticket thisTicket = null;
	    try {
	      db = this.getConnection(context);
	      thisTicket = new Ticket(
	          db, Integer.parseInt(context.getRequest().getParameter("id")));
	      Ticket oldTicket = new Ticket(db, thisTicket.getId());
	      //check permission to record
	      if (!isRecordAccessPermitted(context, db, thisTicket.getOrgId())) {
	        return ("PermissionError");
	      }
	
	      
	      String ticketId = context.getRequest().getParameter("id");
	      
	      int passedId = thisTicket.getOrgId();
	      org.aspcfs.modules.sanzioni.base.TicketList sanzioniList = new org.aspcfs.modules.sanzioni.base.TicketList();
	      int passId = thisTicket.getOrgId();
	      sanzioniList.setOrgId(passedId);
	      sanzioniList.buildListControlli(db, passId, ticketId,8);
	      context.getRequest().setAttribute("SanzioniList", sanzioniList);
	      
	      org.aspcfs.modules.reati.base.TicketList reatiList = new org.aspcfs.modules.reati.base.TicketList();
	      int passIdR = thisTicket.getOrgId();
	      reatiList.setOrgId(passedId);
	      reatiList.buildListControlli(db, passIdR, ticketId,8);
	      context.getRequest().setAttribute("ReatiList", reatiList);
	      
	      
	      org.aspcfs.modules.followup.base.TicketList followupList = new org.aspcfs.modules.followup.base.TicketList();
	      int passIdF = thisTicket.getOrgId();
	      followupList.setOrgId(passedId);
	      followupList.buildListControlli(db, passIdF, ticketId,8);
	      context.getRequest().setAttribute("FollowupList", followupList);
	   
	      org.aspcfs.modules.sequestri.base.TicketList seqList = new org.aspcfs.modules.sequestri.base.TicketList();
	      int passIdS = thisTicket.getOrgId();
	      seqList.setOrgId(passedId);
	      seqList.buildListControlli(db, passIdS, ticketId,8);
	      context.getRequest().setAttribute("SequestriList", seqList);
	  	    
	      
	      
	      Iterator sanzionilIterator=sanzioniList.iterator();
	      Iterator seqlIterator=seqList.iterator();
	      Iterator reatilIterator=reatiList.iterator();
	      Iterator followupIterator=followupList.iterator();
	      
	      int flag=0;
			int numSottoAttivita = 0;
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


		

			if(flag==1  ){
				context.getRequest().setAttribute("Chiudi", "1");
				return (executeCommandTicketDetails(context));

			}

			if(numSottoAttivita == 0 ){

				context.getRequest().setAttribute("numSottoAttivita", "0");
				return (executeCommandTicketDetails(context));

			}
	      
	      
	      
	      
	      thisTicket.setModifiedBy(getUserId(context));
	      resultCount = thisTicket.chiudi(db);
	      
	      
	      /*
			 * Inifio Giuseppe
			 * 
			 */
			
			thisTicket.getIdControlloUfficiale();
			String padd="000000";
			String id_controllo=thisTicket.getIdControlloUfficiale();
			String temp_id_controllo="";
			for(int i=0;i<id_controllo.length();i++){
				
				if(id_controllo.charAt(i)!=padd.charAt(i)){
					temp_id_controllo=temp_id_controllo+id_controllo.charAt(i);
					
				}
				
			}
			org.aspcfs.modules.vigilanza.base.Ticket thisTicketV = new org.aspcfs.modules.vigilanza.base.Ticket(
			          db, Integer.parseInt(temp_id_controllo));
			   
			
			
		      
		     
			 
			 org.aspcfs.modules.campioni.base.TicketList ticList = new org.aspcfs.modules.campioni.base.TicketList();
			 int passedId1 = thisTicketV.getOrgId();
			 ticList.setOrgId(passedId1);
			 ticList.buildListControlli(db, passedId, temp_id_controllo);

			 
			 org.aspcfs.modules.tamponi.base.TicketList tamponiList = new org.aspcfs.modules.tamponi.base.TicketList();
			 int pasId = thisTicketV.getOrgId();
			 tamponiList.setOrgId(passedId1);
			 tamponiList.buildListControlli(db, pasId, temp_id_controllo);

				  	    
				      
				      
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
				          int passIdN = thisTicketV.getOrgId();
				          nonCList.setOrgId(passedId);
				          nonCList.buildListControlli(db, passIdN, temp_id_controllo);
				    	  
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
				         
				          audit.buildListControlli(db, AuditOrgId, idTi);
				          
				    	  Iterator itAudit=audit.iterator();
				    	  
			      while(itAudit.hasNext()){
					    	  
					    	  org.aspcfs.modules.audit.base.Audit auditTemp = (org.aspcfs.modules.audit.base.Audit) itAudit.next();
					    	  
					    	  if(auditTemp.getLivelloRischioFinale()==-1){
					    		  flag=2;
					    		  
					    		  break;
					    		  
					    	  }
					    		  
					      }
				    	  
				      }
				      
				      String attivitaCollegate=context.getRequest().getParameter("altro");
				   
				      if(attivitaCollegate==null){
				      if(flag==1 || flag==2){
				    	  context.getRequest().setAttribute("Chiudi", ""+flag);
				    	  return (executeCommandTicketDetails(context));
				    	  
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
				      
				  
				   
				
			
			
	
	      
	      
	      
	      
	      if (resultCount == -1) {
	        return ( executeCommandTicketDetails(context));
	      } else if (resultCount == 1) {
	        thisTicket.queryRecord(db, thisTicket.getId());
	        this.processUpdateHook(context, oldTicket, thisTicket);
	        return (executeCommandTicketDetails(context));
	      }
	    } catch (Exception errorMessage) {
	      context.getRequest().setAttribute("Error", errorMessage);
	      return ("SystemError");
	    } finally {
	      this.freeConnection(context, db);
	    }
	    context.getRequest().setAttribute("Error", NOT_UPDATED_MESSAGE);
	    return ("UserError");
	  
	  
	  }

}

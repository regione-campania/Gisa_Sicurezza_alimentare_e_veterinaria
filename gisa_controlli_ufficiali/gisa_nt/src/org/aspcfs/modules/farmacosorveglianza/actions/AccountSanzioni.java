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
package org.aspcfs.modules.farmacosorveglianza.actions;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Iterator;

import org.aspcf.modules.controlliufficiali.action.Sanzioni;
import org.aspcfs.controller.SystemStatus;
import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.admin.base.User;
import org.aspcfs.modules.base.DependencyList;
import org.aspcfs.modules.farmacosorveglianza.base.Organization;
import org.aspcfs.modules.sanzioni.base.Ticket;
import org.aspcfs.modules.troubletickets.base.TicketCategory;
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
public final class AccountSanzioni extends CFSModule {

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
    if (!hasPermission(context, "farmacie-farmacie-sanzioni-edit")) {
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
   * Load the ticket details tab
   *
   * @param context Description of Parameter
   * @return Description of the Returned Value
   */
  public String executeCommandTicketDetails(ActionContext context) {
    if (!hasPermission(context, "farmacie-farmacie-sanzioni-view")) {
      return ("PermissionError");
    }
    Connection db = null;
    //Parameters
    String ticketId = context.getRequest().getParameter("id");
    String tickId = context.getRequest().getParameter("ticketId");
    String retPag = null;
    
    String id = context.getRequest().getParameter("idC");
  	context.getRequest().setAttribute("idC",
  			id);
  	
  	String id2 = context.getRequest().getParameter("idNC");
  	context.getRequest().setAttribute("idNC",
  			id2);

    try {
      db = this.getConnection(context);
      // Load the ticket
      Ticket newTic = new Ticket();
      SystemStatus systemStatus = this.getSystemStatus(context);
      newTic.setSystemStatus(systemStatus);
      if(tickId == null)
        newTic.queryRecord(db, Integer.parseInt(ticketId));
      else
    	newTic.queryRecord(db, Integer.parseInt(tickId));

      //find record permissions for portal users
      if (!isRecordAccessPermitted(context, db, newTic.getOrgId())) {
        return ("PermissionError");
      }
  

   
      
      LookupList SiteIdList = new LookupList(db, "lookup_site_id");
      SiteIdList.addItem(-1, "-- SELEZIONA VOCE --");
      context.getRequest().setAttribute("SiteIdList", SiteIdList);
      
      LookupList Provvedimenti = new LookupList(db, "lookup_provvedimenti");
      Provvedimenti.addItem(-1, "-- SELEZIONA VOCE --");
      context.getRequest().setAttribute("Provvedimenti", Provvedimenti);
      
      LookupList SanzioniAmministrative = new LookupList(db, "lookup_sanzioni_amministrative");
      SanzioniAmministrative.addItem(-1, "-- SELEZIONA VOCE --");
      context.getRequest().setAttribute("SanzioniAmministrative", SanzioniAmministrative);
      
      LookupList SanzioniPenali = new LookupList(db, "lookup_sanzioni_penali");
      SanzioniPenali.addItem(-1, "-- SELEZIONA VOCE --");
      context.getRequest().setAttribute("SanzioniPenali", SanzioniPenali);
      
      LookupList isp = new LookupList(db, "lookup_ispezione");
      isp.addItem(-1, "-- SELEZIONA VOCE --");
      context.getRequest().setAttribute("Ispezioni", isp);
  
  	org.aspcfs.modules.vigilanza.base.Ticket CU = new org.aspcfs.modules.vigilanza.base.Ticket(db,Integer.parseInt(newTic.getIdControlloUfficiale()));
	context.getRequest().setAttribute("CU",CU);
	
      LookupList Sequestri = new LookupList(db, "lookup_sequestri");
      Sequestri.addItem(-1, "-- SELEZIONA VOCE --");
      context.getRequest().setAttribute("Sequestri", Sequestri);

    
      context.getRequest().setAttribute("TicketDetails", newTic);
      
      retPag = "DettaglioOK";
      
      addRecentItem(context, newTic);
      // Load the organization for the header
      Organization thisOrganization = new Organization(db, newTic.getOrgId());
      context.getRequest().setAttribute("OrgDetails", thisOrganization);
      addModuleBean(context, "View Accounts", "View Tickets");
      // Reset any pagedLists since this could be a new visit to this ticket
      deletePagedListInfo(context, "AccountTicketsFolderInfo");
      deletePagedListInfo(context, "AccountTicketDocumentListInfo");
      deletePagedListInfo(context, "AccountTicketTaskListInfo");
      deletePagedListInfo(context, "accountTicketPlanWorkListInfo");
     
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
    if (!hasPermission(context, "farmacie-farmacie-sanzioni-delete")) {
      return ("PermissionError");
    }
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
          systemStatus.getLabel("global.button.delete"), "javascript:window.location.href='"+ticket.getURlDettaglio()+"Sanzioni.do?command=DeleteTicket&id=" + id + "&orgId=" + orgId + "&forceDelete=true" + RequestUtils.addLinkParams(
          context.getRequest(), "popup|popupType|actionId") + "'");
      htmlDialog.addButton(
          systemStatus.getLabel("button.cancel"), "javascript:parent.window.close()");
      context.getSession().setAttribute("Dialog", htmlDialog);
      
      if (org.aspcfs.modules.util.imports.ApplicationProperties.getProperty("GESTIONE_PAGOPA")!=null && org.aspcfs.modules.util.imports.ApplicationProperties.getProperty("GESTIONE_PAGOPA").equalsIgnoreCase("si")){
	      String checkSanzioneCancellabilePagoPa = ticket.isSanzioneCancellabilePagoPa(db);
	      if (checkSanzioneCancellabilePagoPa!=null){
				htmlDialog = new HtmlDialog();
				htmlDialog.setTitle(systemStatus.getLabel("confirmdelete.title"));
				htmlDialog.addMessage("<font color=\"red\"><b>"+checkSanzioneCancellabilePagoPa + "</b></font>\n");
				htmlDialog.addButton(systemStatus.getLabel("button.cancel"), "javascript:parent.window.close()");
				context.getSession().setAttribute("Dialog", htmlDialog);
			}
      }
   
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
   * @return D	escription of the Returned Value
   */
  public String executeCommandDeleteTicket(ActionContext context) {
    if (!hasPermission(context, "farmacie-farmacie-sanzioni-delete")) {
      return ("PermissionError");
    }
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
     
      String id_controllo=""+thisTic.getIdControlloUfficialeTicket();
		

	context.getRequest().setAttribute("idC", id_controllo);
	
	recordDeleted = thisTic.delete(db, getDbNamePath(context));
	if (recordDeleted) {
		processDeleteHook(context, thisTic);
		//del
		String inline = context.getRequest().getParameter("popupType");
		context.getRequest().setAttribute("OrgDetails", newOrg);
		context
				.getRequest()
				.setAttribute(
						"refreshUrl",
						thisTic.getURlDettaglio()+"NonConformita.do?command=TicketDetails&id="+thisTic.getId_nonconformita()+"&orgId="
  								+ orgId
								+ (inline != null
										&& "inline".equals(inline
												.trim()) ? "&popup=true"
										: ""));
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
   * Description of the Method
   *
   * @param context Description of the Parameter
   * @return Description of the Return Value
   */
  public String executeCommandRestoreTicket(ActionContext context) {

    if (!(hasPermission(context, "tickets-tickets-edit"))) {
      return ("PermissionError");
    }
    boolean recordUpdated = false;
    Connection db = null;
    Ticket thisTicket = null;
    try {
      db = this.getConnection(context);
      thisTicket = new Ticket(
          db, Integer.parseInt(context.getRequest().getParameter("id")));
      //check permission to record
      if (!isRecordAccessPermitted(context, db, thisTicket.getOrgId())) {
        return ("PermissionError");
      }
      thisTicket.setModifiedBy(getUserId(context));
      recordUpdated = thisTicket.updateStatus(
          db, false, this.getUserId(context));
    } catch (Exception errorMessage) {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    if (recordUpdated) {
      return (executeCommandTicketDetails(context));
    } else {
      context.getRequest().setAttribute("Error", NOT_UPDATED_MESSAGE);
      return ("UserError");
    }
  }



  /**
   * Update the specified ticket
   *
   * @param context Description of Parameter
   * @return Description of the Returned Value
   */
  public String executeCommandUpdateTicket(ActionContext context) {
    if (!hasPermission(context, "farmacie-farmacie-sanzioni-edit")) {
      return ("PermissionError");
    }
    Connection db = null;
    int resultCount = 0;


    try {
      db = this.getConnection(context);
      
     
      
      Organization orgDetails = new Organization(db, Integer.parseInt(context.getParameter("orgId")));
      context.getRequest().setAttribute("OrgDetails", orgDetails);
      
      Sanzioni generic_action = new Sanzioni();
      generic_action.executeCommandUpdateTicket(context);

    } catch (Exception e) {
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }

   
    return (executeCommandTicketDetails(context));
  }


  /**
   * Loads the ticket for modification
   *
   * @param context Description of Parameter
   * @return Description of the Returned Value
   */
  public String executeCommandModifyTicket(ActionContext context) {
	  if (!hasPermission(context, "farmacie-farmacie-edit")) {
	      return ("PermissionError");
	    }	
    Connection db = null;
   
    try {
      db = this.getConnection(context);
      User user = this.getUser(context, this.getUserId(context));
      String ticketId = context.getRequest().getParameter("id");
      Ticket newTic = new Ticket(db, Integer.parseInt(ticketId));
      //Load the organization
      
      Sanzioni generic_action = new Sanzioni();
      generic_action.executeCommandModifyTicket(context);
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
  
  
  /**
   * Description of the Method
   *
   * @param context Description of Parameter
   * @return Description of the Returned Value
   */
  public String executeCommandModify(ActionContext context) {
    if (!hasPermission(context, "farmacie-farmacie-edit")) {
      return ("PermissionError");
    }
    Connection db = null;
    Ticket newTic = null;
    //Parameters
    String ticketId = context.getRequest().getParameter("id");
    SystemStatus systemStatus = this.getSystemStatus(context);
    try {
      db = this.getConnection(context);
      User user = this.getUser(context, this.getUserId(context));
      //Load the ticket
      if (context.getRequest().getParameter("companyName") == null) {
        newTic = new Ticket();
        newTic.queryRecord(db, Integer.parseInt(ticketId));
      } else {
        newTic = (Ticket) context.getFormBean();
       
      }

      //find record permissions for portal users
      if (!isRecordAccessPermitted(context, db, newTic.getOrgId())) {
        return ("PermissionError");
      }

      String fromDefectDetails = context.getRequest().getParameter("defectCheck");
      if (fromDefectDetails == null || "".equals(fromDefectDetails.trim())) {
        fromDefectDetails = (String) context.getRequest().getAttribute("defectCheck");
      }
      if (fromDefectDetails != null && !"".equals(fromDefectDetails.trim())) {
        context.getRequest().setAttribute("defectCheck", fromDefectDetails);
      }

     

      LookupList SiteIdList = new LookupList(db, "lookup_site_id");
      SiteIdList.addItem(-1, "-- SELEZIONA VOCE --");
      context.getRequest().setAttribute("SiteIdList", SiteIdList);
      
     
      
      LookupList Provvedimenti = new LookupList(db, "lookup_provvedimenti");
      
      
      Provvedimenti.setMultiple(true);
      Provvedimenti.setSelectSize(7);
      LookupList multipleSelects=new LookupList();
      
      
      
      HashMap<Integer, String> ListaBpi=newTic.getAzioninonConformePer();
      Iterator<Integer> iteraKiavi= newTic.getAzioninonConformePer().keySet().iterator();
      while(iteraKiavi.hasNext()){
      int kiave=iteraKiavi.next();
      String valore=ListaBpi.get(kiave);
    	  
    	  multipleSelects.addItem(kiave,valore);
    	  
      }
      
      Provvedimenti.setMultipleSelects(multipleSelects);
     
      context.getRequest().setAttribute("Provvedimenti", Provvedimenti);
      
      LookupList SanzioniAmministrative = new LookupList(db, "lookup_sanzioni_amministrative");
      SanzioniAmministrative.addItem(-1, "-- SELEZIONA VOCE --");
      context.getRequest().setAttribute("SanzioniAmministrative", SanzioniAmministrative);
      
      LookupList SanzioniPenali = new LookupList(db, "lookup_sanzioni_penali");
      SanzioniPenali.addItem(-1, "-- SELEZIONA VOCE --");
      context.getRequest().setAttribute("SanzioniPenali", SanzioniPenali);
      
      LookupList Sequestri = new LookupList(db, "lookup_sequestri");
      Sequestri.addItem(-1, "-- SELEZIONA VOCE --");
      context.getRequest().setAttribute("Sequestri", Sequestri);
      
      
     
    
    
      context.getRequest().setAttribute("TicketDetails", newTic);
      addRecentItem(context, newTic);

      //getting current date in mm/dd/yyyy format
      String currentDate = getCurrentDateAsString(context);
      context.getRequest().setAttribute("currentDate", currentDate);
    } catch (Exception errorMessage) {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    context.getRequest().setAttribute("TicketDetails", newTic);
    addModuleBean(context, "ViewTickets", "View Tickets");

    String retPage = "Modify";
  
    
    return getReturn( context, retPage );
  }

  
  
  
  /**
   * Description of the Method
   *
   * @param context Description of Parameter
   * @return Description of the Returned Value
   */
  public String executeCommandUpdate(ActionContext context) {
    if (!hasPermission(context, "farmacie-farmacie-edit")) {
      return ("PermissionError");
    }
    int resultCount = 0;
    int catCount = 0;
    TicketCategory thisCat = null;
    boolean catInserted = false;
    boolean isValid = true;
    Ticket newTic = (Ticket) context.getFormBean();
    Connection db = null;
    SystemStatus systemStatus = this.getSystemStatus(context);
    try {
      db = this.getConnection(context);
      //check permission to record
      if (!isRecordAccessPermitted(context, db, newTic.getOrgId())) {
        return ("PermissionError");
      }
      Organization orgDetails = new Organization(db, newTic.getOrgId());
      
      LookupList Provvedimenti = new LookupList(db, "lookup_provvedimenti");
      Provvedimenti.addItem(-1, "-- SELEZIONA VOCE --");
      context.getRequest().setAttribute("Provvedimenti", Provvedimenti);
      
      LookupList SanzioniAmministrative = new LookupList(db, "lookup_sanzioni_amministrative");
      SanzioniAmministrative.addItem(-1, "-- SELEZIONA VOCE --");
      context.getRequest().setAttribute("SanzioniAmministrative", SanzioniAmministrative);
      
      LookupList SanzioniPenali = new LookupList(db, "lookup_sanzioni_penali");
      SanzioniPenali.addItem(-1, "-- SELEZIONA VOCE --");
      context.getRequest().setAttribute("SanzioniPenali", SanzioniPenali);
      
      LookupList Sequestri = new LookupList(db, "lookup_sequestri");
      Sequestri.addItem(-1, "-- SELEZIONA VOCE --");
      context.getRequest().setAttribute("Sequestri", Sequestri);
     
      newTic.setModifiedBy(getUserId(context));
      //Get the previousTicket, update the ticket, then send both to a hook
   
      newTic.setSiteId(Organization.getOrganizationSiteId(db, newTic.getOrgId()));
      isValid = this.validateObject(context, db, newTic) && isValid;
      if (isValid) {
    	  newTic.setTestoAppoggio("Modifica"); //aggiunto da d.dauria //aggiunto da d.dauria
    	//newTic.setTestoAppoggio("Modifica");  
        resultCount = newTic.update(db);
     
      }
     
    } catch (Exception e) {
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    if (resultCount == 1) {
      if (context.getRequest().getParameter("return") != null && context.getRequest().getParameter(
          "return").equals("list")) {
        return (executeCommandDettaglio(context));
      }
      return getReturn(context, "Update");
    }
    return (executeCommandModify(context));
  }
  
  
  
  public String executeCommandDettaglio(ActionContext context) {
	    if (!hasPermission(context, "farmacie-farmacie-view")) {
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
	      // check wether or not the product id exists
	     

	   
	      
	      LookupList Provvedimenti = new LookupList(db, "lookup_provvedimenti");
	      Provvedimenti.addItem(-1, "-- SELEZIONA VOCE --");
	      context.getRequest().setAttribute("Provvedimenti", Provvedimenti);
	      
	      LookupList SanzioniAmministrative = new LookupList(db, "lookup_sanzioni_amministrative");
	      SanzioniAmministrative.addItem(-1, "-- SELEZIONA VOCE --");
	      context.getRequest().setAttribute("SanzioniAmministrative", SanzioniAmministrative);
	      
	      LookupList SiteIdList = new LookupList(db, "lookup_site_id");
	      SiteIdList.addItem(-1, "-- SELEZIONA VOCE --");
	      context.getRequest().setAttribute("SiteIdList", SiteIdList);
	      
	      LookupList SanzioniPenali = new LookupList(db, "lookup_sanzioni_penali");
	      SanzioniPenali.addItem(-1, "-- SELEZIONA VOCE --");
	      context.getRequest().setAttribute("SanzioniPenali", SanzioniPenali);
	      
	      LookupList Sequestri = new LookupList(db, "lookup_sequestri");
	      Sequestri.addItem(-1, "-- SELEZIONA VOCE --");
	      context.getRequest().setAttribute("Sequestri", Sequestri);
	      
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
	  	    if (!(hasPermission(context, "farmacie-farmacie-sanzioni-edit"))){
	      return ("PermissionError");
	    }
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
	      thisTicket.setModifiedBy(getUserId(context));
	      resultCount = thisTicket.chiudi(db);
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

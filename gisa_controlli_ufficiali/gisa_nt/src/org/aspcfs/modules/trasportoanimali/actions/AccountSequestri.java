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
package org.aspcfs.modules.trasportoanimali.actions;

import java.sql.Connection;

import org.aspcf.modules.controlliufficiali.action.Sequestri;
import org.aspcfs.controller.SystemStatus;
import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.base.DependencyList;
import org.aspcfs.modules.sequestri.base.Ticket;
import org.aspcfs.modules.trasportoanimali.base.Organization;
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
public final class AccountSequestri extends CFSModule {

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
    if (!hasPermission(context, "trasporti-trasporti-sequestri-edit")) {
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
	  if (!hasPermission(context, "trasporti-trasporti-sequestri-view")) {
	      return ("PermissionError");
	    }
	    Connection db = null;
	    
	    String retPag = "" ;

	    try {
	      db = this.getConnection(context);
	      // Load the ticket
	      Sequestri generic_action = new Sequestri();
	      generic_action.executeCommandModifyTicket(context);
	      
	      retPag = "DettaglioOK";
	      Ticket newTic = (Ticket) context.getRequest().getAttribute("TicketDetails");
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
    if (!hasPermission(context, "sequestri-sequestri-delete")) {
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
      
      DependencyList dependencies = ticket.processDependencies(db);
      //Prepare the dialog based on the dependencies
      HtmlDialog htmlDialog = new HtmlDialog();
      dependencies.setSystemStatus(systemStatus);
      htmlDialog.setTitle(systemStatus.getLabel("confirmdelete.title"));
      htmlDialog.addMessage(
          systemStatus.getLabel("confirmdelete.caution") + "\n" + dependencies.getHtmlString());
      /*htmlDialog.setHeader(systemStatus.getLabel("confirmdelete.header"));*/
      htmlDialog.addButton(
          systemStatus.getLabel("global.button.delete"), "javascript:window.location.href='TrasportiSequestri.do?command=DeleteTicket&id=" + id + "&orgId=" + orgId + "&forceDelete=true" + RequestUtils.addLinkParams(
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
    if (!hasPermission(context, "trasporti-trasporti-sequestri-delete")) {
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
     
      String id_controllo=""+thisTic.getIdTicketNonConformita();
		

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
    						"TrasportiNonConformita.do?command=TicketDetails&idC="+id_controllo+"&id="+id_controllo+"&orgId="
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
   * Update the specified ticket
   *
   * @param context Description of Parameter
   * @return Description of the Returned Value
   */
  public String executeCommandUpdateTicket(ActionContext context) {
	  if (!hasPermission(context, "trasporti-trasporti-sequestri-edit")) {
	      return ("PermissionError");
	    }
	    Connection db = null;
	    

	    try {
	      db = this.getConnection(context);
	      
	      Sequestri generic_action = new Sequestri();
	      generic_action.executeCommandUpdateTicket(context);
	      
	      Organization orgDetails = new Organization(db, Integer.parseInt(context.getParameter("orgId")));
	      context.getRequest().setAttribute("OrgDetails", orgDetails);
	      //check permission to record
	      

	    } catch (Exception e) {
	      context.getRequest().setAttribute("Error", e);
	      return ("SystemError");
	    } finally {
	      this.freeConnection(context, db);
	    }

	   
	    return (executeCommandTicketDetails(context));
	  }
  
  public String executeCommandModifyTicket(ActionContext context) {
	  if (!hasPermission(context, "trasporti-trasporti-sequestri-edit")) {
	      return ("PermissionError");
	    }					
	    Connection db = null;
	   
	    try {
	      db = this.getConnection(context);
	     
	      Sequestri generic_action = new Sequestri();
	      generic_action.executeCommandModifyTicket(context);
	      
	      Ticket newTic = (Ticket) context.getRequest().getAttribute("TicketDetails");
	      
	      Organization thisOrganization = new Organization(db, newTic.getOrgId());
	      context.getRequest().setAttribute("OrgDetails", thisOrganization);
	      //Load the departmentList for assigning
	    
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
	  if (!hasPermission(context, "trasporti-trasporti-edit")) {
	      return ("PermissionError");
	    }
	    Connection db = null;
	   
	    try {
	      db = this.getConnection(context);
	      Sequestri generic_action = new Sequestri();
	      generic_action.executeCommandModifyTicket(context);
	      
	      Ticket newTic = (Ticket) context.getRequest().getAttribute("TicketDetails");
	      Organization orgDetails = new Organization(db, newTic.getOrgId());
	      context.getRequest().setAttribute("OrgDetails", orgDetails);

	      
	    } catch (Exception errorMessage) {
	      context.getRequest().setAttribute("Error", errorMessage);
	      return ("SystemError");
	    } finally {
	      this.freeConnection(context, db);
	    }
	 
	    addModuleBean(context, "ViewTickets", "View Tickets");

	    String retPage = "Modify";
	   /* String tipo_richiesta = newTic.getTipo_richiesta();
	    tipo_richiesta = (tipo_richiesta == null) ? ("") : (tipo_richiesta);*/
	    
	    
	  
	    return getReturn( context, retPage );
	  }

  
  
  /**
   * Description of the Method
   *
   * @param context Description of Parameter
   * @return Description of the Returned Value
   */
  public String executeCommandUpdate(ActionContext context) {
    if (!hasPermission(context, "trasporti-trasporti-edit")) {
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
      
      Organization orgDetails = new Organization(db, newTic.getOrgId());
      
      LookupList Provvedimenti = new LookupList(db, "lookup_provvedimenti");
      Provvedimenti.addItem(-1, "-- SELEZIONA VOCE --");
      context.getRequest().setAttribute("Provvedimenti", Provvedimenti);
      
      LookupList SequestriAmministrative = new LookupList(db, "lookup_sequestri_amministrative");
      SequestriAmministrative.addItem(-1, "-- SELEZIONA VOCE --");
      context.getRequest().setAttribute("SequestriAmministrative", SequestriAmministrative);
      
      LookupList SequestriPenali = new LookupList(db, "lookup_sequestri_penali");
      SequestriPenali.addItem(-1, "-- SELEZIONA VOCE --");
      context.getRequest().setAttribute("SequestriPenali", SequestriPenali);
      
      LookupList Sequestri = new LookupList(db, "lookup_sequestri");
      Sequestri.addItem(-1, "-- SELEZIONA VOCE --");
      context.getRequest().setAttribute("Sequestri", Sequestri);
     
      String valore=context.getRequest().getParameter("sequestro");
	     if(valore.equalsIgnoreCase("si")){
	    	 newTic.setSequestro(true);
	    	
	     }else{
	    	 newTic.setSequestro(false); 
	     }
	     
      newTic.setModifiedBy(getUserId(context));
      //Get the previousTicket, update the ticket, then send both to a hook
      Ticket previousTicket = new Ticket(db, newTic.getId());
     
      newTic.setSiteId(Organization.getOrganizationSiteId(db, newTic.getOrgId()));
      isValid = this.validateObject(context, db, newTic) && isValid;
      if (isValid) {
    	  newTic.setTestoAppoggio("Modifica"); //aggiunto da d.dauria //aggiunto da d.dauria
    	//newTic.setTestoAppoggio("Modifica");  
        resultCount = newTic.update(db);
        if (resultCount == 1) {
          newTic.queryRecord(db, newTic.getId());
          processUpdateHook(context, previousTicket, newTic);
        }
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
	    if (!hasPermission(context, "trasporti-trasporti-view")) {
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
	      

	      Organization orgDetails = new Organization(db, newTic.getOrgId());
	      // check wether or not the product id exists
	     
	      
	      LookupList Provvedimenti = new LookupList(db, "lookup_provvedimenti");
	      Provvedimenti.addItem(-1, "-- SELEZIONA VOCE --");
	      context.getRequest().setAttribute("Provvedimenti", Provvedimenti);
	      
	      LookupList SequestriAmministrative = new LookupList(db, "lookup_sequestri_amministrative");
	      SequestriAmministrative.addItem(-1, "-- SELEZIONA VOCE --");
	      context.getRequest().setAttribute("SequestriAmministrative", SequestriAmministrative);
	      
	      LookupList SiteIdList = new LookupList(db, "lookup_site_id");
	      SiteIdList.addItem(-1, "-- SELEZIONA VOCE --");
	      context.getRequest().setAttribute("SiteIdList", SiteIdList);
	      
	      LookupList SequestriPenali = new LookupList(db, "lookup_sequestri_penali");
	      SequestriPenali.addItem(-1, "-- SELEZIONA VOCE --");
	      context.getRequest().setAttribute("SequestriPenali", SequestriPenali);
	      
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
	  	    if (!(hasPermission(context, "trasporti-trasporti-sequestri-edit"))){
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

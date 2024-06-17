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
package org.aspcfs.modules.osm.actions;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

import org.aspcfs.controller.ApplicationPrefs;
import org.aspcfs.controller.SystemStatus;
import org.aspcfs.modules.accounts.utils.AccountsUtil;
import org.aspcfs.modules.actionplans.base.ActionItemWork;
import org.aspcfs.modules.actionplans.base.ActionPlan;
import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.admin.base.Role;
import org.aspcfs.modules.admin.base.User;
import org.aspcfs.modules.admin.base.UserList;
import org.aspcfs.modules.assets.base.Asset;
import org.aspcfs.modules.assets.base.AssetList;
import org.aspcfs.modules.audit.base.Audit;
import org.aspcfs.modules.base.Constants;
import org.aspcfs.modules.base.CustomFieldCategory;
import org.aspcfs.modules.base.CustomFieldRecord;
import org.aspcfs.modules.diffida.base.Ticket;
import org.aspcfs.modules.login.beans.UserBean;
import org.aspcfs.modules.mycfs.beans.CalendarBean;
import org.aspcfs.modules.osm.base.Organization;
import org.aspcfs.modules.osm.base.OrganizationList;
import org.aspcfs.modules.osm.base.SottoAttivita;
import org.aspcfs.modules.pipeline.base.OpportunityHeaderList;
import org.aspcfs.utils.web.CountrySelect;
import org.aspcfs.utils.web.HtmlDialog;
import org.aspcfs.utils.web.HtmlSelect;
import org.aspcfs.utils.web.LookupList;
import org.aspcfs.utils.web.PagedListInfo;
import org.aspcfs.utils.web.StateSelect;

import com.darkhorseventures.framework.actions.ActionContext;

/**
 *  Action for the Account module
 *
 * @author     chris
 * @created    August 15, 2001
 * @version    $Id: Accounts.java 18261 2007-01-08 14:45:02Z matt $
 */
public final class Accounts extends CFSModule {

  /**
   *  Default: not used
   *
   * @param  context  Description of Parameter
   * @return          Description of the Returned Value
   */
  public String executeCommandDefault(ActionContext context) {

    return executeCommandDashboard(context);
  }
  
  
  public String executeCommandGeneraCodiceOsa(ActionContext context) {
	  
	  Connection db = null ;
	  try {
	      db = this.getConnection(context);
	  Organization org = new Organization(db,Integer.parseInt(context.getParameter("orgId")));
	  context.getRequest().setAttribute("orgId", context.getParameter("orgId"));
	  UserBean user = (UserBean) context.getSession().getAttribute("User");
	  org.generaCodice(db, user.getContact().getState());
	  }
	  catch(SQLException e)
	  {
		  e.printStackTrace();
	  }
	  
	  return executeCommandDetails(context);
  }
  
  public String executeCommandViewVigilanza(ActionContext context) {
	    if (!hasPermission(context, "osm-osm-vigilanza-view")) {
	      return ("PermissionError");
	    }
	    Connection db = null;
	    org.aspcfs.modules.vigilanza.base.TicketList ticList = new org.aspcfs.modules.vigilanza.base.TicketList();
	    Organization newOrg = null;
	    //Process request parameters
	    int passedId = Integer.parseInt(
	        context.getRequest().getParameter("orgId"));

	    //Prepare PagedListInfo
	    PagedListInfo ticketListInfo = this.getPagedListInfo(
	        context, "AccountTicketInfo", "t.entered", "desc");
	    ticketListInfo.setLink(
	        "Osm.do?command=ViewVigilanza&orgId=" + passedId);
	    ticList.setPagedListInfo(ticketListInfo);
	    try {
	      db = this.getConnection(context);
	      //find record permissions for portal users
	      
	      SystemStatus systemStatus = this.getSystemStatus(context);
	      LookupList TipoCampione = new LookupList(db, "lookup_tipo_controllo");
	      TipoCampione.addItem(-1,  "-- SELEZIONA VOCE --");
	      context.getRequest().setAttribute("TipoCampione", TipoCampione);
	      
	      org.aspcfs.modules.vigilanza.base.TicketList controlliList = new org.aspcfs.modules.vigilanza.base.TicketList();
	        controlliList.setOrgId(passedId);
	    	
	      
	      LookupList AuditTipo = new LookupList(db, "lookup_audit_tipo");
	      AuditTipo.addItem(-1, "-- SELEZIONA VOCE --");
	      context.getRequest().setAttribute("AuditTipo", AuditTipo);
	      
	      LookupList TipoAudit = new LookupList(db, "lookup_tipo_audit");
	      TipoAudit.addItem(-1, "-- SELEZIONA VOCE --");
	      context.getRequest().setAttribute("TipoAudit", TipoAudit);
	      
	      LookupList EsitoCampione = new LookupList(db, "lookup_esito_campione");
	      EsitoCampione.addItem(-1,  "-- SELEZIONA VOCE --");
	      context.getRequest().setAttribute("EsitoCampione", EsitoCampione);
	     
	      newOrg = new Organization(db, passedId);
	      ticList.setOrgId(passedId);
	      if (newOrg.isTrashed()) {
	        ticList.setIncludeOnlyTrashed(true);
	      }
	      
	      UserBean thisUser = (UserBean) context.getSession().getAttribute("User"); 
			if (thisUser.getRoleId()==Role.RUOLO_CRAS)
				ticList.setIdRuolo(thisUser.getRoleId());
			
	      ticList.buildList(db);
	      context.getRequest().setAttribute("TicList", ticList);
	      context.getRequest().setAttribute("OrgDetails", newOrg);
	      addModuleBean(context, "View Accounts", "Accounts View");
	    } catch (Exception errorMessage) {
	      context.getRequest().setAttribute("Error", errorMessage);
	      return ("SystemError");
	    } finally {
	      this.freeConnection(context, db);
	    }
	    return getReturn(context, "ViewVigilanza");
	  }
  
  public String executeCommandViewCessazionevariazione(ActionContext context) {
	    if (!hasPermission(context, "osm-osm-cessazionevariazione-view")) {
	      return ("PermissionError");
	    }
	    Connection db = null;
	    org.aspcfs.modules.cessazionevariazione.base.TicketList ticList = new org.aspcfs.modules.cessazionevariazione.base.TicketList();
	    Organization newOrg = null;
	    //Process request parameters
	    int passedId = Integer.parseInt(
	        context.getRequest().getParameter("orgId"));

	    //Prepare PagedListInfo
	    PagedListInfo ticketListInfo = this.getPagedListInfo(
	        context, "AccountTicketInfo", "t.entered", "desc");
	    ticketListInfo.setLink(
	        "Osm.do?command=ViewCessazionevariazione&orgId=" + passedId);
	    ticList.setPagedListInfo(ticketListInfo);
	    try {
	      db = this.getConnection(context);
	      //find record permissions for portal users
	      
	      SystemStatus systemStatus = this.getSystemStatus(context);
	      LookupList TipoCampione = new LookupList(db, "lookup_tipo_campione");
	      TipoCampione.addItem(-1,  "-- SELEZIONA VOCE --");
	      context.getRequest().setAttribute("TipoCampione", TipoCampione);
	      
	      LookupList EsitoCampione = new LookupList(db, "lookup_esito_campione");
	      EsitoCampione.addItem(-1,  "-- SELEZIONA VOCE --");
	      context.getRequest().setAttribute("EsitoCampione", EsitoCampione);
	      if (!isRecordAccessPermitted(context, db, passedId)) {
	        return ("PermissionError");
	      }
	      newOrg = new Organization(db, passedId);
	      ticList.setOrgId(passedId);
	      if (newOrg.isTrashed()) {
	        ticList.setIncludeOnlyTrashed(true);
	      }
	      ticList.buildList(db);
	      context.getRequest().setAttribute("TicList", ticList);
	      context.getRequest().setAttribute("OrgDetails", newOrg);
	      addModuleBean(context, "View Accounts", "Accounts View");
	    } catch (Exception errorMessage) {
	      context.getRequest().setAttribute("Error", errorMessage);
	      return ("SystemError");
	    } finally {
	      this.freeConnection(context, db);
	    }
	    return getReturn(context, "ViewCessazionevariazione");
	  }
  

  /**
   *  Search: Displays the Account search form
   *
   * @param  context  Description of Parameter
   * @return          Description of the Returned Value
   */
  public String executeCommandSearchForm(ActionContext context) {
    if (!(hasPermission(context, "osm-osm-view"))) {
      return ("PermissionError");
    }
    
   /* if (!(hasPermission(context, "request-view"))) {
        return ("PermissionError");
      }
*/
    //Bypass search form for portal users
    if (isPortalUser(context)) {
      return (executeCommandSearch(context));
    }
    SystemStatus systemStatus = this.getSystemStatus(context);
    Connection db = null;
    try {
      db = getConnection(context);
      
      
      
/*    LookupList llist=new LookupList(db,"lookup_osm_types");
      llist.addItem(-1, "-nessuno-");
      context.getRequest().setAttribute("llist", llist);
*/
      LookupList impiantoZ = new LookupList(db, "lookup_attivita_osm");
      impiantoZ.addItem(-1,  "-- SELEZIONA VOCE --");
      context.getRequest().setAttribute("impiantoZ", impiantoZ);
           
      LookupList categoriaList = new LookupList(db, "lookup_categoria");
      categoriaList.addItem(-1,  "-- SELEZIONA VOCE --");
      context.getRequest().setAttribute("CategoriaList", categoriaList);
      
      LookupList siteList = new LookupList(db, "lookup_site_id");
      siteList.addItem(-1,  "-- SELEZIONA VOCE --");
      context.getRequest().setAttribute("SiteList", siteList);
      
      LookupList statoLab = new LookupList(db, "lookup_stato_lab");
      statoLab.addItem(-1,  "-- SELEZIONA VOCE --");
      context.getRequest().setAttribute("statoLab", statoLab);
      
      LookupList impianto = new LookupList(db, "lookup_attivita_osm");
      impianto.addItem(-1,  "-- SELEZIONA VOCE --");
      context.getRequest().setAttribute("impianto", impianto);
      
      //tabella modificata
      
      UserBean user = (UserBean) context.getSession().getAttribute("User");
      org.aspcfs.modules.accounts.base.Comuni c = new org.aspcfs.modules.accounts.base.Comuni();
      ArrayList<org.aspcfs.modules.accounts.base.Comuni> listaComuni = c.buildList(db, user.getSiteId());
      LookupList comuniList = new LookupList(listaComuni);
      
      comuniList.addItem(-1, "");
      context.getRequest().setAttribute("ComuniList", comuniList);

      //reset the offset and current letter of the paged list in order to make sure we search ALL accounts
      PagedListInfo orgListInfo = this.getPagedListInfo(
          context, "SearchOrgListInfo");
      orgListInfo.setCurrentLetter("");
      orgListInfo.setCurrentOffset(0);
      if (orgListInfo.getSearchOptionValue("searchcodeContactCountry") != null && !"-1".equals(orgListInfo.getSearchOptionValue("searchcodeContactCountry"))) {
        StateSelect stateSelect = new StateSelect(systemStatus,orgListInfo.getSearchOptionValue("searchcodeContactCountry"));
        if (orgListInfo.getSearchOptionValue("searchContactOtherState") != null) {
          HashMap map = new HashMap();
          map.put((String)orgListInfo.getSearchOptionValue("searchcodeContactCountry"), (String)orgListInfo.getSearchOptionValue("searchContactOtherState"));
          stateSelect.setPreviousStates(map);
        }
        context.getRequest().setAttribute("ContactStateSelect", stateSelect);
      }
      if (orgListInfo.getSearchOptionValue("searchcodeAccountCountry") != null && !"-1".equals(orgListInfo.getSearchOptionValue("searchcodeAccountCountry"))) {
        StateSelect stateSelect = new StateSelect(systemStatus,orgListInfo.getSearchOptionValue("searchcodeAccountCountry"));
        if (orgListInfo.getSearchOptionValue("searchAccountOtherState") != null) {
          HashMap map = new HashMap();
          map.put((String)orgListInfo.getSearchOptionValue("searchcodeAccountCountry"), (String)orgListInfo.getSearchOptionValue("searchAccountOtherState"));
          stateSelect.setPreviousStates(map);
        }
        context.getRequest().setAttribute("AccountStateSelect", stateSelect);
      }
    } catch (Exception e) {
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    addModuleBean(context, "Search Accounts", "Accounts Search");
    return ("SearchOK");
  }


  /**
   *  Add: Displays the form used for adding a new Account
   *
   * @param  context  Description of Parameter
   * @return          Description of the Returned Value
   */
  public String executeCommandAdd(ActionContext context) {
    if (!hasPermission(context, "osm-osm-add")) {
      return ("PermissionError");
    }
    SystemStatus systemStatus = this.getSystemStatus(context);
    Connection db = null;
    try {
      db = this.getConnection(context);
      LookupList siteList = new LookupList(db, "lookup_site_id");
      siteList.addItem(-1,  "-- SELEZIONA VOCE --");
      context.getRequest().setAttribute("SiteList", siteList);
      

      
      LookupList statoLab = new LookupList(db, "lookup_stato_lab");
      statoLab.addItem(-1,  "-- SELEZIONA VOCE --");
      context.getRequest().setAttribute("statoLab", statoLab);
      
      LookupList impianto = new LookupList(db, "lookup_attivita_osm");
      impianto.addItem(-1,  "-- SELEZIONA VOCE --");
      context.getRequest().setAttribute("impianto", impianto);
      
      
      
      //LOOKUP CATEGORIA AGGIUNTA DA GIUSEPPE
      LookupList categoriaList = new LookupList(db, "lookup_categoria");
      categoriaList.addItem(-1,  "-- SELEZIONA VOCE --");
      context.getRequest().setAttribute("CategoriaList", categoriaList);

      Organization newOrg = (Organization) context.getFormBean();
      ApplicationPrefs prefs = (ApplicationPrefs) context.getServletContext().getAttribute("applicationPrefs");
      StateSelect stateSelect = new StateSelect(systemStatus, (newOrg.getAddressList() != null?newOrg.getAddressList().getCountries():"")+prefs.get("SYSTEM.COUNTRY"));
      stateSelect.setPreviousStates((newOrg.getAddressList() != null? newOrg.getAddressList().getSelectedStatesHashMap():new HashMap()));
      context.getRequest().setAttribute("StateSelect", stateSelect);
            
      UserBean thisUser = (UserBean) context.getSession().getAttribute("User");
      String provincia = thisUser.getContact().getState();
      ArrayList<Integer> asl_id = new ArrayList<Integer>();
      
      if(provincia!=null){
      if(provincia.equals("AV")){
    	  asl_id.add(201);
    	  
      }else if(provincia.equals("BN")){
    	  asl_id.add(202);
      }else if(provincia.equals("CE")){
    	  asl_id.add(203);
    	  
      }else if(provincia.equals("NA")){
    	  asl_id.add(204);
    	  asl_id.add(205);
    	  asl_id.add(206);
    	 
    	  
      }else if(provincia.equals("SA")){
    	  asl_id.add(207);
    	
    	  
      }}
      newOrg.setComuniProvincia(db, asl_id );
     
    } catch (Exception e) {
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    addModuleBean(context, "Add Account", "Accounts Add");
    context.getRequest().setAttribute(
        "systemStatus", this.getSystemStatus(context));
    //if a different module reuses this action then do a explicit return
    if (context.getRequest().getParameter("actionSource") != null) {
        return getReturn(context, "AddAccount");
    }

    return getReturn(context, "Add");
  }


  /**
   *  Details: Displays all details relating to the selected Account. The user
   *  can also goto a modify page from this form or delete the Account entirely
   *  from the database
   *
   * @param  context  Description of Parameter
   * @return          Description of the Returned Value
   */
  public String executeCommandDetails(ActionContext context) {
    if (!hasPermission(context, "osm-osm-view")) {
      return ("PermissionError");
    }
    
	context.getRequest().setAttribute("Messaggio", (String)context.getRequest().getAttribute("Messaggio"));

    Connection   db           = null;
    SystemStatus systemStatus = this.getSystemStatus(context);
    Organization newOrg       = null;
    ArrayList    elencoAttivita = null;
    try {
    	 org.aspcfs.modules.osm.base.OrganizationAddress soperativa = null;
    	 
    	 /**
    	  * 	COSTRUZIONE DEL BEAN A PARTIRE DALL'ID IN INPUT
    	  */
    		
    	 String temporgId = context.getRequest().getParameter("orgId");
         if (temporgId == null) {
           temporgId = (String) context.getRequest().getAttribute("orgId");
         }
         int tempid = Integer.parseInt(temporgId);
         db = this.getConnection(context);
//         if (!isRecordAccessPermitted(context, db, Integer.parseInt(temporgId))) {
//           return ("PermissionError");
//         }
         newOrg = new Organization(db, tempid);
         //Caricamento Diffide
         Ticket t = new Ticket();
 		context.getRequest().setAttribute("DiffideList", t.getDiffide(db,false,null,null,newOrg.getOrgId(),null));
 		context.getRequest().setAttribute("DiffideListStorico", t.getDiffide(db,true,null,null,newOrg.getOrgId(),null));
        
      Iterator it1 = newOrg.getAddressList().iterator();
   	  int nlocali =0;
   	  while(it1.hasNext())
   	  {
   		  org.aspcfs.modules.osm.base.OrganizationAddress add=(org.aspcfs.modules.osm.base.OrganizationAddress)it1.next();
   		  if(add.getType()==5)
       		  {
       		  soperativa=add;
       		  }
   		 if(add.getLatitude()!=0 && add.getLongitude()!=0){
    		  String spatial_coords [] = null;
    		  spatial_coords = this.converToWgs84UTM33NInverter(Double.toString(add.getLatitude()), Double.toString(add.getLongitude()),db);
//    		  if (Double.parseDouble(spatial_coords[0].replace(',', '.'))< 39.988475 || Double.parseDouble(spatial_coords[0].replace(',', '.'))> 41.503754)
//    		  {
//    			 AjaxCalls ajaxCall = new AjaxCalls();
//    			 String[] coordinate= ajaxCall.getCoordinate(add.getStreetAddressLine1(), add.getCity(), add.getState(), add.getZip(), ""+add.getLatitude(), ""+add.getLongitude(), "");
//    			 add.setLatitude(coordinate[1]);
//    			 add.setLongitude(coordinate[0]);
//    		  }
//    		  else
//    		  {
    			  add.setLatitude(spatial_coords[0]);
    			  add.setLongitude(spatial_coords[1]);
    		  //}

    		  
    		  
    	  }
   		  
   	  }
   	 context.getRequest().setAttribute("AddressSedeOperativa",soperativa);
      
      //check whether or not the owner is an active User
      newOrg.setOwner(this.getUserId(context));
      
      LookupList siteList = new LookupList(db, "lookup_site_id");
      siteList.addItem(-1,  "-- SELEZIONA VOCE --");
      context.getRequest().setAttribute("SiteList", siteList);
      
      LookupList statoLab = new LookupList(db, "lookup_stato_lab");
      statoLab.addItem(-1,  "-- SELEZIONA VOCE --");
      context.getRequest().setAttribute("statoLab", statoLab);
      
      LookupList categoriaRischioList = new LookupList(db, "lookup_org_catrischio");
      categoriaRischioList.addItem(-1,  "-- SELEZIONA VOCE --");
      context.getRequest().setAttribute("OrgCategoriaRischioList", categoriaRischioList);
      
      LookupList impianto = new LookupList(db, "lookup_attivita_osm");
      impianto.addItem(-1,  "-- SELEZIONA VOCE --");
      context.getRequest().setAttribute("impianto", impianto);
      
      LookupList IstatList = new LookupList(db, "lookup_codistat");
      IstatList.addItem(-1, getSystemStatus(context).getLabel("calendar.none.4dashes"));
      context.getRequest().setAttribute("IstatList", IstatList);

      String codice1 = null;
      String codice2 = null;
      String codice3 = null;
      String codice4 = null;
      String codice5 = null;
      String codice6 = null;
      String codice7 = null;
      String codice8 = null;
      String codice9 = null;
      String codice10 = null;
      
      if(newOrg.getCodice1()!=null){
      codice1 = IstatList.getSelectedValueShort(newOrg.getCodice1(), db);
      context.getRequest().setAttribute("codice1", codice1);
      }else if(newOrg.getCodice2()!=null){
      codice2 = IstatList.getSelectedValueShort(newOrg.getCodice2(), db);
      context.getRequest().setAttribute("codice2", codice2);
      }else if(newOrg.getCodice3()!=null){
      codice3 = IstatList.getSelectedValueShort(newOrg.getCodice3(), db);
      context.getRequest().setAttribute("codice3", codice3);
      }else if(newOrg.getCodice4()!=null){
      codice4 = IstatList.getSelectedValueShort(newOrg.getCodice4(), db);
      context.getRequest().setAttribute("codice4", codice4);
      }else if(newOrg.getCodice5()!=null){
      codice5 = IstatList.getSelectedValueShort(newOrg.getCodice5(), db);
      context.getRequest().setAttribute("codice5", codice5);
      }else if(newOrg.getCodice6()!=null){
      codice6 = IstatList.getSelectedValueShort(newOrg.getCodice6(), db);
      context.getRequest().setAttribute("codice6", codice6);
      }else if(newOrg.getCodice7()!=null){
      codice7 = IstatList.getSelectedValueShort(newOrg.getCodice7(), db);
      context.getRequest().setAttribute("codice7", codice7);
      }else if(newOrg.getCodice8()!=null){
      codice8 = IstatList.getSelectedValueShort(newOrg.getCodice8(), db);
      context.getRequest().setAttribute("codice8", codice8);
      }else if(newOrg.getCodice9()!=null){
      codice9 = IstatList.getSelectedValueShort(newOrg.getCodice9(), db);
      context.getRequest().setAttribute("codice9", codice9);
      }else if(newOrg.getCodice10()!=null){
      codice10 = IstatList.getSelectedValueShort(newOrg.getCodice10(), db);
      context.getRequest().setAttribute("codice10", codice10);
      }     
      
      
      LookupList categoriaList = new LookupList(db, "lookup_categoria");
      categoriaList.addItem(-1,  "-- SELEZIONA VOCE --");
      context.getRequest().setAttribute("categoriaList", categoriaList);
      
      LookupList imballataList = new LookupList(db, "lookup_sottoattivita_imballata");
      imballataList.addItem(-1,  "-- SELEZIONA VOCE --");
      context.getRequest().setAttribute("imballataList", imballataList);
      
      LookupList tipoAutorizzazioneList = new LookupList(db, "lookup_sottoattivita_tipoautorizzazione");
      tipoAutorizzazioneList.addItem(-1,  "-- SELEZIONA VOCE --");
      context.getRequest().setAttribute("tipoAutorizzazioneList", tipoAutorizzazioneList);
      
      elencoAttivita =  SottoAttivita.loadByStabilimento(tempid, db);
      
      /*org.aspcfs.modules.audit.base.AuditList audit = new org.aspcfs.modules.audit.base.AuditList();
      int AuditOrgId = newOrg.getOrgId();
      audit.setOrgId(AuditOrgId);
     
    //  audit.buildList(db);
      
      if( (audit.size() - 1)>=0){
      
    	  context.getRequest().setAttribute("Audit",audit.get(0) );
      }*/
      context.getRequest().setAttribute("elencoSottoAttivita", elencoAttivita);
      
    } catch (Exception e) {
    	e.printStackTrace();
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    addRecentItem(context, newOrg);
    String action = context.getRequest().getParameter("action");
    if (action != null && action.equals("modify")) {
      //If user is going to the modify form
      addModuleBean(context, "Accounts", "Modify Account Details");
      return ("DetailsOK");
    } else {
      //If user is going to the detail screen
      addModuleBean(context, "View Accounts", "View Account Details");
      context.getRequest().setAttribute("OrgDetails", newOrg);
      if(context.getRequest().getAttribute("generato")!=null)
    	  return "generazioneCodiceOk";
      return getReturn(context, "Details");
    }
  }
  
 
  /**
   *  Description of the Method
   *
   * @param  context  Description of the Parameter
   * @return          Description of the Return Value
   */
  public String executeCommandDashboardScelta(ActionContext context) {

	// Controllo per i permessi dell'utente
    if (!hasPermission(context, "osm-home-view")) {
      if (!hasPermission(context, "osm-osm-view")) {
        return ("PermissionError");
      }
    }
    
    return ("DashboardSceltaOK");
  }
  

  /**
   *  Description of the Method
   *
   * @param  context  Description of the Parameter
   * @return          Description of the Return Value
   */
  public String executeCommandDashboard(ActionContext context) {
    if (!hasPermission(context, "osm-dashboard-view")) {
      if (!hasPermission(context, "osm-osm-view")) {
        return ("PermissionError");
      }
      //Bypass dashboard and search form for portal users
      if (isPortalUser(context)) {
        return (executeCommandSearch(context));
      }
      return (executeCommandSearchForm(context));
    }
    addModuleBean(context, "Dashboard", "Dashboard");
    CalendarBean calendarInfo = (CalendarBean) context.getSession().getAttribute(
        "AccountsCalendarInfo");
    if (calendarInfo == null) {
      calendarInfo = new CalendarBean(
          this.getUser(context, this.getUserId(context)).getLocale());
      calendarInfo.addAlertType(
          "Accounts", "org.aspcfs.modules.osm.base.AccountsListScheduledActions", "Accounts");
      calendarInfo.setCalendarDetailsView("Accounts");
      context.getSession().setAttribute("AccountsCalendarInfo", calendarInfo);
    }

    UserBean thisUser = (UserBean) context.getSession().getAttribute("User");

    //this is how we get the multiple-level heirarchy...recursive function.
    User thisRec = thisUser.getUserRecord();

    UserList shortChildList = thisRec.getShortChildList();
    UserList newUserList = thisRec.getFullChildList(
        shortChildList, new UserList());

    newUserList.setMyId(getUserId(context));
    newUserList.setMyValue(
        thisUser.getUserRecord().getContact().getNameLastFirst());
    newUserList.setIncludeMe(true);

    newUserList.setJsEvent(
        "onChange = \"javascript:fillFrame('calendar','MyCFS.do?command=MonthView&source=Calendar&userId='+document.getElementById('userId').value + '&return=Accounts'); javascript:fillFrame('calendardetails','MyCFS.do?command=Alerts&source=CalendarDetails&userId='+document.getElementById('userId').value + '&return=Accounts');javascript:changeDivContent('userName','Scheduled Actions for ' + document.getElementById('userId').options[document.getElementById('userId').selectedIndex].firstChild.nodeValue);\"");
    HtmlSelect userListSelect = newUserList.getHtmlSelectObj(
        "userId", getUserId(context));
    userListSelect.addAttribute("id", "userId");
    context.getRequest().setAttribute("Return", "Accounts");
    context.getRequest().setAttribute("NewUserList", userListSelect);
    return ("DashboardOK");
  }


  /**
   *  Search Accounts
   *
   * @param  context  Description of the Parameter
   * @return          Description of the Return Value
   */
  public String executeCommandSearch(ActionContext context) {
    if (!hasPermission(context, "osm-osm-view")) {
      return ("PermissionError");
    }
    String categoriaR = (String) context.getRequest().getParameter("searchcodecategoriaRischio");

    String source = (String) context.getRequest().getParameter("source");
    String stato = (String) context.getRequest().getParameter("searchstatoLab");
    String impianto = (String) context.getRequest().getParameter("searchimpianto");
    String categoria_id = (String)context.getRequest().getParameter("searchcodeCodiceSezione");
    String categoria_R = (String)context.getRequest().getParameter("searchcodecategoriaRischio");
    String codiceAllerta = context.getRequest().getParameter("searchcodiceAllerta");
    String name =context.getRequest().getParameter("searchAccountName"); 
    OrganizationList organizationList = new OrganizationList();
    addModuleBean(context, "View Accounts", "Search Results");

    //Prepare pagedListInfo
    PagedListInfo searchListInfo = this.getPagedListInfo(
        context, "SearchOrgListInfo");
    searchListInfo.setLink("Osm.do?command=Search");
    SystemStatus systemStatus = this.getSystemStatus(context);
    //Need to reset any sub PagedListInfos since this is a new account
    this.resetPagedListInfo(context);
    Connection db = null;
    try {
      db = this.getConnection(context);

      //For portal usr set source as 'searchForm' explicitly since
      //the search form is bypassed.
      //temporary solution for page redirection for portal user.
      if (isPortalUser(context)) {
        organizationList.setOrgSiteId(this.getUserSiteId(context));
        source = "searchForm";
      }
      organizationList.setCategoria(categoria_R);
      organizationList.setTipologia(800);
      
      if(!"".equals(impianto) && impianto!=null && !impianto.equals("-1")) {
      	organizationList.setImpianto(impianto);
      	 }
      if(!"".equals(stato) && stato!=null && !stato.equals("-1")) {
        	organizationList.setStatoLab(stato);
        	 }
      if((context.getParameter("searchNumAut"))!=null){
          organizationList.setNumAut(context.getParameter("searchNumAut"));
          }
      if(categoriaR!=null)
      organizationList.setCategoriaRischio(Integer.parseInt(categoriaR));
     /* org.aspcfs.modules.audit.base.AuditList audit = new org.aspcfs.modules.audit.base.AuditList();
     // audit.buildList(db);
      context.getRequest().setAttribute("AuditList",audit );
      */
      if(!"".equals(codiceAllerta) && codiceAllerta != null)
      	organizationList.setCodiceAllerta(codiceAllerta);
      
      if(!"".equals(name) && name != null)
        	organizationList.setName(name);
      
      //return if no criteria is selected
      if ((searchListInfo.getListView() == null || "".equals(
          searchListInfo.getListView())) && !"searchForm".equals(source)) {
        return "ListOK";
      }
      UserBean user = (UserBean) context.getSession().getAttribute("User");
      org.aspcfs.modules.accounts.base.Comuni c = new org.aspcfs.modules.accounts.base.Comuni();
      ArrayList<org.aspcfs.modules.accounts.base.Comuni> listaComuni = c.buildList(db, user.getSiteId());
      LookupList comuniList = new LookupList(listaComuni);
      
      comuniList.addItem(-1, "");
      context.getRequest().setAttribute("ComuniList", comuniList);
      
      LookupList siteList = new LookupList(db, "lookup_site_id");
      siteList.addItem(-1,  "-- SELEZIONA VOCE --");
      siteList.addItem(-2, "-- TUTTI --");
      context.getRequest().setAttribute("SiteIdList", siteList);
     
      LookupList impiantoZ = new LookupList(db, "lookup_attivita_osm");
      impiantoZ.addItem(-1,  "-- SELEZIONA VOCE --");
      context.getRequest().setAttribute("impianto", impiantoZ);
      
      //inserito da Carmela
      LookupList OrgCategoriaRischioList = new LookupList(db, "lookup_org_catrischio");
      OrgCategoriaRischioList.addItem(-1,  "-- SELEZIONA VOCE --");
      context.getRequest().setAttribute("OrgCategoriaRischioList", OrgCategoriaRischioList);
      
      
      LookupList statoLab = new LookupList(db, "lookup_stato_lab");
      statoLab.addItem(-1,  "-- SELEZIONA VOCE --");
      context.getRequest().setAttribute("statoLab", statoLab);
      
      
      //Display list of accounts if user chooses not to list contacts
      if (!"true".equals(searchListInfo.getCriteriaValue("searchContacts"))) {
        if ("contacts".equals(context.getSession().getAttribute("previousSearchType"))) {
          this.deletePagedListInfo(context, "SearchOrgListInfo");
          searchListInfo = this.getPagedListInfo(context, "SearchOrgListInfo");
          searchListInfo.setLink("Osm.do?command=Search");
        }
        //Build the organization list
        organizationList.setPagedListInfo(searchListInfo);
        organizationList.setMinerOnly(false);
        organizationList.setTypeId(searchListInfo.getFilterKey("listFilter1"));
        
    
        if((context.getParameter("searchNumAut"))!=null){
        organizationList.setNumAut(context.getParameter("searchNumAut"));
        }
        organizationList.setStageId(searchListInfo.getCriteriaValue("searchcodeStageId"));
        
        searchListInfo.setSearchCriteria(organizationList, context);
        //fetching criterea for account source (my accounts or all accounts)
        if ("my".equals(searchListInfo.getListView())) {
          organizationList.setOwnerId(this.getUserId(context));
        }
        if (organizationList.getOrgSiteId() == Constants.INVALID_SITE) {
          organizationList.setOrgSiteId(this.getUserSiteId(context));
          organizationList.setIncludeOrganizationWithoutSite(false);
        } else if (organizationList.getOrgSiteId() == -1) {
          organizationList.setIncludeOrganizationWithoutSite(true);
        }
        //fetching criterea for account status (active, disabled or any)
        int enabled = searchListInfo.getFilterKey("listFilter2");
        organizationList.setIncludeEnabled(enabled);
        //If the user is a portal user, fetching only the
        //the organization that he access to
        //(i.e., the organization for which he is an account contact
        if (isPortalUser(context)) {
          organizationList.setOrgSiteId(this.getUserSiteId(context));
          organizationList.setIncludeOrganizationWithoutSite(false);
          organizationList.setOrgId(getPortalUserPermittedOrgId(context));
        }
        organizationList.buildList(db);
        context.getRequest().setAttribute("OrgList", organizationList);
        context.getSession().setAttribute("previousSearchType", "accounts");
        if (organizationList.size() == 1 && organizationList.getAssetSerialNumber() != null) {
          AssetList assets = new AssetList();
          assets.setOrgId(((Organization) organizationList.get(0)).getId());
          assets.setSerialNumber(organizationList.getAssetSerialNumber());
          assets.setSkipParentIdRequirement(true);
          assets.buildList(db);
          if (assets.size() == 1) {
            Asset asset = (Asset) assets.get(0);
            context.getRequest().setAttribute(
                "id", String.valueOf(asset.getId()));
            return "AssetDetailsOK";
          }
        }
        return "ListOK";
      } else {}
    } catch (Exception e) {
      //Go through the SystemError process
    	e.printStackTrace();
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }return "" ;
  }


  public static void generaCodice(Connection db, org.aspcfs.modules.osm.base.Organization thisOrganization, String provincia) throws SQLException
  {
	  try
	  {
		  thisOrganization.generaCodice(db, provincia);
	  }  
	  catch(Exception e)
	  {
		  thisOrganization.rollback_sequence(db, provincia);
		  e.printStackTrace();
		
	  }
	
 }
  
  /**
   *  Insert: Inserts a new Account into the database.
   *
   * @param  context  Description of Parameter
   * @return          Description of the Returned Value
   */
  public String executeCommandInsert(ActionContext context) {
    if (!hasPermission(context, "osm-osm-add")) {
      return ("PermissionError");
    }
    Connection db = null;
    boolean recordInserted = false;
    boolean isValid = false;
    Organization insertedOrg = null;
    SystemStatus systemStatus = this.getSystemStatus(context);
    Organization newOrg = (Organization) context.getFormBean();
    Audit audit = new Audit();
    audit.setLivelloRischioFinale(-1);

    newOrg.setTypeList(context.getRequest().getParameterValues("selectedList"));
    newOrg.setEnteredBy(getUserId(context));
    newOrg.setContractEndDate(new Timestamp(System.currentTimeMillis()));
    newOrg.setModifiedBy(getUserId(context));
    newOrg.setOwner(getUserId(context));
    newOrg.setImpianto(context.getRequest().getParameter("impianto"));
    newOrg.setStatoLab(context.getRequest().getParameter("statoLab"));
    newOrg.setCategoriaRischio(3);
    UserBean user = (UserBean) context.getSession().getAttribute("User");
    String ip = user.getUserRecord().getIp();
    newOrg.setIp_entered(ip);
    newOrg.setIp_modified(ip);
    
    
    try {
      db = this.getConnection(context);

     
      //aggiunto da d.dauria
      LookupList statoLab = new LookupList(db, "lookup_stato_lab");
      statoLab.addItem(-1,  "-- SELEZIONA VOCE --");
      context.getRequest().setAttribute("statoLab", statoLab);
      
      LookupList OrgCategoriaRischioList = new LookupList(db, "lookup_org_catrischio");
      OrgCategoriaRischioList.addItem(-1,  "-- SELEZIONA VOCE --");
      context.getRequest().setAttribute("OrgCategoriaRischioList", OrgCategoriaRischioList);
      
      LookupList impianto = new LookupList(db, "lookup_attivita_osm");
      impianto.addItem(-1,  "-- SELEZIONA VOCE --");
      context.getRequest().setAttribute("impianto", impianto);
      
      LookupList IstatList = new LookupList(db, "lookup_codistat");
      IstatList.addItem(-1, getSystemStatus(context).getLabel("calendar.none.4dashes"));
      context.getRequest().setAttribute("IstatList", IstatList);

      String codice1 = null;
      String codice2 = null;
      String codice3 = null;
      String codice4 = null;
      String codice5 = null;
      String codice6 = null;
      String codice7 = null;
      String codice8 = null;
      String codice9 = null;
      String codice10 = null;
      
      if(newOrg.getCodice1()!=null){
      codice1 = IstatList.getSelectedValueShort(newOrg.getCodice1(), db);
      context.getRequest().setAttribute("codice1", codice1);
      }else if(newOrg.getCodice2()!=null){
      codice2 = IstatList.getSelectedValueShort(newOrg.getCodice2(), db);
      context.getRequest().setAttribute("codice2", codice2);
      }else if(newOrg.getCodice3()!=null){
      codice3 = IstatList.getSelectedValueShort(newOrg.getCodice3(), db);
      context.getRequest().setAttribute("codice3", codice3);
      }else if(newOrg.getCodice4()!=null){
      codice4 = IstatList.getSelectedValueShort(newOrg.getCodice4(), db);
      context.getRequest().setAttribute("codice4", codice4);
      }else if(newOrg.getCodice5()!=null){
      codice5 = IstatList.getSelectedValueShort(newOrg.getCodice5(), db);
      context.getRequest().setAttribute("codice5", codice5);
      }else if(newOrg.getCodice6()!=null){
      codice6 = IstatList.getSelectedValueShort(newOrg.getCodice6(), db);
      context.getRequest().setAttribute("codice6", codice6);
      }else if(newOrg.getCodice7()!=null){
      codice7 = IstatList.getSelectedValueShort(newOrg.getCodice7(), db);
      context.getRequest().setAttribute("codice7", codice7);
      }else if(newOrg.getCodice8()!=null){
      codice8 = IstatList.getSelectedValueShort(newOrg.getCodice8(), db);
      context.getRequest().setAttribute("codice8", codice8);
      }else if(newOrg.getCodice9()!=null){
      codice9 = IstatList.getSelectedValueShort(newOrg.getCodice9(), db);
      context.getRequest().setAttribute("codice9", codice9);
      }else if(newOrg.getCodice10()!=null){
      codice10 = IstatList.getSelectedValueShort(newOrg.getCodice10(), db);
      context.getRequest().setAttribute("codice10", codice10);
      }
      
   
        //don't want to populate the addresses, etc. if this is an individual account
        newOrg.setIsIndividual(false);
        newOrg.setRequestItems(context);
     
      if (this.getUserSiteId(context) != -1) {
        // Set the site Id of the account to be equal to the site Id of the user
        // for a new account
        if (newOrg.getId() == -1) {
          newOrg.setSiteId(this.getUserSiteId(context));
        } else {
          // Check whether the user has access to update the organization
          if (!isRecordAccessPermitted(context, db, newOrg.getId())) {
            return ("PermissionError");
          }
        }
      }

      isValid = this.validateObject(context, db, newOrg);
      Iterator it = newOrg.getAddressList().iterator();
      while(it.hasNext())
      {
    	  org.aspcfs.modules.osm.base.OrganizationAddress thisAddress = (org.aspcfs.modules.osm.base.OrganizationAddress) it.next();
    	  //RICHIAMO METODO PER CONVERSIONE COORDINATE
    	  String[] coords = null;
    	  if(thisAddress.getLatitude()!= 0 && thisAddress.getLongitude() != 0) {
    		  coords = this.convert2Wgs84UTM33N(Double.toString(thisAddress.getLatitude()), Double.toString(thisAddress.getLongitude()),db);
    		  thisAddress.setLatitude(coords[1]);
        	  thisAddress.setLongitude(coords[0]);
    	  }
      }//Fine aggiunta
        
      
      if (isValid) {
        recordInserted = newOrg.insert(db,context);
      }
      if (recordInserted) {
        insertedOrg = new Organization(db, newOrg.getOrgId());
        context.getRequest().setAttribute("OrgDetails", insertedOrg);
        addRecentItem(context, newOrg);

        
      }
    } catch (Exception errorMessage) {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    addModuleBean(context, "View Accounts", "Accounts Insert ok");
    if (recordInserted) {
      String target = context.getRequest().getParameter("target");
      if (context.getRequest().getParameter("popup") != null) {
        return ("ClosePopupOK");
      }
      if (target != null && "add_contact".equals(target)) {
       	  return ("InsertAndAddContactOK");  
      } else {
    	  return ("InsertOK");
      }
    }
    return (executeCommandAdd(context));
  }


  /**
   *  Update: Updates the Organization table to reflect user-entered
   *  changes/modifications to the currently selected Account
   *
   * @param  context  Description of Parameter
   * @return          Description of the Returned Value
   */
  public String executeCommandUpdate(ActionContext context) {
    if (!(hasPermission(context, "osm-osm-edit"))) {
      return ("PermissionError");
    }
    Connection db = null;
    int resultCount = -1;
    boolean isValid = false;
    Organization newOrg = (Organization) context.getFormBean(); 
    Organization oldOrg = null;
    SystemStatus systemStatus = this.getSystemStatus(context);
    newOrg.setTypeList(
        context.getRequest().getParameterValues("selectedList"));
    newOrg.setModifiedBy(getUserId(context));
    newOrg.setEnteredBy(getUserId(context));
    UserBean user = (UserBean) context.getSession().getAttribute("User");
    String ip = user.getUserRecord().getIp();
    newOrg.setIp_entered(ip);
    newOrg.setIp_modified(ip);
    try {
      db = this.getConnection(context);
      //set the name to namelastfirstmiddle if individual
    
 
        //don't want to populate the addresses, etc. if this is an individual account
        newOrg.setIsIndividual(false);
        newOrg.setRequestItems(context);
      
     
     
      oldOrg = new Organization(db, newOrg.getOrgId());
      isValid = this.validateObject(context, db, newOrg);
      
      Iterator it = newOrg.getAddressList().iterator();
      while(it.hasNext())
      {
    	  org.aspcfs.modules.osm.base.OrganizationAddress thisAddress = (org.aspcfs.modules.osm.base.OrganizationAddress) it.next();
    	  //RICHIAMO METODO PER CONVERSIONE COORDINATE
    	  String[] coords = null;
    	  if(thisAddress.getLatitude()!= 0 && thisAddress.getLongitude() != 0) {
    		  coords = this.convert2Wgs84UTM33N(Double.toString(thisAddress.getLatitude()), Double.toString(thisAddress.getLongitude()),db);
    		  thisAddress.setLatitude(coords[1]);
        	  thisAddress.setLongitude(coords[0]);
    	  }
      }//Fine aggiunta
      
      
      if (isValid) {
        resultCount = newOrg.update(db,context);
      }
      if (resultCount == 1) {
        processUpdateHook(context, oldOrg, newOrg);
        //if this is an individual account, populate and update the primary contact
       
        //update all contacts which are associated with this organization
      
        LookupList IstatList = new LookupList(db, "lookup_codistat");
        IstatList.addItem(-1, getSystemStatus(context).getLabel("calendar.none.4dashes"));
        context.getRequest().setAttribute("IstatList", IstatList);
          
        String codice1 = null;
        String codice2 = null;
        String codice3 = null;
        String codice4 = null;
        String codice5 = null;
        String codice6 = null;
        String codice7 = null;
        String codice8 = null;
        String codice9 = null;
        String codice10 = null;
        
        if(newOrg.getCodice1()!=null){
        codice1 = IstatList.getSelectedValueShort(newOrg.getCodice1(), db);
        context.getRequest().setAttribute("codice1", codice1);
        }else if(newOrg.getCodice2()!=null){
        codice2 = IstatList.getSelectedValueShort(newOrg.getCodice2(), db);
        context.getRequest().setAttribute("codice2", codice2);
        }else if(newOrg.getCodice3()!=null){
        codice3 = IstatList.getSelectedValueShort(newOrg.getCodice3(), db);
        context.getRequest().setAttribute("codice3", codice3);
        }else if(newOrg.getCodice4()!=null){
        codice4 = IstatList.getSelectedValueShort(newOrg.getCodice4(), db);
        context.getRequest().setAttribute("codice4", codice4);
        }else if(newOrg.getCodice5()!=null){
        codice5 = IstatList.getSelectedValueShort(newOrg.getCodice5(), db);
        context.getRequest().setAttribute("codice5", codice5);
        }else if(newOrg.getCodice6()!=null){
        codice6 = IstatList.getSelectedValueShort(newOrg.getCodice6(), db);
        context.getRequest().setAttribute("codice6", codice6);
        }else if(newOrg.getCodice7()!=null){
        codice7 = IstatList.getSelectedValueShort(newOrg.getCodice7(), db);
        context.getRequest().setAttribute("codice7", codice7);
        }else if(newOrg.getCodice8()!=null){
        codice8 = IstatList.getSelectedValueShort(newOrg.getCodice8(), db);
        context.getRequest().setAttribute("codice8", codice8);
        }else if(newOrg.getCodice9()!=null){
        codice9 = IstatList.getSelectedValueShort(newOrg.getCodice9(), db);
        context.getRequest().setAttribute("codice9", codice9);
        }else if(newOrg.getCodice10()!=null){
        codice10 = IstatList.getSelectedValueShort(newOrg.getCodice10(), db);
        context.getRequest().setAttribute("codice10", codice10);
        }

      
        
        LookupList statoLab = new LookupList(db, "lookup_stato_lab");
        statoLab.addItem(-1,  "-- SELEZIONA VOCE --");
        context.getRequest().setAttribute("statoLab", statoLab);
        
        LookupList OrgCategoriaRischioList = new LookupList(db, "lookup_org_catrischio");
        OrgCategoriaRischioList.addItem(-1,  "-- SELEZIONA VOCE --");
        context.getRequest().setAttribute("OrgCategoriaRischioList", OrgCategoriaRischioList);
        
        LookupList impianto = new LookupList(db, "lookup_attivita_osm");
        impianto.addItem(-1,  "-- SELEZIONA VOCE --");
        context.getRequest().setAttribute("impianto", impianto);
        

      }
    } catch (Exception errorMessage) {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    addModuleBean(context, "View Accounts", "Modify Account");
    
    if (resultCount == -1 || !isValid) {
      return (executeCommandModify(context));
    } else if (resultCount == 1) {
      if (context.getRequest().getParameter("return") != null && context.getRequest().getParameter(
          "return").equals("list")) {
        return (executeCommandSearch(context));
      } else if (context.getRequest().getParameter("return") != null && context.getRequest().getParameter(
          "return").equals("dashboard")) {
        return (executeCommandDashboard(context));
      } else if (context.getRequest().getParameter("return") != null && context.getRequest().getParameter(
          "return").equals("Calendar")) {
        if (context.getRequest().getParameter("popup") != null) {
          return ("PopupCloseOK");
        }
      } else {
        return ("UpdateOK");
      }
    } else {
      context.getRequest().setAttribute("Error", NOT_UPDATED_MESSAGE);
      return ("UserError");
    }
    return ("UpdateOK");
  }

  /**
   *  Update: Updates the Organization table to reflect user-entered
   *  changes/modifications to the currently selected Account
   *
   * @param  context  Description of Parameter
   * @return          Description of the Returned Value
   */
  public String executeCommandUpdateCatRischio(ActionContext context) {
    if (!(hasPermission(context, "osm-tipochecklist-edit"))) {
      return ("PermissionError");
    }
    Connection db = null;
    int resultCount = -1;
    boolean isValid = false;
    String org_id = context.getRequest().getParameter( "orgId" );
    String account_size = context.getRequest().getParameter( "accountSize" );
    Organization oldOrg = null;
    SystemStatus systemStatus = this.getSystemStatus(context);
    try {
      db = this.getConnection(context);
      //set the name to namelastfirstmiddle if individual

      Organization newOrg = new Organization( db, Integer.parseInt( org_id ) );
      newOrg.setAccountSize( account_size );
      newOrg.setTypeList(
          context.getRequest().getParameterValues("selectedList"));
      newOrg.setModifiedBy(getUserId(context));
      newOrg.setEnteredBy(getUserId(context));
      
      oldOrg = new Organization(db, newOrg.getOrgId());
      isValid = this.validateObject(context, db, newOrg);
      if (isValid) {
        resultCount = newOrg.update(db,context);
      }

    } catch (Exception errorMessage) {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    addModuleBean(context, "View Accounts", "Modify Account");

    return ("UpdateCatRischioOK");
  }
  
  /**
   *  Delete: Deletes an Account from the Organization table
   *
   * @param  context  Description of Parameter
   * @return          Description of the Returned Value
   */
  public String executeCommandDelete(ActionContext context) {
    if (!hasPermission(context, "osm-osm-delete")) {
      return ("PermissionError");
    }
    SystemStatus systemStatus = this.getSystemStatus(context);
    Exception errorMessage = null;
    boolean recordDeleted = false;
    Organization thisOrganization = null;
    Connection db = null;
    try {
      db = this.getConnection(context);
      thisOrganization = new Organization(
          db, Integer.parseInt(context.getRequest().getParameter("orgId")));
      //check permission to record
      if (!isRecordAccessPermitted(context, db, thisOrganization.getId())) {
        return ("PermissionError");
      }
      if (context.getRequest().getParameter("action") != null) {
        if (((String) context.getRequest().getParameter("action")).equals(
            "delete")) {
          // NOTE: these may have different options later
          thisOrganization.setContactDelete(true);
          thisOrganization.setRevenueDelete(true);
          thisOrganization.setDocumentDelete(true);
          OpportunityHeaderList opportunityList = new OpportunityHeaderList();
          opportunityList.setOrgId(thisOrganization.getOrgId());
          opportunityList.buildList(db);
          opportunityList.invalidateUserData(context, db);
          thisOrganization.setForceDelete(
              context.getRequest().getParameter("forceDelete"));
          recordDeleted = thisOrganization.delete(
              db, context, getDbNamePath(context));
        } else if (((String) context.getRequest().getParameter("action")).equals(
            "disable")) {
          recordDeleted = thisOrganization.disable(db);
        }
      }
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }
    addModuleBean(context, "Accounts", "Delete Account");
    if (errorMessage == null) {
      if (recordDeleted) {
        
        context.getRequest().setAttribute(
            "refreshUrl", "Osm.do?command=Search");
        if ("disable".equals(context.getRequest().getParameter("action")) && "list".equals(
            context.getRequest().getParameter("return"))) {
          return executeCommandSearch(context);
        }
        return "DeleteOK";
      } else {
        processErrors(context, thisOrganization.getErrors());
        return (executeCommandSearch(context));
      }
    } else {
      System.out.println(errorMessage);
      context.getRequest().setAttribute(
          "actionError", systemStatus.getLabel(
          "object.validation.actionError.accountDeletion"));
      context.getRequest().setAttribute(
          "refreshUrl", "Osm.do?command=Search");
      return ("DeleteError");
    }
  }


  /**
   *  Description of the Method
   *
   * @param  context  Description of the Parameter
   * @return          Description of the Return Value
   */
  public String executeCommandTrash(ActionContext context) {
    if (!hasPermission(context, "osm-osm-delete")) {
      return ("PermissionError");
    }
    boolean recordUpdated = false;
    Connection db = null;
    try {
        db = this.getConnection(context);
        int orgId = Integer.parseInt(context.getRequest().getParameter("orgId"));
        String note = context.getRequest().getParameter("note");

        //check permission to record
        if (!isRecordAccessPermitted(context, db, orgId)) {
          return ("PermissionError");
        }
        
        // NOTE: these may have different options later
        recordUpdated = AccountsUtil.deleteCentralizzato(db, orgId, note, this.getUserId(context));
        
   
      } catch (Exception e) {
      context.getRequest().setAttribute(
          "refreshUrl", "Osm.do?command=Search");
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    addModuleBean(context, "Accounts", "Delete Account");
    if (recordUpdated) {
      context.getRequest().setAttribute(
          "refreshUrl", "Osm.do?command=Search");
      if ("list".equals(context.getRequest().getParameter("return"))) {
        return executeCommandSearch(context);
      }
      return "DeleteOK";
    } else {
      return (executeCommandSearch(context));
    }
  }


  /**
   *  Description of the Method
   *
   * @param  context  Description of the Parameter
   * @return          Description of the Return Value
   */
  public String executeCommandRestore(ActionContext context) {
    if (!hasPermission(context, "osm-osm-delete")) {
      return ("PermissionError");
    }
    boolean recordUpdated = false;
    Organization thisOrganization = null;
    Connection db = null;
    try {
      db = this.getConnection(context);
      String orgId = context.getRequest().getParameter("orgId");
      //check permission to record
      if (!isRecordAccessPermitted(context, db, Integer.parseInt(orgId))) {
        return ("PermissionError");
      }
      thisOrganization = new Organization(db, Integer.parseInt(orgId));
      // NOTE: these may have different options later
      recordUpdated = thisOrganization.updateStatus(
          db, context, false, this.getUserId(context));
      this.invalidateUserData(context, this.getUserId(context));
      this.invalidateUserData(context, thisOrganization.getOwner());
    } catch (Exception e) {
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    addModuleBean(context, "Accounts", "Delete Account");
    if (recordUpdated) {
      context.getRequest().setAttribute(
          "refreshUrl", "Osm.do?command=Search");
      if ("list".equals(context.getRequest().getParameter("return"))) {
        return executeCommandSearch(context);
      }
      return this.executeCommandDetails(context);
    } else {
      return (executeCommandSearch(context));
    }
  }


  /**
   *  Description of the Method
   *
   * @param  context  Description of the Parameter
   * @return          Description of the Return Value
   */
  public String executeCommandEnable(ActionContext context) {
    if (!hasPermission(context, "osm-osm-edit")) {
      return ("PermissionError");
    }
    boolean recordEnabled = false;
    Organization thisOrganization = null;
    Connection db = null;
    try {
      db = this.getConnection(context);
      thisOrganization = new Organization(
          db, Integer.parseInt(context.getRequest().getParameter("orgId")));
      recordEnabled = thisOrganization.enable(db);
      if (!recordEnabled) {
        this.validateObject(context, db, thisOrganization);
      }
    } catch (Exception e) {
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    addModuleBean(context, "Accounts", "Delete Account");
    return (executeCommandSearch(context));
  }


  /**
   *  Description of the Method
   *
   * @param  context  Description of the Parameter
   * @return          Description of the Return Value
   */
  public String executeCommandConfirmDelete(ActionContext context) {
    if (!hasPermission(context, "osm-osm-delete")) {
      return ("PermissionError");
    }
    Connection db = null;
    HtmlDialog htmlDialog = new HtmlDialog();
    int orgId = -1;
    SystemStatus systemStatus = this.getSystemStatus(context);
    if (context.getRequest().getParameter("id") != null) {
    	orgId = Integer.parseInt(context.getRequest().getParameter("id"));
    	}
    try {
        db = this.getConnection(context);
        //check permission to record
        if (!AccountsUtil.isCancellabile(db, orgId)){
      	  htmlDialog.addMessage("<font color=\"red\"><b>Impossibile proseguire nella cancellazione. Sono presenti CU associati.</b></font>");
            htmlDialog.addMessage("<br/>");
            htmlDialog.addMessage("<input type=\"button\" value=\"CHIUDI\" onClick=\"javascript:parent.window.close()\"/>");
        }
        else {
        htmlDialog.addMessage("<form action=\"Osm.do?command=Trash&auto-populate=true\" method=\"post\">");
        htmlDialog.addMessage("<b>Note cancellazione</b>: <textarea required id=\"note\" name=\"note\" rows=\"2\" cols=\"40\"></textarea>");
        htmlDialog.addMessage("<br/>");
        htmlDialog.addMessage("<input type=\"submit\" value=\"ELIMINA\"/>");
        htmlDialog.addMessage("&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ");
        htmlDialog.addMessage("<input type=\"button\" value=\"ANNULLA\" onClick=\"javascript:parent.window.close()\"/>");
        htmlDialog.addMessage("<input type=\"hidden\" id=\"action\" name=\"action\" value=\"delete\"/>");
        htmlDialog.addMessage("<input type=\"hidden\" id=\"forceDelete\" name=\"forceDelete\" value=\"true\"/>");
        htmlDialog.addMessage("<input type=\"hidden\" id=\"orgId\" name=\"orgId\" value=\""+orgId+"\"/>");
        htmlDialog.addMessage("</form>");
        }
      } catch (Exception e) {
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    context.getSession().setAttribute("Dialog", htmlDialog);
    return ("ConfirmDeleteOK");
  }


  /**
   *  Modify: Displays the form used for modifying the information of the
   *  currently selected Account
   *
   * @param  context  Description of Parameter
   * @return          Description of the Returned Value
   */
  public String executeCommandModify(ActionContext context) {
    if (!hasPermission(context, "osm-osm-edit")) {
      return ("PermissionError");
    }
    String orgid = context.getRequest().getParameter("orgId");
    context.getRequest().setAttribute("orgId", orgid);
    SystemStatus systemStatus = this.getSystemStatus(context);
    
    int tempid = Integer.parseInt(orgid);
    Connection db = null;
    Organization newOrg = null;
    try {
      db = this.getConnection(context);
      org.aspcfs.modules.osm.base.OrganizationAddress soperativa = null;
      newOrg = (Organization) context.getFormBean();
      newOrg.setComuni2(db, ( (UserBean) context.getSession().getAttribute("User")).getSiteId() );
      ApplicationPrefs prefs = (ApplicationPrefs) context.getServletContext().getAttribute("applicationPrefs");
      StateSelect stateSelect = new StateSelect(systemStatus, (newOrg.getAddressList() != null?newOrg.getAddressList().getCountries():"")+prefs.get("SYSTEM.COUNTRY"));
      stateSelect.setPreviousStates((newOrg.getAddressList() != null? newOrg.getAddressList().getSelectedStatesHashMap():new HashMap()));
      context.getRequest().setAttribute("StateSelect", stateSelect);
            
      Iterator it1 = newOrg.getAddressList().iterator();
   	  int nlocali =0;
   	  while(it1.hasNext())
   	  {
   		  org.aspcfs.modules.osm.base.OrganizationAddress add=(org.aspcfs.modules.osm.base.OrganizationAddress)it1.next();
   		  if(add.getType()==5)
   		  {
       		  soperativa=add;
   		  } 
   	  }
    
   	 context.getRequest().setAttribute("AddressSedeOperativa",soperativa);
      
      if (newOrg.getId() == -1) {
        newOrg = new Organization(db, tempid);
      
      } else {
        
      }
      if (!isRecordAccessPermitted(context, db, newOrg.getId())) {
        return ("PermissionError");
      }
    
      context.getRequest().setAttribute("systemStatus", systemStatus);
     
      LookupList OrgCategoriaRischioList = new LookupList(db, "lookup_org_catrischio");
      OrgCategoriaRischioList.addItem(-1,  "-- SELEZIONA VOCE --");
      context.getRequest().setAttribute("OrgCategoriaRischioList", OrgCategoriaRischioList);
      
       LookupList statoLab = new LookupList(db, "lookup_stato_lab");
      statoLab.addItem(-1,  "-- SELEZIONA VOCE --");
      context.getRequest().setAttribute("statoLab", statoLab);
      
      LookupList impianto = new LookupList(db, "lookup_attivita_osm");
      impianto.addItem(-1,  "-- SELEZIONA VOCE --");
      context.getRequest().setAttribute("impianto", impianto);


      LookupList siteList = new LookupList(db, "lookup_site_id");
      siteList.addItem(-1,  "-- SELEZIONA VOCE --");
      context.getRequest().setAttribute("SiteList", siteList);


      LookupList IstatList = new LookupList(db, "lookup_codistat");
      IstatList.addItem(-1, getSystemStatus(context).getLabel("calendar.none.4dashes"));
      context.getRequest().setAttribute("IstatList", IstatList);
      
      String codice1 = null;
      String codice2 = null;
      String codice3 = null;
      String codice4 = null;
      String codice5 = null;
      String codice6 = null;
      String codice7 = null;
      String codice8 = null;
      String codice9 = null;
      String codice10 = null;
      
      if(newOrg.getCodice1()!=null){
      codice1 = IstatList.getSelectedValueShort(newOrg.getCodice1(), db);
      context.getRequest().setAttribute("cod1", codice1);
      }else if(newOrg.getCodice2()!=null){
      codice2 = IstatList.getSelectedValueShort(newOrg.getCodice2(), db);
      context.getRequest().setAttribute("cod2", codice2);
      }else if(newOrg.getCodice3()!=null){
      codice3 = IstatList.getSelectedValueShort(newOrg.getCodice3(), db);
      context.getRequest().setAttribute("cod3", codice3);
      }else if(newOrg.getCodice4()!=null){
      codice4 = IstatList.getSelectedValueShort(newOrg.getCodice4(), db);
      context.getRequest().setAttribute("cod4", codice4);
      }else if(newOrg.getCodice5()!=null){
      codice5 = IstatList.getSelectedValueShort(newOrg.getCodice5(), db);
      context.getRequest().setAttribute("cod5", codice5);
      }else if(newOrg.getCodice6()!=null){
      codice6 = IstatList.getSelectedValueShort(newOrg.getCodice6(), db);
      context.getRequest().setAttribute("cod6", codice6);
      }else if(newOrg.getCodice7()!=null){
      codice7 = IstatList.getSelectedValueShort(newOrg.getCodice7(), db);
      context.getRequest().setAttribute("cod7", codice7);
      }else if(newOrg.getCodice8()!=null){
      codice8 = IstatList.getSelectedValueShort(newOrg.getCodice8(), db);
      context.getRequest().setAttribute("cod8", codice8);
      }else if(newOrg.getCodice9()!=null){
      codice9 = IstatList.getSelectedValueShort(newOrg.getCodice9(), db);
      context.getRequest().setAttribute("cod9", codice9);
      }else if(newOrg.getCodice10()!=null){
      codice10 = IstatList.getSelectedValueShort(newOrg.getCodice10(), db);
      context.getRequest().setAttribute("cod10", codice10);
      }     
      UserBean thisUser = (UserBean) context.getSession().getAttribute("User");
      String provincia = thisUser.getContact().getState();
      
      ArrayList<Integer> asl_id = new ArrayList<Integer>();
      
      if(provincia.equals("AV")){
    	  asl_id.add(201);
    	
      }else if(provincia.equals("BN")){
    	  asl_id.add(202);
      }else if(provincia.equals("CE")){
    	  asl_id.add(203);
    	 
      }else if(provincia.equals("NA")){
    	  asl_id.add(204);
    	  asl_id.add(205);
    	  asl_id.add(206);
    	 
    	  
      }else if(provincia.equals("SA")){
    	  asl_id.add(207);
    	 
    	  
      }
      newOrg.setComuniProvincia(db, asl_id );
     
      Iterator it = newOrg.getAddressList().iterator();
   	  while(it.hasNext())
   	  {
   		  org.aspcfs.modules.osm.base.OrganizationAddress add=(org.aspcfs.modules.osm.base.OrganizationAddress)it.next();
   		  if(add.getLatitude()!=0 && add.getLongitude()!=0){
    		  String spatial_coords [] = null;
    		  spatial_coords = this.converToWgs84UTM33NInverter(Double.toString(add.getLatitude()), Double.toString(add.getLongitude()),db);
//    		  if (Double.parseDouble(spatial_coords[0].replace(',', '.'))< 39.988475 || Double.parseDouble(spatial_coords[0].replace(',', '.'))> 41.503754)
//    		  {
//    			 AjaxCalls ajaxCall = new AjaxCalls();
//    			 String[] coordinate= ajaxCall.getCoordinate(add.getStreetAddressLine1(), add.getCity(), add.getState(), add.getZip(), ""+add.getLatitude(), ""+add.getLongitude(), "");
//    			 add.setLatitude(coordinate[1]);
//    			 add.setLongitude(coordinate[0]);
//    		  }
//    		  else
//    		  {
    			  add.setLatitude(spatial_coords[0]);
    			  add.setLongitude(spatial_coords[1]);
  //  		  }

    	  }
   		  
   	  }//Fine modifica
      
      
      
      
      //newOrg.setComuni2(db, ( (UserBean) context.getSession().getAttribute("User")).getSiteId() );
     

      //Make the StateSelect and CountrySelect drop down menus available in the request.
      //This needs to be done here to provide the SystemStatus to the constructors, otherwise translation is not possible
      //ApplicationPrefs prefs = (ApplicationPrefs) context.getServletContext().getAttribute("applicationPrefs");
         CountrySelect countrySelect = new CountrySelect(systemStatus);
      context.getRequest().setAttribute("CountrySelect", countrySelect);
      context.getRequest().setAttribute("systemStatus", systemStatus);

      UserList userList = filterOwnerListForSite(context, newOrg.getSiteId());
      context.getRequest().setAttribute("UserList", userList);
    } catch (Exception e) {
    	e.printStackTrace();
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    addModuleBean(context, "View Accounts", "Account Modify");
    context.getRequest().setAttribute("OrgDetails", newOrg);
    if (context.getRequest().getParameter("popup") != null) {
      return ("PopupModifyOK");
    } else {
      return ("ModifyOK");
    }
  }

  
//inserito carmela
  public String executeCommandModificaCatRischio(ActionContext context) {
	    if ((!hasPermission(context, "osm-tipochecklist-add"))) {
	      return ("PermissionError");
	    }
	    Connection db = null;
	    SystemStatus systemStatus = this.getSystemStatus(context);
	    Organization newOrg = null;
	    try {
	      String temporgId = context.getRequest().getParameter("orgId");
	      if (temporgId == null) {
	        temporgId = (String) context.getRequest().getAttribute("orgId");
	      }
	      int tempid = Integer.parseInt(temporgId);
	      db = this.getConnection(context);
	      if (!isRecordAccessPermitted(context, db, Integer.parseInt(temporgId))) {
	        return ("PermissionError");
	      }
	      newOrg = new Organization(db, tempid);
	      //check whether or not the owner is an active User
	      LookupList siteList = new LookupList(db, "lookup_site_id");
	      siteList.addItem(-1,  "-- SELEZIONA VOCE --");
	      context.getRequest().setAttribute("SiteList", siteList);
	      
	      
	    } catch (Exception e) {
	      context.getRequest().setAttribute("Error", e);
	      return ("SystemError");
	    } finally {
	      this.freeConnection(context, db);
	    }
	    addRecentItem(context, newOrg);
	    String action = context.getRequest().getParameter("action");
	    if (action != null && action.equals("modify")) {
	      //If user is going to the modify form
	      addModuleBean(context, "Accounts", "Modify Account Details");
	      return ("ModificaCatRischioOK");
	    } else {
	      //If user is going to the detail screen
	      addModuleBean(context, "View Accounts", "View Account Details");
	      context.getRequest().setAttribute("OrgDetails", newOrg);
	      return getReturn(context, "ModificaCatRischio");
	    }
	  }


  /**
   *  Description of the Method
   *
   * @param  context  Description of the Parameter
   * @return          Description of the Return Value
   */
  public String executeCommandDeleteFields(ActionContext context) {
    if (!(hasPermission(context, "osm-osm-folders-delete"))) {
      return ("PermissionError");
    }
    String source = context.getRequest().getParameter("source");
    String popupString = context.getRequest().getParameter("popup");
    boolean popup = (popupString != null && "true".equals(popupString.trim()));
    boolean returnToList = true;
    String actionStepId = context.getRequest().getParameter("actionStepId");
    ActionItemWork item = null;
    if (source != null && !"".equals(source.trim())) {
      context.getRequest().setAttribute("source", source);
    }
    if (actionStepId != null && !"".equals(actionStepId.trim())) {
      context.getRequest().setAttribute("actionStepId", actionStepId);
    }
    Connection db = null;
    try {
      db = this.getConnection(context);
      String selectedCatId = context.getRequest().getParameter("catId");
      String recordId = context.getRequest().getParameter("recId");
      String orgId = context.getRequest().getParameter("orgId");

      //check permission to record
      if (!isRecordAccessPermitted(context, db, Integer.parseInt(orgId))) {
        return ("PermissionError");
      }

      CustomFieldCategory thisCategory = new CustomFieldCategory(
          db,
          Integer.parseInt(selectedCatId));

      CustomFieldRecord thisRecord = new CustomFieldRecord(
          db, Integer.parseInt(recordId));
      thisRecord.setLinkModuleId(Constants.ACCOUNTS);
      thisRecord.setLinkItemId(Integer.parseInt(orgId));
      thisRecord.setCategoryId(Integer.parseInt(selectedCatId));
      if (actionStepId != null && !"".equals(actionStepId.trim()) && !"-1".equals(actionStepId) && !"null".equals(actionStepId)) {
        item = new ActionItemWork(db, Integer.parseInt(actionStepId));
      }
      if (!thisCategory.getReadOnly()) {
        thisRecord.delete(db);
      }
      context.getRequest().setAttribute("recordDeleted", "true");
      if (item != null && item.getId() > 0) {
        if (thisRecord.getId() == item.getLinkItemId() && item.getLinkModuleId() == ActionPlan.getMapIdGivenConstantId(db, ActionPlan.ACCOUNTS)) {
          returnToList = false;
          thisCategory.setRecordId(thisRecord.getId());
          context.getRequest().setAttribute("Category", thisCategory);
        }
      }
    } catch (Exception e) {
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    if (returnToList) {
      return getReturn(context, "DeleteFields");
    }
    return "DeletedFieldPopupOK";
  }


  /**
   *  Description of the Method
   *
   * @param  context  Description of the Parameter
   */
  private void resetPagedListInfo(ActionContext context) {
    
    this.deletePagedListInfo(context, "AccountFolderInfo");
    this.deletePagedListInfo(context, "RptListInfo");
    this.deletePagedListInfo(context, "OpportunityPagedInfo");
    this.deletePagedListInfo(context, "AccountTicketInfo");
    this.deletePagedListInfo(context, "AutoGuideAccountInfo");
    this.deletePagedListInfo(context, "RevenueListInfo");
    this.deletePagedListInfo(context, "AccountDocumentInfo");
    this.deletePagedListInfo(context, "ServiceContractListInfo");
    this.deletePagedListInfo(context, "AssetListInfo");
    this.deletePagedListInfo(context, "AccountProjectInfo");
    this.deletePagedListInfo(context, "orgHistoryListInfo");
  }


  /**
   *  Description of the Method
   *
   * @param  context        Description of the Parameter
   * @param  siteId         Description of the Parameter
   * @return                Description of the Return Value
   * @exception  Exception  Description of the Exception
   */
  private UserList filterOwnerListForSite(ActionContext context, int siteId) throws Exception {
    UserBean thisUser = (UserBean) context.getSession().getAttribute("User");
    //this is how we get the multiple-level heirarchy...recursive function.
    User thisRec = thisUser.getUserRecord();
    UserList shortChildList = thisRec.getShortChildList();
    UserList userList = thisRec.getFullChildList(
        shortChildList, new UserList());
    userList.setMyId(getUserId(context));
    userList.setMyValue(thisUser.getContact().getNameLastFirst());
    userList.setIncludeMe(true);
    userList.setExcludeDisabledIfUnselected(true);
    userList.setExcludeExpiredIfUnselected(true);

    // filter possible owners for accounts with site ids.

    // An account WITH a site id can be owned by a user with the same
    // site id or by one who has access to all sites
    // (i.e., siteId = -1 or site_id IS NULL)
    if (siteId != -1) {
      Iterator itr = userList.iterator();
      while (itr.hasNext()) {
        User tmpUser = (User) itr.next();
        if (tmpUser.getSiteId() == -1) {
          continue;
        }
        if (siteId != tmpUser.getSiteId()) {
          itr.remove();
        }
      }
    }

    // An account WITHOUT a site id can ONLY be owned by a user with access
    // to all sites
    // (i.e., siteId = -1 or site_id IS NULL)
    if (siteId == -1) {
      Iterator itr = userList.iterator();
      while (itr.hasNext()) {
        User tmpUser = (User) itr.next();
        if (siteId != tmpUser.getSiteId()) {
          itr.remove();
        }
      }
    }
    return userList;
  }
  
  

  public String executeCommandOsmUpload(ActionContext context){
		Connection db = null;

		try {
			db = getConnection(context);
		
			
			
			 UserBean thisUser = (UserBean) context.getSession().getAttribute("User");
			
		      if (thisUser.getRoleId()==21){ //UTENTE COMUNE
		    	  context.getRequest().setAttribute("UserComune", thisUser);
		      }
		     
		      if (thisUser.getRoleId()==23){ //UTENTE PROVINCIA
		    	  context.getRequest().setAttribute("UserProvincia", thisUser);
		      }		     
				
						
		} catch (Exception e) {	
			context.getRequest().setAttribute("Error", e);
			e.printStackTrace();
			return ("SystemError");
		} finally {
			this.freeConnection(context, db);
		}
		return ("OsmUploadAddOK");
		
	}
  
  /*
  private String[] convert2Wgs84UTM33N( String latitude, String longitude, Connection conn  ) throws SQLException
  {
		
		String[] ret = null;
		String sql = 
		"select 	X \n"	+ 
		"( \n"				+ 
		"	transform \n"	+ 
		"	(  \n"			+ 
		"		geomfromtext \n"	+ 
		"		(  \n"				+ 
		"			'POINT( " + longitude + " " + latitude + " )', 4326 \n"	+ 
		"	 \n"					+ 
		"		), 32633 \n"			+ 
		"	) \n"					+ 
		") AS x, \n"				+ 
		"Y \n"						+ 
		"( \n"						+ 
		"	transform \n"			+ 
		"	(  \n"					+ 
		"		geomfromtext \n"	+ 
		"		(  \n"				+ 
		"			'POINT( " + longitude + " " + latitude + " )', 4326 \n"	+ 
		"	 \n"			+ 
		"		), 32633 \n"	+ 
		"	) \n"			+ 
		") AS y \n";
		
		try
		{
			
			PreparedStatement stat = conn.prepareStatement( sql );
			//stat.setString( 1, wgs84[0] );
			//stat.setString( 2, wgs84[1] );
			//stat.setString( 3, wgs84[0] );
			//stat.setString( 4, wgs84[1] );
			//System.out.println("Query: "+stat.toString());
			
			ResultSet res = stat.executeQuery();
			if( res.next() )
			{
				ret = new String[2];
				ret[0] = res.getString( "x" );
				ret[1] = res.getString( "y" );
				//System.out.println("latitudine wgs84 utm 33n : "+ret[0]);
				//System.out.println("longitudine wgs84 utm 33n : "+ret[1]);
				
			}
			res.close();
			stat.close();
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		return ret;
	}
  
  private String[] converToWgs84UTM33NInverter(String latitudine , String longitudine, Connection db) throws SQLException
  {
          String lat ="";
          String lon = "";
          String [] coord = new String [2];
          String sql1 = 
                  "select         X \n"        + 
                  "( \n"                                + 
                  "        transform \n"        + 
                  "        (  \n"                        + 
                  "                geomfromtext \n"        + 
                  "                (  \n"                                + 
                  "                        'POINT("+latitudine+" "+longitudine+")', 32633 \n"        + 
                  "         \n"                                        + 
                  "                ), 4326 \n"                        + 
                  "        ) \n"                                        + 
                  ") AS x, \n"                                + 
                  "Y \n"                                                + 
                  "( \n"                                                + 
                  "        transform \n"                        + 
                  "        (  \n"                                        + 
                  "                geomfromtext \n"        + 
                  "                (  \n"                                + 
                  "                        'POINT("+latitudine+" "+longitudine+")', 32633 \n"        + 
                  "         \n"                        + 
                  "                ), 4326 \n"        + 
                  "        ) \n"                        + 
                  ") AS y \n";
          
        try {
        	
          PreparedStatement stat1 = db.prepareStatement( sql1 );
          //System.out.println("Query di conversione:" +stat1.toString());
          ResultSet res1 = stat1.executeQuery();
          if( res1.next() )
          {
                  lat = res1.getString( "y") ;
                  lon=res1.getString( "x" );
                  coord [0] =lat;
                  coord [1] =lon;
                  //System.out.println("latitudine input : "+ lat);
                  //System.out.println("longitudine input : "+ lon);
          
          }
          res1.close();
          stat1.close();
          
        }catch (Exception e){
        	e.printStackTrace();
        }
         
        return coord;
          
  } */
  
}




  



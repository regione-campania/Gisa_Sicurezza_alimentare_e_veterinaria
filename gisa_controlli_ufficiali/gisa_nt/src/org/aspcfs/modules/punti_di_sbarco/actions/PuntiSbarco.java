package org.aspcfs.modules.punti_di_sbarco.actions;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.logging.Logger;

import org.aspcfs.controller.ApplicationPrefs;
import org.aspcfs.controller.SystemStatus;
import org.aspcfs.modules.accounts.utils.AccountsUtil;
import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.admin.base.User;
import org.aspcfs.modules.admin.base.UserList;
import org.aspcfs.modules.base.Constants;
import org.aspcfs.modules.diffida.base.Ticket;
import org.aspcfs.modules.login.beans.UserBean;
import org.aspcfs.modules.mycfs.beans.CalendarBean;
import org.aspcfs.modules.punti_di_sbarco.base.Organization;
import org.aspcfs.modules.punti_di_sbarco.base.OrganizationList;
import org.aspcfs.utils.web.CountrySelect;
import org.aspcfs.utils.web.HtmlDialog;
import org.aspcfs.utils.web.HtmlSelect;
import org.aspcfs.utils.web.LookupList;
import org.aspcfs.utils.web.PagedListInfo;
import org.aspcfs.utils.web.StateSelect;

import com.darkhorseventures.framework.actions.ActionContext;


public final class PuntiSbarco extends CFSModule {
	
	 Logger logg = Logger.getLogger("MainLogger");

 /**
  *  Default: not used
  *
  * @param  context  Description of Parameter
  * @return          Description of the Returned Value
  */
 public String executeCommandDefault(ActionContext context) {

	 		  return executeCommandDashboard(context);
 } 


 /**
  *  Search: Displays the Account search form
  *
  * @param  context  Description of Parameter
  * @return          Description of the Returned Value
  */

 
 public String executeCommandSearchForm(ActionContext context) {
	    if (!(hasPermission(context, "punti_di_sbarco-view"))) {
	      return ("PermissionError");
	    }

	    //Bypass search form for portal users
	    if (isPortalUser(context)) {
	      return (executeCommandSearch(context));
	    }
	    SystemStatus systemStatus = this.getSystemStatus(context);
	    Connection db = null;
	    try {
	      db = getConnection(context);
	      LookupList siteList = new LookupList(db, "lookup_site_id");
	      siteList.addItem(-1, "--Tutti--");
	      //siteList.addItem(Constants.INVALID_SITE,  "-- TUTTI --");
	      context.getRequest().setAttribute("SiteList", siteList);
	        
	      org.aspcfs.modules.accounts.base.Comuni c = new org.aspcfs.modules.accounts.base.Comuni();
	      UserBean user = (UserBean) context.getSession().getAttribute("User");
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
	      Organization newOrg = (Organization) context.getFormBean();
	      //ApplicationPrefs prefs = (ApplicationPrefs) context.getServletContext().getAttribute("applicationPrefs");
	      
	      if (newOrg==null)
	      {
	    	  newOrg = new Organization();
	      }
	    	  newOrg.setComuni2(db);
	      //if (newOrg.getEnteredBy() != -1) {
	        
	        context.getRequest().setAttribute("OrgDetails", newOrg);

	      
	    } catch (Exception e) {
	      context.getRequest().setAttribute("Error", e);
	      e.printStackTrace();
	      return ("SystemError");
	    } finally {
	      this.freeConnection(context, db);
	    }
	    addModuleBean(context, "Search Accounts", "Accounts Search");
	    return ("SearchOK");
	  }
 
 
 public String executeCommandAdd(ActionContext context) {
	    if (!hasPermission(context, "punti_di_sbarco-add")) {
	      return ("PermissionError");
	    }
	    SystemStatus systemStatus = this.getSystemStatus(context);
	    Connection db = null;
	    try {
	      db = this.getConnection(context);
	      LookupList siteList = new LookupList(db, "lookup_site_id");
	      siteList.addItem(-1,  "-- SELEZIONA VOCE --");
	      context.getRequest().setAttribute("SiteList", siteList);
	      
	      LookupList stageList = new LookupList(db, "lookup_account_stage");
	      stageList.addItem(-1,  "-- SELEZIONA VOCE --");
	      context.getRequest().setAttribute("StageList", stageList);
	      
	      Organization newOrg = (Organization) context.getFormBean();
	      ApplicationPrefs prefs = (ApplicationPrefs) context.getServletContext().getAttribute("applicationPrefs");
	      if(newOrg == null)
	      {
	    	  newOrg = new Organization();
	      }
	      newOrg.setComuni2(db);
	      //if (newOrg.getEnteredBy() != -1) {
	        
	        context.getRequest().setAttribute("OrgDetails", newOrg);
	      //}
	    } catch (Exception e) {
	      context.getRequest().setAttribute("Error", e);
	      e.printStackTrace();
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
 
 public String executeCommandInsert(ActionContext context) throws SQLException {
	    if (!hasPermission(context, "punti_di_sbarco-add")) {
	      return ("PermissionError");
	    }
	    Connection db = null;
	    boolean recordInserted = false;
	    boolean isValid = false;
	    Organization insertedOrg = null;

	    
	    Organization newOrg = (Organization) context.getFormBean();
	   
	    String comune = (String) context.getRequest().getParameter("address1city");
	    newOrg.setEnteredBy(getUserId(context));
	    newOrg.setModifiedBy(getUserId(context));
	    newOrg.setName(context.getRequest().getParameter("name"));
	    newOrg.setAlert(context.getRequest().getParameter("alert"));
	    
	    //Calcolo l'asl in base al comune
	   
	    UserBean user = (UserBean) context.getSession().getAttribute("User");
	    String ip = user.getUserRecord().getIp();
	    newOrg.setIp_entered(ip);
	    newOrg.setIp_modified(ip);
	    
		
	     try {
	      db = this.getConnection(context);
	      SystemStatus systemStatus = this.getSystemStatus(context);
	      int asl = newOrg.selectAsl(db, comune);
		  newOrg.setSiteId(asl); 
	      newOrg.setComuni2(db);
	      newOrg.setRequestItems(context);
	      LookupList siteList = new LookupList(db, "lookup_site_id");
	      siteList.addItem(-1,  "-- SELEZIONA VOCE --");
	      context.getRequest().setAttribute("SiteList", siteList);
	      if (this.getUserSiteId(context) != -1) {
	        // Set the site Id of the account to be equal to the site Id of the user
	        // for a new account
	        if (newOrg.getId() == -1) {
	          newOrg.setSiteId(this.getUserSiteId(context));
	        }/* else {
	           Check whether the user has access to update the organization
	          if (!isRecordAccessPermitted(context, db, newOrg.getId())) {
	            return ("PermissionError");
	          }
	        }*/
	      }
	      
	      newOrg.setEntered(new Timestamp (new Date(System.currentTimeMillis()).getTime()));

	      newOrg.setModified(new Timestamp (new Date(System.currentTimeMillis()).getTime()));
	     
	      newOrg.setEnteredBy(user.getUserId());
	      newOrg.setModifiedBy(user.getUserId());

	      isValid = this.validateObject(context, db, newOrg);
	      if (isValid) {
	        recordInserted = newOrg.insert(db,context);
	      }
	      if (recordInserted) {
	        insertedOrg = new Organization(db, newOrg.getOrgId());
	        context.getRequest().setAttribute("OrgDetails", insertedOrg);
	        
	        addRecentItem(context, newOrg);
	        
	       
	        
		        
	      }
	    } catch (Exception errorMessage) {
	      String forward = "";
	      logg.severe("Errore di forwarding nella MiddleServlet: " + forward);
	      context.getRequest().setAttribute("Error", errorMessage);
	      return ("SystemError");
	    } finally {
	      this.freeConnection(context, db);
	    }
	    addModuleBean(context, "View Accounts", "Pippo Insert ok");
	    if (recordInserted) {
	      String target = context.getRequest().getParameter("target");
	      if (context.getRequest().getParameter("popup") != null) {
	        return ("ClosePopupOK");
	      }
	      if (target != null && "add_contact".equals(target)) {
	        return ("InsertAndAddContactOK");
	      } else {
	        //return ("InsertOK");
	    	  return "GoToDetailsOk";
	      }
	    }
	    return (executeCommandAdd(context));
	  }






 public String executeCommandDetails(ActionContext context) {
	    if (!hasPermission(context, "punti_di_sbarco-view")) {
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
	      //Caricamento Diffide
	      Ticket t = new Ticket();
			context.getRequest().setAttribute("DiffideList", t.getDiffide(db,false,null,null,newOrg.getOrgId(),null));
			context.getRequest().setAttribute("DiffideListStorico", t.getDiffide(db,true,null,null,newOrg.getOrgId(),null));
	       
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
	      return ("DetailsOK");
	    } else {
	      //If user is going to the detail screen
	      addModuleBean(context, "View Accounts", "View Account Details");
	      context.getRequest().setAttribute("OrgDetails", newOrg);
	        return ("DetailsOK");
	    }
	  }
 

 
 public String executeCommandDashboard(ActionContext context) {
	    if (!hasPermission(context, "punti_di_sbarco-view")) {
	      if (!hasPermission(context, "punti_di_sbarco-view")) {
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
	          "Accounts", "org.aspcfs.modules.accounts.base.AccountsListScheduledActions", "Accounts");
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
 

 
 
 public String executeCommandSearch(ActionContext context) {
	    if (!hasPermission(context, "punti_di_sbarco-view")) {
	      return ("PermissionError");
	    }

	    String source = (String) context.getRequest().getParameter("source");
	    String name = (String) context.getRequest().getParameter("searchAccountName");
	    String comune =  (String) context.getRequest().getParameter("searchAccountCity");
	    
	    OrganizationList organizationList = new OrganizationList();
	    
	   
	    addModuleBean(context, "View Accounts", "Search Results");

	    //Prepare pagedListInfo
	    PagedListInfo searchListInfo = this.getPagedListInfo(
	        context, "SearchOrgListInfo");
	    searchListInfo.setLink("PuntiSbarco.do?command=Search");
	    searchListInfo.setListView("All");
	    SystemStatus systemStatus = this.getSystemStatus(context);
	    //Need to reset any sub PagedListInfos since this is a new account
	    this.resetPagedListInfo(context);
	    Connection db = null;
	    try {
	      db = this.getConnection(context);	      
	      
	      String addressType = context.getRequest().getParameter("addess_type_op");
	      if(addressType!=null && !addressType.equals("")){
	    	    organizationList.setAddressType(addressType);
	    	  }
	      
	      if(name != null) {
	    	  organizationList.setAccountName(name);
	    	  organizationList.setName(name);
	      }
	   	     
	      if (comune != null){
	    	  organizationList.setAccountCity(comune);
	    	  organizationList.setCity(comune);
	      }
	   	   
	      LookupList siteList = new LookupList(db, "lookup_site_id");
	      siteList.addItem(-1,  "-- SELEZIONA VOCE --");
	      siteList.addItem(Constants.INVALID_SITE,  "-- TUTTI --");
	         
	      context.getRequest().setAttribute("SiteIdList", siteList);
	      Organization newOrg = new Organization();
	      newOrg.setComuni2(db);
	            
	        context.getRequest().setAttribute("OrgDetails", newOrg);
	      //For portal usr set source as 'searchForm' explicitly since
	      //the search form is bypassed.
	      //temporary solution for page redirection for portal user.
	      if (isPortalUser(context)) {
	        organizationList.setOrgSiteId(this.getUserSiteId(context));
	        source = "searchForm";
	      }
	      //return if no criteria is selected
	      if ((searchListInfo.getListView() == null || "".equals(
	          searchListInfo.getListView())) && !"searchForm".equals(source)) {
	        return "ListOK";
	      }
	      
	      //Display list of accounts if user chooses not to list contacts
	      if (!"true".equals(searchListInfo.getCriteriaValue("searchContacts"))) {
	        if ("contacts".equals(context.getSession().getAttribute("previousSearchType"))) {
	          this.deletePagedListInfo(context, "SearchOrgListInfo");
	          searchListInfo = this.getPagedListInfo(context, "SearchOrgListInfo");
	          searchListInfo.setLink("PuntiSbarco.do?command=Search");
	        }
	        //Build the organization list
	        organizationList.setPagedListInfo(searchListInfo);
	        organizationList.setMinerOnly(false);
	        organizationList.setTypeId(searchListInfo.getFilterKey("listFilter1"));
	        
	     
	        if((context.getRequest().getParameter("searchcodeOrgSiteId")==null)){
	       		organizationList.setSiteId("-1");   	
	       	}else{
	        organizationList.setSiteId(context.getRequest().getParameter("searchcodeOrgSiteId"));
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
	          
	        }
	        
	        organizationList.buildList(db);
	        
	        
	        context.getRequest().setAttribute("OrgList", organizationList);
	        context.getSession().setAttribute("previousSearchType", "accounts");
	        
	        return "ListOK";
		      
	      } else {}
	    } catch (Exception e) {
	        //Go through the SystemError process
	        context.getRequest().setAttribute("Error", e);
	        return ("SystemError");
	      } finally {
	        this.freeConnection(context, db);
	      }
	    return "" ;
	      
	   
 }
  
 public String executeCommandModify(ActionContext context) {
	    if (!hasPermission(context, "punti_di_sbarco-edit")) {
	      return ("PermissionError");
	    }
	    String orgid = context.getRequest().getParameter("orgId");
	    context.getRequest().setAttribute("orgId", orgid);
	    int tempid = Integer.parseInt(orgid);
	    Connection db = null;
	    Organization newOrg = null;
	    try {
	      db = this.getConnection(context);
	    
	        newOrg = new Organization(db, tempid);
	        
	      //In fase di modifica
	        Iterator it_coords = newOrg.getAddressList().iterator();
	        while(it_coords.hasNext()){
	        	  
	        	  org.aspcfs.modules.punti_di_sbarco.base.OrganizationAddress thisAddress = (org.aspcfs.modules.punti_di_sbarco.base.OrganizationAddress) it_coords.next();
	        	 
	        }
	      
	      if (!isRecordAccessPermitted(context, db, newOrg.getId())) {
	        return ("PermissionError");
	      }
	      newOrg.setComuni2(db);
		   
	      SystemStatus systemStatus = this.getSystemStatus(context);
	      context.getRequest().setAttribute("systemStatus", systemStatus);
	      
	      //if this is an individual account
	      LookupList siteList = new LookupList(db, "lookup_site_id");
	      siteList.addItem(-1,  "-- SELEZIONA VOCE --");
	      context.getRequest().setAttribute("SiteList", siteList);
	      
	      CountrySelect countrySelect = new CountrySelect(systemStatus);
	      context.getRequest().setAttribute("CountrySelect", countrySelect);
	      context.getRequest().setAttribute("systemStatus", systemStatus);

	      /*UserList userList = filterOwnerListForSite(context, newOrg.getSiteId());
	      context.getRequest().setAttribute("UserList", userList);*/
	      
	    } catch (Exception e) {
	      context.getRequest().setAttribute("Error", e);
	      e.printStackTrace();
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
 
 public String executeCommandDelete(ActionContext context) {
	    if (!hasPermission(context, "punti_di_sbarco-delete")) {
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
	      
	      if (context.getRequest().getParameter("action") != null) {
	        if (((String) context.getRequest().getParameter("action")).equals(
	            "delete")) {
	          // NOTE: these may have different options later
	          
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
	            "refreshUrl", "PuntiSbarco.do?command=Search");
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
	      //System.out.println(errorMessage);
	      context.getRequest().setAttribute(
	          "actionError", systemStatus.getLabel(
	          "object.validation.actionError.accountDeletion"));
	      context.getRequest().setAttribute(
	          "refreshUrl", "PuntiSbarco.do?command=Search");
	      return ("DeleteError");
	    }
	  }

public String executeCommandTrash(ActionContext context) {
	    if (!hasPermission(context, "punti_di_sbarco-delete")) {
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
	              "refreshUrl", ".do?command=SearchForm");
	          context.getRequest().setAttribute("Error", e);
	          return ("SystemError");
	        } finally {
	          this.freeConnection(context, db);
	        }
	        addModuleBean(context, "Accounts", "Delete Account");
	        if (recordUpdated) {
	        	context.getRequest().setAttribute(
	      	          "refreshUrl", "PuntiSbarco.do?command=Search");
	      	      if ("list".equals(context.getRequest().getParameter("return"))) {
	      	        return executeCommandSearch(context);
	      	      }
	      	      return "DeleteOK";
	      	    } else {
	      	      return (executeCommandSearch(context));
	      	    }
	      	  }
	     

public String executeCommandRestore(ActionContext context) {
	    if (!hasPermission(context, "punti_di_sbarco-delete")) {
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
	      
	      this.invalidateUserData(context, this.getUserId(context));
	      
	    } catch (Exception e) {
	      context.getRequest().setAttribute("Error", e);
	      return ("SystemError");
	    } finally {
	      this.freeConnection(context, db);
	    }
	    addModuleBean(context, "Accounts", "Delete Account");
	    if (recordUpdated) {
	      context.getRequest().setAttribute(
	          "refreshUrl", "PuntiSbarco.do?command=Search");
	      if ("list".equals(context.getRequest().getParameter("return"))) {
	        return executeCommandSearch(context);
	      }
	      return this.executeCommandDetails(context);
	    } else {
	      return (executeCommandSearch(context));
	    }
	  }



public String executeCommandConfirmDelete(ActionContext context) {
	    if (!hasPermission(context, "punti_di_sbarco-delete")) {
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
	        htmlDialog.addMessage("<form action=\"Imbarcazioni.do?command=Trash&auto-populate=true\" method=\"post\">");
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

public String executeCommandUpdate(ActionContext context) {
    if (!(hasPermission(context, "punti_di_sbarco-edit"))) {
      return ("PermissionError");
    }
    Connection db = null;
    int resultCount = -1;
    boolean isValid = false;
    String orgId = context.getRequest().getParameter("orgId");
    Organization newOrg = (Organization) context.getFormBean();
    Organization oldOrg = null;
    SystemStatus systemStatus = this.getSystemStatus(context);
    newOrg.setModifiedBy(getUserId(context));
    UserBean user = (UserBean) context.getSession().getAttribute("User");
    String ip = user.getUserRecord().getIp();
    newOrg.setIp_entered(ip);
    newOrg.setIp_modified(ip);
    newOrg.setEnteredBy(getUserId(context));
    newOrg.setOrgId(Integer.parseInt(orgId));
    newOrg.setName(context.getRequest().getParameter("name"));
    try {
      db = this.getConnection(context);
      //set the name to namelastfirstmiddle if individual
      LookupList siteList = new LookupList(db, "lookup_site_id");
      siteList.addItem(-1,  "-- SELEZIONA VOCE --");
      context.getRequest().setAttribute("SiteList", siteList);
      
      oldOrg = new Organization(db, newOrg.getOrgId());
      
      newOrg.setRequestItems(context);
      newOrg.setModified(new Timestamp (new Date(System.currentTimeMillis()).getTime()));
      newOrg.setModifiedBy(user.getUserId());
      
      isValid = this.validateObject(context, db, newOrg);
      if (isValid) {
        resultCount = newOrg.update(db,context);
      //  String prova = context.getRequest().getParameter("address1state");
       // newOrg.setState(prova);
      }
      if (resultCount == 1) {
        processUpdateHook(context, oldOrg, newOrg);
        //if this is an individual account, populate and update the primary contact
        
        //update all contacts which are associated with this organization
       
      }
    } catch (Exception errorMessage) {
      context.getRequest().setAttribute("Error", errorMessage);
      errorMessage.printStackTrace();
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

   public String executeCommandCessazioneAttivita(ActionContext context) throws ParseException
	{
	 
	    int orgId = Integer.parseInt(context.getParameter("idAnagrafica"));
		String dataFineString = context.getParameter("dataCessazioneAttivita");
		Timestamp dataFine = null;	
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		dataFine = new Timestamp(sdf.parse(dataFineString).getTime());
		String note = context.getParameter("noteCessazione");
		int userId = getUserId(context);
	  
		Connection db = null;
		try
		{
			db=super.getConnection(context);
			Organization org = new Organization(db,orgId);
			AccountsUtil.cessazioneAttivita(db, orgId, dataFine, note, userId);
			context.getRequest().setAttribute("OrgDetails", org);
		}
		catch(SQLException e)
		{
			
		}
			finally{
				super.freeConnection(context, db);
			}
		return "InsertOK";
	}
 
}

 
 
 

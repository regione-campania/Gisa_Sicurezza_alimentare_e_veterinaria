package org.aspcfs.taglib;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Hashtable;
import java.util.StringTokenizer;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;
import javax.servlet.jsp.tagext.TryCatchFinally;

import org.aspcfs.controller.ApplicationPrefs;
import org.aspcfs.controller.SystemStatus;
import org.aspcfs.modules.login.beans.UserBean;
import org.aspcfs.modules.opu.base.IndirizzoNotFoundException;
import org.aspcfs.utils.GestoreConnessioni;

import com.darkhorseventures.database.ConnectionElement;

import ext.aspcfs.modules.apiari.base.DelegaList;

public class AnagraficaApicoltoriRole extends TagSupport implements TryCatchFinally {
	  private String codiceFiscale = null;
	  private String name = null;
	  private boolean allRequired = false;
	  private boolean hasNone = false;

	  public void doCatch(Throwable throwable) throws Throwable {
	    // Required but not needed
	  }

	  public void doFinally() {
	    // Reset each property or else the value gets reused
	    codiceFiscale = null;
	    allRequired = false;
	    hasNone = false;
	  }
	  
	  /**
	   * Sets the Name attribute of the PermissionHandler object
	   *
	   * @param tmp The new Name value
	   * @since 1.1
	   */
	 


	  public String getCodiceFiscale() {
		return codiceFiscale;
	}

	public void setCodiceFiscale(String codiceFiscale) {
		this.codiceFiscale = codiceFiscale;
	}
	
	
	 public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

	/**
	   * Sets the All attribute of the PermissionHandler object. If set to true
	   * then the user must have all permissions passed in.
	   *
	   * @param tmp The new All value
	   * @since 1.1
	   */
	  public void setAll(String tmp) {
	    Boolean checkAll = new Boolean(tmp);
	    this.allRequired = checkAll.booleanValue();
	  }


	  /**
	   * Sets the None attribute of the PermissionHandler object
	   *
	   * @param tmp The new None value
	   * @since 1.1
	   */
	  public void setNone(String tmp) {
	    Boolean checkNone = new Boolean(tmp);
	    this.hasNone = checkNone.booleanValue();
	  }


	  /**
	   * Checks to see if the user has permission to access the body of the tag. A
	   * comma-separated list of permissions can be used to match any of the
	   * permissions.
	   *
	   * @return Description of the Returned Value
	   * @throws JspException Description of Exception
	   * @since 1.1
	   */
	  public final int doStartTag() throws JspException {
	    if (codiceFiscale == null || "".equals(codiceFiscale)) {
	      return EVAL_BODY_INCLUDE;
	    }
	    boolean result = false;
	    int matches = 0;
	    int checks = 0;
	    UserBean thisUser = (UserBean) pageContext.getSession().getAttribute(
	        "User");
	    Connection db = null ; 
	    if (thisUser != null) {
	    try
	    {
	    	String cf = thisUser.getContact().getCodiceFiscale() ; 
	    	if (thisUser.getContact().getCodiceFiscale()==null|| "".equalsIgnoreCase(thisUser.getContact().getCodiceFiscale()))
	    		cf = "#############";
	    	db =  GestoreConnessioni.getConnection();
	    	DelegaList listaDeleghe = new DelegaList();
	    	listaDeleghe.setCodice_fiscale_delegante(codiceFiscale);
	    	listaDeleghe.setCodice_fiscale_delegato(thisUser.getContact().getVisibilitaDelega());
	    	listaDeleghe.setIdAsl(thisUser.getSiteId());
	    	listaDeleghe.buildList(db,null,null);
	    	
	    	String cfImpresa = null;
	    	if(thisUser.getRoleId()==org.aspcfs.modules.admin.base.Role.RUOLO_DELEGATO || thisUser.getContact().getVisibilitaDelega().equalsIgnoreCase("avellino") || 
	    			thisUser.getContact().getVisibilitaDelega().equalsIgnoreCase("benevento") || 
	    			thisUser.getContact().getVisibilitaDelega().equalsIgnoreCase("caserta") || 
	    			thisUser.getContact().getVisibilitaDelega().equalsIgnoreCase("NAPOLI 1 CENTRO") || 
	    			thisUser.getContact().getVisibilitaDelega().equalsIgnoreCase("NAPOLI 2 NORD") || 
	    			thisUser.getContact().getVisibilitaDelega().equalsIgnoreCase("NAPOLI 3 SUD") || 
	    			thisUser.getContact().getVisibilitaDelega().equalsIgnoreCase("salerno"))
	    		cfImpresa = thisUser.getSoggetto().getCodFiscale();
	    	else
	    		cfImpresa = thisUser.getContact().getVisibilitaDelega();
	    	
	    	
	    	if ((codiceFiscale.equalsIgnoreCase(cfImpresa) ) || getPermissionRole()==1)
	    		 result = true;
	    }
	    catch(SQLException | IndirizzoNotFoundException e)
	    {
	    	e.printStackTrace();
	    }
	    finally{
	    	GestoreConnessioni.freeConnection(db);
	    }
	    
	    }
	   
	   

	    //The request wants to know if the user does not have the permissions
	    if (hasNone) {
	      result = !result;
	    }

	    if (result) {
	      return EVAL_BODY_INCLUDE;
	    } else {
	      return SKIP_BODY;
	    }
	  }
	  
	  
	  
	  
	  
	  
	  
	  public final int getPermissionRole() throws JspException
	  {

	    if (name == null || "".equals(name)) {
	      return EVAL_BODY_INCLUDE;
	    }
	    boolean result = false;
	    int matches = 0;
	    int checks = 0;
	    UserBean thisUser = (UserBean) pageContext.getSession().getAttribute("User");
	    if (thisUser != null) 
	    {
	      ConnectionElement ce = thisUser.getConnectionElement();
	      SystemStatus systemStatus = (SystemStatus) ((Hashtable) pageContext.getServletContext().getAttribute("SystemStatus")).get(ce.getUrl());
	      StringTokenizer st = new StringTokenizer(name, ",");
	      boolean isOfflineMode = Boolean.parseBoolean(ApplicationPrefs.getPref(pageContext.getServletContext(), "OFFLINE_MODE"));
	      while (st.hasMoreTokens()) 
	      {
	        String thisPermission = st.nextToken();
	        ++checks;
	        if (systemStatus.hasPermission(thisUser.getRoleId(), thisPermission + (isOfflineMode?"-offline":""))) 
	          ++matches;
	      }
	      if ((allRequired && matches > 0 && matches == checks) || (!allRequired && matches > 0)) 
	        result = true;
	    }

	    //The request wants to know if the user does not have the permissions
	    if (hasNone) 
	      result = !result;

	    if (result) 
	      return EVAL_BODY_INCLUDE;
	    else 
	      return SKIP_BODY;
	  }  

	  public int doEndTag() 
	  {
		return EVAL_PAGE;
	  }

	}
<%-- 
  - Copyright(c) 2004 Dark Horse Ventures LLC (http://www.centriccrm.com/) All
  - rights reserved. This material cannot be distributed without written
  - permission from Dark Horse Ventures LLC. Permission to use, copy, and modify
  - this material for internal use is hereby granted, provided that the above
  - copyright notice and this permission notice appear in all copies. DARK HORSE
  - VENTURES LLC MAKES NO REPRESENTATIONS AND EXTENDS NO WARRANTIES, EXPRESS OR
  - IMPLIED, WITH RESPECT TO THE SOFTWARE, INCLUDING, BUT NOT LIMITED TO, THE
  - IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR ANY PARTICULAR
  - PURPOSE, AND THE WARRANTY AGAINST INFRINGEMENT OF PATENTS OR OTHER
  - INTELLECTUAL PROPERTY RIGHTS. THE SOFTWARE IS PROVIDED "AS IS", AND IN NO
  - EVENT SHALL DARK HORSE VENTURES LLC OR ANY OF ITS AFFILIATES BE LIABLE FOR
  - ANY DAMAGES, INCLUDING ANY LOST PROFITS OR OTHER INCIDENTAL OR CONSEQUENTIAL
  - DAMAGES RELATING TO THE SOFTWARE.
  - 
  - Version: $Id: accounts_search.jsp 18543 2007-01-17 02:55:07Z matt $
  - Description: 
  --%> 
  
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="org.aspcfs.modules.base.Constants,org.aspcfs.utils.web.*" %>
<jsp:useBean id="SearchOrgListInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<jsp:useBean id="AccountStateSelect" class="org.aspcfs.utils.web.StateSelect" scope="request"/>
<jsp:useBean id="OrgDetails" class="org.aspcfs.modules.zonecontrollo.base.Organization" scope="request"/>
<jsp:useBean id="ContactStateSelect" class="org.aspcfs.utils.web.StateSelect" scope="request"/>
<jsp:useBean id="ComuniList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="CountrySelect" class="org.aspcfs.utils.web.CountrySelect" scope="request"/>
<jsp:useBean id="SegmentList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="TypeSelect" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SiteList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="StageList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>

<%@ include file="../utils23/initPage.jsp" %>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popLookupSelect.js"></script>

<script type="text/javascript" src="dwr/interface/PopolaCombo.js"> </script>
        <script type="text/javascript" src="dwr/engine.js"> </script>
        <script type="text/javascript" src="dwr/util.js"></script>
        
<script language="JavaScript">
  function clearForm() {
    <%-- Account Filters --%>
    document.forms['searchAccount'].searchAccountName.value="";
//     document.forms['searchAccount'].searchAccountNumber.value="";
//     document.forms['searchAccount'].searchCognomeRappresentante.value="";
//     document.forms['searchAccount'].searchAccountCityOp.value="";
//     document.forms['searchAccount'].searchAccountCityLeg.value="";
//     document.forms['searchAccount'].searchcodiceMatrice.value=-1;
//     document.forms['searchAccount'].searchcodiceDenominazione.value=-1;
//     document.forms['searchAccount'].searchcodiceEnte.value=-1;
    document.forms['searchAccount'].searchAccountComune.value=-1;
   // document.forms['searchAccount'].searchcodeOrgSiteId.value=-1;
  }
  
  function fillAccountSegmentCriteria(){
    var index = document.forms['searchAccount'].viewOnlySegmentId.selectedIndex;
    var text = document.forms['searchAccount'].viewOnlySegmentId.options[index].text;
    if (index == 0){
      text = "";
    }
    document.forms['searchAccount'].searchAccountSegment.value = text;
  }

  function updateContacts(countryObj, stateObj, selectedValue) {

    var country = document.forms['searchAccount'].elements[countryObj].value;
    var url = "ExternalContacts.do?command=States&country="+country+"&obj="+stateObj+"&selected="+selectedValue+"&form=searchAccount&stateObj=searchcodeContactState";
    window.frames['server_commands'].location.href=url;
  }

  function updateAccounts(countryObj, stateObj, selectedValue) {
    var country = document.forms['searchAccount'].elements[countryObj].value;
    var url = "ZoneControllo.do?command=States&country="+country+"&obj="+stateObj+"&selected="+selectedValue+"&form=searchAccount&stateObj=searchcodeAccountState";
    window.frames['server_commands'].location.href=url;
  }

  function continueUpdateState(stateObj, showText) {
	switch(stateObj){
      case '2':
        if(showText == 'true'){
          hideSpan('state31');
          showSpan('state41');
          document.forms['searchAccount'].searchcodeAccountState.options.selectedIndex = 0;
        } else {
          hideSpan('state41');
          showSpan('state31');
          document.forms['searchAccount'].searchAccountOtherState.value = '';
        }
        break;
	  case '1':
      default:
        if(showText == 'true'){
          hideSpan('state11');
          showSpan('state21');
          document.forms['searchAccount'].searchcodeContactState.options.selectedIndex = 0;
        } else {
          hideSpan('state21');
          showSpan('state11');
          document.forms['searchAccount'].searchContactOtherState.value = '';
        }
        break;
    }
  }
</script>
<dhv:include name="accounts-search-name" none="true">
  <body onLoad="clearForm();">
</dhv:include>
<form name="searchAccount" action="ZoneControllo.do?command=Search" method="post">
<%-- Trails --%>

<table class="trails" cellspacing="0">
<tr>
<td>
<a href="ZoneControllo.do?command=SearchForm"><dhv:label name="">Zone di Controllo</dhv:label></a> > 
<dhv:label name="">Cerca Zone di Controllo</dhv:label>
</td>
</tr>
</table>
<%-- End Trails --%>
<table cellpadding="2" cellspacing="2" border="0" width="100%">
  <tr>
    <td width="50%" valign="top">

      <table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
        <tr>
          <th colspan="2">
            <strong><dhv:label name="">Ricerca Zone di Controllo</dhv:label></strong>
          </th>
        </tr>
        <tr>
          <td class="formLabel">
            <dhv:label name="lab.denom">Descrizione luogo del controllo</dhv:label>
          </td>
          <td>
            <input type="text" maxlength="70" size="50" name="searchAccountName" id="searchAccountName" value="<%= SearchOrgListInfo.getSearchOptionValue("searchAccountName") %>">
          </td>
        </tr>
       <tr>
	<td nowrap class="formLabel" name="address1city" id="address1city">
      <dhv:label name="requestor.requestor_add.City">City</dhv:label>
    </td> 
    <td > 
	<select  name="searchAccountComune" id="searchAccountComune">  
	<option value="-1">Nessuna Selezione</option>
            
	 <%
                Vector v4 = OrgDetails.getComuni2();
	 			Enumeration e4=v4.elements();
                while (e4.hasMoreElements()) {
                	String prov4=e4.nextElement().toString();
                	
        %>
                <option value="<%=prov4%>"><%= prov4 %></option>	
              <%}%>
		
	</select> 
	</td>
  	</tr>
  		
  		 <tr>
          <td nowrap class="formLabel">
            <dhv:label name="accounts.site">Site</dhv:label>
          </td>
          <td>
           <dhv:evaluate if="<%=User.getUserRecord().getSiteId() == -1 %>" >
            <%= SiteList.getHtmlSelect("searchcodeOrgSiteId", ("".equals(SearchOrgListInfo.getSearchOptionValue("searchcodeOrgSiteId")) ? String.valueOf(Constants.INVALID_SITE) : SearchOrgListInfo.getSearchOptionValue("searchcodeOrgSiteId"))) %>
           </dhv:evaluate>
           <dhv:evaluate if="<%=User.getUserRecord().getSiteId() != -1 %>" >
              <input type="hidden" name="searchcodeOrgSiteId" id="searchcodeOrgSiteId" value="<%= User.getUserRecord().getSiteId() %>">
              <%= SiteList.getSelectedValue(User.getUserRecord().getSiteId()) %>
           </dhv:evaluate>
          </td>
        </tr>
        
        
  		
  	</table>
    </td>
  </tr>
</table>
<dhv:include name="accounts-search-contacts" none="false">
  <input type="checkbox" name="searchContacts" value="true" <%= "true".equals(SearchOrgListInfo.getCriteriaValue("searchContacts"))? "checked":""%> />
  <dhv:label name="accounts.search.includeContactsInSearchResults">Include contacts in search results</dhv:label><br />
  <br />
</dhv:include>
<input type="submit" id="search" name="search" value="Ricerca" />
<input type="button" value="<dhv:label name="button.clear">Clear</dhv:label>" onClick="javascript:clearForm();">
<input type="hidden" name="source" value="searchForm">
<iframe src="empty.html" name="server_commands" id="server_commands" style="visibility:hidden" height="0"></iframe>
<script type="text/javascript">
  </script>
</form>



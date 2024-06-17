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
  - Version: $Id: accounts_list.jsp 18543 2007-01-17 02:55:07Z matt $
  - Description:
  --%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*,org.aspcfs.modules.acquedirete.base.*, org.aspcfs.modules.base.*" %>
<jsp:useBean id="OrgList" class="org.aspcfs.modules.acquedirete.base.OrganizationList" scope="request"/>
<jsp:useBean id="SearchOrgListInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<jsp:useBean id="SiteIdList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="OrgCategoriaRischioList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="TypeSelect" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="Audit" class="org.aspcfs.modules.audit.base.Audit" scope="request"/>
<%@ include file="../utils23/initPage.jsp" %>
<%-- Initialize the drop-down menus --%>
<%@ include file="../utils23/initPopupMenu.jsp" %>
<%@ include file="acquedirete_list_menu.jsp" %>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/spanDisplay.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popLookupSelect.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popURL.js"></SCRIPT>
<script language="JavaScript" type="text/javascript">

  <%-- Preload image rollovers for drop-down menu --%>
  
</script>
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="AcqueRete.do?command=SearchForm"><dhv:label name="">Acque Di Rete</dhv:label></a> > 
<dhv:label name="">Risultato Ricerca</dhv:label>
</td>
</tr>
</table>
<%-- End Trails --%>
<dhv:evaluate if="<%= (User.getRoleType() > 0) %>" >
<table class="note" cellspacing="0">
  <tr>
    <th><img src="images/icons/stock_about-16.gif" border="0" align="absmiddle"/></th>
    <td><dhv:label name="accounts.manage">Select an account to manage.</dhv:label></td>
  </tr>
</table>
</dhv:evaluate>

<dhv:pagedListStatus title='<%= showError(request, "actionError") %>' object="SearchOrgListInfo"/>
<% int columnCount = 0; %>
<table cellpadding="8" cellspacing="0" border="0" width="100%" class="pagedList">
  <tr>
    <th nowrap <% ++columnCount; %>>
      <%--strong><a href="LaboratoriHACCP.do?command=Search&column=o.ragione_sociale"--%><dhv:label name="">Denominazione</dhv:label><%--/a></strong>
      <%= SearchOrgListInfo.getSortIcon("o.ragione_sociale") --%>
    </th>  
     <th nowrap <% ++columnCount; %>>
      <%--strong><a href="LaboratoriHACCP.do?command=Search&column=o.ragione_sociale"--%><dhv:label name="">Codice Univoco</dhv:label><%--/a></strong>
      <%= SearchOrgListInfo.getSortIcon("o.ragione_sociale") --%>
    </th>
     <th nowrap <% ++columnCount; %>>
      <dhv:label name="">ASL</dhv:label>
    </th>  
        <%--    <dhv:include name="organization.list.siteId" none="true"> --%>
<zeroio:debug value='<%="JSP::accounts_list.jsp "+ SearchOrgListInfo.getSearchOptionValue("searchcodeOrgSiteId")+" == "+(String.valueOf(Constants.INVALID_SITE)) %>'/>
      <%--dhv:evaluate if='<%= SearchOrgListInfo.getSearchOptionValue("searchcodeOrgSiteId").equals(String.valueOf(Constants.INVALID_SITE)) %>'--%>       
        <th <% ++columnCount; %>>
          <strong><dhv:label name="">Ubicazione</dhv:label></strong>
        </th>
  </tr>
<%
	Iterator j = OrgList.iterator();
	if ( j.hasNext() ) {
    int rowid = 0;
    int i = 0;
    while (j.hasNext()) {
    i++;
    rowid = (rowid != 1 ? 1 : 2);
    Organization thisOrg = (Organization)j.next();
%>
  <tr class="row<%= rowid %>">
	<td>
      <a href="AcqueRete.do?command=Details&orgId=<%=thisOrg.getOrgId()%>">
      <%= toHtml((thisOrg.getName()!=null && !thisOrg.getName().equals("") ? thisOrg.getName() : "< Non disponibile >") ) %></a>
	</td>
	 <td>
    	<%= toHtml(thisOrg.getAccountNumber()) %>
    </td> 
    <td>
    	<%= SiteIdList.getSelectedValue(thisOrg.getSiteId()) %>
    </td> 
      
	<% Iterator iaddress = thisOrg.getAddressList().iterator();
       Object address[] = null;
       int x = 0;
       if (iaddress.hasNext()) {%>
       <td>
    	   <%
          while (iaddress.hasNext()) {
        	  
        	  org.aspcfs.modules.acquedirete.base.OrganizationAddress thisAddress = (org.aspcfs.modules.acquedirete.base.OrganizationAddress)iaddress.next(); 
          if(thisAddress.getType()==1){ 
         %>
     <b>Sede Legale:&nbsp;</b> 
      <%= toHtml((thisAddress.getStreetAddressLine1()!= null && (thisAddress.getCity()!=null)&&(thisAddress.getType()==1)) ? (thisAddress.getStreetAddressLine1()+" "+thisAddress.getCity()) : ("")) %>&nbsp;<br/><br/>
	<%}
	if(thisAddress.getType()==5){ %>
	<b>&nbsp;</b> 
    <%--  <%= toHtml(thisAddress.getCity()) %>  --%>
       <%= toHtml((thisAddress.getStreetAddressLine1()!= null) ? thisAddress.getStreetAddressLine1()+" "+thisAddress.getCity() : (thisAddress.getCity())) %>
		
	<%}}%>
	</td>
	<%}else{ %>
	<td nowrap>Nessun Indirizzo.</td>
	<%} %>
  </tr>
   
  <input type="hidden" name="source" value="searchForm">
<%}%>
<%} else {%>
  <tr class="containerBody">
    <td colspan="<%= SearchOrgListInfo.getSearchOptionValue("searchcodeOrgSiteId").equals(String.valueOf(Constants.INVALID_SITE))?columnCount+1:columnCount %>">
      <dhv:label name="">Nessun Acque Di Rete trovato.</dhv:label><br />
      <a href="AcqueRete.do?command=SearchForm"><dhv:label name="">Modifica Ricerca</dhv:label></a>.
    </td>
  </tr>
<%}%>
</table>
<br />
<dhv:pagedListControl object="SearchOrgListInfo" tdClass="row1"/>


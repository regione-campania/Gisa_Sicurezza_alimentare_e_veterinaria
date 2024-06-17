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
<%@ page import="java.util.*,org.aspcfs.modules.trasportoanimali.base.*, org.aspcfs.modules.base.*" %>
<jsp:useBean id="OrgList" class="org.aspcfs.modules.trasportoanimali.base.OrganizationList" scope="request"/>
<jsp:useBean id="SearchOrgListInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<jsp:useBean id="SiteIdList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="TypeSelect" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<%@ include file="../utils23/initPage.jsp" %>
<%-- Initialize the drop-down menus --%>
<%@ include file="../utils23/initPopupMenu.jsp" %>
<%@ include file="accounts_list_menu.jsp" %>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/spanDisplay.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popURL.js"></SCRIPT>
<script language="JavaScript" type="text/javascript">
  <%-- Preload image rollovers for drop-down menu --%>
  
</script>
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="TrasportoAnimali.do"><dhv:label name="">Trasporto Animali</dhv:label></a> > 
<dhv:label name="trasportoanimali.SearchResults">Risultati Ricerca</dhv:label>
</td>
</tr>
</table>
<%-- End Trails --%>
<dhv:evaluate if="<%= (User.getRoleType() > 0) %>" >
<table class="note" cellspacing="0">
  <tr>
    <th><img src="images/icons/stock_about-16.gif" border="0" align="absmiddle"/></th>
    <td><dhv:label name="trasportoanimali.manage">Select an account to manage.</dhv:label></td>
  </tr>
</table>
</dhv:evaluate>
<dhv:permission name="trasportoanimali-trasportoanimali-add"><a href="TrasportoAnimali.do?command=ScegliRichiesta"><dhv:label name="">Aggiungi Trasporto Animali</dhv:label></a></dhv:permission>
<dhv:include name="pagedListInfo.alphabeticalLinks" none="true">
<center><dhv:pagedListAlphabeticalLinks object="SearchOrgListInfo"/></center></dhv:include>
<dhv:pagedListStatus title='<%= showError(request, "actionError") %>' object="SearchOrgListInfo"/>
<% int columnCount = 0; %>
<table cellpadding="8" cellspacing="0" border="0" width="100%" class="pagedList">
 
	<tr>
    		
	    <th nowrap <% ++columnCount; %>>
      		<strong><a href="TrasportoAnimali.do?command=Search&column=o.name"><dhv:label name="">Denominazione/Cognome Nome</dhv:label></a></strong>
      		<%= SearchOrgListInfo.getSortIcon("o.name") %>
    	</th>
    	<th nowrap <% ++columnCount; %>>
    		<strong>
    			<dhv:label name="organization.accountNumber">Account number</dhv:label></strong>
    	</th>   
    	<th nowrap <% ++columnCount; %>>
    		<strong>
    			<dhv:label name="">A.S.L.</dhv:label></strong>
    	</th> 
         
    	<th nowrap <% ++columnCount; %>>
          <strong>Targa veicolo</strong>
		</th>
		<th nowrap <% ++columnCount; %>>
          <strong>Stato Attivit�</strong>
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
      <a href="TrasportoAnimali.do?command=Details&tipo_richiesta=<%=thisOrg.getDunsType() %>&orgId=<%=thisOrg.getOrgId()%>"><%= toHtml(thisOrg.getName()) %></a>
	</td>
	
	<td>
     <%= toHtml(thisOrg.getAccountNumber()) %>
      
	</td>  	
<%--    <dhv:include name="organization.list.siteId" none="true"> --%>
      <%--<dhv:evaluate if='<%= SearchOrgListInfo.getSearchOptionValue("searchcodeOrgSiteId").equals(String.valueOf(Constants.INVALID_SITE)) %>'>
        <td valign="top"><%= SiteIdList.getSelectedValue(thisOrg.getSiteId()) %>xx</td>
      </dhv:evaluate>--%>
      <td valign="top"><%= SiteIdList.getSelectedValue(thisOrg.getSiteId()) %></td>
<%--    </dhv:include> --%>
	
	
		<td>
      <%= toHtml(thisOrg.getTarga())%>
	</td>
	<td>
      <%= toHtml(thisOrg.getStato())%>
	</td>
  </tr>
<%}%>
<%} else {%>
  <tr class="containerBody">
    <td colspan="<%= SearchOrgListInfo.getSearchOptionValue("searchcodeOrgSiteId").equals(String.valueOf(Constants.INVALID_SITE))?columnCount+1:columnCount %>">
      <dhv:label name="trasportoanimali.search.notFound">Nessun Impresa trovata con i parametri di ricerca specificati.</dhv:label><br />
      <a href="TrasportoAnimali.do?command=SearchForm"><dhv:label name="trasportoanimali.trasportoanimali_list.ModifySearch">Modifica Ricerca</dhv:label></a>.
    </td>
  </tr>
<%}%>
</table>
<br />
<dhv:pagedListControl object="SearchOrgListInfo" tdClass="row1"/>


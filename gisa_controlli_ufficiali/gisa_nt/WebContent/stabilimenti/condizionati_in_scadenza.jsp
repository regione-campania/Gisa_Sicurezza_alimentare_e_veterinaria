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
<%@ page import="java.util.*,org.aspcfs.modules.stabilimenti.base.*, org.aspcfs.modules.base.*" %>

<jsp:useBean id="SearchOrgListInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<jsp:useBean id="SiteIdList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="OrgCategoriaRischioList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="impianto" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="statoLab" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="TypeSelect" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="statiStabilimenti" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="AuditList" class="org.aspcfs.modules.audit.base.AuditList" scope="request"/>
<jsp:useBean id="Audit" class="org.aspcfs.modules.audit.base.Audit" scope="request"/>
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
<a href="Stabilimenti.do"><dhv:label name="stabilimenti.stabilimenti">Accounts</dhv:label></a> > 
Linee Produttive Condizionate in Scadenza
</td>
</tr>
</table>
<%-- End Trails --%>
<dhv:evaluate if="<%= (User.getRoleType() > 0) %>" >
<table class="note" cellspacing="0">
  <tr>
    <th><img src="images/icons/stock_about-16.gif" border="0" align="absmiddle"/></th>
    <td><dhv:label name="stabilimenti.manage">Select an account to manage.</dhv:label></td>
  </tr>
</table>
</dhv:evaluate>
<dhv:include name="pagedListInfo.alphabeticalLinks" none="true">
<center><dhv:pagedListAlphabeticalLinks object="SearchOrgListInfo"/></center></dhv:include>
<dhv:pagedListStatus title='<%= showError(request, "actionError") %>' object="SearchOrgListInfo"/>
<% int columnCount = 0; %>
<table cellpadding="8" cellspacing="0" border="0" width="100%" class="pagedList">
  <tr>
    
    <th nowrap <% ++columnCount; %>>
      <strong><a href="Stabilimenti.do?command=Search&column=o.name"><dhv:label name="organization.name">Account Name</dhv:label></a></strong>
      <%= SearchOrgListInfo.getSortIcon("o.name") %>
    </th>
    
    <th nowrap <% ++columnCount; %>>
      <strong>Approval Number</strong>
    </th>
    
    
    <th nowrap <% ++columnCount; %>>
      <strong>Stato Attivita</strong>
    </th>
    
      
     <th nowrap <% ++columnCount; %>>
      <strong>Sezione</strong>
    </th>
   
    
    <th nowrap <% ++columnCount; %>>
      <strong>Data inizio</strong>
    </th>
        <th nowrap <% ++columnCount; %>>
      <strong>Data Scadenza</strong>
    </th>
    
    
    
  
    
 
	



  </tr>
<%

ArrayList<SottoAttivita> l = (ArrayList<SottoAttivita>)request.getAttribute("OrgList");
	Iterator j = l.iterator();
	if ( j.hasNext() ) {
    int rowid = 0;
    int i = 0;
    while (j.hasNext()) {
    i++;
    rowid = (rowid != 1 ? 1 : 2);
    SottoAttivita thisOrg = (SottoAttivita)j.next();
   
%>
  <tr class="row<%= rowid %>">
    
    
 
		<td>
	      <a href="Stabilimenti.do?command=Details&orgId=<%=thisOrg.getId_stabilimento()%>"><%= toHtml(thisOrg.getRagioneSociale()) %></a>
		</td>

	<td>
    <%=thisOrg.getApprovalNumber() %>
      </td>
	<%if(thisOrg.getStato_attivita()>-1) {%>
	<td>
      <%= statoLab.getSelectedValue(thisOrg.getStato_attivita()) %>
	</td>
	<%}else{%>
		<td>&nbsp;
		</td> 
	<%}%>
	
	<%if(thisOrg.getCodice_impianto()>0) {%>
	<td>
      <%=impianto.getSelectedValue(thisOrg.getCodice_impianto())%>
	</td>
		<%}else{%>
		<td>&nbsp;
		</td> 
	<%}%>
	<td><%=thisOrg.getData_inizio_attivitaAsString() %>
		</td> 
	<td><%=thisOrg.getDataScadenzaAsString() %>
		</td> 
	


  </tr>
<%}%>
<%} else {%>
  <tr class="containerBody">
    <td colspan="<%= SearchOrgListInfo.getSearchOptionValue("searchcodeOrgSiteId").equals(String.valueOf(Constants.INVALID_SITE))?columnCount+1:columnCount %>">
      <dhv:label name="stabilimenti.search.notFound">No accounts found with the specified search parameters.</dhv:label><br />
      <a href="Stabilimenti.do?command=SearchForm"><dhv:label name="stabilimenti.stabilimenti_list.ModifySearch">Modify Search</dhv:label></a>.
    </td>
  </tr>
<%}%>
</table>
<br />
<dhv:pagedListControl object="SearchOrgListInfo" tdClass="row1"/>

<form method="post" action="./Stabilimenti.do?command=export">
<%

String source="";
String numaut="";
 source = (String) request.getParameter("source");

if((request.getParameter("searchNumAut"))!=null){
    numaut=request.getParameter("searchNumAut");
    }

%>


<%--input type="submit" value="scarica stabilimenti .xls"--%>
<input type="hidden" value="<%=numaut %>">
</form>


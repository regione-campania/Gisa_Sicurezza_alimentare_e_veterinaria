

<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*,org.aspcfs.modules.osa.base.*, org.aspcfs.modules.base.*" %>
<jsp:useBean id="OrgList" class="org.aspcfs.modules.osa.base.OrganizationList" scope="request"/>
<jsp:useBean id="SearchOrgListInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<jsp:useBean id="SiteIdList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="OrgCategoriaRischioList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="AuditList" class="org.aspcfs.modules.audit.base.AuditList" scope="request"/>
<jsp:useBean id="Audit" class="org.aspcfs.modules.audit.base.Audit" scope="request"/>
<jsp:useBean id="TypeSelect" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<%@ include file="../utils23/initPage.jsp" %>

<%@ include file="../utils23/initPopupMenu.jsp" %>
<%@ include file="accounts_list_menu.jsp" %>
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
<a href="OsAnimali.do">Operatori Sperimentazione Animali</a> > 
<dhv:label name="accounts.SearchResults">Search Results</dhv:label>
</td>
</tr>
</table>
<%-- End Trails --%>



<dhv:pagedListStatus title='<%= showError(request, "actionError") %>' object="SearchOrgListInfo"/>
<% int columnCount = 0; %>
<table cellpadding="8" cellspacing="0" border="0" width="100%" class="pagedList">
  <tr>
    
    <th nowrap <% ++columnCount; %>>
      <strong><a href="OsAnimali.do?command=Search&column=o.name">
      Impresa</a></strong>
      <%= SearchOrgListInfo.getSortIcon("o.name") %>
    </th>
   <th nowrap <% ++columnCount; %>>

      <strong>Codice Autorizzazione</strong>

    </th>
    <th nowrap <% ++columnCount; %>>
          <strong>Sede Operativa</strong>
		</th>
    
    
        <th <% ++columnCount; %>>
          <strong><dhv:label name="accounts.site">Site</dhv:label></strong>
        </th>
      
        <th nowrap <% ++columnCount; %>>
          <strong>Responsabile Legale</strong>
		</th>
		 <th nowrap <% ++columnCount; %>>
          <strong>Responsabile Animale Care</strong>
		</th>
        <th nowrap <% ++columnCount; %>>
          <strong>Medico Veterinario</strong>
		</th>
		<th nowrap <% ++columnCount; %>>
      <strong>Categoria Rischio</strong>
    </th>
    
        <th nowrap <% ++columnCount; %>>
          <strong>Inserito da</strong>
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
      <a href="OsAnimali.do?command=Details&orgId=<%=thisOrg.getOrgId()%>"><%= toHtml(thisOrg.getName()) %></a>
	</td>
	
	<td>
      <%= toHtml(thisOrg.getAccountNumber()) %>
	</td>

		<%
	Iterator iaddress = thisOrg.getAddressList().iterator();
       Object address[] = null;
       int x = 0;
       boolean trovato = false ;
       if (iaddress.hasNext()) {
          
    	   while (iaddress.hasNext()) {
        	  org.aspcfs.modules.accounts.base.OrganizationAddress thisAddress = (org.aspcfs.modules.accounts.base.OrganizationAddress)iaddress.next(); 
          if(thisAddress.getType()==5){
        	  trovato = true ;
        	  %>
     <td>
      <%= toHtml((thisAddress.getStreetAddressLine1()!= null && (thisAddress.getCity()!=null)&&(thisAddress.getType()==5)) ? (thisAddress.getStreetAddressLine1()+" "+thisAddress.getCity()) : ("")) %>
	</td> 
	<%}}}
   
	 %>
		
        <td valign="top" nowrap><%= SiteIdList.getSelectedValue(thisOrg.getSiteId()) %></td>

	  
    
	<td nowrap>
       <%= toHtml(thisOrg.getNomeRappresentante()) %>
       </td>
       <td>
       <%= toHtml(thisOrg.getResponsabileAnimale()) %>
	</td>
	<td nowrap>
      <%= toHtml(thisOrg.getMedicoVeterinario()) %>
	</td>
	<td>
	<%= (thisOrg.getCategoriaRischio()) %>
	</td>
	
    <td nowrap>
      <dhv:username id="<%= thisOrg.getEnteredBy() %>" />
	</td>
  </tr>
<%}%>
<%} else {%>
  <tr class="containerBody">
    <td colspan="<%= SearchOrgListInfo.getSearchOptionValue("searchcodeOrgSiteId").equals(String.valueOf(Constants.INVALID_SITE))?columnCount+1:columnCount %>">
      Nessu Operatore Trovato Con i parametri specificati
      <a href="OsAnimali.do?command=SearchForm"><dhv:label name="accounts.accounts_list.ModifySearch">Modify Search</dhv:label></a>.
    </td>
  </tr>
<%}%>
</table>
<br />
<dhv:pagedListControl object="SearchOrgListInfo" tdClass="row1"/>


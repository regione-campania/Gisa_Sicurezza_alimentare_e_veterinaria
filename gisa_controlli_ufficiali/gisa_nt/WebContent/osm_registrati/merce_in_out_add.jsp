<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,org.aspcfs.modules.troubletickets.base.*" %>
<%@ include file="../utils23/initPage.jsp" %>
<jsp:useBean id="OrgDetails" class="org.aspcfs.modules.osmregistrati.base.Organization" scope="request"/>
<jsp:useBean id="TipoMollusco" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<form name="addticket" action="StabMerceInOut.do?command=Insert&auto-populate=true" method="post">
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="OsmRegistrati.do">OSM Registrati</a> > 
<a href="OsmRegistrati.do?command=Search"><dhv:label name="stabilimenti.SearchResults">Search Results</dhv:label></a> >
<a href="OsmRegistrati.do?command=Details&orgId=<%=OrgDetails.getOrgId() %>"><dhv:label name="communications.campaign.Dashboards">Scheda OSM</dhv:label></a> >

<a href="StabMerceInOut.do?command=List&orgId=<%=OrgDetails.getOrgId() %>"><dhv:label name="merce_in_out">Merce in Ingresso/Uscita</dhv:label></a> > 
<dhv:label name="merce_in_out.new">Nuova Merce in Ingresso/Uscita</dhv:label>
</td>
</tr>
</table>
<%-- End Trails --%>
<input type="submit" value="<dhv:label name="button.insert">Insert</dhv:label>" name="Save" onClick="return checkForm(this.form)">
<input type="submit" value="Annulla" onClick="javascript:this.form.action='Molluschicoltori.do?command=ViewSanzioni'">
<br>
<dhv:formMessage />
<iframe src="empty.html" name="server_commands" id="server_commands" style="visibility:hidden" height="0"></iframe>
<% if (request.getAttribute("closedError") != null) { %>
  <%= showAttribute(request, "closedError")  %>
<%}%>
<%-- include basic troubleticket add form --%>

<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.text.DateFormat, org.aspcfs.modules.actionplans.base.*" %>
<jsp:useBean id="DepartmentList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="resolvedByDeptList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="CategoryList" class="org.aspcfs.modules.troubletickets.base.TicketCategoryList" scope="request"/>
<jsp:useBean id="TicketDetails" class="org.aspcfs.modules.sanzioni.base.Ticket" scope="request"/>
<jsp:useBean id="PriorityList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SiteIdList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="Provvedimenti" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SanzioniAmministrative" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SanzioniPenali" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="Sequestri" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SeverityList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SourceList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="ticketStateList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="Recipient" class="org.aspcfs.modules.contacts.base.Contact" scope="request"/>
<jsp:useBean id="causeList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="resolutionList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="EscalationList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="OrgList" class="org.aspcfs.modules.osmregistrati.base.OrganizationList" scope="request"/>

<jsp:useBean id="SubList1" class="org.aspcfs.modules.troubletickets.base.TicketCategoryList" scope="request"/>
<jsp:useBean id="SubList2" class="org.aspcfs.modules.troubletickets.base.TicketCategoryList" scope="request"/>
<jsp:useBean id="SubList3" class="org.aspcfs.modules.troubletickets.base.TicketCategoryList" scope="request"/>
<jsp:useBean id="UserList" class="org.aspcfs.modules.admin.base.UserList" scope="request"/>
<jsp:useBean id="resolvedUserList" class="org.aspcfs.modules.admin.base.UserList" scope="request"/>
<jsp:useBean id="ContactList" class="org.aspcfs.modules.contacts.base.ContactList" scope="request"/>
<jsp:useBean id="actionPlans" class="org.aspcfs.modules.actionplans.base.ActionPlanList" scope="request"/>
<jsp:useBean id="insertActionPlan" class="java.lang.String" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="defectSelect" class="org.aspcfs.utils.web.HtmlSelect" scope="request"/>
<jsp:useBean id="TimeZoneSelect" class="org.aspcfs.utils.web.HtmlSelectTimeZone" scope="request"/>
<jsp:useBean id="systemStatus" class="org.aspcfs.controller.SystemStatus" scope="request"/>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popAccounts.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popServiceContracts.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popAssets.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popProducts.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popURL.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popCalendar.js"></script>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popLookupSelect.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popContacts.js"></SCRIPT>

<table cellpadding="4" cellspacing="0" width="100%" class="details">
	<tr>
    <th colspan="2">
      <strong><dhv:label name="">Aggiungi Merce in Uscita</dhv:label></strong>
    </th>
	</tr>

   <tr class="containerBody">
    <td nowrap class="formLabel">
      <dhv:label name="stab.stab">OSM</dhv:label>
    </td>
    <td>
    	<%=toHtmlValue( OrgDetails.getName() ) %>
    	<input type="hidden" name="orgId" value="<%=OrgDetails.getOrgId() %>" />
    </td>
  </tr>
  
  <tr class="containerBody">
    <td nowrap class="formLabel">
      <dhv:label name="merce_in_out.data_arrivoo">Data Arrivo</dhv:label>
    </td>
    <td>
      <zeroio:dateSelect form="addticket" field="data_arrivo" timeZone="<%= TicketDetails.getAssignedDateTimeZone() %>" showTimeZone="false" />
    </td>
  </tr>
	
  <tr class="containerBody">
    <td nowrap class="formLabel">
      <dhv:label name="merce_in_out.data_invio">Data Invio</dhv:label>
    </td>
    <td>
      <zeroio:dateSelect form="addticket" field="data_invio" timeZone="<%= TicketDetails.getAssignedDateTimeZone() %>" showTimeZone="false" />
    </td>
  </tr>
  
  <tr class="containerBody">
    <td nowrap class="formLabel">
      <dhv:label name="merce_in_out.moll">Specie Mollusco</dhv:label>
    </td>
    <td>
      <%=TipoMollusco.getHtmlSelect( "tipo_mollusco", -1 ) %>
    </td>
  </tr>
  
  <tr class="containerBody">
    <td nowrap class="formLabel">
      <dhv:label name="merce_in_out.quantita">Quantit&agrave;</dhv:label>
    </td>
    <td>
      <input type="text" name="quantita" />
    </td>
  </tr>
  
  <tr class="containerBody">
    <td nowrap class="formLabel">
      <dhv:label name="merce_in_out.id_destinatario">Provenienza</dhv:label>
    </td>
    <td>
            <div id="changeaccount_prov">
              <% if(TicketDetails.getOrgId() != -1) {%>
                <%= toHtml(TicketDetails.getCompanyName()) %>
              <%} else {%>
                <dhv:label name="accounts.accounts_add.NoneSelected">None Selected</dhv:label>
              <%}%>
            </div>
    	<input type="hidden" name="id_provenienza" id="id_provenienza" value="-1" />
        [<a href="javascript:popAccountsListSingleNew('id_provenienza','changeaccount_prov', 'showMyCompany=true&filters=all|my|disabled');"><dhv:label name="accountsa.accounts_add.select">Seleziona OSM</dhv:label></a>]
        [<a href="javascript:popAccountsListSingleNewMoll('id_provenienza','changeaccount_prov', 'showMyCompany=true&filters=all|my|disabled');"><dhv:label name="accountsa.accounts_add.select">Seleziona Molluschicoltore</dhv:label></a>]
    </td>
  </tr>
  
  <tr class="containerBody">
    <td nowrap class="formLabel">
      <dhv:label name="merce_in_out.stato_regione_provenienza">Stato/Regione Provenienza</dhv:label>
    </td>
    <td>
      <input type="text" name="stato_regione_provenienza" />
    </td>
  </tr>
  
  <tr class="containerBody">
    <td nowrap class="formLabel">
      <dhv:label name="merce_in_out.id_destinatario">Destinatario</dhv:label>
    </td>
    <td>
            <div id="changeaccount">
              <% if(TicketDetails.getOrgId() != -1) {%>
                <%= toHtml(TicketDetails.getCompanyName()) %>
              <%} else {%>
                <dhv:label name="accounts.accounts_add.NoneSelected">None Selected</dhv:label>
              <%}%>
            </div>
    	<input type="hidden" name="id_destinatario" id="id_destinatario" value="-1" />
        [<a href="javascript:popAccountsListSingleNew('id_destinatario','changeaccount', 'showMyCompany=true&filters=all|my|disabled');"><dhv:label name="accountsa.accounts_add.select">Seleziona OSM</dhv:label></a>]
    </td>
  </tr>
  
  <tr class="containerBody">
    <td nowrap class="formLabel">
      <dhv:label name="merce_in_out.id_doc_traporto">Identificativo Documento di Trasporto</dhv:label>
    </td>
    <td>
      <input type="text" name="idetificativo_documento_trasporto" />
    </td>
  </tr>


</table>
<br />
<a name="categories"></a>
<input type="hidden" name="close" value="">
<input type="hidden" name="refresh" value="-1">
<input type="hidden" name="modified" value="<%=  TicketDetails.getModified() %>" />
<input type="hidden" name="currentDate" value="<%=  request.getAttribute("currentDate") %>" />
<input type="hidden" name="statusId" value="<%=  TicketDetails.getStatusId() %>" />
<input type="hidden" name="trashedDate" value="<%=  TicketDetails.getTrashedDate() %>" />
<%= addHiddenParams(request, "popup|popupType|actionId") %>


<br>
<input type="submit" value="<dhv:label name="button.insert">Insert</dhv:label>" name="Save" onClick="return checkForm(this.form)">
<input type="submit" value="Annulla" onClick="javascript:this.form.action='Molluschicoltori.do?command=ViewSanzioni'">
</form>

<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*,org.aspcfs.modules.vigilanza.base.*" %>
<%@ include file="../utils23/initPage.jsp" %>

<%@page import="org.aspcfs.utils.web.LookupList"%><jsp:useBean id="OrgDetails" class="org.aspcfs.modules.parafarmacie.base.Organization" scope="request"/>
<jsp:useBean id="TicketDetails" class="org.aspcfs.modules.vigilanza.base.Ticket" scope="request"/>
<jsp:useBean id="SiteIdList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="TipoIspezione" class="org.aspcfs.utils.web.LookupList" scope="request"/>

<script type="text/javascript" src="dwr/interface/ControlliUfficiali.js?n=2"> </script>
<script type="text/javascript" src="dwr/engine.js"> </script>
<script type="text/javascript" src="dwr/util.js"></script>


<body onload = "provaFunzione('addticket'); onloadAllerta('addticket');
costruisci_rel_ateco_attivita('<%= OrgDetails.getOrgId() %>', 'id_linea_sottoposta_a_controllo'); ">


<%@ page
	import="java.text.DateFormat, org.aspcfs.modules.actionplans.base.*"%>
<jsp:useBean id="DepartmentList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="EsitoCampione" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="TipoCampione" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="TipoAudit" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="AuditTipo" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="Bpi" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="Haccp" class="org.aspcfs.utils.web.LookupList"
	scope="request" />

<jsp:useBean id="Ispezione" class="java.util.HashMap" scope="request" />
<jsp:useBean id="IspezioneMacrocategorie" class="org.aspcfs.utils.web.LookupList" scope="request" />


<jsp:useBean id="PianoMonitoraggio1"
	class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="PianoMonitoraggio2"
	class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="PianoMonitoraggio3"
	class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="resolvedByDeptList"
	class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="TitoloNucleo" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="TitoloNucleoDue"
	class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="TitoloNucleoTre"
	class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="TitoloNucleoQuattro"
	class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="TitoloNucleoCinque"
	class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="TitoloNucleoSei"
	class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="TitoloNucleoSette"
	class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="TitoloNucleoOtto"
	class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="TitoloNucleoNove"
	class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="TitoloNucleoDieci"
	class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="CategoryList"
	class="org.aspcfs.modules.troubletickets.base.TicketCategoryList"
	scope="request" />
<jsp:useBean id="PriorityList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="Provvedimenti" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="SanzioniAmministrative"
	class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="SeverityList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="SourceList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="ticketStateList"
	class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="Recipient"
	class="org.aspcfs.modules.contacts.base.Contact" scope="request" />
<jsp:useBean id="DestinatarioCampione"
	class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="causeList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="fileItem" class="com.zeroio.iteam.base.FileItem"
	scope="request" />
<jsp:useBean id="EsitoControllo" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="DistribuzionePartita"
	class="org.aspcfs.utils.web.LookupList" scope="request" />

<jsp:useBean id="DestinazioneDistribuzione"
	class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="ArticoliAzioni" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="AzioniAdottate" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="resolutionList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="EscalationList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
<jsp:useBean id="OrgList"
	class="org.aspcfs.modules.parafarmacie.base.OrganizationList"
	scope="request" />
<jsp:useBean id="SubList1"
	class="org.aspcfs.modules.troubletickets.base.TicketCategoryList"
	scope="request" />
<jsp:useBean id="SubList2"
	class="org.aspcfs.modules.troubletickets.base.TicketCategoryList"
	scope="request" />
<jsp:useBean id="SubList3"
	class="org.aspcfs.modules.troubletickets.base.TicketCategoryList"
	scope="request" />
<jsp:useBean id="UserList"
	class="org.aspcfs.modules.admin.base.UserList" scope="request" />
<jsp:useBean id="resolvedUserList"
	class="org.aspcfs.modules.admin.base.UserList" scope="request" />
<jsp:useBean id="ContactList"
	class="org.aspcfs.modules.contacts.base.ContactList" scope="request" />
<jsp:useBean id="actionPlans"
	class="org.aspcfs.modules.actionplans.base.ActionPlanList"
	scope="request" />
<jsp:useBean id="insertActionPlan" class="java.lang.String"
	scope="request" />
<jsp:useBean id="defectSelect" class="org.aspcfs.utils.web.HtmlSelect"
	scope="request" />
<jsp:useBean id="TimeZoneSelect"
	class="org.aspcfs.utils.web.HtmlSelectTimeZone" scope="request" />
<jsp:useBean id="systemStatus"
	class="org.aspcfs.controller.SystemStatus" scope="request" />
<script language="JavaScript" TYPE="text/javascript"
	SRC="javascript/popAccounts.js"></script>
<script language="JavaScript" TYPE="text/javascript"
	SRC="javascript/popServiceContracts.js"></script>
<script language="JavaScript" TYPE="text/javascript"
	SRC="javascript/popAssets.js"></script>
<script language="JavaScript" TYPE="text/javascript"
	SRC="javascript/popProducts.js"></script>
<script language="JavaScript" TYPE="text/javascript"
	SRC="javascript/popURL.js"></script>
<script language="JavaScript" TYPE="text/javascript"
	SRC="javascript/popCalendar.js"></script>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript"
	SRC="javascript/popLookupSelect.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript"
	SRC="javascript/popContacts.js"></SCRIPT>
<script language="JavaScript" type="text/javascript"
	src="javascript/confrontaDate.js"></script>
<script language="JavaScript" TYPE="text/javascript"
	SRC="javascript/checkDate.js"></script>
<script language="JavaScript" TYPE="text/javascript"
	SRC="javascript/controlliUfficiali.js?n=2"></script>
<script language="JavaScript" TYPE="text/javascript"
	SRC="javascript/controlli_ufficiali_imprese.js"></script>
<body onload = "provaFunzione('addticket'); onloadAllerta('addticket')">

 <%
 //gestioneVisibilitaCodiceAteco('addticket')
	TipoIspezione.setJsEvent("onChange=javascript:mostraMenuTipoIspezione('addticket');");
	TitoloNucleoDue.setJsEvent("onChange=mostraCampo2('addticket')");
	PianoMonitoraggio1.setJsEvent("onChange=javascript:piani('addticket')");
    PianoMonitoraggio2.setJsEvent("onChange=javascript:piani('addticket')");
    PianoMonitoraggio3.setJsEvent("onChange=javascript:piani('addticket')");
	AuditTipo.setJsEvent("onChange=javascript:mostraMenu4('addticket')");
    TipoAudit.setJsEvent("onChange=javascript:mostraMenu2('addticket')");
  
    TipoCampione.setJsEvent("onChange=javascript:reloadAddCU('ParafarmacieVigilanza.do?command=Add&orgId="+OrgDetails.getOrgId()+"&tipoCampione='+this.value)"); 
	TitoloNucleo.setJsEvent("onChange=mostraCampooo('addticket')"); 
%>



<script>
//var r = confirm("ATTENZIONE! Per aggiungere un controllo ufficiale � necessario importare prima lo stabilimento nella NUOVA ANAGRAFICA.\nProseguire con la procedura di importazione?");		
alert("ATTENZIONE! Prima di aggiungere un nuovo controllo, � necessario aggiornare la scheda anagrafica utilizzando la funzione COMPLETA SCHEDA ANAGRAFICA.");
window.location.href='Parafarmacie.do?command=DetailsFcie&idFarmacia=<%=OrgDetails.getOrgId()%>';		
</script>


<form method="post" name="addticket" action="ParafarmacieVigilanza.do?command=Insert&auto-populate=true" >
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
  <a href="Parafarmacie.do?command=SearchFormFcie"><dhv:label name="">Farmacie / Grossisti / Parafarmacie</dhv:label></a> > 
<a href="Parafarmacie.do?command=SearchFcie"><dhv:label name="accounts.SearchResults">Search Results</dhv:label></a> >
 <a href="Parafarmacie.do?command=DetailsFcie&idFarmacia=<%=OrgDetails.getOrgId()%>">Dettaglio Parafarmacie</a> >
  <a href="ParafarmacieVigilanza.do?command=ViewVigilanza&orgId=<%=OrgDetails.getOrgId()%>"><dhv:label name="vigilanza">Tickets</dhv:label></a> >
  <dhv:label name="campioni.aggiungi">Aggiungi Controllo Ufficiale</dhv:label>
</td>
</tr>
</table>

<input type="submit" value="<dhv:label name="button.inserta">Inserisci </dhv:label>" name="Save" onClick="<%--javascript:this.form.action='AccountVigilanza.do?command=InsertContinua&auto-populate=true';--%>return checkForm(this.form)">
<input type="submit" value="Annulla" onClick="javascript:this.form.action='Parafarmacie.do?command=ViewVigilanza&orgId=<%=OrgDetails.getOrgId()%>'">
<br>
<dhv:formMessage />


<table cellpadding="4" cellspacing="0" width="100%" class="details">
	
	<tr>
    <th colspan="2">
      <strong><dhv:label name="">Aggiungi Controllo Ufficiale</dhv:label></strong>
    </th>
	</tr>
  
   

<%@ include file="../controlliufficiali/controlli_ufficiali_add.jsp" %>



	<tr>

	

</table>
<br><br>

<%@ include file="../controlliufficiali/controlli_ufficiali_allarmerapido_add.jsp" %>

<%@ include file="../controlliufficiali/controlli_ufficiali_laboratori_haccp.jsp" %>

<br>
<br>
<br>

<%@ include file="../controlliufficiali/controlli_ufficiali_laboratori_haccp_non_in_regione.jsp" %>
	
 
 
<input type="hidden" name="close" value="">
<input type="hidden" name="refresh" value="-1">
<input type="hidden" name="modified" value="<%=  TicketDetails.getModified() %>" />
<input type="hidden" name="currentDate" value="<%=  request.getAttribute("currentDate") %>" />
<input type="hidden" name="statusId" value="<%=  TicketDetails.getStatusId() %>" />
 

  <input type="hidden" name="isAllegato" value="<%=TicketDetails.isListaDistribuzioneAllegata() %>">
<input type="hidden" name="trashedDate" value="<%=  TicketDetails.getTrashedDate() %>" />
<%= addHiddenParams(request, "popup|popupType|actionId") %>


<br>
<input type="submit" value="<dhv:label name="button.inserta">Inserisci </dhv:label>" name="Save" onClick="<%--javascript:this.form.action='AccountVigilanza.do?command=InsertContinua&auto-populate=true';--%>return checkForm(this.form)">
<input type="submit" value="Annulla" onClick="javascript:this.form.action='ParafarmacieVigilanza.do?command=ViewVigilanza&orgId=<%=OrgDetails.getOrgId()%>'">
</form>
</body>

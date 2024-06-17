
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>

<%@ page import = "org.aspcfs.modules.stabilimenti.base.Organization"%>
<%@ page import = "org.aspcfs.utils.web.CustomLookupElement"%>
<%@ page import = "org.aspcfs.utils.web.CustomLookupList"%>
<jsp:useBean id="ControlloUfficiale" class="org.aspcfs.modules.vigilanza.base.Ticket" scope="request"/>
<jsp:useBean id="checklistList" class="java.util.ArrayList" scope="request"/>
<jsp:useBean id="typeList" class="org.aspcfs.utils.web.CustomLookupList" scope="request"/>
<jsp:useBean id="OrgCategoriaRischioList" class="org.aspcfs.utils.web.LookupList" scope="request"/>

<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popCalendar.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popAttenzioneChecklist.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popLookupSelect.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/spanDisplay.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/div.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/checkDate.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/checkNumber.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/checklist_controlli.js"></script>
<%@ include file="../utils23/initPage.jsp" %>

<link rel="stylesheet" type="text/css" href="css/checklist.css" >

<%Organization OrgDetails = (Organization) request.getAttribute("OrgDetails"); %>


<form name="addAccountAudit" method="post" action="CheckListStabilimenti.do?command=Save&auto-populate=true" onSubmit="return checkForm();">

<%-- Trails --%>
	<% if (OrgDetails.isOperatoreIttico()) { %>
		<table class="trails" cellspacing="0">
				<tr>
				<td>
					<a href="Stabilimenti.do"><dhv:label name="stabilimenti.stabilimenti">Accounts</dhv:label></a> > 
					<a href="Stabilimenti.do?command=Search"><dhv:label name="accounts.SearchResults">Search Results</dhv:label></a> >
					<a href="Stabilimenti.do?command=Details&orgId=<%=OrgDetails.getIdMercatoIttico()%>"><dhv:label name="">Mercato Ittico</dhv:label></a> >
					<a href="Stabilimenti.do?command=DetailsOperatoriMercatiIttici&orgId=<%=OrgDetails.getId()%>"><dhv:label name="">Scheda Operatore Mercato Ittico</dhv:label></a> >
				    <a href="Stabilimenti.do?command=ViewVigilanza&orgId=<%=OrgDetails.getOrgId()%>"><dhv:label name="">Controlli Ufficiali</dhv:label></a> >
				    <a href="StabilimentiVigilanza.do?command=TicketDetails&id=<%= request.getAttribute("idC")%>&orgId=<%=OrgDetails.getOrgId()%>"><dhv:label name="">Controllo Ufficiale</dhv:label></a> >
				    <dhv:label name="audit.aggiungiAudit">Aggiungi Check List</dhv:label>
				</td>
			</tr>
		</table>
	<% } else { %>
		<table class="trails" cellspacing="0">
				<tr>
				<td>
					<a href="Stabilimenti.do"><dhv:label name="stabilimenti.stabilimenti">Accounts</dhv:label></a> > 
					<a href="Stabilimenti.do?command=Search"><dhv:label name="accounts.SearchResults">Search Results</dhv:label></a> >
				    <a href="Stabilimenti.do?command=Details&orgId=<%= OrgDetails.getOrgId() %>"><dhv:label name="">Scheda Stabilimento</dhv:label></a> >
				    <a href="Stabilimenti.do?command=ViewVigilanza&orgId=<%=OrgDetails.getOrgId()%>"><dhv:label name="">Controlli Ufficiali</dhv:label></a> >
				    <a href="StabilimentiVigilanza.do?command=TicketDetails&id=<%= request.getAttribute("idC")%>&orgId=<%=OrgDetails.getOrgId()%>"><dhv:label name="">Controllo Ufficiale</dhv:label></a> >
				    <dhv:label name="audit.aggiungiAudit">Aggiungi Check List</dhv:label>
				</td>
			</tr>
		</table>
	<% } %>
<%-- End Trails --%>

<%
	String nomeContainer ="";

	if (OrgDetails.isMacelloUngulati()) 
		nomeContainer = "stabilimenti_macellazioni_ungulati";
	else
		if (OrgDetails.isOperatoreIttico())
			nomeContainer = "operatori_mercati_ittici";
	else
		nomeContainer = "stabilimenti";

%>

<dhv:container name="<%= nomeContainer %>" selected="vigilanza" object="OrgDetails" param='<%= "orgId=" + OrgDetails.getOrgId() %>' appendToUrl='<%= addLinkParams(request, "popup|popupType|actionId") %>'>


<input type="button" value="Annulla" onClick="window.location.href='StabilimentiVigilanza.do?command=TicketDetails&id=<%= request.getAttribute("idC") %>&orgId=<%=OrgDetails.getOrgId()%>';this.form.dosubmit.value='false';" />
<br/><br/>

<%@ include file="../checklist/checklist_add.jsp" %>
<input type="button" value="Annulla" onClick="window.location.href='StabilimentiVigilanza.do?command=TicketDetails&id=<%= request.getAttribute("idC") %>&orgId=<%=OrgDetails.getOrgId()%>';this.form.dosubmit.value='false';" />


</dhv:container>
</form>



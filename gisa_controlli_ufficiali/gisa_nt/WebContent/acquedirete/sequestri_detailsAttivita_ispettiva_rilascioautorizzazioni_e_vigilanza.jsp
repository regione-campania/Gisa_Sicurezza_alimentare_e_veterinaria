<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*,java.text.DateFormat,org.aspcfs.modules.troubletickets.base.*,com.zeroio.iteam.base.*, org.aspcfs.modules.quotes.base.*,org.aspcfs.modules.base.EmailAddress" %>
<jsp:useBean id="TicketDetails" class="org.aspcfs.modules.sequestri.base.Ticket" scope="request"/>
<jsp:useBean id="ticketCategoryList" class="org.aspcfs.modules.troubletickets.base.TicketCategoryList" scope="request"/>
<jsp:useBean id="product" class="org.aspcfs.modules.products.base.ProductCatalog" scope="request"/>
<jsp:useBean id="customerProduct" class="org.aspcfs.modules.products.base.CustomerProduct" scope="request"/>
<jsp:useBean id="quoteList" class="org.aspcfs.modules.quotes.base.QuoteList" scope="request"/>
<jsp:useBean id="OrgDetails" class="org.aspcfs.modules.acquedirete.base.Organization" scope="request"/>
<jsp:useBean id="Provvedimenti" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SequestriAmministrative" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SequestriPenali" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="Sequestri" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SiteIdList" class="org.aspcfs.utils.web.LookupList" scope="request"/>

<jsp:useBean id="SequestroDi" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="TipoSequestro" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SequestroDi_sp" class="org.aspcfs.utils.web.LookupList" scope="request"/>

<jsp:useBean id="causeList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="ticketStateList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="resolutionList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="defectCheck" class="java.lang.String" scope="request"/>
<jsp:useBean id="defect" class="org.aspcfs.modules.troubletickets.base.TicketDefect" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></script>
<script type="text/javascript">

</script>
<%@ include file="../utils23/initPage.jsp" %>
<form name="details" action="AcqueReteSequestri.do?command=ModifyTicket&auto-populate=true" method="post">

<input type ="hidden" name = "idC" value="<%=request.getAttribute("idC") %>">
<input type ="hidden" name = "idNC" value="<%=request.getAttribute("idNC") %>">
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="AcqueRete.do?command=SearchForm">AcqueRete</a> > 
<a href="AcqueRete.do?command=Search"><dhv:label name="accounts.SearchResults">Search Results</dhv:label></a> >
<a href="AcqueRete.do?command=Details&orgId=<%=TicketDetails.getOrgId()%>">Scheda Acque Di Rete</a> >
<a href="AcqueReteVigilanza.do?command=ViewVigilanza&orgId=<%=TicketDetails.getOrgId()%>"><dhv:label name="">Controlli Ufficiali</dhv:label></a> >
<a href="AcqueReteVigilanza.do?command=TicketDetails&id=<%= request.getAttribute("idC")%>&orgId=<%=TicketDetails.getOrgId()%>"><dhv:label name="">Controllo Ufficiale</dhv:label></a> >


<%
if (TicketDetails.getTipologiaNonConformita()==Ticket.TIPO_NON_CONFORMITA_A_CARICO)
{
	%>
<a href="AcqueReteNonConformita.do?command=TicketDetails&id=<%= request.getAttribute("idNC")%>&orgId=<%=TicketDetails.getOrgId()%>"><dhv:label name="">Non Conformit� Rilevata</dhv:label></a> >
	
	<%
}else
{
%>
<a href="AcqueReteAltreNonConformita.do?command=TicketDetails&id=<%= request.getAttribute("idNC")%>&orgId=<%=TicketDetails.getOrgId()%>"><dhv:label name="">Non Conformit� Rilevata</dhv:label></a> >

<%} %>
<%--a href="Accounts.do?command=ViewSequestri&orgId=<%=TicketDetails.getOrgId() %>"><dhv:label name="sequestri">Sequestri</dhv:label></a> --%>
<%
	if (defectCheck != null && !"".equals(defectCheck.trim())) {
%>
  <a href="AcqueReteSequestri.do?command=TicketDetails&Id=<%=TicketDetails.getId()%>&orgId=<%=OrgDetails.getOrgId() %>"><dhv:label name="tickets.defects.viewDefects">View Defects</dhv:label></a> >
  <a href="AcqueReteSequestriDefects.do?command=Details&defectId=<%= defectCheck %>"><dhv:label name="tickets.defects.defectDetails">Defect Details</dhv:label></a> >
<%
  	} else {
  %>
<%
	if ("yes"
				.equals((String) session.getAttribute("searchTickets"))) {
%>
  <a href="AcqueReteSequestri.do?command=SearchTicketsForm"><dhv:label name="tickets.searchForm">Search Form</dhv:label></a> >
  <a href="AcqueReteSequestri.do?command=SearchTickets"><dhv:label name="accounts.SearchResults">Search Results</dhv:label></a> >
<%
  	} else {
  %> 
 <%--  <a href="Accounts.do?command=ViewSequestri&orgId=<%=OrgDetails.getOrgId()%>"><dhv:label name="sequestri.visualizza">Visualizza Sequestri Amministrative</dhv:label></a> > --%>
<%
   	}
   %>
<%
	}
%>


<dhv:label name="sequestri.dettagli">Scheda Sequestro/Blocco </dhv:label>
</td>
</tr>
</table>
<%-- End Trails --%>
<%
	String param1 = "id=" + TicketDetails.getId();
%>
<dhv:container name="acquedirete" selected="vigilanza" object="OrgDetails" param='<%= "orgId=" + TicketDetails.getOrgId() %>' hideContainer='<%= isPopup(request) || (defectCheck != null && !"".equals(defectCheck.trim())) %>'>
	
	<%
		TicketDetails.setPermission();
		String permission_op_edit = TicketDetails.getPermission_ticket()+"-sequestri-edit" ;
		String permission_op_del = TicketDetails.getPermission_ticket()+"-sequestri-delete" ;
		
	%>
	<%@ include file="../controlliufficiali/header_sequestri.jsp"%>
	
	<%@ include file="../controlliufficiali/sequestri_view.jsp"%>
<br />
	<%@ include file="../controlliufficiali/header_sequestri.jsp"%>
	
</dhv:container>
</form>


<%
String msg = (String)request.getAttribute("Messaggio");
if(request.getAttribute("Messaggio")!=null)
{
	%>
	<script>
	
	alert("La pratica non pu� essere chiusa . \n Controllare di aver inserito l'esito.");
	</script>
	<%
}

%>

<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*,java.text.DateFormat,org.aspcfs.modules.troubletickets.base.*,com.zeroio.iteam.base.*,org.aspcfs.modules.quotes.base.*,org.aspcfs.modules.base.EmailAddress" %>
<jsp:useBean id="TicketDetails" class="org.aspcfs.modules.reati.base.Ticket" scope="request"/>
<jsp:useBean id="ticketCategoryList" class="org.aspcfs.modules.troubletickets.base.TicketCategoryList" scope="request"/>
<jsp:useBean id="product" class="org.aspcfs.modules.products.base.ProductCatalog" scope="request"/>
<jsp:useBean id="customerProduct" class="org.aspcfs.modules.products.base.CustomerProduct" scope="request"/>
<jsp:useBean id="quoteList" class="org.aspcfs.modules.quotes.base.QuoteList" scope="request"/>
<jsp:useBean id="OrgDetails" class="org.aspcfs.modules.operatorinonaltrove.base.Organization" scope="request"/>
<jsp:useBean id="Provvedimenti" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="ReatiAmministrative" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="ReatiPenali" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="Sequestri" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SiteIdList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="causeList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="ticketStateList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="resolutionList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="defectCheck" class="java.lang.String" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></script>

<%@ include file="../utils23/initPage.jsp" %>
<form name="details" action="OpnonAltroveReati.do?command=ModifyTicket&auto-populate=true" method="post">

<input type ="hidden" name = "idC" value="<%=request.getAttribute("idC") %>">
<input type ="hidden" name = "idNC" value="<%=request.getAttribute("idNC") %>">
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
    <a  href="OpnonAltrove.do"  onclick="return !this.disabled;">Operatori non Altrove</a> > 
<a href="OpnonAltrove.do?command=Search"  onclick="return !this.disabled;"><dhv:label name="accounts.SearchResults">Search Results</dhv:label></a> >
<a href="OpnonAltrove.do?command=Details&orgId=<%=OrgDetails.getOrgId()%>"  onclick="return !this.disabled;">Scheda</a> ><a href="OpnonAltrove.do?command=ViewVigilanza&orgId=<%=OrgDetails.getOrgId()%>"  onclick="return !this.disabled;"><dhv:label name="">Controlli Ufficiali</dhv:label></a> >
<a href="AOpnonAltroveVigilanza.do?command=TicketDetails&id=<%= request.getAttribute("idC")%>&orgId=<%=TicketDetails.getOrgId()%>"><dhv:label name="">Controllo Ufficiale</dhv:label></a> >
<%
if (TicketDetails.getTipologiaNonConformita()==Ticket.TIPO_NON_CONFORMITA_A_CARICO)
{
	%>
<a href="OpnonAltroveNonConformita.do?command=TicketDetails&idC=<%= request.getAttribute("idC")%>&id=<%= request.getAttribute("idNC")%>&orgId=<%=TicketDetails.getOrgId()%>"><dhv:label name="">Non Conformit� Rilevata</dhv:label></a> >
	
	<%
}else
{
%>
<a href="OpnonAltroveAltreNonConformita.do?command=TicketDetails&idC=<%= request.getAttribute("idC")%>&id=<%= request.getAttribute("idNC")%>&orgId=<%=TicketDetails.getOrgId()%>"><dhv:label name="">Non Conformit� Rilevata</dhv:label></a> >

<%} %>
<%
	if (defectCheck != null && !"".equals(defectCheck.trim())) {
%>
  <a href="OpnonAltroveReati.do?command=TicketDetails&Id=<%=TicketDetails.getId()%>&orgId=<%=OrgDetails.getOrgId() %>"><dhv:label name="tickets.defects.viewDefects">View Defects</dhv:label></a> >
<%
  	} else {
  %>
<%
	if ("yes".equals((String) session.getAttribute("searchTickets"))) {
%>
  <a href="OpnonAltroveReati.do?command=SearchTicketsForm"><dhv:label name="tickets.searchForm">Search Form</dhv:label></a> >
  <a href="OpnonAltrovetReati.do?command=SearchTickets"><dhv:label name="accounts.SearchResults">Search Results</dhv:label></a> >
<%
  	} 
  %> 
 
<%
	}
%>


<dhv:label name="reati.dettagli">Scheda Notizia di reato </dhv:label>
</td>
</tr>
</table>
<%-- End Trails --%>
<%
	String param1 = "id=" + TicketDetails.getId() + "&orgId="+TicketDetails.getOrgId()+"&idNC="+request.getAttribute("idNC");
%>
<dhv:container name="operatorinonaltrove" selected="vigilanza" object="OrgDetails" param='<%= "orgId=" + TicketDetails.getOrgId() %>' hideContainer='<%= isPopup(request) || (defectCheck != null && !"".equals(defectCheck.trim())) %>'>
	<%
	String permission_op_edit = TicketDetails.getPermission_ticket()+"-reati-edit" ;
	String permission_op_del = TicketDetails.getPermission_ticket()+"-reati-delete" ;
	
	%>
	<%@ include file="../controlliufficiali/header_reati.jsp"%>
	
	
		<%@ include file="../controlliufficiali/reati_view.jsp"%>
	
	<br />
	
&nbsp;
<br />
	<%@ include file="../controlliufficiali/header_reati.jsp"%>
	
</dhv:container>
</form>

<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*,java.text.DateFormat,org.aspcfs.modules.troubletickets.base.*,com.zeroio.iteam.base.*, org.aspcfs.modules.quotes.base.*,org.aspcfs.modules.base.EmailAddress" %>
<jsp:useBean id="TicketDetails" class="org.aspcfs.modules.followup.base.Ticket" scope="request"/>
<jsp:useBean id="ticketCategoryList" class="org.aspcfs.modules.troubletickets.base.TicketCategoryList" scope="request"/>
<jsp:useBean id="product" class="org.aspcfs.modules.products.base.ProductCatalog" scope="request"/>
<jsp:useBean id="customerProduct" class="org.aspcfs.modules.products.base.CustomerProduct" scope="request"/>
<jsp:useBean id="quoteList" class="org.aspcfs.modules.quotes.base.QuoteList" scope="request"/>
<jsp:useBean id="OrgDetails" class="org.aspcfs.modules.oia.base.OiaNodo" scope="request"/>
<jsp:useBean id="Provvedimenti" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="FollowupAmministrative" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="FollowupPenali" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="Sequestri" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SiteIdList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="causeList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="ticketStateList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="resolutionList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="defectCheck" class="java.lang.String" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></script>
<%
String idNodo = OrgDetails.getId()+ "" ;
request.setAttribute("idNodo",idNodo);

%>

<%@ include file="../utils23/initPage.jsp" %>
<form name="details" action="OiaFollowup.do?command=ModifyTicket&idNodo=<%=idNodo %>&auto-populate=true" method="post">
<input type ="hidden" name = "idC" value="<%=request.getAttribute("idC") %>">
<input type ="hidden" name = "idNC" value="<%=request.getAttribute("idNC") %>">
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr> 
<td>

<a href="Oia.do?command=Home">Asl</a> > 
<a href="Oia.do?command=Search"><dhv:label name="accounts.SearchResults">Ricerca Dipartimenti/Distretti</dhv:label></a> >
<a href="Oia.do?command=Details&idNodo=<%=idNodo %>&orgId=<%=TicketDetails.getOrgId()%>">Scheda Dipartimento</a> >
<a href="OiaVigilanza.do?command=ViewVigilanza&idNodo=<%=idNodo %>&orgId=<%=TicketDetails.getOrgId()%>"><dhv:label name="">Controlli Ufficiali</dhv:label></a> >
<a href="OiaVigilanza.do?command=TicketDetails&idNodo=<%=idNodo %>&id=<%= request.getAttribute("idC")%>&orgId=<%=TicketDetails.getOrgId()%>"><dhv:label name="">Controllo Ufficiale</dhv:label></a> >
<a href="OiaNonConformita.do?command=TicketDetails&idNodo=<%=idNodo %>&id=<%= request.getAttribute("idNC")%>&orgId=<%=TicketDetails.getOrgId()%>"><dhv:label name="">Non Conformit� Rilevata</dhv:label></a> >
<%-- %>a href="Oia.do?command=ViewFollowup&orgId=<%=TicketDetails.getOrgId() %>"><dhv:label name="followup">FollowUp</dhv:label></a> --%>
<%
	if (defectCheck != null && !"".equals(defectCheck.trim())) {
%>
  <a href="OiaFollowup.do?command=TicketDetails&idNodo=<%=idNodo %>&Id=<%=TicketDetails.getId()%>&orgId=<%=OrgDetails.getOrgId() %>"><dhv:label name="tickets.defects.viewDefects">View Defects</dhv:label></a> >
  <a href="OiaFollowupDefects.do?command=Details&idNodo=<%=idNodo %>&defectId=<%= defectCheck %>"><dhv:label name="tickets.defects.defectDetails">Defect Details</dhv:label></a> >
<%
  	} else {
  %>
<%
	if ("yes"
				.equals((String) session.getAttribute("searchTickets"))) {
%>
  <a href="OiaFollowup.do?command=SearchTicketsForm"><dhv:label name="tickets.searchForm">Search Form</dhv:label></a> >
  <a href="OiaFollowup.do?command=SearchTickets"><dhv:label name="accounts.SearchResults">Ricerca Dipartimenti/Distretti</dhv:label></a> >
<%
  	} else {
  %> 
 <%--  <a href="Oia.do?command=ViewFollowup&orgId=<%=OrgDetails.getOrgId()%>"><dhv:label name="followup.visualizza">Visualizza Notizie di Reato</dhv:label></a> > --%>
<%
   	}
   %>
<%
	}
%>


<dhv:label name="followup.dettagli">Scheda Follow Up</dhv:label>
</td>
</tr>
</table>
<%-- End Trails --%>
<%
	String param1 = "id=" + TicketDetails.getId() + "&idNodo="+idNodo+"&orgId="+TicketDetails.getOrgId()+"&idNC="+request.getAttribute("idNC");
%>
<dhv:container name="asl" selected="vigilanza" object="OrgDetails" param='<%= "orgId=" + TicketDetails.getOrgId() +"&idNodo="+idNodo %>' >

	<%-- include file="ticket_header_include_followup.jsp" --%>
	
		<%
	String permission_op_edit = TicketDetails.getPermission_ticket()+"-followup-edit" ;
	String permission_op_del = TicketDetails.getPermission_ticket()+"-followup-delete" ;
	
	%>
	
	
	<%@ include file="../controlliufficiali/header_followupi.jsp" %>
	
	<%@ include file="../controlliufficiali/followup_view.jsp" %>
		
	<br />
	
&nbsp;
<br />
	
	
	<%@ include file="../controlliufficiali/header_followupi.jsp" %>
</dhv:container>
</form>

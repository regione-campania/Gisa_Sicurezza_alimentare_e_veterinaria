<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*,java.text.DateFormat,org.aspcfs.modules.troubletickets.base.*,com.zeroio.iteam.base.*, org.aspcfs.modules.quotes.base.*,org.aspcfs.modules.base.EmailAddress" %>
<jsp:useBean id="TicketDetails" class="org.aspcfs.modules.sanzioni.base.Ticket" scope="request"/>
<jsp:useBean id="ticketCategoryList" class="org.aspcfs.modules.troubletickets.base.TicketCategoryList" scope="request"/>
<jsp:useBean id="product" class="org.aspcfs.modules.products.base.ProductCatalog" scope="request"/>
<jsp:useBean id="customerProduct" class="org.aspcfs.modules.products.base.CustomerProduct" scope="request"/>
<jsp:useBean id="quoteList" class="org.aspcfs.modules.quotes.base.QuoteList" scope="request"/>
<jsp:useBean id="OrgDetails" class="org.aspcf.modules.controlliufficiali.base.Organization" scope="request"/>
<jsp:useBean id="Provvedimenti" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SanzioniAmministrative" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SanzioniPenali" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="Sequestri" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SiteIdList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="causeList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="ticketStateList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="resolutionList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="defectCheck" class="java.lang.String" scope="request"/>
<jsp:useBean id="defect" class="org.aspcfs.modules.troubletickets.base.TicketDefect" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="CU" class="org.aspcfs.modules.vigilanza.base.Ticket" scope="request"/>

<script language="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></script>

<%@ include file="../utils23/initPage.jsp" %>

<%
%>
<form name="details" action="OperatoriPrivatiSanzioni.do?command=ModifyTicket&auto-populate=true" method="post">
<input type = "hidden" name = "idC" value = "<%=request.getAttribute("idC")%>">


<input type ="hidden" name = "idNC" value="<%=request.getAttribute("idNC") %>">
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="Operatoriprivati.do"><dhv:label name="operatoriprivati.operatoriprivati">OperatoriPrivati</dhv:label></a> > 
<a href="Operatoriprivati.do?command=Search">Risultati ricerca</a> >
<a href="Operatoriprivati.do?command=Details&altId=<%=TicketDetails.getAltId()%>"><dhv:label name="operatoriprivati.details"> Dettaglio Operatore Privato</dhv:label></a> >
<a href="Operatoriprivati.do?command=ViewVigilanza&altId=<%=TicketDetails.getAltId()%>"><dhv:label name="">Controlli Ufficiali</dhv:label></a> >
<a href="OperatoriprivatiVigilanza.do?command=TicketDetails&id=<%= request.getAttribute("idC")%>&altId=<%=TicketDetails.getAltId()%>"><dhv:label name="">Controllo Ufficiale</dhv:label></a> >
 
 
  <%if (TicketDetails.getTipologiaNonConformita()==Ticket.TIPO_NON_CONFORMITA_A_CARICO){ %>
<a href="OperatoriPrivatiNonConformita.do?command=TicketDetails&id=<%= request.getAttribute("idNC")%>&altId=<%=TicketDetails.getAltId()%>"><dhv:label name="">Non Conformit� Rilevata</dhv:label></a> >
 <%}
else
{
%>
<a href="OperatoriprivatiAltreNonConformita.do?command=TicketDetails&id=<%= request.getAttribute("idNC")%>&altId=<%=TicketDetails.getAltId()%>"><dhv:label name="">Non Conformit� Rilevata</dhv:label></a> >

<%} %>
<%--a href="OperatoriPrivati.do?command=ViewSanzioni&altId=<%=TicketDetails.getAltId() %>"><dhv:label name="">Sanzioni Amministrative</dhv:label></a> --%>
<%
	if (defectCheck != null && !"".equals(defectCheck.trim())) {
%>
  <a href="OperatoriPrivatiSanzioni.do?command=TicketDetails&Id=<%=TicketDetails.getId()%>&altId=<%=OrgDetails.getAltId() %>"><dhv:label name="tickets.defects.viewDefects">View Defects</dhv:label></a> >
  <a href="OperatoriPrivatiSanzioniDefects.do?command=Details&defectId=<%= defectCheck %>"><dhv:label name="tickets.defects.defectDetails">Defect Details</dhv:label></a> >
<%
  	} else {
  %>
<%
	if ("yes"
				.equals((String) session.getAttribute("searchTickets"))) {
%>
  <a href="OperatoriPrivatiSanzioni.do?command=SearchTicketsForm"><dhv:label name="tickets.searchForm">Search Form</dhv:label></a> >
  <a href="OperatoriPrivatiSanzioni.do?command=SearchTickets">Risultati ricerca</a> >
<%
  	} else {
  %> 
 <%--  <a href="OperatoriPrivati.do?command=ViewSanzioni&altId=<%=OrgDetails.getAltId()%>"><dhv:label name="sanzioni.visualizza">Visualizza Sanzioni Amministrative</dhv:label></a> > --%>
<%
   	}
   %>
<%
	}
%>


<dhv:label name="sanzioni.dettagli">Scheda Sanzione Amministrativa</dhv:label>
</td>
</tr>
</table>
<%-- End Trails --%>
<%
	String param1 = "id=" + TicketDetails.getId() + "&altId="+TicketDetails.getAltId()+"&idNC="+request.getAttribute("idNC");
%>
<dhv:container name="operatoriprivati" selected="vigilanza" object="OrgDetails" param='<%= "altId=" + TicketDetails.getAltId() %>' hideContainer='<%= isPopup(request) || (defectCheck != null && !"".equals(defectCheck.trim())) %>'>
	
	<%-- @include file="ticket_header_include.jsp" --%>
	
	<%
	String permission_op_edit = TicketDetails.getPermission_ticket()+"-sanzioni-edit" ;
	String permission_op_del = TicketDetails.getPermission_ticket()+"-sanzioni-delete" ;
	
	%>
	<%@ include file="../controlliufficiali/header_sanzioni.jsp"%>
	
	<%@ include file="../controlliufficiali/sanzioni_view.jsp"%>
	
	
	<br />
	
&nbsp;
<br />
		<%@ include file="../controlliufficiali/header_sanzioni.jsp"%>
<%-- </dhv:container> --%>
</dhv:container>
</form>

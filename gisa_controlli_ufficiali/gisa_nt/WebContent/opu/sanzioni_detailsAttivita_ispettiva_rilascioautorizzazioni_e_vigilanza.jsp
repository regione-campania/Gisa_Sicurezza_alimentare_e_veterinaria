<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*,java.text.DateFormat,org.aspcfs.modules.troubletickets.base.*,com.zeroio.iteam.base.*, org.aspcfs.modules.quotes.base.*,org.aspcfs.modules.base.EmailAddress" %>
<jsp:useBean id="TicketDetails" class="org.aspcfs.modules.sanzioni.base.Ticket" scope="request"/>
<jsp:useBean id="OrgDetails" class="org.aspcfs.modules.opu.base.Stabilimento" scope="request"/>
<jsp:useBean id="Provvedimenti" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SanzioniAmministrative" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SanzioniPenali" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="Sequestri" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SiteIdList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="causeList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="CU" class="org.aspcfs.modules.vigilanza.base.Ticket" scope="request"/>
<jsp:useBean id="ticketStateList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="resolutionList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="defectCheck" class="java.lang.String" scope="request"/>
<jsp:useBean id="defect" class="org.aspcfs.modules.troubletickets.base.TicketDefect" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></script>

<%
TicketDetails.setPermission();
%>

<%@ include file="../utils23/initPage.jsp" %>

<%
%>
<form name="details" action="<%=OrgDetails.getAction() %>Sanzioni.do?command=ModifyTicket&auto-populate=true" method="post">
<input type = "hidden" name = "idC" value = "<%=request.getAttribute("idC")%>">


<input type ="hidden" name = "idNC" value="<%=request.getAttribute("idNC") %>">
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
  <dhv:label name=""><a href="<%=OrgDetails.getAction()+".do?command=SearchForm" %>" >Anagrafica Stabilimenti </a>-><a  href="<%=OrgDetails.getAction()+".do?command=Details&stabId="+OrgDetails.getIdStabilimento()%>">Scheda Impresa</a> -><a href="<%=OrgDetails.getAction()+".do?command=ViewVigilanza&stabId="+OrgDetails.getIdStabilimento()%>"> Controlli Ufficiali </a>-> <a href="<%=OrgDetails.getAction()+"Vigilanza.do?command=TicketDetails&id="+CU.getIdControlloUfficiale()+"&idStabilimentoopu="+OrgDetails.getIdStabilimento()%>">Scheda controllo</a>->
   
 <%if (TicketDetails.getTipologiaNonConformita()==Ticket.TIPO_NON_CONFORMITA_A_CARICO){ %>
   <a href="<%=OrgDetails.getAction()+"NonConformita.do?command=TicketDetails&id="+TicketDetails.getId_nonconformita()+"&stabId="+OrgDetails.getIdStabilimento()%>">Scheda non Conformita </a>->
 
 <%}
else
{
%>
  <a href="<%=OrgDetails.getAction()+"AltreNonConformita.do?command=TicketDetails&id="+TicketDetails.getId_nonconformita()+"&stabId="+OrgDetails.getIdStabilimento()%>">Scheda non Conformita NON a carico del soggetto Ispezionato</a>


<%} %>
  
  
   Scheda Sanzione </dhv:label>

 
</td>
</tr>
</table>
<%-- End Trails --%>
<%
	String param1 = "id=" + TicketDetails.getId() + "&orgId="+TicketDetails.getOrgId()+"&idNC="+request.getAttribute("idNC");
String container = OrgDetails.getContainer();
request.setAttribute("Operatore",OrgDetails.getOperatore());
if (User.getUserRecord().getGruppo_ruolo()==Role.GRUPPO_ALTRE_AUTORITA)
	container+="Ext";
%>
<dhv:container name="<%=container %>" selected="vigilanza" object="Operatore" param='<%= "stabId=" + TicketDetails.getIdStabilimento() +"&opId="+OrgDetails.getIdOperatore()+"&id="+CU.getIdMacchinetta()  %>' hideContainer='<%= isPopup(request) || (defectCheck != null && !"".equals(defectCheck.trim())) %>'>
	
	<%-- @include file="ticket_header_include.jsp" --%>
	
	<%
	String permission_op_edit = TicketDetails.getPermission_ticket()+"-sanzioni-edit" ;
	String permission_op_del = TicketDetails.getPermission_ticket()+"-sanzioni-delete" ;
	
	%>
	<%@ include file="../controlliufficiali/opu_header_sanzioni.jsp"%>
	
	<%@ include file="../controlliufficiali/opu_sanzioni_view.jsp"%>
	
	
	<br />
	
&nbsp;
<br />
		<%@ include file="../controlliufficiali/opu_header_sanzioni.jsp"%>
<%-- </dhv:container> --%>
</dhv:container>
</form>


<%@page import="org.aspcfs.modules.opu.base.Operatore"%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*,java.text.DateFormat,org.aspcfs.modules.accounts.base.*,org.aspcfs.modules.vigilanza.base.Ticket,com.zeroio.iteam.base.*" %>

<%@page import="org.aspcfs.modules.suap.base.InformazioniStabilimento"%>
<jsp:useBean id="OrgDetails" class="org.aspcfs.modules.suap.base.Stabilimento" scope="request"/>
<jsp:useBean id="TipoCampione" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="AuditTipo" class="org.aspcfs.utils.web.LookupList" scope="request"/>

<jsp:useBean id="EsitoCampione" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="TipoAudit" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="TipoIspezione" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="TicList" class="org.aspcfs.modules.vigilanza.base.TicketList" scope="request"/>
<jsp:useBean id="AccountTicketInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<%@ include file="../utils23/initPage.jsp" %>
<%-- Initialize the drop-down menus --%> 
<%@ include file="../utils23/initPopupMenu.jsp" %> 
<%@ include file="accounts_vigilanza_list_menu.jsp" %>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/spanDisplay.js"></SCRIPT>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popURL.js"></script>
<%

%>
<dhv:evaluate if="<%= !isPopup(request) %>">
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
  <dhv:label name=""><a href="OpuStab.do?command=SearchForm" >Gestione Anagrafica Impresa </a>-><a  href="<%=OrgDetails.getAction()+".do?command=Details&altId="+OrgDetails.getAltId()%>">Scheda Impresa</a> -><a href="<%=OrgDetails.getAction()+".do?command=ViewVigilanza&altId="+OrgDetails.getAltId()%>"> Controlli Ufficiali </a></dhv:label>

</td>
</tr>
</table>
<%-- End Trails --%>
</dhv:evaluate>
<%
request.setAttribute("Operatore",OrgDetails.getOperatore());
String nomeContainer = OrgDetails.getContainer();
if (User.getUserRecord().getGruppo_ruolo()==Role.GRUPPO_ALTRE_AUTORITA)
	nomeContainer+="Ext";
String param = "altId="+OrgDetails.getAltId()+"&opId=" + OrgDetails.getIdOperatore()+"&id="+request.getAttribute("idMacchinetta") ;
%>
<dhv:container name="<%=nomeContainer %>"  selected="vigilanza" object="Operatore" param="<%=param%>"  hideContainer="false">
 
    <dhv:permission name="accounts-accounts-vigilanza-add"><a href="<%=OrgDetails.getAction() %>Vigilanza.do?command=Add&operatoreunico=1&idMacchinetta=<%=request.getAttribute("idMacchinetta") %>&altId=<%= OrgDetails.getAltId() %><%= addLinkParams(request, "popup|popupType|actionId") %>"><dhv:label name="accounts.richiesta.add">Aggiungi Nuovo Controllo Ufficiale</dhv:label></a></dhv:permission>
    <input type=hidden name="orgId" value="<%= OrgDetails.getAltId() %>">
    <br>
  <dhv:pagedListStatus title='<%= showError(request, "actionError") %>' object="AccountTicketInfo"/>
  

  
 
  
<%@ include file="../controlliufficiali/alt_lista_controlli_ufficiali.jsp" %>
  <dhv:pagedListControl object="AccountTicketInfo"/>

	<br>
</dhv:container>
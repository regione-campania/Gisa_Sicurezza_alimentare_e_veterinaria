
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*,java.text.DateFormat,org.aspcfs.modules.opu.base.*,org.aspcfs.modules.cessazionevariazione.base.Ticket,com.zeroio.iteam.base.*" %>
<jsp:useBean id="OrgDetails" class="org.aspcfs.modules.opu.base.Stabilimento" scope="request"/>
<jsp:useBean id="TipoCampione" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="EsitoCampione" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="TicList" class="org.aspcfs.modules.cessazionevariazione.base.TicketList" scope="request"/>
<jsp:useBean id="RichiesteVoltureOperatore" class="org.aspcfs.modules.cessazionevariazione.base.TicketList" scope="request"/>

<jsp:useBean id="AccountTicketInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<%@ include file="../utils23/initPage.jsp" %>
<%-- Initialize the drop-down menus --%>
<%@ include file="../utils23/initPopupMenu.jsp" %>
<%@ include file="accounts_cessazionevariazione_list_menu.jsp" %>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/spanDisplay.js"></SCRIPT>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popURL.js"></script>

<dhv:evaluate if="<%= !isPopup(request) %>">
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<dhv:label name="">Impresa -> Stabilimento -> Volture</dhv:label>
</td>
</tr>
</table>
<%-- End Trails --%>
</dhv:evaluate>
<%
String nomeContainer = OrgDetails.getContainer();
%>
<dhv:container name="<%=nomeContainer %>" selected="cessazionevariazione" object="OrgDetails" param='<%= "stabId=" + OrgDetails.getIdStabilimento()+"&opId="+OrgDetails.getIdOperatore() %>' appendToUrl='<%= addLinkParams(request, "popup|popupType|actionId") %>'>
    <dhv:permission name="accounts-accounts-cessazionevariazione-add">
    <%if (RichiesteVoltureOperatore.size()==0)
    	{%>
    <a href="<%=OrgDetails.getAction() %>Cessazionevariazione.do?command=AddTicket&tipo_richiesta=autorizzazione_trasporto_animali_vivi&stabId=<%= OrgDetails.getIdStabilimento()+"&opId="+OrgDetails.getIdOperatore() %><%= addLinkParams(request, "popup|popupType|actionId") %>">
    <dhv:label name="accounts.richiesta.add">Aggiungi Nuova Voltura</dhv:label></a>
    <%}
    else
    {
    	%>
    	<font color = "red">Attenzione!Per questa Impresa ci sono volture da Approvare</font>
    	<%
    }
    %>
    </dhv:permission>
    <input type=hidden name="orgId" value="<%= OrgDetails.getOrgId() %>">
    <br>
  <dhv:pagedListStatus title='<%= showError(request, "actionError") %>' object="AccountTicketInfo"/>
  <table cellpadding="4" cellspacing="0" border="0" width="100%" class="pagedList">
        <tr>
		
    <th valign="center" align="left">
      <strong><dhv:label name="">Numero pratica</dhv:label></strong>
    </th>
    <th><b>Operazione</b></th>
     <th><b><dhv:label name="sanzionia.data_richiesta">Data</dhv:label></b></th>
     <th><b><dhv:label name="">Impresa</dhv:label></b></th>
     <th><b><dhv:label name="">Rappresentante Impresa</dhv:label></b></th>
     <th><b><dhv:label name="">Rappresentante Stabilimento</dhv:label></b></th>
     <th><b><dhv:label name="">Inserito Da</dhv:label></b></th>

  </tr>
  <%
    Iterator j = TicList.iterator();
    if ( j.hasNext() ) {
      int rowid = 0;
      int i =0;
      while (j.hasNext()) {
        i++;
        rowid = (rowid != 1?1:2);
        Ticket thisTic = (Ticket)j.next();
  %>
    <tr class="row<%= rowid %>">
   
		<td width="10%" valign="top" nowrap>
				<a href="<%=OrgDetails.getAction() %>Cessazionevariazione.do?command=TicketDetails&id=<%= thisTic.getId() %>&stabId=<%= thisTic.getIdStabilimento()%>&opId=<%=OrgDetails.getIdOperatore()%><%= addLinkParams(request, "popup|popupType|actionId") %>"><%= thisTic.getPaddedId() %></a>
		</td>
		<td>
		     <%= toHtml(thisTic.getOperazione()) %>  
		</td>
		<td>
		<%if(thisTic.getAssignedDate()!=null)
			{%>
		      <zeroio:tz timestamp="<%= thisTic.getAssignedDate() %>" timeZone="<%= User.getTimeZone() %>" dateOnly="true" showTimeZone="false" default="&nbsp;"/>
			<%}
		else
		{%>
		Non Specificata
		<%} %>
		</td>
		<td>
		     <%= toHtml(thisTic.getName()) %>  
		</td>
		<td>
		     <%= toHtml(thisTic.getRappresentateImpresa().getNome()+" "+thisTic.getRappresentateImpresa().getCognome()) %>  
		</td>
		<td>
		     <%= toHtml(thisTic.getRappresentateStabilimento().getNome()+" "+thisTic.getRappresentateStabilimento().getCognome()) %>  
		</td>
		<td>
		     <%= toHtml(thisTic.getInserita_da()) %>  
		</td>
    
		
	</tr>

  <%}%>
  <%} else {%>
  
    <tr class="containerBody">
      <td colspan="7">
        <dhv:label name="accounts.richieste.search.notFound">Nessuna Voltura Trovata.</dhv:label>
      </td>
    </tr>
  <%}%>
  </table>
	<br>
  <dhv:pagedListControl object="AccountTicketInfo"/>
</dhv:container>
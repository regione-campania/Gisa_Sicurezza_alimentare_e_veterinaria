<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*,java.text.DateFormat,org.aspcfs.modules.nonconformita.base.*,com.zeroio.iteam.base.*, org.aspcfs.modules.quotes.base.*,org.aspcfs.modules.base.EmailAddress" %>
<%@ include file="../utils23/initPage.jsp" %>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/nonConformita.js"></SCRIPT>
<jsp:useBean id="TicketDetails" class="org.aspcfs.modules.nonconformita.base.Ticket" scope="request"/>
<jsp:useBean id="SanzioniList" class="org.aspcfs.modules.sanzioni.base.TicketList" scope="request"/>
<jsp:useBean id="SequestriList" class="org.aspcfs.modules.sequestri.base.TicketList" scope="request"/>
<jsp:useBean id="ReatiList" class="org.aspcfs.modules.reati.base.TicketList" scope="request"/>
<jsp:useBean id="FollowupList" class="org.aspcfs.modules.followup.base.TicketList" scope="request"/>
<jsp:useBean id="product" class="org.aspcfs.modules.products.base.ProductCatalog" scope="request"/>
<jsp:useBean id="customerProduct" class="org.aspcfs.modules.products.base.CustomerProduct" scope="request"/>
<jsp:useBean id="quoteList" class="org.aspcfs.modules.quotes.base.QuoteList" scope="request"/>
<jsp:useBean id="TitoloNucleo" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="TitoloNucleoDue" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="TitoloNucleoTre" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="TitoloNucleoQuattro" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="TitoloNucleoCinque" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="TitoloNucleoSei" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="TitoloNucleoSette" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="TitoloNucleoOtto" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="TitoloNucleoNove" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="TitoloNucleoDieci" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="ConseguenzePositivita" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="ResponsabilitaPositivita" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="AlimentiNonTrasformati" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="AlimentiNonTrasformatiValori" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="AlimentiTrasformati" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="AlimentiVegetali" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean  id="OrgDetails" class="org.aspcfs.modules.sintesis.base.SintesisStabilimento" scope="request"/>
<jsp:useBean id="Provvedimenti" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SanzioniAmministrative" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="EsitoCampione" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="DestinatarioCampione" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="TipoCampione" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SanzioniPenali" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="CU" class="org.aspcfs.modules.vigilanza.base.Ticket" scope="request"/>

<jsp:useBean id="Sequestri" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SiteIdList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="causeList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="ticketStateList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="resolutionList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="defectCheck" class="java.lang.String" scope="request"/>
<jsp:useBean id="defect" class="org.aspcfs.modules.troubletickets.base.TicketDefect" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></script>
<body onload="verificaChiusuraNcAziendeAricole(<%=request.getAttribute("Chiudi")%>,<%=request.getAttribute("numSottoAttivita")%>,'<%=request.getAttribute("Messaggio2")%>',<%=TicketDetails.getIdControlloUfficiale()%>,'AziendeAgricoleOpuStabVigilanza',<%=OrgDetails.getIdStabilimento()%>)">

<form name="details" action="<%=OrgDetails.getAction()%>NonConformita.do?command=ModifyTicket&auto-populate=true" method="post">
<%-- Trails --%>
<input type = "hidden" name = "idC" value = "<%=TicketDetails.getIdControlloUfficiale()%>">

<table class="trails" cellspacing="0">
<tr>
<td>
   <dhv:label name=""><a href="<%=OrgDetails.getAction()+".do?command=SearchForm"%>" >Gestione Anagrafica Impresa </a>-><a  href="<%=OrgDetails.getAction()+".do?command=Details&altId="+OrgDetails.getAltId()%>">Scheda Impresa</a> -><a href="<%=OrgDetails.getAction()+".do?command=ViewVigilanza&altId="+OrgDetails.getAltId()%>"> Controlli Ufficiali </a>-> <a href="<%=OrgDetails.getAction()+"Vigilanza.do?command=TicketDetails&id="+CU.getIdControlloUfficiale()+"&altId="+TicketDetails.getAltId()%>">Scheda controllo</a>-> Scheda Non Conformita</dhv:label>


</td>
</tr>
</table>
<%-- End Trails --%>

<%
	String nomeContainer = OrgDetails.getContainer();
TicketDetails.setPermission();
request.setAttribute("Operatore",OrgDetails.getOperatore());
if (User.getUserRecord().getGruppo_ruolo()==Role.GRUPPO_ALTRE_AUTORITA)
	nomeContainer+="Ext";
%>
<dhv:container name="<%=nomeContainer%>" selected="vigilanza" object="Operatore" param='<%="altId=" + OrgDetails.getAltId() +"&opId="+OrgDetails.getIdOperatore() +"&id="+CU.getIdMacchinetta()%>' hideContainer='<%=isPopup(request) || (defectCheck != null && !"".equals(defectCheck.trim()))%>'>
	
	
	<%
				String permission_op_edit = TicketDetails.getPermission_ticket()+"-nonconformita-edit" ;
				String permission_op_del = TicketDetails.getPermission_ticket()+"-nonconformita-delete" ;
			%>
	
	
	<%@ include file="../controlliufficiali/opu_header_non_conformita.jsp" %>
	
	
	
	<input type="hidden" name="id" id="id" value="<%=TicketDetails.getId()%>" />
  <input type="hidden" name="stabId" id="orgId" value="<%=TicketDetails.getIdStabilimento()%>" />
	<table cellpadding="4" cellspacing="0" width="100%" class="details">
		<tr>
			<th colspan="2"><strong><dhv:label
				name="sanzionia.information">Scheda Non Conformita</dhv:label></strong></th>
		</tr>
		<tr class="containerBody">
					<td nowrap class="formLabel"><dhv:label
						name="stabilimenti.site">Site</dhv:label></td>
					<td><%=SiteIdList.getSelectedValue(TicketDetails
										.getSiteId())%>
					<%
						
					%> 
					<input type="hidden"
						name="siteId" value="<%=TicketDetails.getSiteId()%>"></td>
		</tr>
 
<tr class="containerBody">
    <td class="formLabel">
      <dhv:label name="">Identificativo C.U.</dhv:label>
    </td>
   
     
      <td>
      		<%=toHtmlValue(TicketDetails.getIdControlloUfficiale())%>
      </td>
  </tr>
  
  <%
    	if(TicketDetails.getIdentificativo()!=null && !TicketDetails.getIdentificativo().equals("") ){
    %>
  <tr class="containerBody">
    <td class="formLabel">
      <dhv:label name="">Codice delle Non Conformita</dhv:label>
    </td>
      <td>
      
      		<%=toHtmlValue(TicketDetails.getIdentificativo())%>
      </td>
   
  </tr>	

<%
		}
	%>


 <tr class="containerBody" style="display: none">
    <td nowrap class="formLabel">
      <dhv:label name="campioni.data_richiesta">Data Rilevazione Non Conformit�</dhv:label>
    </td>
    <td>
      <zeroio:tz
				timestamp="<%=TicketDetails.getAssignedDate()%>" dateOnly="true"
				timeZone="<%=TicketDetails.getAssignedDateTimeZone()%>"
				showTimeZone="false" default="&nbsp;" /> 
     
    </td>
  </tr>
  <dhv:evaluate if="<%=hasText(TicketDetails.getProblem())%>">
  <tr class="containerBody">
    <td valign="top" class="formLabel">
      <dhv:label name="sanzioni.note">Note</dhv:label>
    </td>
    <td>
      <%=toString(TicketDetails.getProblem())%>
    </td>
	</tr>
</dhv:evaluate>
<dhv:evaluate if="<%=hasText(TicketDetails.getCause())%>">
  <tr class="containerBody">
    <td valign="top" class="formLabel">
      <dhv:label name="sanzionia.importo">Codice Accettazione</dhv:label>
    </td>
    <td><%=toHtmlValue(TicketDetails.getCause())%>
    </td>
  </tr>
  </dhv:evaluate>
 
  <%@ include file="../nonconformita/alt_nonconformita_view.jsp" %>
  
 
   </table>
   <br>
<br />


<br><br><br>

 
  <br><br>
	
<%@ include file="../controlliufficiali/opu_header_non_conformita.jsp"  %>
	
</dhv:container>
</form>

</body>
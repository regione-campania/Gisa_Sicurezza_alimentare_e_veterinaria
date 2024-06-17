<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*,java.text.DateFormat,org.aspcfs.modules.campioni.base.*,com.zeroio.iteam.base.*, org.aspcfs.modules.quotes.base.*,org.aspcfs.modules.base.EmailAddress" %>
<jsp:useBean id="TicketDetails" class="org.aspcfs.modules.campioni.base.Ticket" scope="request"/>
<jsp:useBean id="product" class="org.aspcfs.modules.products.base.ProductCatalog" scope="request"/>
<jsp:useBean id="customerProduct" class="org.aspcfs.modules.products.base.CustomerProduct" scope="request"/>
<jsp:useBean id="CU" class="org.aspcfs.modules.vigilanza.base.Ticket" scope="request"/>

<jsp:useBean id="ConseguenzePositivita" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="ResponsabilitaPositivita" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean  id="OrgDetails" class="org.aspcfs.modules.sintesis.base.SintesisStabilimento" scope="request"/>
<jsp:useBean id="Provvedimenti" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SanzioniAmministrative" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="EsitoCampione" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="DestinatarioCampione" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="TipoCampione" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SanzioniPenali" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="Sequestri" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SiteIdList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="id" class="java.lang.String" scope="request"/>
<jsp:useBean id="ck_mot" class="java.lang.String" scope="request"/>
<jsp:useBean id="ck_nv" class="java.lang.String" scope="request"/>
<jsp:useBean id="ck_dp" class="java.lang.String" scope="request"/>
<jsp:useBean id="ck_mat" class="java.lang.String" scope="request"/>
<jsp:useBean id="ck_an" class="java.lang.String" scope="request"/>
<jsp:useBean id="input" class="java.lang.String" scope="request"/>
<jsp:useBean id="elencoMotivazioni" class="java.util.ArrayList" scope="session"/>

<script language="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></script>


<script type="text/javascript">

function openPopupModulesPdf(orgId, ticketId){
	var res;
	var result;
		window.open('ManagePdfModules.do?command=PrintSelectedModules&orgId='+orgId+'&ticketId='+ticketId,'popupSelect',
		'height=300px,width=580px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=no,resizable=no ,modal=yes');
		}
/*

function openUltimiDocumenti(orgId, tipo, ticketId, idCU, tipoSin){
	var res;
	var result;
	
	window.open('GestioneDocumenti.do?command=GestioneDownloadUltimoPdf&orgId='+orgId+'&tipo='+tipo+'&ticketId='+ticketId+'&idCU='+idCU+'&tipoSin='+tipoSin,'open_window', 'height=295px,width=595px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=yes ,modal=yes');} */
</script>

<style type="text/css">
#dhtmltooltip{
	position: absolute;
	left: -300px;
	width: 150px;
	border: 1px solid black;
	padding: 2px;
	background-color: lightyellow;
	visibility: hidden;
	z-index: 100;
	/*Remove below line to remove shadow. Below line should always appear last within this CSS*/
	filter: progid:DXImageTransform.Microsoft.Shadow(color=gray,direction=135);
}
#dhtmlpointer{
	position:absolute;
	left: -300px;
	z-index: 101;
	visibility: hidden;
}
</style>

<script type="text/javascript">
	
</script>

<%@ include file="../utils23/initPage.jsp" %>


<form id="details" name="details" action="<%=OrgDetails.getAction() %>Campioni.do?command=ModifyTicket&auto-populate=true" method="post" >
<input type = "hidden" name ="idC" value = "<%=TicketDetails.getIdControlloUfficiale() %>">
<!-- <input type="hidden" name = "idControlloUfficiale" value ="<%= request.getAttribute("idC")%>">-->
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<td>


  <dhv:label name=""><a href="<%=OrgDetails.getAction()+".do?command=SearchForm" %>" >Gestione Anagrafica Impresa </a>-><a  href="<%=OrgDetails.getAction()+".do?command=Details&altId="+OrgDetails.getAltId()%>">Scheda Impresa</a> -><a href="<%=OrgDetails.getAction()+".do?command=ViewVigilanza&altId="+OrgDetails.getAltId()%>"> Controlli Ufficiali </a>-> <a href="<%=OrgDetails.getAction()+"Vigilanza.do?command=TicketDetails&id="+CU.getIdControlloUfficiale()+"&altId="+OrgDetails.getAltId()%>">Scheda controllo</a>-> Scheda Campione</dhv:label>

</td>
</tr>
</table>
<%-- End Trails --%>
<%
	String param1 = "id=" + TicketDetails.getId();
	String idCU =  TicketDetails.getIdControlloUfficiale();
%>
<%
String nomeContainer = OrgDetails.getContainer();
request.setAttribute("Operatore",OrgDetails.getOperatore());

%>

<!-- INIZIO PEZZO PER AMR -->
<dhv:permission name="global-search-amr-add">
<% if (CU.isAMR()){%>
	<center>
	<div id="divAMR" style="display:none; border: 1px solid black; width:70%; background:#e0e0e0">
	<font size="5px">
	<b>Attenzione:</b>
	<br/>
	<i>Il campione inserito ha le caratteristiche dell'invio AMR ma non sono stati inseriti i necessari dati aggiuntivi.<br/>Se si desidera procedere alla stampa del verbale accompagnatorio e all'invio in cooperazione applicativa a SINVSA, � possibile</i> 
	<mark><a href="#"  style="font-size:20px" onClick="openPopupBox('PrintReportVigilanza.do?command=GestioneAMR&idControllo=<%=CU.getId()%>'); return false;">inserire adesso le informazioni necessarie</a></mark> 
	<i>secondo le</i> 
	<mark><a href="#" style="font-size:20px" onClick="openPopupBox('man/#amr'); return false;">modalit� previste dal manuale utente</a></mark>. 
	<i>Nel caso si decidesse di proseguire senza inserimento dati AMR sar� sempre possibile inserire i dati in un secondo momento ricercando il CU dal menu "Ricerca CU AMR".</i>
	<br/>
	<mark><a href="#" style="font-size:20px" onClick="document.getElementById('divAMR').style.display='none'">Prosegui senza inserimento dati AMR</a></mark>
	<br/>
	</div>
	</center>
	<%}	%>

<script>
function openPopupBox(url){
	var res;
	var result;
		window.open(url,'popupSelect',
		'height=600px,width=580px,directories=no,status=no,continued from previous linemenubar=no,resizable=no ,modal=yes').focus();
		
}

 if (window.location.href.indexOf("&commandOld=StabilimentoSintesisActionCampioni.do;Insert")>0){
 	document.getElementById("divAMR").style.display="block";
	}
</script>
</dhv:permission>
<!-- FINE PEZZO PER AMR -->

<dhv:container name="<%=nomeContainer %>" selected="vigilanza" object="Operatore" param='<%= "altId=" + TicketDetails.getAltId()+"&opId="+OrgDetails.getIdOperatore()+"&id="+CU.getIdMacchinetta() %>' hideContainer='<%= isPopup(request)  %>'>

<% if ("true".equalsIgnoreCase(org.aspcfs.modules.util.imports.ApplicationProperties.getProperty("NUOVA_GESTIONE_CAMPIONI_MACELLI"))){ %>
<%@ include file="/campioni/campioni_macello_informazioni_con_preaccettazione.jsp" %>
<% } %>

    
 	<%String numero_include="1";
 	  String perm_op_delete = TicketDetails.getPermission_ticket()+"-campioni-delete";
 	  String perm_op_edit = TicketDetails.getPermission_ticket()+"-campioni-edit";
 	 %>
	<%@ include file="/campioni/alt_header_campioni.jsp" %>
	<%@ include file="/campioni/stampa_modello_sin_generale.jsp" %>
	<br>
	<br>
	<%@ include file="/campioni/stampa_verbale_pnaa.jsp" %>
	<table cellpadding="4" cellspacing="0" width="100%" class="details">
		<tr>
			<th colspan="2"><strong><dhv:label
				name="sanzionia.information">Scheda Campione</dhv:label></strong></th>
		</tr>
	
		  <%@ include file="/campioni/opu_campioni_view.jsp" %>
				
   </table>
     
   
   </br>
   
   
	  <%@ include file="/campioni/alt_campioni_esito_view.jsp" %>
 
    </table>
&nbsp;
<br />
	<% numero_include="2";%>
	<%@ include file="/campioni/alt_header_campioni.jsp" %>
</dhv:container>
</form>
<%
String msg = (String)request.getAttribute("Messaggio");
if(request.getAttribute("Messaggio")!=null)
{
	%>
	<script>
	
	alert("La pratica non pu� essere chiusa . \n Controllare di aver inserito l'esito o di aver compilato il modello PNAA se richiesto.");
	</script>
	<%
}

%>
<%
String msg2 = (String)request.getAttribute("Messaggio2");
if(request.getAttribute("Messaggio2")!=null)
{
	%>
	<script>


	var answer = confirm("Tutte le Attivita Collegate al controllo sono state chiuse . \n Desideri Chiudere il Controllo Ufficiale ?\n Attenzione! La pratica verr� chiusa e non sar� pi� possibile fare modifiche \n sulla scheda se non con il permesso del supervisore o dell amministratore")

	if (answer){
		
		doSubmit(<%=TicketDetails.getId() %>);
	}


	function doSubmit(idTicket){

		document.details.action="<%=OrgDetails.getAction() %>Campioni.do?command=Chiudi&stabId=<%=OrgDetails.getOrgId()%>&id="+idTicket+"&chiudiCu=true'"
		document.details.submit();

		}
	
	</script>
	<%
}
%>



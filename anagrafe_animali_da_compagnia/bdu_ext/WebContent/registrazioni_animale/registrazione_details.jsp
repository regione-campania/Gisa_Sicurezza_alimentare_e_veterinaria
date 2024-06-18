<%@page import="java.net.InetAddress"%>
<%@page import="org.aspcfs.modules.ws.WsPost"%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*,org.aspcfs.modules.opu.base.*, org.aspcfs.modules.base.*, org.aspcfs.modules.registrazioniAnimali.base.*" %>

<link rel="stylesheet" href="https://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />

<script src="https://code.jquery.com/jquery-1.9.1.js"></script>
<script src="https://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>

<jsp:useBean id="registrazioniList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="AslList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="animaleDettaglio" class="org.aspcfs.modules.anagrafe_animali.base.Animale" scope="request"/>
<jsp:useBean id="EventiListInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<jsp:useBean id="evento" class="org.aspcfs.modules.registrazioniAnimali.base.Evento" scope="request"/>
<jsp:useBean id="statoList" class="org.aspcfs.utils.web.LookupList"	scope="request" />

<%
	WsPost ws = request.getAttribute("ws")!=null ? ((WsPost)request.getAttribute("ws")) : (null);
	InetAddress net = InetAddress.getByName(ApplicationProperties.getProperty("SINAAF_MONITORAGGIO_HOST"));
	String monitoraggioPort = ApplicationProperties.getProperty("SINAAF_MONITORAGGIO_PORT");
	String monitoraggioApp = ApplicationProperties.getProperty("SINAAF_MONITORAGGIO_APP");

%>


	
<%@ include file="../initPage.jsp" %>
<%@ include file="../initPopupMenu.jsp" %>

<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/spanDisplay.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popLookupSelect.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popURL.js"></SCRIPT>
<!--script type="text/javascript">

function openRichiestaPDF(idAnimale, idSpecie, idEvento, idLinea, idTipo){
	var res;
	var result;
		window.open('GestioneDocumenti.do?command=ListaDocumentiByTipo&tipo='+idTipo+'&IdAnimale='+idAnimale+'&IdSpecie='+idSpecie+'&idEvento='+idEvento+'&idLinea='+idLinea,'popupSelect',
		'height=595px,width=842px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=yes ,modal=yes');
}
</script-->

<script language="JavaScript" TYPE="text/javascript"
	SRC="gestione_documenti/generazioneDocumentale.js"></script>

<% String param1 = "idAnimale=" + animaleDettaglio.getIdAnimale() +"&idSpecie=" + animaleDettaglio.getIdSpecie();
   %>
<dhv:evaluate if="<%= !isPopup(request) %>">
<%-- Trails --%>
<script type="text/javascript">
function sendIdEventoToVam(){ //Funzione per gestione con postmessage VAM BDU
	parent.postMessage("<%=evento.getIdEvento()%>","*");
	
//	var win = document.getElementById("iframe").contentWindow
//var win = parent.document;
//	win.contentWindow.postMessage('www', 'http://localhost:8080/vam/');
	//parent.document.getElementById('te').value = 'valore da iframe';
	//alert(window.top.document.getElementById("te").value);
}



<%if (session.getAttribute("caller") != null && !("").equals(session.getAttribute("caller")) && (ApplicationProperties.getProperty("VAM_ID")).equals(session.getAttribute("caller"))){%>
$('a').removeAttr('href');
$('table').on( "click", "a", function(e) {
	//alert('aaa');
	
    e.preventDefault();
    //do other stuff when a click happens
});
var idEvento = <%=evento.getIdEvento()%>;
$.getScript("javascript/comunicazioniToVamChangeDomain.js")
<%}%>
</script>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="AnimaleAction.do?command=Details&animaleId=<%=evento.getIdAnimale() %>&idSpecie=<%=evento.getSpecieAnimaleId() %>"><dhv:label name="">Dettaglio animale</dhv:label></a> > 
<a href="AnimaleAction.do?command=ListaRegistrazioni&animaleId=<%=evento.getIdAnimale() %>&idSpecie=<%=evento.getSpecieAnimaleId() %>"><dhv:label name="">Lista registrazioni</dhv:label></a> >
<dhv:label name="">Dettaglio registrazione</dhv:label>
</td>
</tr>
</table>
<%-- End Trails --%>
</dhv:evaluate>

<%
if(request.getAttribute("Error")!=null)
{
%>
<%=showError(request, "Error")%>
<%
}
if(request.getAttribute("messaggio")!=null)
{
%>
<%=showMessage(request, "messaggio")%>
<%
}
%>

<table cellpadding="4" cellspacing="0" border="0" width="100%" class="pagedList">
<th colspan="2">Dettagli generali registrazione</th>
 <%
	//if(ws!=null && ws.propagazioneSinaaf)
	if( User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_HD1")) ||  User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_HD2"))){
		
		if(ws!=null)
	  		{	
  	%>
    <tr>
     <td>
       <strong>Stato SINAAF</strong>
      </td>
      <td nowrap>
        	

  		<img src="images/<%=ws.getColoreSincronizzazione()%>.gif"> <%=ws.getLabelSincronizzazione()%>
		<% //if (!ws.sincronizzato)
  		if(false)
  		{%>
  		   <p><B><%=ApplicationProperties.getProperty("SINAAF_MSG_PROBLEM") %></B></p>
  		   <%} %>
		<%	/*if( User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_HD1")) ||
        	User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_HD2"))){*/
			if(true)
			{ %>
		<input type="button" value="Sincronizza" onclick="Sync(<%=evento.getIdEvento()%>,'evento');" />
		<input type="button" value="Vedi body put/post" onclick="getBody(<%=evento.getIdEvento()%>,'evento')" />
		<input type="button" value="Vedi in sinaaf" onclick="VediInSinaaf(<%=evento.getIdEvento()%>,'evento')" />
	 	<input type="button" value="Monitoraggio"   target="_new" onclick="monitoraggio(<%=evento.getIdEvento()%>,'evento');" />
	 <% 	}
     if(ws.idSinaaf!=null && !ws.idSinaaf.equals(""))
     {
%>
      	<br/>ID: <%=ws.idSinaaf %>  		
     <%
  		}
     %>
     
     <% 	
     if(ws.idSinaafSecondario!=null && !ws.idSinaafSecondario.equals(""))
     {
%>
      	<br/>ID SECONDARIO: <%=ws.idSinaafSecondario %>  		
     <%
  		}
     %>
     </td>
     </tr>
     
     <%
  		}
	  		}
  	%>
     <tr>
    
      <td>
       <strong>Identificativo</strong>
      </td>
      <td nowrap>
        <%= evento.getIdEvento() %> 
         <dhv:evaluate if="<%= evento.getDataCancellazione()!= null && !evento.getDataCancellazione().equals("") && !evento.getDataCancellazione().equals("null")%>">
        <strong><font color="red"> CANCELLATA</font></strong>
        </dhv:evaluate>
      </td></tr>
     <tr> <td>
      <b><dhv:label name="">Categoria</dhv:label></b>
      </td>
      <td  nowrap>
	   	<%= toHtml(registrazioniList.getSelectedValue(evento.getIdTipologiaEvento())) %>
	   	<%if (evento.isFlagRegistrazioneForzata()){ %> <div style="color:red;">(Inserimento a posteriori) </div> <%} %>
	  </td></tr>
	 <tr> <td><b><dhv:label name="">Data inserimento in BDU</dhv:label></b></td>
	  <td >
      	<%=toDateasString(evento.getEntered()) %>&nbsp;
      </td></tr>
    <tr>  <td><b><dhv:label name="">Data della registrazione</dhv:label></b></td>
      	  <td >
      	<%=toDateasString(evento.getDataRegistrazione()) %>&nbsp;
      </td></tr>
	<tr>  <td width="20%">
        <b><dhv:label name="">Animale</dhv:label></b>
      </td>
       <td>  <a href="AnimaleAction.do?command=Details&animaleId=<%=evento.getIdAnimale() %>&idSpecie=<%=evento.getSpecieAnimaleId() %>"> <%= evento.getMicrochip() %></a>
  
	   </td></tr>
	<tr><td><b><dhv:label name="">Asl di Riferimento</dhv:label></b></td>
  	<td>
  	<%=AslList.getSelectedValue(evento.getIdAslRiferimento()) %>
  	</td>
     </tr>
    
  </table>
  </br>

 <dhv:evaluate if="<%=User.getRoleId()==new Integer(ApplicationProperties.getProperty("ID_RUOLO_HD1")) || User.getRoleId()==new Integer(ApplicationProperties.getProperty("ID_RUOLO_HD2"))%>">
  <table cellpadding="4" cellspacing="0" border="0" width="100%" class="pagedList">
   <th colspan="2">Stato animale precedente alla registrazione </th>
        <tr class="">
  <dhv:evaluate if="<%= evento.getIdStatoOriginale()>0%>">
  <td>
      	<%=toHtml(statoList.getSelectedValue(evento.getIdStatoOriginale()))%> </td></tr>
  </dhv:evaluate>
   </table>
   
  <dhv:evaluate if="<%= evento.getDataCancellazione()!= null && !evento.getDataCancellazione().equals("") && !evento.getDataCancellazione().equals("null")%>">
 </br> <table  cellpadding="4" cellspacing="0" border="0" width="100%" class="pagedList">
<th colspan="2"  style="background-color:red;color:white;">Dettagli della cancellazione </th>
    <tr class="">
       	 <tr class=""><td width="20%"><b>Cancellato</b></td><td nowrap> <font color="red"><b>  <dhv:username id="<%=evento.getIdUtenteCancellazione() %>"></dhv:username> il <%=toDateasString(evento.getDataCancellazione()) %></b></font> </td></tr>
      	  <tr class=""><td width="20%"><b> Note cancellazione</b></td><td nowrap><font color="red"><b> <%=evento.getNoteCancellazione() %></b></font> 
      </td></tr>
  </table>
  
  </dhv:evaluate></dhv:evaluate>
  
  
  
  
	<br>
	<%String file_to_include = "evento_"+evento.getIdTipologiaEvento()+".jsp"; %>

	<jsp:include page='<%= file_to_include %>'  flush="true"/>
	
	
	</br>
	  
  		<table cellpadding="4" cellspacing="0" border="0" width="100%"
			class="details">
			<tr>
				<th colspan="2"><strong>NOTE</strong></th>
			</tr>
			<tr class="containerBody">
				<td valign="top" class="formLabel"><dhv:label name="">Note</dhv:label>
				</td>
				<td><%=toString(evento.getNote())%>
				</td>
			</tr>
		</table>
		
		</br>
	
	</br>
	<table cellpadding="4" cellspacing="0" border="0" width="100%" class="pagedList">
<th colspan="2">Altre informazioni </th>
    <tr class="">
      <td>
       <strong>Inserito</strong>
      </td>
      <td nowrap>
        <%=evento.getInformazioniInserimentoRecord() %>&nbsp;
      </td></tr>

          <tr class="">
      <td>
       <strong>Modificato</strong>
      </td>
      <td nowrap>
        <dhv:username id="<%= evento.getModifiedby() %>" /> il 	<%=(evento.getModified() != null)? toDateasString(evento.getModified()) : "" %>&nbsp;
      </td></tr>

  </table>
  
  </br>
  
  	<dhv:permission name="anagrafe_canina-note_internal_use_only-add">
		<table cellpadding="4" cellspacing="0" border="0" width="100%"
			class="details">
			<tr>
				<th colspan="2"><strong>NOTE USO INTERNO</strong></th>
			</tr>
			<tr class="containerBody">
				<td valign="top" class="formLabel"><dhv:label name="">Note</dhv:label>
				</td>
				<td><textarea name="noteInternalUseOnly" rows="3" cols="50" disabled="disabled"><%=toString(evento.getNoteInternalUseOnly())%></textarea>
				</td>
			</tr>
		</table>
		<script>
		
		
		function Sync(getid,entita)
		{
			console.log(<%=ApplicationProperties.getProperty("BDU2SINAC_ATTIVO")%>);
			
			<%
			if(ApplicationProperties.getProperty("BDU2SINAC_ATTIVO").equals("true"))
			{
			%>
			console.log(entita);

			if(entita == 'detentore')
				{
				entita = "proprietario";
				}
			
			popURL("SinaafAction.do?command=Redirect2Bdu2Sinac&idEntita="+getid+"&entita="+entita+"&tipo=sincronizza",'Sinaaf','650','500','yes','yes');
			//loadModalWindow();
			//setTimeout(function() {
			//	  window.location.reload()
			//	}, 10000);
			
			<%
			}else
			{
			%>
			

			location.href='SinaafAction.do?command=Invia&idSinaaf=<%=ws.idSinaaf%>&entita=evento&id=<%=evento.getIdEvento()%>&urlToRedirect=RegistrazioniAnimale.do?command=Details_____id=<%=evento.getIdEvento()%>_____tipologiaEvento=<%=evento.getIdTipologiaEvento()%>'

			
			<%
			}
			%>
			
			}

		function getBody(getid,entita)
		{
			
			
			
			<%
			if(ApplicationProperties.getProperty("BDU2SINAC_ATTIVO").equals("true"))
			{
			%>
			console.log(entita);

			if(entita == 'detentore')
				{
				  entita = "proprietario";
				}
			
			popURL("SinaafAction.do?command=Redirect2Bdu2Sinac&idEntita="+getid+"&entita="+entita+"&tipo=body",'Sinaaf','650','500','yes','yes');
				
			<%
			}else
			{
			%>
			

			popURL('SinaafAction.do?command=VediRequest&idSinaaf=<%=ws.idSinaaf%>&entita=evento&id=<%=evento.getIdEvento()%>&urlToRedirect=RegistrazioniAnimale.do?command=Details_____id=<%=evento.getIdEvento()%>_____tipologiaEvento=<%=evento.getIdTipologiaEvento()%>','Sinaaf','650','500','yes','yes')			

			<%
			}
			%>
		}
			
			function VediInSinaaf(getid,entita)
			{
				
				
				
				<%
				if(ApplicationProperties.getProperty("BDU2SINAC_ATTIVO").equals("true"))
				{
				%>
				console.log(entita);

				if(entita == 'detentore')
					{
					  entita = "proprietario";
					}
				
				popURL("SinaafAction.do?command=Redirect2Bdu2Sinac&idEntita="+getid+"&entita="+entita+"&tipo=vediInSinaaf",'Sinaaf','650','500','yes','yes');
					
				<%
				}else
				{
				%>
				

				if(<%=ws.idSinaaf==null || ws.idSinaaf.equals("") || ws.idSinaaf.equals("null")%>){alert('Registrazione non presente in sinaaf');} else { popURL('SinaafAction.do?command=Vedi&idSinaaf=<%=ws.idSinaaf%>&entita=evento&id=<%=evento.getIdEvento()%>','Sinaaf','650','500','yes','yes');} 			
				
			
			
			<%
			}
			%>
			
		}
			
			function monitoraggio(getid,entita)
			{
				
				
				
				<%
				if(ApplicationProperties.getProperty("BDU2SINAC_ATTIVO").equals("true"))
				{
				%>
				console.log(entita);

				if(entita == 'detentore')
					{
					  entita = "proprietario";
					}
				
				popURL("SinaafAction.do?command=Redirect2Bdu2Sinac&idEntita="+getid+"&entita="+entita+"&tipo=monitoraggio",'Sinaaf','650','500','yes','yes');
					
				<%
				}else
				{
				%>
			
			<%
			}
			%>

			
		}


		</script>
	</dhv:permission>

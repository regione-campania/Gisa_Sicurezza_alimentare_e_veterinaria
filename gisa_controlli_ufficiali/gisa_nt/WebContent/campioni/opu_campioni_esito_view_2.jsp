 <!--  CAMPIONI_ESITO_VIEW_2 : MODIFICABILE SOLO LA PARTE DELL'ESITO -->
 
 
 
 
 <%@page import="org.aspcfs.modules.campioni.base.Analita"%>
 
 <!-- RELATIVO AL NUOVO CALENDARIO CON MESE E ANNO FACILMENTE MODIFICABILI -->
<SCRIPT LANGUAGE="JavaScript" SRC="javascript/CalendarPopup2.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="javascript/common.js"></SCRIPT>
<!-- 
<SCRIPT LANGUAGE="JavaScript">document.write(getCalendarStyles());</SCRIPT>
<SCRIPT LANGUAGE="JavaScript" ID="js19">
	var cal19 = new CalendarPopup();
	cal19.showYearNavigation();
	cal19.showYearNavigationInput();
	cal19.showNavigationDropdowns();
</SCRIPT>
 -->

<script>
function checkFormEsiti(){
	var checkEsiti =true;
	var msg = "Impossibile salvare gli esiti campione. Controllare i seguenti campi: \n";
	var i = 1;
	
	
	var codice = document.getElementById('cause');
	var dataAccettazione = document.getElementById('dataAccettazione');
	var descrizione = document.getElementById('esito_note_esame');
	var dataRisultato = document.getElementById('dataRisultato');
	
	if (codice!=null && codice.value==''){
		checkEsiti = false;
		msg += "Codice accettazione \n";
	}
	if (dataAccettazione!=null && dataAccettazione.value==''){
		checkEsiti = false;
		msg += "Data accettazione \n";
	}
	if (descrizione!=null && descrizione.value==''){
		checkEsiti = false;
		msg += "Descrizione risultato esame \n";
}
	if (dataRisultato!=null && dataRisultato.value==''){
		checkEsiti = false;
		msg += "Data risultato \n";
}
		
	if (checkEsiti!=true)
		alert(msg);
	
	return checkEsiti;
}
</script>

  <% int colspan = 10 ;
	 if (TicketDetails.getPdp()!=null && TicketDetails.getPdp().getId()>0)
	 {
		colspan = 11 ;
	 }
	 %>
	 
	  <table cellpadding="4" cellspacing="0" width="100%" class="details">
  	<tr>
    <th colspan="2">
      <strong><dhv:label name="">Esito Laboratorio</dhv:label></strong>
    </th>
	</tr>
	 <tr class="containerBody">
    <td valign="top" class="formLabel">
      <dhv:label name="sanzionia.importo">Codice Accettazione</dhv:label>
    </td>
    <%--<td><%= toHtmlValue(TicketDetails.getCause()) %></td>--%>
    <td>
      <input type="text" name="cause" id="cause" value="<%= toHtmlValue(TicketDetails.getCause()) %>" size="20" maxlength="256" />
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
      <dhv:label name="">Data Accettazione</dhv:label>
    </td>
    <td>   
    <input type="text" id="dataAccettazione" name="dataAccettazione" size="10" class="date_picker"
		value="<%= (TicketDetails.getDataAccettazione()==null)?(""):(getLongDate(TicketDetails.getDataAccettazione()))%>"/>
    </td>
  </tr>
  
 <% if ((TicketDetails.getDestinatarioCampione()==1 || TicketDetails.getDestinatarioCampione() == 2)
		&& TicketDetails.isHasPreaccettazione()) {%>
  <tr class="containerBody">
    <td valign="top" class="formLabel">
      <dhv:label name="sanzionia.azioni">Descrizione Risultato Esame</dhv:label>
    </td>
    <td>
      <table border="0" cellspacing="0" cellpadding="0" width="100%">
        <tr>
          <td>
            <textarea readonly style="background-color:grey;" name="esito_note_esame" cols="55" rows="8" onkeyup="this.value = this.value.replace(/[`~!@#$%^&*|+\-=?���<>\{\}\[\]\\\/]/gi, '').replace(/\r?\n/g, '');" onpaste="this.value = this.value.replace(/[`~!@#$%^&*|+\-=?���<>\{\}\[\]\\\/]/gi, '').replace(/\r?\n/g, '');"><%=TicketDetails.getEsitoNoteEsame() %></textarea>
          </td>
          <td valign="top">
            <%= showAttribute(request, "problemError") %>
          </td>
        </tr>
        </table>
        </td>
        </tr>
       <% } else { %>
       		<tr class="containerBody">
    <td valign="top" class="formLabel">
      <dhv:label name="sanzionia.azioni">Descrizione Risultato Esame</dhv:label>
    </td>
    <td>
      <table border="0" cellspacing="0" cellpadding="0" width="100%">
        <tr>
          <td>
            <textarea name="esito_note_esame" cols="55" rows="8" onkeyup="this.value = this.value.replace(/[`~!@#$%^&*|+\-=?���<>\{\}\[\]\\\/]/gi, '').replace(/\r?\n/g, '');" onpaste="this.value = this.value.replace(/[`~!@#$%^&*|+\-=?���<>\{\}\[\]\\\/]/gi, '').replace(/\r?\n/g, '');"><%=TicketDetails.getEsitoNoteEsame() %></textarea>
          </td>
          <td valign="top">
            <%= showAttribute(request, "problemError") %>
          </td>
        </tr>
        </table>
        </td>
        </tr>
       <% } %>
  <!-- NUOVO CAMPO DATA -->
   <tr class="containerBody">
    <td nowrap class="formLabel">
      <dhv:label name="">Data Risultato</dhv:label>
    </td>
    <td>   
    <input type="text" id="dataRisultato" name="dataRisultato" size="10" class="date_picker"
		value="<%= (TicketDetails.getDataRisultato()==null)?(""):(getLongDate(TicketDetails.getDataRisultato()))%>"/>	
    </td>
  
  </tr>
  
  </table>
  <br>
  <br>
	 
	 
 <table cellpadding="4" cellspacing="0" width="100%" class="details">
	<% if(TicketDetails.getDestinatarioCampione() == 2) {%>
		<tr>
	    <th colspan="<%=colspan%>">
	      <strong><dhv:label name="">Esito Campione</dhv:label></strong> <input type="button" value="VAI IN SIGLA WEB" onClick="openPopupGisaReport('http://siglaweb.izsmportici.it/SiglaWEB/login.do')"/>
	    </th>
		</tr>
	<% } %>
	<tr>
	 <th>Analita</th>
	 <th>Data esito</th>
	 <th>Esito</th>
	 <th>Motivo Respingimento</th>
	 <% if (!TicketDetails.getURlDettaglio().contains("AcqueRete")) {%>
	 <th>Punteggio</th>
	 <th>Responsabilita</th>
	 <th>Allarme Rapido</th>
	 <th>Segnal. Info</th>
	 <%} %>
	  <% if (TicketDetails.getPdp()!=null && TicketDetails.getPdp().getId()>0)
	 {
		 %>
		 <th>
		 Punto di Prelievo</th>
		 <%
	 }
	 %>
	
	 </tr>
	 
	 <!--  COMMENTARE PER NON FAR SCHIATTARE (NON AGGIORNA GLI ANALITI) -->
<%-- 	  <input type="hidden" id="numAnaliti" name="numAnaliti" value="<%=TicketDetails.getTipiCampioni().size()%>"/> --%>
	  
 <% int k = 0;
 for(Analita analita : TicketDetails.getTipiCampioni())
 { k++;
	 %>
	 <input type="hidden" id="idAnalita_<%=k %>" name="idAnalita_<%=k %>" value="<%=analita.getIdAnalita()%>"/>
	 <tr>
	 <td><%=analita.getDescrizione() %> &nbsp;</td>
	  <td><%=toDateasString(analita.getEsito_data()) %> &nbsp;</td>
	  <td><%= toStringSpace(EsitoCampione.getSelectedValue(analita.getEsito_id()))%> &nbsp;</td>
	 <td><%=toStringSpace(analita.getEsito_motivazione_respingimento()) %> &nbsp;</td>
	<% if (!TicketDetails.getURlDettaglio().contains("AcqueRete")) {%>
	 <td><%= analita.getEsito_punteggio() %> &nbsp;</td>
	 <td> <%=toStringSpace(ResponsabilitaPositivita.getSelectedValue(analita.getEsito_responsabilita_positivita()))%> &nbsp; </td>
	 <td><%if(analita.isEsito_allarme_rapido()){%><input type="checkbox" checked disabled><%}else{%><input type="checkbox" disabled> &nbsp;<%}%></td>
	 <td><%if(analita.isEsito_segnalazione_informazioni()){%><input type="checkbox" checked disabled><%}else{%><input type="checkbox" disabled> &nbsp;<%}%></td>
	 <% } %>
	  <%
	 if (TicketDetails.getPdp()!=null && TicketDetails.getPdp().getId()>0)
	 {
		 %>
		 <td>
		 <%=(TicketDetails.getPdp().getOrgdDetails() != null) ? TicketDetails.getPdp().getOrgdDetails().getName()+"<br> loc. "+TicketDetails.getPdp().getOrgdDetails().getAddressList().getAddress(5).toString() : ""%>
		
		 </td>
		 <%
	 }
	 %>
	 	 </tr>
	 <%
 }
 %>

  <input type="hidden" id="stabId" name="stabId" value="<%=TicketDetails.getIdStabilimento()%>"/>
<script>
 $( document ).ready(function() {
	    calenda('dataAccettazione','','0');
	 	calenda('dataRisultato','','0');
	});

</script>

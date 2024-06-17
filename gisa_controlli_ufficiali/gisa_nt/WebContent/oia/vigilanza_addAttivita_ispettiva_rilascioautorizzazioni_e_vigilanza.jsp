<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>

<%@ include file="../utils23/initPage.jsp" %>

<link rel="stylesheet" href="css/jquery-ui.css" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css">

<%@ page import="java.util.*,org.aspcfs.modules.vigilanza.base.*" %>

<jsp:useBean id="TicketDetails" class="org.aspcfs.modules.vigilanza.base.Ticket" scope="request"/>
<jsp:useBean id="OrgDetails" class="org.aspcfs.modules.oia.base.Organization" scope="request"/>
<jsp:useBean id="idAsl" class="java.lang.String" scope="request"/>
<jsp:useBean id="SiteIdList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="AslList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="OggettoAudit" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="TipoTecnica" class="org.aspcfs.utils.web.LookupList" scope="request"/>

<script type="text/javascript" src="dwr/engine.js"> </script>
<script type="text/javascript" src="dwr/util.js"></script>
<SCRIPT LANGUAGE="JavaScript" SRC="javascript/CalendarPopup2.js"></SCRIPT>


<script>
$( document ).ready(function() {
	calenda('dataInizioControllo','','0');
	calenda('dataFineControllo','','');
});

function checkDataFine() {
	if($('#dataInizioControllo').val() == null || $('#dataInizioControllo').val() == ''){
		alert("Selezionare prima una data di inizio valida");
		$('#dataFineControllo').blur();
		$('#dataFineControllo').datepicker("hide");
		//$("#data_fine ~ .ui-datepicker").hide();
	}else{
		$('#dataFineControllo').datepicker('option','minDate',$('#dataInizioControllo').val());
		$('#dataFineControllo').datepicker("show");
	}
}

function gestisciTecnica(val){
	var rows = document.getElementById("tableControlloUfficiale").rows;
	for (var i = 0; i<rows.length; i++){
		if (val == 7){ //AUDIT INTERNO
			if (rows[i].className.includes('trAuditInterno'))
				rows[i].style.display='table-row';
			if (rows[i].className.includes('trSupervisione'))
				rows[i].style.display='none';
		}
		else if (val == 22){ //SUPERVISIONE
			if (rows[i].className.includes('trAuditInterno'))
				rows[i].style.display='none';
			if (rows[i].className.includes('trSupervisione'))
				rows[i].style.display='table-row';
		}
	}
}

function openUploadListaPopUpDocumentale(orgId,folderId,tipoUpload){
	var res;
	var result;

		window.open('GestioneAllegatiUpload.do?command=PrepareUploadLista&tipo='+tipoUpload+'&tipoAllegato='+tipoUpload+'&orgId='+orgId+'&folderId='+folderId,null,
		'height=450px,width=480px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=no,resizable=no ,modal=yes');
		} 
		
function checkInserimentoCu(form){
	
	var idAsl = form.siteId.value;
	var tipoTecnica = form.tipoTecnica.value;
	
	var verbale = form.allegatoSupervisioneDocumentale.value;
	
	var tipoMotivoAudit = form.tipoMotivoAudit.value;
	//var tipoMotivoSupervisione = form.tipoMotivoSupervisione.value;

	var oggettoAudit = Array.prototype.slice.call(form.oggettoAudit.selectedOptions).map(function(v,i,a) {  return v.value;});
	var auditFollowUp = form.auditFollowupCb.checked;

	var strutture = '';
	var inputStrutture = document.getElementsByName('strutturaId');
	for (var i = 0; i<inputStrutture.length; i++){
			if (strutture != '')
				strutture += ',';
			strutture+=inputStrutture[i].value;
		}
	
	var perContoDi = '';
	var inputPerContoDi = document.getElementsByName('perContoDiId');
	for (var i = 0; i<inputPerContoDi.length; i++){
			if (perContoDi != '')
				perContoDi += ',';
			perContoDi+=inputPerContoDi[i].value;
		}
	
	var dataInizioControllo = form.dataInizioControllo.value;
	var dataFineControllo = form.dataFineControllo.value;
	var note = form.note.value;
	
	var nucleoIspettivo = '';
	var inputNucleoIspettivo = document.getElementsByName('qualificaStrutturaComponenteId');
	for (var i = 0; i<inputNucleoIspettivo.length; i++){
			if (nucleoIspettivo != '')
				nucleoIspettivo += ',';
			nucleoIspettivo+=inputNucleoIspettivo[i].value;
		}
	

	var msg = '';
	
	msg += '\n idAsl: ' + idAsl;
	msg += '\n tipoTecnica: ' + tipoTecnica;
	msg += '\n verbale: ' + verbale;
	msg += '\n tipoMotivoAudit: ' + tipoMotivoAudit;
	//msg += '\n tipoMotivoSupervisione: ' + tipoMotivoSupervisione;
	msg += '\n oggettoAudit: ' + oggettoAudit;
	msg += '\n auditFollowUp: ' + auditFollowUp;
	msg += '\n strutture: ' + strutture;
	msg += '\n perContoDi: ' + perContoDi;
	msg += '\n dataInizioControllo: ' + dataInizioControllo;
	msg += '\n dataFineControllo: ' + dataFineControllo;
	msg += '\n note: ' + note;
	msg += '\n nucleoIspettivo: ' + nucleoIspettivo;

	//alert(msg);
	
	var esito = true;
	var errore = '';
	
	if (idAsl == '' || idAsl == '-1'){
		esito = false;
		errore += 'Indicare ASL.\n';
	}
	if (tipoTecnica == '' || tipoTecnica == '-1'){
		esito = false;
		errore += 'Indicare TECNICA DI CONTROLLO.\n';
	}
	if (strutture == ''){
		esito = false;
		errore += 'Indicare STRUTTURE CONTROLLATE.\n';
	}
	if (perContoDi == ''){
		esito = false;
		errore += 'Indicare PER CONTO DI.\n';
	}
	if (dataInizioControllo == ''){
		esito = false;
		errore += 'Indicare DATA INIZIO CONTROLLO.\n';
	}
	if (nucleoIspettivo == ''){
		esito = false;
		errore += 'Indicare NUCLEO ISPETTIVO.\n';
	}
	
	if (tipoTecnica == 7) { //AUDIT INTERNO
		if (tipoMotivoAudit == ''){
			esito = false;
			errore += 'Indicare MOTIVO AUDIT.\n';
		}
		if (oggettoAudit == '' || oggettoAudit == '-1'){
			esito = false;
			errore += 'Indicare CAMPO AUDIT.\n';
		}
	}
	
	if (tipoTecnica == 22) { //SUPERVISIONE
		if (verbale == ''){
			esito = false;
			errore += 'Allegare VERBALE.\n';
		}
// 		if (tipoMotivoSupervisione == ''){
// 			esito = false;
// 			errore += 'Indicare MOTIVO.\n';
// 		}
	}
	
	if (!esito){
		alert('Inserimento non possibile. Verificare gli errori:\n\n'+errore);
		return false;
	}
	
	if (confirm("Procedere all'inserimento?")){
		loadModalWindow();
		form.submit();
	}
}
</script>


<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr><td>
  <a href="Oia.do?command=Home">Autorita' Competenti</a> > 
  Aggiungi Controllo Ufficiale
</td></tr>
</table>
<%-- End Trails --%>

<body>

<form name="addticket" action="OiaVigilanza.do?command=Insert&auto-populate=true" method="post">

<input type="button" value="Inserisci" name="Save" onClick="checkInserimentoCu(this.form)"/>
<input type="button" value="Annulla" onClick="javascript:this.form.action='Oia.do?command=Home'; this.form.submit()"/>

<br/><br/>
<center>
<div style="position:relative; width: auto; height:auto; text-align:center; border:1px solid black; display: inline-block; padding: 20px">
<font color="red" size="3px">Per allegare il rapporto di AUDIT � obbligatorio chiudere il Controllo Ufficiale</font>
</div>
</center>

<br>

<iframe src="empty.html" name="server_commands" id="server_commands" style="visibility:hidden" height="0"></iframe>

  
<table cellpadding="10" cellspacing="10" width="100%" class="details" id="tableControlloUfficiale">
	
<tr><th colspan="2"><strong>Aggiungi Controllo Ufficiale</strong> </th></tr>

<input type="hidden" name="orgId" value="<%=OrgDetails.getOrgId()%>"/>
	
<tr class="containerBody">
<td nowrap class="formLabel">Operatore Sottoposto a controllo</td> 
<td>
<% SiteIdList.setJsEvent("onChange=\"window.location.href='OiaVigilanza.do?command=Add&idAsl='+this.value\""); %>
<%=SiteIdList.getHtmlSelect("siteId", idAsl)%> 
</td>
</tr>

<%-- <tr class="containerBody" <%=OrgDetails.getOrgId()<=0 ? "style='display:none'" : "" %>> --%>
<!-- <td nowrap class="formLabel">Operatore Sottoposto a controllo</td> -->
<%-- <td><b><%=OrgDetails.getName() %></b> --%>
<!-- </td> -->
<!-- </tr> -->

<tr class="containerBody" <%=OrgDetails.getOrgId()<=0 ? "style='display:none'" : "" %>>
<td nowrap class="formLabel" width="50p;">Tecnica di controllo</td>
<td>
<% TipoTecnica.setJsEvent("onChange='gestisciTecnica(this.value)'"); %>
<%=TipoTecnica.getHtmlSelect("tipoTecnica", -1)%>
</td>
</tr>

<tr class="containerBody trSupervisione" style="display:none" <%=OrgDetails.getOrgId()<=0 ? "style='display:none'" : "" %>>
<td nowrap class="formLabel" width="50p;">Verbale</td>
<td>

<a href = "javascript:openUploadListaPopUpDocumentale(<%=OrgDetails.getOrgId() %>,-1,'VerbaleSupervisione')">Allega Verbale</a>
		
<input type="hidden" name="dosubmit" value="true" /> 
<input type="hidden" name="idFileSupervisione" id = "idFileSupervisione" value="">
<input type="hidden" name="fileAllegareSupervisione" id = "fileAllegareSupervisione" value="">
<input type="hidden" name="isAllegatoSupervisione" id = "isAllegatoSupervisione" value="false">
<input type="text" readonly style="border-style:none;" name="allegatoSupervisioneDocumentale" id = "allegatoSupervisioneDocumentale" value=""/>
<label name="allegatoSupervisioneDocumentaleNome" id = "allegatoSupervisioneDocumentaleNome"></label>
<label name="msg_fileSupervisione" id = "msg_fileSupervisione"><font color = "red">File non Allegato</font></label>

</td>
</tr>

<%-- <tr class="containerBody trSupervisione" style="display:none" <%=OrgDetails.getOrgId()<=0 ? "style='display:none'" : "" %>> --%>
<!-- <td nowrap class="formLabel" width="50p;">Motivo</td> -->
<!-- <td> -->

<%-- <%  --%>
<%-- for (MotivoIspezione motivo : listaMotiviSupervisione) { %> --%>
<%-- <input type = "radio" name = "tipoMotivoSupervisione" value = "<%=motivo.getIdMotivoIspezione()%>">  --%>
<%-- <%=motivo.getDescrizioneMotivoIspezione() %>  --%>
<!-- <br/> -->
<%-- <% } %> --%>
<!-- </td> -->
<!-- </tr> -->

<tr class="containerBody trAuditInterno" style="display:none" <%=OrgDetails.getOrgId()<=0 ? "style='display:none'" : "" %>>
<td nowrap class="formLabel" width="50p;">Motivo audit</td>
<td>

<% 
ArrayList<MotivoAudit> listaMotiviAudit = (ArrayList<MotivoAudit>) request.getAttribute("ListaMotiviAudit");
for (MotivoAudit motivo : listaMotiviAudit) { %>
<input type = "radio" name = "tipoMotivoAudit" value = "<%=motivo.getIdAuditTipo()%>"> 
<%=motivo.getDescrizioneAuditTipo() %> 
<br/>
<% } %>
</td>
</tr>	
	
<tr class="containerBody trAuditInterno" style="display:none" <%=OrgDetails.getOrgId()<=0 ? "style='display:none'" : "" %>>
<td nowrap class="formLabel" width="50p;">Campo dell'audit</td>
<td>
<%OggettoAudit.setSelectSize(9);
OggettoAudit.setMultiple(true);%>
<%=OggettoAudit.getHtmlSelect("oggettoAudit",-1) %></td>
</tr>	
	
<tr class="containerBody trAuditInterno" style="display:none" <%=OrgDetails.getOrgId()<=0 ? "style='display:none'" : "" %>>
<td nowrap class="formLabel" width="50p;">Audit di followup</td>
<td>
<input type="checkbox" id="auditFollowupCb" name="auditFollowupCb" value="true"/>
</td>
</tr>	

<tr class="containerBody" <%=OrgDetails.getOrgId()<=0 ? "style='display:none'" : "" %>>
<td nowrap class="formLabel" width="50p;">Strutture controllate</td>
<td>
<%@ include file="../controlliufficiali/dialog_strutture_controllate_autorita_competenti_new.jsp" %>
</td>
</tr>	

<tr class="containerBody" <%=OrgDetails.getOrgId()<=0 ? "style='display:none'" : "" %>>
<td nowrap class="formLabel" width="50p;">Per conto di</td>
<td>
<%@ include file="../controlliufficiali/dialog_per_conto_di_autorita_competenti_new.jsp" %>
</td>
</tr>	

<tr class="containerBody" <%=OrgDetails.getOrgId()<=0 ? "style='display:none'" : "" %>>
<td nowrap class="formLabel" width="50p;">Data inizio controllo</td>
<td><input type="text" id="dataInizioControllo" name="dataInizioControllo" size="10" class="date_picker" onchange="$('#dataFineControllo').val('')"/></td>
</tr>	

<tr class="containerBody" <%=OrgDetails.getOrgId()<=0 ? "style='display:none'" : "" %>>
<td nowrap class="formLabel" width="50p;">Data fine controllo</td>
<td><input type="text" id="dataFineControllo" name="dataFineControllo" size="10" class="date_picker" onclick="checkDataFine()"/></td>
</tr>	

<tr class="containerBody" <%=OrgDetails.getOrgId()<=0 ? "style='display:none'" : "" %>>
<td nowrap class="formLabel" width="50p;">Note</td>
<td>
<textarea name="note" cols="55" rows="8"></textarea>
</td>
</tr>	

<tr class="containerBody" <%=OrgDetails.getOrgId()<=0 ? "style='display:none'" : "" %>>
<td nowrap class="formLabel" width="50p;">Nucleo Ispettivo</td>
<td>
<%@ include file="../controlliufficiali/dialog_nucleo_ispettivo_autorita_competenti_new.jsp" %>
</td>
</tr>	






































</table>

<br>
<br>

<input type= "hidden" name="context" value = "gisa">

<input type="hidden" id="tipoOperatore" name="tipoOperatore" value="<%=request.getAttribute("tipologia") %>"/>
<input type = "hidden" name = "idStabilimentoopu" value = "-1">
<input type="hidden" name="isAllegato" value="<%=TicketDetails.isListaDistribuzioneAllegata() %>"> 
<input type="hidden" name="close" value="">
<input type="hidden" name="refresh" value="-1">
<input type="hidden" name="modified" value="<%=  TicketDetails.getModified() %>" />
<input type="hidden" name="currentDate" value="<%=  request.getAttribute("currentDate") %>" />
<input type="hidden" name="statusId" value="<%=  TicketDetails.getStatusId() %>" />
<input type="hidden" name="trashedDate" value="<%=  TicketDetails.getTrashedDate() %>" />
<%= addHiddenParams(request, "popup|popupType|actionId") %>

<br>

<input type="button" value="Inserisci" name="Save" onClick="checkInserimentoCu(this.form)"/>
<input type="button" value="Annulla" onClick="javascript:this.form.action='Oia.do?command=Home'; this.form.submit()"/>

</form>
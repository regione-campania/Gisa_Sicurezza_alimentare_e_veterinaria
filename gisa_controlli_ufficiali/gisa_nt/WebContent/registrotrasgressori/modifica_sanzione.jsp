<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%@ include file="../../utils23/initPage.jsp"%>
<jsp:useBean id="trasgr" class="org.aspcfs.modules.registrotrasgressori.base.Trasgressione" scope="request"/>
<jsp:useBean id="gruppiUtente" type="java.util.ArrayList" scope="request" />
<jsp:useBean id="messaggio" class="java.lang.String" scope="request"/>
<%@page import="org.aspcfs.modules.registrotrasgressori.base.Trasgressione"%>

  <% UserBean user = (UserBean) session.getAttribute("User");%>

<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %> 

<link rel="stylesheet" documentale_url="" href="registrotrasgressori/css/trasgressori_screen.css" type="text/css" media="screen" />
<link rel="stylesheet" documentale_url="" href="registrotrasgressori/css/trasgressori_print.css" type="text/css" media="print" />


<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/spanDisplay.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popLookupSelect.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popURL.js"></SCRIPT>

<!-- RELATIVO AL NUOVO CALENDARIO CON MESE E ANNO FACILMENTE MODIFICABILI -->
<SCRIPT LANGUAGE="JavaScript" SRC="javascript/CalendarPopup.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="javascript/common.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">document.write(getCalendarStyles());</SCRIPT>
<SCRIPT LANGUAGE="JavaScript" ID="js19">
	var cal19 = new CalendarPopup();
	cal19.showYearNavigation();
	cal19.showYearNavigationInput();
	cal19.showNavigationDropdowns();
</SCRIPT>
<script src='javascript/modalWindow.js'></script>
<script src="javascript/jquery-1.8.2.js"></script>
<script src="javascript/jquery-ui.js"></script>
<link rel="stylesheet" type="text/css" href="css/modalWindow.css"></link>

<DIV ID='modalWindow' CLASS='unlocked'><P CLASS='wait'>Attendere il completamento dell'operazione...</P></DIV>

<script type="text/javascript" src="dwr/engine.js"> </script>
<script type="text/javascript" src="dwr/util.js"></script>

<%@ include file="js/registro_sanzioni_js.jsp"%>

<% if (messaggio!=null && !messaggio.equals("")){ %>
<script> alert('<%=messaggio%>');</script>

<div style="background:yellow">
<pre><xmp><%=messaggio.replaceAll(">", ">\n") %></xmp></pre>
</div>
<%} %>



<form name="form1" id="form1" action="RegistroTrasgressori.do?command=UpdateSanzione" method="post">

<table class="details2" id = "tabletrasgressione" cellpadding="10" cellspacing="10">

<tr><th colspan="4">Modifica sanzione nel Registro Trasgressori</th></tr>

<tr><th>N� prog </th>  
<td><%= trasgr.getProgressivo() %>\<%=trasgr.getAnnoYY() %></td>

<th>Id controllo </th>  
<td><%=(trasgr.getIdControllo()>0) ? trasgr.getIdControllo() : "" %></td></tr>

<tr><th>ASL di competenza</th>  
<td><%=(trasgr.getAsl()!=null) ? trasgr.getAsl() : "" %></td>

<th>Ente accertatore</th>  
<td>
<% LinkedHashMap<String,String> listaEnti = trasgr.getListaEnti();
for(Map.Entry<String, String> ente : listaEnti.entrySet()){%>
<%=(ente.getValue()!=null) ? ente.getValue()+"<br/>" : "" %>
<%} %>
</td></tr> 

<tr><th>PV N� </th>  
<td><%=(trasgr.getPV()!=null) ? trasgr.getPV() : "" %></td>

<th>Num. sequestro eventualmente effettuato</th>  
<td><%=(trasgr.getPVsequestro()!=null) ? trasgr.getPVsequestro() : "" %></td></tr>
 
<tr><th>Data accertamento  </th>  
<td>
<input class="layout" type="text" id="data_accertamento" name="data_accertamento" readonly="readonly" size="10" value="<%=(trasgr.getDataAccertamento()!=null) ?  toDateasString(trasgr.getDataAccertamento()) : "" %>"/> 
</td>

<th>Data prot. in entrata in regione</th>  
<td>
<input class="editField" gruppo="1" type="text" readonly id="data_prot_entrata" name="data_prot_entrata" size="10" value="<%=(trasgr.getDataProt()!=null) ?  toDateasString(trasgr.getDataProt()) : "" %>"/>
<%if (gruppiUtente.contains(1)) { %>
<a href="#" onClick="cal19.select(document.forms[0].data_prot_entrata,'anchor19','dd/MM/yyyy'); return false;" NAME="anchor19" ID="anchor19">
<img src="images/icons/stock_form-date-field-16.gif" border="0" align="absmiddle"></a> &nbsp;
<%} %>
</td></tr>

<tr><th>Trasgressore</th>  
<td><%=(trasgr.getTrasgressore()!=null) ? trasgr.getTrasgressore() : "" %></td>

<th>Obbligato in solido</th>  
<td><%=(trasgr.getObbligatoInSolido()!=null) ? trasgr.getObbligatoInSolido() : "" %></td></tr>

<tr><th>Importo sanzione ridotta</th>  
<td><%= trasgr.getImportoSanzioneRidotta() %>  &#x20ac; </td>

<th>Importo sanzione ridotta del 30%</th>  
<td><%=(trasgr.getImportoSanzioneUltraridotta() !=null) ? trasgr.getImportoSanzioneUltraridotta() : "" %></td></tr>

<tr><th>Illecito di competenza U.O.D. 01</th>  
<td>
<input type="checkbox" gruppo="1" <%if (!gruppiUtente.contains(1)) { %> onClick="return false" style="opacity : .50; filter: alpha(opacity=50)" <%} %> name="competenza_regionale" id="competenza_regionale" <% if (trasgr.isCompetenzaRegionale()){ %> checked="checked" <%} %> onClick="gestisciCompetenzaRegionale(); gestisciPraticaChiusaIndiretta();"/>
</td>

<th>Data ultima notifica</th>  
<td class="competenzaRegionaleClass">
<input class="editField" gruppo="1" type="text" readonly id="data_ultima_notifica" name="data_ultima_notifica" size="10" value="<%=(trasgr.getDataUltimaNotifica()!=null) ?  toDateasString(trasgr.getDataUltimaNotifica()) : "" %>"/>
<%if (gruppiUtente.contains(1)) { %>
<a href="#" onClick="cal19.select(document.forms[0].data_ultima_notifica,'anchor19','dd/MM/yyyy'); return false;" NAME="anchor19" ID="anchor19">
<img src="images/icons/stock_form-date-field-16.gif" border="0" align="absmiddle"></a> &nbsp;
<%} %>
</td></tr>

<tr><th>PV oblato in misura ridotta</th>  
<td class="competenzaRegionaleClass">
<input type="checkbox" disabled <% if (trasgr.isPagopaPvOblatoRidotta()){ %> checked="checked" <%} %>/>
</td>

<th>PV oblato in misura ultraridotta</th>  
<td class="competenzaRegionaleClass">
<input type="checkbox" disabled <% if (trasgr.isPagopaPvOblatoUltraRidotta()){ %> checked="checked" <%} %>/>
</td>

</tr>
 
<tr><th>Data pagamento PV</th>  
<td class="competenzaRegionaleClass">
<input class="layout" type="text" readonly="readonly" name="data_pagamento" id="data_pagamento" size="10" value="<%=(trasgr.getPagopaPvDataPagamento()!=null) ?  toDateasString(trasgr.getPagopaPvDataPagamento()) : "" %>"/> 
</td>

</tr>
 
<tr><th>Funzionario assegnatario</th>  
<td class="competenzaRegionaleClass">
<input class="editField" type="text" gruppo="1" <%if (!gruppiUtente.contains(1)) { %> readonly <%} %> name="fi_assegnatario" id="fi_assegnatario" size="10" value="<%=(trasgr.getFiAssegnatario()!=null) ? trasgr.getFiAssegnatario() : "" %>"/>
</td>

<th>Presentati scritti difensivi</th>  
<td class="competenzaRegionaleClass">
<input type="checkbox" gruppo="1" <%if (!gruppiUtente.contains(1)) { %> onClick="return false" style="opacity : .50; filter: alpha(opacity=50)" <%} %> name="presentati_scritti" id="presentati_scritti" <% if (trasgr.isPresentatiScritti()){ %> checked="checked" <%} %> 
</td></tr>
 	
<tr><th>Presentata richiesta riduzione sanzione e/o rateizzazione</th>  
<td class="competenzaRegionaleClass">
<input type="checkbox" gruppo="1" <%if (!gruppiUtente.contains(1)) {%> onClick="return false" style="opacity : .50; filter: alpha(opacity=50)" <%}%> name="presentata_richiesta_riduzione" id="presentata_richiesta_riduzione" <% if (trasgr.isRichiestaRiduzioneSanzione()){ %> checked="checked" <%} %> 
</td>

<th>Presentata richiesta audizione</th>  
<td class="competenzaRegionaleClass">
<input type="checkbox" gruppo="1" <%if (!gruppiUtente.contains(1)) {%> onClick="return false" style="opacity : .50; filter: alpha(opacity=50)" <%}%> name="presentata_richiesta_audizione" id="presentata_richiesta_audizione" <% if (trasgr.isRichiestaAudizione()){ %> checked="checked" <%} %> 
</td></tr>
 
<tr><th>Ordinanza emessa</th>  
<td class="competenzaRegionaleClass">
<input type="radio" gruppo="1" <%if (!gruppiUtente.contains(1)) {%> onClick="return false" style="opacity : .50; filter: alpha(opacity=50)" <%}%> name="ordinanza_emessa" id="ordinanza_emessaA" value="A" <% if ("A".equals(trasgr.getOrdinanzaEmessa())){ %> checked="checked" <%} %> onClick="gestisciArgomentazioni(); gestisciPraticaChiusaIndiretta();"/> Ord. Archiviazione <br/>
<input type="radio" gruppo="1" <%if (!gruppiUtente.contains(1)) {%> onClick="return false" style="opacity : .50; filter: alpha(opacity=50)" <%}%> name="ordinanza_emessa" id="ordinanza_emessaB" value="B" <% if ("B".equals(trasgr.getOrdinanzaEmessa())){ %> checked="checked" <%} %> onClick="gestisciArgomentazioni();"/> Ord. Ingiunzione
<input type="radio" gruppo="1" <%if (!gruppiUtente.contains(1)) {%> onClick="return false" style="opacity : .50; filter: alpha(opacity=50)" <%}%> name="ordinanza_emessa" id="ordinanza_emessaC" value="C" <% if ("C".equals(trasgr.getOrdinanzaEmessa())){ %> checked="checked" <%} %> onClick="gestisciArgomentazioni(); gestisciPraticaChiusaIndiretta();"/> Pratica non lavorata
</td>

<th>Num. ordinanza</th>  
<td class="competenzaRegionaleClass">
<input class="editField" type="text" gruppo="1" <%if (!gruppiUtente.contains(1)) {%> readonly <%}%> name="num_ordinanza" id="num_ordinanza" size="10" value="<%=(trasgr.getNumOrdinanza()!=null) ? trasgr.getNumOrdinanza() : "" %>" onkeyup="this.value=this.value.replace(/[^0-9]+/,'')" /> </td>
</td></tr>

<tr><th>Data di emissione dell'Ordinanza</th>  
<td class="competenzaRegionaleClass">
<input class="editField" gruppo="1" type="text" readonly id="data_emissione" name="data_emissione" size="10" value="<%=(trasgr.getDataEmissione()!=null) ?  toDateasString(trasgr.getDataEmissione()) : "" %>" />
<%if (gruppiUtente.contains(1)) {%> 
<a href="#" onClick="cal19.select(document.forms[0].data_emissione,'anchor19','dd/MM/yyyy'); return false;" NAME="anchor19" ID="anchor19">
<img src="images/icons/stock_form-date-field-16.gif" border="0" align="absmiddle"></a>
<%} %>
</td>

<th>Giorni di lavorazione pratica</th>  
<td class="competenzaRegionaleClass">
<input class="layout" type="text" readonly id="giorni_lavorazione" name="giorni_lavorazione" size="3" value="<%=(trasgr.getGiorniLavorazione()>-1) ? trasgr.getGiorniLavorazione() : "" %>"/>
</td></tr>
 
<tr><th>Importo sanzione ingiunta</th>  
<td class="competenzaRegionaleClass argomentazioniClass">
<input class="editField" type="text" gruppo="1" <%if (!gruppiUtente.contains(1)) {%> readonly <%}%> name="importo_sanzione_ingiunta" id="importo_sanzione_ingiunta" size="10" value="<%=trasgr.getImportoSanzioneIngiunta() %>" onkeyup="this.value=this.value.replace(/[^0-9]+/,'')"/> &#x20ac;
</td>

<th>Data ultima notifica ordinanza</th>  
<td class="competenzaRegionaleClass argomentazioniClass">
<input class="editField" gruppo="1" type="text" readonly id="data_ultima_notifica_ordinanza" name="data_ultima_notifica_ordinanza" size="10" value="<%=(trasgr.getDataUltimaNotificaOrdinanza()!=null) ?  toDateasString(trasgr.getDataUltimaNotificaOrdinanza()) : "" %>"/>
<%if (gruppiUtente.contains(1)) { %>
<a href="#" onClick="cal19.select(document.forms[0].data_ultima_notifica_ordinanza,'anchor19','dd/MM/yyyy'); return false;" NAME="anchor19" ID="anchor19">
<img src="images/icons/stock_form-date-field-16.gif" border="0" align="absmiddle"></a> &nbsp;
<%} %>
</td></tr>
 
<tr><th>Data pagamento ordinanza</th>  
<td class="competenzaRegionaleClass argomentazioniClass">
<input class="editField" gruppo="2" type="text" readonly id="data_pagamento_ordinanza" name="data_pagamento_ordinanza" size="10" value="<%=(trasgr.getDataPagamentoOrdinanza()!=null) ?  toDateasString(trasgr.getDataPagamentoOrdinanza()) : "" %>"/>
<%if (gruppiUtente.contains(2)) { %>
<a href="#" onClick="cal19.select(document.forms[0].data_pagamento_ordinanza,'anchor19','dd/MM/yyyy'); return false;" NAME="anchor19" ID="anchor19">
<img src="images/icons/stock_form-date-field-16.gif" border="0" align="absmiddle"></a> &nbsp;
<%} %>
</td>

<th>Concessa rateizzazione dell'ordinanza-ingiunzione</th>  
<td class="competenzaRegionaleClass argomentazioniClass">
<input type="radio" gruppo="1" <%if (!gruppiUtente.contains(1)) {%> onClick="return false" style="opacity : .50; filter: alpha(opacity=50)" <%}%> name="richiesta_rateizzazione" id="richiesta_rateizzazioneSI" value="true" <% if (trasgr.isRichiestaRateizzazione()){ %> checked="checked" <%} %> onClick="gestisciRichiestaRateizzazione()"/> SI <br/>
<input type="radio" gruppo="1" <%if (!gruppiUtente.contains(1)) {%> onClick="return false" style="opacity : .50; filter: alpha(opacity=50)" <%}%> name="richiesta_rateizzazione" id="richiesta_rateizzazioneNO" <% if (!trasgr.isRichiestaRateizzazione()){ %> checked="checked" <%} %> onClick="gestisciRichiestaRateizzazione()"/> NO 
</td></tr>
 
<tr><th>Rate pagate</th>  
<td class="competenzaRegionaleClass">
<%=trasgr.getPagopaNoRatePagate().length() > 0 ? trasgr.getPagopaNoRatePagate().replaceAll(",", "<br/>") : "" %>
</td>

<th>Ordinanza ingiunzione oblata</th> 
<td class="competenzaRegionaleClass argomentazioniClass">
<input type="checkbox" gruppo="2" <%if (!gruppiUtente.contains(2)) {%> onClick="return false" style="opacity : .50; filter: alpha(opacity=50)" <%}%>  name="ordinanza_ingiunzione_oblata" id="ordinanza_ingiunzione_oblata" <% if (trasgr.isIngiunzioneOblata()){ %> checked="checked" <%} %>/> 
</td></tr>
  
<tr><th>Importo effettivamente introitato (2)</th>  
<td class="competenzaRegionaleClass argomentazioniClass">
<input class="editField" type="text" gruppo="2" <% if (!gruppiUtente.contains(2)) {%> readonly <%} else if (trasgr.getPagopaTipo().equals("NO") && trasgr.getDataEmissione()!=null && trasgr.getDataEmissione().after(java.sql.Timestamp.valueOf("2022-04-19 00:00:00"))) {%> readonly <%}%> name="importo_effettivamente_versato2" id="importo_effettivamente_versato2" size="10" value="<%=trasgr.getImportoEffettivamenteVersato2() %>" onkeyup="this.value=this.value.replace(/[^0-9]+/,'')"/> &#x20ac; 
</td>

<th>Presentata opposizione all'ordinanza-ingiunzione</th>  
<td class="competenzaRegionaleClass argomentazioniClass">
<input type="checkbox" gruppo="1" <%if (!gruppiUtente.contains(1)) {%> onClick="return false" style="opacity : .50; filter: alpha(opacity=50)" <%}%> name="presentata_opposizione" id="presentata_opposizione" <% if (trasgr.isPresentataOpposizione()){ %> checked="checked" <%} %>/>
</td></tr>
 
<tr><th>Sentenza favorevole al ricorrente</th>  
<td class="competenzaRegionaleClass argomentazioniClass">
<input type="radio" gruppo="1" <%if (!gruppiUtente.contains(1)) {%> onClick="return false" style="opacity : .50; filter: alpha(opacity=50)" <%}%> name="sentenza_favorevole" id="sentenza_favorevoleSI" value="true" <% if (trasgr.isSentenzaFavorevole()){ %> checked="checked" <%} %> onClick="gestisciSentenza()"/> SI <br/>
<input type="radio" gruppo="1" <%if (!gruppiUtente.contains(1)) {%> onClick="return false" style="opacity : .50; filter: alpha(opacity=50)" <%}%> name="sentenza_favorevole" id="sentenza_favorevoleNO" <% if (!trasgr.isSentenzaFavorevole()){ %> checked="checked" <%} %> onClick="gestisciSentenza()"/> NO 
</td>

<th>Importo stabilito dalla A.G.</th>  
<td class="competenzaRegionaleClass argomentazioniClass sentenzaClass">
<input class="editField" type="text" gruppo="1" <%if (!gruppiUtente.contains(1)) {%> readonly <%}%> name="importo_stabilito" id="importo_stabilito" size="10" value="<%=trasgr.getImportoStabilito() %>" onkeyup="this.value=this.value.replace(/[^0-9]+/,'')"/> &#x20ac;
</td></tr> 

<tr><th>Ordinanza-ingiunzione oblata secondo il dispositivo della sentenza</th>  
<td class="competenzaRegionaleClass argomentazioniClass sentenzaClass">
<input type="checkbox" gruppo="1" <%if (!gruppiUtente.contains(1)) { %> onClick="return false" style="opacity : .50; filter: alpha(opacity=50)" <%} %> name="ordinanza_ingiunzione_sentenza" id="ordinanza_ingiunzione_sentenza" <% if (trasgr.isIngiunzioneOblataSentenza()){ %> checked="checked" <%} %>/>
</td>

<th>Importo effettivamente introitato (3)</th>  
<td class="competenzaRegionaleClass argomentazioniClass sentenzaClass">
<input class="editField" type="text" gruppo="2" <%if (!gruppiUtente.contains(2)) {%> readonly <%}%> name="importo_effettivamente_versato3" id="importo_effettivamente_versato3" size="10" value="<%=trasgr.getImportoEffettivamenteVersato3() %>" onkeyup="this.value=this.value.replace(/[^0-9]+/,'')"/> &#x20ac; 
</td></tr>
 
<tr><th>Avviata per l'esecuzione forzata</th> 
<td class="competenzaRegionaleClass argomentazioniClass sentenzaClass">
<input type="checkbox" gruppo="2" <%if (!gruppiUtente.contains(2)) {%> onClick="return false" style="opacity : .50; filter: alpha(opacity=50)" <%}%> name="iscrizione_ruoli_sattoriali" id="iscrizione_ruoli_sattoriali" <% if (trasgr.isIscrizioneRuoliSattoriali()){ %> checked="checked" <%} %>/>
</td>

<th>Importo effettivamente introitato (4)</th>  
<td class="competenzaRegionaleClass argomentazioniClass sentenzaClass">
<input class="editField" type="text" gruppo="2" <%if (!gruppiUtente.contains(2)) {%> readonly <%}%> name="importo_effettivamente_versato4" id="importo_effettivamente_versato4" size="10" value="<%=trasgr.getImportoEffettivamenteVersato4() %>" onkeyup="this.value=this.value.replace(/[^0-9]+/,'')" /> &#x20ac;
</td></tr>
 
<tr><th>Note Gruppo 1</th>  
<td>
<textarea class="editField" gruppo="1" <%if (!gruppiUtente.contains(1)) {%> readonly <%}%> name="note1" id="note1" cols="20" rows="3"/><%= (trasgr.getNote1()!=null) ? trasgr.getNote1() : ""%></textarea>
</td>

<th>Note Gruppo 2</th>  
<td>
<textarea class="editField" gruppo="2" <%if (!gruppiUtente.contains(2)) {%> readonly <%}%> name="note2" id="note2" cols="20" rows="3"/><%= (trasgr.getNote2()!=null) ? trasgr.getNote2() : ""%></textarea>
</td></tr>
 
<tr><th>Processo Verbale</th>  

<td>
<div id="linkDocumentoPv">
<% if (trasgr.getAllegatoPv()!=null && !trasgr.getAllegatoPv().replaceAll("#", "").equals("")) { 
for (int k = 0; k<trasgr.getListaAllegatiPv().length; k++) {
	String[] alleg = trasgr.getListaAllegatiPv()[k].split("#");
	String header = "", oggetto = "", nomeClient = "";
	try {header= alleg[0];} catch (Exception e) {}
	try {oggetto= alleg[1];} catch (Exception e) {}
	try {nomeClient= alleg[2];} catch (Exception e) {}
	if (oggetto.equals("")) oggetto = header;
	if (nomeClient.equals("")) nomeClient = header;
%>
<a id = "<%=header%>_download" href="GestioneAllegatiTrasgressori.do?command=DownloadPDF&codDocumento=<%=header%>&nomeDocumento=<%=nomeClient%>"> <%=oggetto %>  </a><br/><br/>
<%} } %>
</div> 
</td>

<th>Altri allegati inseriti dagli agenti</th>  

<td>
<div id="linkDocumentoAl">
<% if (trasgr.getAllegatoAl()!=null && !trasgr.getAllegatoAl().equals("")) { 
for (int k = 0; k<trasgr.getListaAllegatiAl().length; k++) {
	String[] alleg = trasgr.getListaAllegatiAl()[k].split("#");
	String header = "", oggetto = "", nomeClient = "";
	try {header= alleg[0];} catch (Exception e) {}
	try {oggetto= alleg[1];} catch (Exception e) {}
	try {nomeClient= alleg[2];} catch (Exception e) {}
	if (oggetto.equals("")) oggetto = header;
	if (nomeClient.equals("")) nomeClient = header;
%>
<a id = "<%=header%>_download" href="GestioneAllegatiTrasgressori.do?command=DownloadPDF&codDocumento=<%=header%>&nomeDocumento=<%=nomeClient%>"> <%=oggetto %>  </a><br/><br/>
<%} } %>
</div> 
</td>

</tr>

<tr><th>Avvisi esterni a GISA</th>  
<td>
<div id="linkDocumentoAE">
<% if (trasgr.getAllegatoAe()!=null && !trasgr.getAllegatoAe().replaceAll("#", "").equals("")) { 
				for (int k = 0; k<trasgr.getListaAllegatiAe().length; k++) {
					String[] alleg = trasgr.getListaAllegatiAe()[k].split("#");
					String header = "", oggetto = "", nomeClient = "";
					try {header= alleg[0];} catch (Exception e) {}
					try {oggetto= alleg[1];} catch (Exception e) {}
					try {nomeClient= alleg[2];} catch (Exception e) {}
					if (oggetto.equals("")) oggetto = header;
					if (nomeClient.equals("")) nomeClient = header;
					%>
					<a id = "<%=header%>_download" href="GestioneAllegatiTrasgressori.do?command=DownloadPDF&codDocumento=<%=header%>&nomeDocumento=<%=nomeClient%>"> <%=oggetto %>  </a>
					
					<%if (gruppiUtente.contains(1) || gruppiUtente.contains(2)) {%>
						&nbsp; &nbsp; &nbsp; &nbsp;  <i><b>Elimina</b></i> <input type="checkbox" id="allegato_ae_elimina_<%=k %>" name="allegato_ae_elimina_<%=k %>" value="si"> 
					<% } %>
					
					<br/><br/>
					<input type="hidden" id="allegato_ae_<%=k %>" name="allegato_ae_<%=k %>" value="<%=header%>"/>
					<input type="hidden" id="allegato_ae_oggetto_<%=k %>" name="allegato_ae_oggetto_<%=k %>" value="<%=oggetto%>"/>
					<input type="hidden" id="allegato_ae_nomeclient_<%=k %>" name="allegato_ae_nomeclient_<%=k %>" value="<%=nomeClient%>"/>
<%} } %>
</div> 

<div id="linkAllegati_ae" name="linkAllegati_ae"></div>

<%if (gruppiUtente.contains(1) || gruppiUtente.contains(2)) {%>
<a href = "javascript:openUploadAllegatoTragressori('<%=trasgr.getId() %>','<%=trasgr.getIdSanzione() %>', 'RegistroTrasgressoriAe')" id="allega"><b>Allega nuovo</b></a>
<input type="hidden" id="allegato_ae_size" name="allegato_ae_size" value="<%=trasgr.getListaAllegatiAe().length%>"/>
<%} %>



</td>

<th>Avvisi esterni a GISA pagati</th>  
<td>
<input type="checkbox" gruppo="1" <%if (!gruppiUtente.contains(1)) {%> onClick="return false" style="opacity : .50; filter: alpha(opacity=50)" <%}%>  name="ae_pagati" id="ae_pagati" <% if (trasgr.isAePagati()){ %> checked="checked" <%} %> />
</td></tr>

<tr><th>Altri allegati</th>  
<td>
<div id="linkDocumento">
<% if (trasgr.getAllegatoRt()!=null && !trasgr.getAllegatoRt().replaceAll("#", "").equals("")) { 
				for (int k = 0; k<trasgr.getListaAllegatiRt().length; k++) {
					String[] alleg = trasgr.getListaAllegatiRt()[k].split("#");
					String header = "", oggetto = "", nomeClient = "";
					try {header= alleg[0];} catch (Exception e) {}
					try {oggetto= alleg[1];} catch (Exception e) {}
					try {nomeClient= alleg[2];} catch (Exception e) {}
					if (oggetto.equals("")) oggetto = header;
					if (nomeClient.equals("")) nomeClient = header;
					%>
					<a id = "<%=header%>_download" href="GestioneAllegatiTrasgressori.do?command=DownloadPDF&codDocumento=<%=header%>&nomeDocumento=<%=nomeClient%>"> <%=oggetto %>  </a>
					
					<%if (gruppiUtente.contains(1) || gruppiUtente.contains(2)) {%>
						&nbsp; &nbsp; &nbsp; &nbsp;  <i><b>Elimina</b></i> <input type="checkbox" id="allegato_rt_elimina_<%=k %>" name="allegato_rt_elimina_<%=k %>" value="si"> 
					<% } %>
					
					<br/><br/>
					<input type="hidden" id="allegato_rt_<%=k %>" name="allegato_rt_<%=k %>" value="<%=header%>"/>
					<input type="hidden" id="allegato_rt_oggetto_<%=k %>" name="allegato_rt_oggetto_<%=k %>" value="<%=oggetto%>"/>
					<input type="hidden" id="allegato_rt_nomeclient_<%=k %>" name="allegato_rt_nomeclient_<%=k %>" value="<%=nomeClient%>"/>
<%} } %>
</div> 

<div id="linkAllegati_rt" name="linkAllegati_rt"></div>

<%if (gruppiUtente.contains(1) || gruppiUtente.contains(2)) {%>
<a href = "javascript:openUploadAllegatoTragressori('<%=trasgr.getId() %>','<%=trasgr.getIdSanzione() %>', 'RegistroTrasgressori')" id="allega"><b>Allega nuovo</b></a>
<input type="hidden" id="allegato_rt_size" name="allegato_rt_size" value="<%=trasgr.getListaAllegatiRt().length%>"/>
<%} %>



</td>

<th>Pratica chiusa</th>  
<td>
<input type="checkbox" gruppo="2" <%if (!gruppiUtente.contains(2)) {%> onClick="return false" style="opacity : .50; filter: alpha(opacity=50)" <%}%>  name="pratica_chiusa" id="pratica_chiusa" <% if (trasgr.isPraticaChiusa()){ %> checked="checked" <%} %>  onClick="gestisciPraticaChiusa()" />
</td></tr>

<tr><th>Modificato da</th> 
<td> <dhv:username id="<%= trasgr.getIdUtenteModifica() %>" /></td> 
<th>Modificato il</th> 
<td><%=toDateasStringWitTime(trasgr.getDataModifica()) %></td>
</tr>


<tr>
<th colspan="2"><input type="button" id="annulla" value="ANNULLA" onClick="annullaModificaSanzione('<%=trasgr.getAnno()%>', '<%=trasgr.getTrimestre()%>')"/></th>
<th colspan="2"><input type="button" id="salva" value="SALVA" onClick="checkFormModificaSanzione(this.form)"/></th>
</tr> 

<tr><th colspan="4"><input type="button" id="torna" value="TORNA AL REGISTRO (TRIMESTRE DI QUESTA SANZIONE)" onClick="tornaAlRegistro('<%=trasgr.getAnno()%>', '<%=trasgr.getTrimestre()%>')"/></th></tr>
<tr><th colspan="4"><input type="button" id="torna" value="TORNA AL REGISTRO (TUTTO L'ANNO)" onClick="tornaAlRegistro('<%=trasgr.getAnno()%>', '-1')"/></th></tr>

<input type="hidden" readonly id="idControlloUfficiale" name="idControlloUfficiale" value="<%=trasgr.getIdControllo() %>"/>
<input type="hidden" readonly id="id_sanzione" name="id_sanzione" value="<%=trasgr.getIdSanzione() %>"/>
<input type="hidden" readonly id="id" name="id" value="<%=trasgr.getId() %>"/>
	

</table>

<% if (!"B".equals(trasgr.getOrdinanzaEmessa())){%>
			<script>gestisciArgomentazioni()</script>
<%} else if (trasgr.isSentenzaFavorevole()){%>
			<script>gestisciSentenza()</script>
<%} %>

<%if (!trasgr.isRichiestaRateizzazione()) {%>
			<script>gestisciRichiestaRateizzazione()</script>
<%} %>

<%if (!trasgr.isCompetenzaRegionale()) {%>
			<script>gestisciCompetenzaRegionale()</script>
<%} %>

<%if (trasgr.isPraticaChiusa()) {%>
			<script>gestisciPraticaChiusa()</script>
<%} %>			
		
</form>		

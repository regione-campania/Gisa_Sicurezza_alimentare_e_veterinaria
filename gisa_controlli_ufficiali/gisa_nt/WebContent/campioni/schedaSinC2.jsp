<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html40/strict.dtd">
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="org.aspcfs.modules.base.Constants,org.aspcfs.utils.web.*" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import=" org.aspcfs.modules.util.imports.ApplicationProperties"%>
<%@page import="java.net.InetAddress"%><html>
<%@ include file="../utils23/initPage.jsp" %>

<%@page import="org.apache.derby.tools.sysinfo"%>
<link rel="stylesheet" documentale_url="" href="campioni/print.css" type="text/css" media="print" />
<link rel="stylesheet" type="text/css" media="screen" documentale_url="" href="campioni/screen.css">


<jsp:useBean id="SinDetails" class="org.aspcfs.modules.campioni.base.Sin" scope="request"/>

<script>

function checkRow(i){

	var ret = true;
	message = "";
	for(var j=1; j<=4; j++){
		if(document.getElementById("b4_" + i + "_"+j).value == ''){
				message += "- Controlla di aver riempito l'intera riga dei campi relativi agli alimenti somministrati (B4)\r\n";
				ret = false;
				break;
		}
		else {
			ret = true;
		}
			
	}
	if (!ret) {
		alert(message);
	}

	return ret;
		
		
}


function onKeyNumeric(e) {
	
	// Accetto solo numeri e backspace <-
	if ( ((e.keyCode >= 48) && (e.keyCode <= 57)) || (e.keyCode == 8) ) {
		return true;
	} else {
		alert('Il campo Aliquote � di tipo numerico!')
		return false;
	}
}


function checkForm()
{
	var ret = true;
	message = "";


	var valc = "";

	if(document.myform.prelev.checked){
		valc = '1';
	}
	else {
		
		for (var a=0; a < document.myform.prelev.length; a++)
		{
		   if (document.myform.prelev[a].checked)
		      {
		      		valc = document.myform.prelev[a].value;
		      }
		}
	}
	
	var id= 'a2_1_'+valc;
	if( document.getElementById(id).value == '' || document.getElementById(id).value == 'null')
	{
		message += "\"Codice Fiscale\" obbligatorio ma non presente in GISA.\n E' necessario comunicare all'HELP DESK il CF per salvare correttamente la scheda SIN.\r\n";
		ret = false;
	}

	if( document.getElementById('a4_1').value == '' )		
	{
		message += "\"Codice SIN\" obbligatorio\r\n";
		ret = false;
	}

	if( document.getElementById('a4_2').value == '' )		
	{
		message += "\"Denominazione SIN\" obbligatoria\r\n";
		ret = false;
	}

	if( document.getElementById('a11_1').value == '' )		
	{
		message += "\"Latitudine\" obbligatoria\r\n";
		ret = false;
	}
	else {
		
		//Latitudine inserita...
		if ( (document.getElementById('a11_1').value < 39.988475) || (document.getElementById('a11_1').value > 41.503754 || document.getElementById('a11_1').value == 'a11_2' )){
	        message += "- Valore errato per il campo Latitudine! Il valore deve essere compreso tra 39.988475 e 41.503754\r\n";
	        ret = false;
	    }		 
	
	}

	if( document.getElementById('a11_2').value == '' )		
	{
		message += "\"Longitudine\" obbligatoria\r\n";
		ret = false;
	}
	
	else {

		if ( (document.getElementById('a11_2').value < 13.7563172) || (document.getElementById('a11_2').value > 15.8032837) ){
		   message += "- Valore errato per il campo Longitudine, il valore deve essere compreso tra 13.7563172 e 15.8032837 \r\n";
		   ret = false;
	     }		 
		
	}

	if( document.getElementById('a13').value == '' )		
	{
		message += "- Controlla di aver inserito il numero di aliquote (A13)\r\n";
		ret = false;
	}

	if( document.getElementById('a6').value == '' )		
	{
		message += "\"Indirizzo\" obbligatorio. Si prega di inserirlo.\r\n";
		document.myform.a6.readOnly = false;
		document.myform.a6.className = "editNoBottom"; 
		ret = false;
	}
	
	if( document.getElementById('a7').value == '' )		
	{
		message += "\"Comune\" obbligatorio. Si prega di inserirlo.\r\n";
		document.myform.a7.readOnly = false;
		document.myform.a7.className = "editNoBottom"; 
		ret = false;
	}

	
	var val1 = "";
	for (var i=0; i < document.myform.a1.length; i++)
	{
	   if (document.myform.a1[i].checked)
	      {
	      		val1 = document.myform.a1[i].value;
	      }
	}
	
	if(val1 == "")	
	{
		message += "- Controlla di aver selezionato una strategia di campionamento (A1)\r\n";
		ret = false;
	}


	var val2 = "";
	for (var j=0; j < document.myform.b1.length; j++)
	{
	   if (document.myform.b1[j].checked)
	   {
	      		val2 = document.myform.b1[j].value;
	    }
	}
	
	if(val2 == "")	
	{
		message += "- Controlla di aver selezionato una destinazione dell'alimento prelevato (B1)\r\n";
		ret = false;
	}

	var val3 = "";
	for (var k=0; k < document.myform.b2.length; k++)
	{
	   if (document.myform.b2[k].checked)
	      {
	      		val3 = document.myform.b2[k].value;
	      }
	}
	
	if(val3 == "")	
	{
		message += "- Controlla di aver selezionato la specie animale da cui proviene l'alimento (B2)\r\n";
		ret = false;
	}

	var val4 = "";
	for (var l=0; l < document.myform.b3.length; l++)
	{
	   if (document.myform.b3[l].checked)
	      {
	      		val4 = document.myform.b3[l].value;
	      }
	}
	
	if(val4 == "")	
	{
		message += "- Controlla di aver selezionato il tipo di stabulazione (B3)\r\n";
		ret = false;
	}

	var i=1;
	var empty1 = false;
	for(var j=1; j<=4; j++){
		if(document.getElementById("b4_" + i + "_"+j).value == ''){
				message += "- Controlla di aver riempito la prima riga dei campi relativi agli alimenti somministrati (B4)\r\n";
				empty1 = true;
				ret = false;
				break;
		}
			
	}
	
	var val5 = "";
	for (var i=0; i < document.myform.b4_1_5.length; i++)
	{
	   if (document.myform.b4_1_5[i].checked)
	      {
	      		val5 = document.myform.b4_1_5[i].value;
	      }
	}
	
	if(val5 == "")	
	{
		message += "- Controlla di aver selezionato la produzione locale almeno della prima riga (B4)\r\n";
		ret = false;
	}    
	
	
	if (!ret) {
		alert(message);
	}

	return ret;
}


</script>


<script>
function closeAndRefresh(chiudi,url) {
		if(chiudi == "si")
		{
			self.close();
			window.opener.location.href = url;
		 	
		}	
	}	


function setCF(i,max) {
	document.getElementById(i).style.display = 'block';
	
	for (var j=1; j<=max; j++){
		if(j != i){
			document.getElementById(j).style.display = 'none';	
		}
	}	

	var valc = '';

	if(document.myform.prelev.checked){
		valc = '1';
	}
	else{
		
		for (var a=0; a < document.myform.prelev.length; a++)
		{
		   if (document.myform.prelev[a].checked)
		      {
		      		valc = document.myform.prelev[a].value;
		      }
		}
	}

	if(valc != ''){
		var firma_val = 'firma_'+valc;

		document.getElementById(valc).style.display='block';	
		document.getElementById('firma').value = document.getElementById(firma_val).value;
	}
	else {	
		document.myform.prelev[0].checked = true;
	}
	
}	


function setCFbyPrelev() {
	var valc = '';

	if(document.myform.prelev.checked){
		valc = '1';
	}
	else{
		
		for (var a=0; a < document.myform.prelev.length; a++)
		{
		   if (document.myform.prelev[a].checked)
		      {
		      		valc = document.myform.prelev[a].value;
		      }
		}
	}

if(valc != ''){
		
		var firma_val = 'firma_'+valc;
		document.getElementById(valc).style.display='block';	
		document.getElementById('firma').value = document.getElementById(firma_val).value;
	}
	
	else {
		
		if(document.myform.prelev.length > 1){
			document.myform.prelev[0].checked = true;
			document.getElementById(1).style.display = 'block';
			document.getElementById('firma').value = document.getElementById('firma_1').value;
			
		}
		
		else {
			document.myform.prelev.checked = true;
			document.getElementById(1).style.display = 'block';
			document.getElementById('firma').value = document.getElementById('firma_1').value;
			
		} 
		
		
	}
	
}	
</script>
<jsp:useBean id="definitivo" class="java.lang.String" scope="request"/>
<dhv:permission name="server_documentale-view">
<%if (definitivo==null || !definitivo.equals("true")){ %>
<div style="display:none">
<%} else { %>
<div style="display:block">
<%} %>
<!--  BOX DOCUMENTALE -->
	 <jsp:include page="../gestione_documenti/boxDocumentale.jsp">
    <jsp:param name="orgId" value="<%=request.getParameter("orgId") %>" />
     <jsp:param name="ticketId" value="<%=request.getParameter("idControllo") %>" />
      <jsp:param name="tipo" value="<%=request.getParameter("tipo") %>" />
       <jsp:param name="idCU" value="-1" />
        <jsp:param name="url" value="<%=request.getParameter("url") %>" />
</jsp:include></div>
<!--  BOX DOCUMENTALE -->
</dhv:permission>
<body onload="javascript:setCFbyPrelev();closeAndRefresh('<%= request.getAttribute("chiudi")%>','<%= request.getAttribute("redirect")%>')">

<div class="boxIdDocumento"></div>
<br/><br/><br/> <!-- FACCIO POSTO PER BOX ID DOCUMENTO IN GENERA PDF -->

<form method="post" name="myform" action="CampioniReport.do?command=InsertSchedaSin&type=2&idControllo=<%=SinDetails.getIdControllo()%>&orgId=<%=SinDetails.getOrgId()%>&url=<%=SinDetails.getUrl()%>&tipo=latteC2">

<i>Mod. C2: Scheda di accompagnamento campioni<br>
(contaminanti ambientali in alimenti di origine animale prodotti nelle aree oggetto di emergenze ambientali)</i>
&nbsp;
&nbsp;
&nbsp;
&nbsp;
Scheda N.<input type="text" class="layout" readonly name="a14" id="a14" value="<%=SinDetails.getA14()%>" size="10" maxlength="10"/>

<input type="submit" name="salva" class = "buttonClass" onclick="javascript:this.form.tipoAzione.value='salva';return checkForm();" value="Salva in GISA"/>
&nbsp;
<input type="submit" name="stampa" class = "buttonClass" onclick="window.print();" value="Stampa"/>

<input type="hidden" id="tipoAzione" name="tipoAzione" value="" />



<h2>PARTE 1: SPAZIO A CURA DEL PRELEVATORE</h4>
<h3>A. PARTE GENERALE</h3>
<H4>Tipologia di campionamento</H2>
<table>
<tr class="colorcell">
  <td colspan="2"><b>A1. Strategia di campionamento (S33-34-35)</b></td>
</tr>
<tr>
  <td><input type="radio"  id="a1" name="a1" value="0" <%=(SinDetails.isA1_1()) ? ("checked=\"checked\"") : ("") %>> Monitoraggio</td>
  <td><input type="radio"  id="a1" name="a1" value="1" <%=(SinDetails.isA1_2()) ? ("checked=\"checked\"") : ("") %>>A seguito di positivita'</td>
</tr>
<tr class="colorcell">
  <td><b>A2. Prelevatore (Nome e Cognome - Codice Fiscale)</b></td>
  <td><b>A3. ASL di appartenenza (O1):</b></td> 
</tr>
<tr>
<td>
<% int i=0;
	for(String p : SinDetails.getA2().split(",")) { 
	
	++i;
	%> 
  	<input type="radio" name="prelev" id="prelev" value="<%=i%>" <%=(SinDetails.isCheckedPrelevatore(i)) ? ("checked=\"checked\"") : ("") %> onchange="setCF('<%=i%>','<%= request.getAttribute("max")%>')"><%=p.trim()%>
  	<input type="hidden" name="firma_<%=i%>" id="firma_<%=i%>" value="<%=p.trim()%>" />
  	<br>
  	<% }%>
  	<input type="hidden" name="a2" id="a2" value="<%=SinDetails.getA2()%>"/> 
	<% int j=0;
	for(String p : SinDetails.getA2_1().split(",")) {
		++j;
	%>
	<br>
	<div id="<%=j%>" style="display: none">
  	CF: <input type="text" class="layout" readonly name="a2_1_<%=j%>" id="a2_1_<%=j%>" value="<%=p.trim()%>" size="20" maxlength="16"/><br>
  	</div>
  	<% } if(j == 0){ %> 
  	<div id="<%=1%>" style="display: none">
  	CF: <input type="text" class="layout" readonly name="a2_1_1" id="a2_1_1" value="" size="20" maxlength="16"/><br>
  	</div>
  	<% } %>	
  </td>
  <%--<td>
      <input type="text" class="editNoBottom"  name="a2_1" id="a2_1" value="<%= (SinDetails.getA2_1() != null && !(SinDetails.getA2_1().equals(""))) ? SinDetails.getA2_1() : "" %>" size="20" maxlength="16"/>
  </td>
  --%>
  <td><input type="text" class="layout" readonly  name="a3" id="a3" value="<%=SinDetails.getA3()%>" size="83" maxlength="60"/></td> 
</tr>
<tr class="colorcell">
  <td colspan="2"><b>A4. Luogo di prelievo (S39):</b></td>
</tr>
<tr>
  <td>Codice SIN:<input type="text" class="editNoBottom" readonly="readonly"  name="a4_1" id="a4_1" value="83" size="60" maxlength="60"/></td>
  <td>Denominazione SIN: <input type="text" class="editNoBottom"  name="a4_2" id="a4_2" readonly="readonly" value="VESUVIANO - PIANURA - ORIENTALE - BAGNOLI" size="60" maxlength="60"/></td>
</tr>
<tr class="colorcell">
  <td><b>A5. Codice Azienda (S19):</b></td>
  <td><b>A6. Indirizzo del luogo di prelievo (S19):</b></td>
</tr>
<tr>
  <td><input type="text" class="layout" readonly  name="a5" id="a5" value="<%=SinDetails.getA5()%>" size="80" maxlength="60"/></td>
  <td><input type="text" class="layout" readonly  name="a6" id="a6" value="<%=SinDetails.getA6()%>" size="83" maxlength="60"/></td>  
</tr>
<tr class="colorcell">
  <td><b>A7. Comune (S05):</b></td>
  <td><b>A8. Nazione (S04):</b></td>
</tr>
<tr>
  <td><input type="text" class="layout" readonly  name="a7" id="a7" value="<%=SinDetails.getA7()%>" size="80" maxlength="60"/></td>
  <td><input type="text" class="layout" readonly  name="a8" id="a8" value="<%=SinDetails.getA8()%>" size="83" maxlength="60"/></td>  
</tr>
<tr class="colorcell">
  <td><b>A9. Ragione sociale (S19):</b></td>
  <td><b>A10. Data del prelievo (S28-30):</b></td>
</tr>
<tr>
  <td><input type="text" class="layout" readonly  name="a9" id="a9" value="<%=SinDetails.getA9() %>" size="80" maxlength="60"/></td>
  <td><input type="text" class="layout" readonly   name="a10" id="a10" value="<%=SinDetails.getA10()%>" size="83" maxlength="60"/></td>  
</tr>
<tr class="colorcell">
  <td colspan="2"><b>A11. Localizzazione geografica del punto di prelievo (GPS - Formato decimale):</b></td>
</tr>
<tr>
  <td>Latitudine: <input type="text" class="editNoBottom"  name="a11_1" id="a11_1" value="<%= (SinDetails.getA11_1() != null && !(SinDetails.getA11_1().equals(""))) ? SinDetails.getA11_1() : "" %>" size="60" maxlength="60"/></td>
  <td>Longitudine: <input type="text" class="editNoBottom"  name="a11_2" id="a11_2" value="<%= (SinDetails.getA11_2() != null && !(SinDetails.getA11_2().equals(""))) ? SinDetails.getA11_2() : "" %>" size="60" maxlength="60"/></td>  
</tr>
<tr class="colorcell">
  <td><b>A12. Codice identificativo del campione (S13):</b></td>
  <td><b>A13. Numero di aliquote in cui � suddiviso il campione:</b></td>
</tr>
<tr>
  <td><input type="text" class="layout" readonly  name="a12" id="a12" value="<%=SinDetails.getA12()%>" size="80" maxlength="60"/></td>
  <td><input type="text" class="editNoBottom"  name="a13" id="a13" value="<%= (SinDetails.getA13() != null && !(SinDetails.getA13().equals(""))) ? SinDetails.getA13() : "" %>" size="83" maxlength="60" onkeydown="return onKeyNumeric(event);" /></td>  
</tr>
<tr class="colorcell">
  <td><b>A14. Codice scheda di prelievo</b></td>
  <td><b>A15. Riferimento N.verbale</b></td>
</tr>
<tr>
  <td><input type="text" class="layout" readonly  name="a14" id="a14" value="<%=SinDetails.getA14()%>" size="80" maxlength="60"/></td>
  <td><input type="text" class="layout" readonly  name="a15" id="a15" value="<%=SinDetails.getA15()%>" size="83" maxlength="60"/></td>  
</tr>
</table>

<div style="height: 150px;">&nbsp;</div>
<p >Data di elaborazione
  <input type="text" class="layout" readonly  name="data" id="data" value="<%=SinDetails.getData()%>" size="15" maxlength="15"/>
</p>

<div class="fine" style="height: 150px;">&nbsp;</div>
Mod. C2: Scheda di accompagnamento campioni<br>
(contaminanti ambientali in alimenti di origine animale prodotti nelle aree oggetto di emergenze ambientali)</i>
&nbsp;
&nbsp;
&nbsp;
&nbsp;
Scheda N.<input type="text" class="layout" readonly name="a14" id="a14" value="<%=SinDetails.getA14()%>" size="10" maxlength="10"/>

<h2>B. INFORMAZIONI SUI CAMPIONI PRELEVATI:</h4>
<H3>ALIMENTO ZOOTECNICO</H3>
<h4>Dati relativi al campione prelevato:</h2>
<table border="0">
<tr class="colorcell">
  <td colspan="2"><b>B1. Destinazione dell'alimento prelevato:</b></td>
</tr>
<tr>
  <td><input type="radio" id="b1" name="b1" value="0" <%=(SinDetails.isB1_1()) ? ("checked=\"checked\"") : ("") %>>Latte destinato autoconsumo</td>
</tr>
<tr>
  <td><input type="radio" id="b1" name="b1" value="1" <%=(SinDetails.isB1_2()) ? ("checked=\"checked\"") : ("") %>>Latte destinato alla vendita</td>
</tr>
<tr class="colorcell">
  <td colspan="2"><b>B2. Specie animale da cui proviene l'alimento:</b></td>
</tr>
<tr>
  <td><input type="radio" id="b2" name="b2" value="0" <%=(SinDetails.isB2_1()) ? ("checked=\"checked\"") : ("") %>>Ovina</td>
</tr>
<tr>
  <td><input type="radio" id="b2" name="b2" value="1" <%=(SinDetails.isB2_2()) ? ("checked=\"checked\"") : ("") %>>Caprina</td>
</tr>
<tr>
  <td><input type="radio" id="b2" name="b2" value="2" <%=(SinDetails.isB2_3()) ? ("checked=\"checked\"") : ("") %>>Bovina</td>
</tr>
<tr>
  <td><input type="radio" id="b2" name="b2" value="3" <%=(SinDetails.isB2_4()) ? ("checked=\"checked\"") : ("") %>>Bufalina</td>
</tr>
<tr class="colorcell">
  <td colspan="2"><b>B3. Tipo di stabulazione</b></td>
</tr>
<tr>
  <td><input type="radio" id="b3" name="b3" value="0" <%=(SinDetails.isB3_1()) ? ("checked=\"checked\"") : ("") %>>Pascolo tutto l'anno</td>
</tr>
<tr>
  <td><input type="radio" id="b3" name="b3" value="1" <%=(SinDetails.isB3_2()) ? ("checked=\"checked\"") : ("") %>>Pascolo primavera</td>
</tr>
<tr>
  <td><input type="radio" id="b3" name="b3" value="2" <%=(SinDetails.isB3_3()) ? ("checked=\"checked\"") : ("") %>>Pascolo estate</td>
</tr>
<tr>
  <td><input type="radio" id="b3" name="b3" value="3" <%=(SinDetails.isB3_4()) ? ("checked=\"checked\"") : ("") %>>Stabulati al chiuso, alimentati con foraggi prodotti nel SIN</td>
</tr>
<tr class="colorcell">
  <td><b>B4. Alimenti somministrati:</b></td>
</tr>
  <table cellspacing="1" cellpadding="5" border="1">
    <tr>
      <th rowspan="2">Descrizione alimento
      <th rowspan="2">Kg/capo/die
      <th colspan="2">Periodo di somministrazione</th>
      <th colspan="2">Produzione locale</th>  
   </tr>
   <tr>
      <th>dal gg/mm/aaaa</th>
      <th>al gg/mm/aaaa</th>
      <th>SI</td>
      <th>NO</td>    
    </tr>  
    <tr>
      <th><input type="text" class="editNoBottom"  name="b4_1_1" id="b4_1_1" value="<%=SinDetails.getB4_1_1()%>" size="30" maxlength="30"/></th>
      <th><input type="text" class="editNoBottom"  name="b4_1_2" id="b4_1_2" value="<%=SinDetails.getB4_1_2()%>" size="30" maxlength="30"/></th>
      <th><input type="text" class="editNoBottom"  name="b4_1_3" id="b4_1_3" value="<%=SinDetails.getB4_1_3()%>" maxlength="30"/></th>
      <th><input type="text" class="editNoBottom"  name="b4_1_4" id="b4_1_4" value="<%=SinDetails.getB4_1_4()%>" size="30" maxlength="30"/></th>
      <th><input type="radio" name="b4_1_5" id="b4_1_5" value="0" <%=(SinDetails.isB4_1_5_1()) ? ("checked=\"checked\"") : ("") %>/></th>
      <th><input type="radio" name="b4_1_5" id="b4_1_5" value="1" <%=(SinDetails.isB4_1_5_2()) ? ("checked=\"checked\"") : ("") %>/></th>    
    </tr>  
    <tr>
      <th><input type="text" class="editNoBottom"  name="b4_2_1" id="b4_2_1" value="<%=SinDetails.getB4_2_1()%>" size="30" maxlength="30"/></th>
      <th><input type="text" class="editNoBottom"  name="b4_2_2" id="b4_2_2" value="<%=SinDetails.getB4_2_2()%>" size="30" maxlength="30"/></th>
      <th><input type="text" class="editNoBottom"  name="b4_2_3" id="b4_2_3" value="<%=SinDetails.getB4_2_3()%>" size="30" maxlength="30"/></th>
      <th><input type="text" class="editNoBottom"  name="b4_2_4" id="b4_2_4" value="<%=SinDetails.getB4_2_4()%>" size="30" maxlength="30"/></th>
      <th><input type="radio" name="b4_2_5" id="b4_2_5" value="0" <%=(SinDetails.isB4_2_5_1()) ? ("checked=\"checked\"") : ("") %>/></th>
      <th><input type="radio" name="b4_2_5" id="b4_2_5" value="1" <%=(SinDetails.isB4_2_5_2()) ? ("checked=\"checked\"") : ("") %>/></th>      
    </tr>  
    <tr>
     <th><input type="text" class="editNoBottom"  name="b4_3_1" id="b4_3_1" value="<%=SinDetails.getB4_3_1()%>" size="30" maxlength="30"/></th>
      <th><input type="text" class="editNoBottom"  name="b4_3_2" id="b4_3_2" value="<%=SinDetails.getB4_3_2()%>" size="30" maxlength="30"/></th>
      <th><input type="text" class="editNoBottom"  name="b4_3_3" id="b4_3_3" value="<%=SinDetails.getB4_3_3()%>" size="30" maxlength="30"/></th>
      <th><input type="text" class="editNoBottom"  name="b4_3_4" id="b4_3_4" value="<%=SinDetails.getB4_3_4()%>" size="30" maxlength="30"/></th>
      <th><input type="radio" name="b4_3_5" id="b4_3_5" value="0" <%=(SinDetails.isB4_3_5_1()) ? ("checked=\"checked\"") : ("") %>/></th>
      <th><input type="radio" name="b4_3_5" id="b4_3_5" value="1" <%=(SinDetails.isB4_3_5_2()) ? ("checked=\"checked\"") : ("") %>/></th>    
    </tr>  
    <tr>
     <th><input type="text" class="editNoBottom"  name="b4_4_1" id="b4_4_1" value="<%=SinDetails.getB4_4_1()%>" size="30" maxlength="30"/></th>
      <th><input type="text" class="editNoBottom"  name="b4_4_2" id="b4_4_2" value="<%=SinDetails.getB4_4_2()%>" size="30" maxlength="30"/></th>
      <th><input type="text" class="editNoBottom"  name="b4_4_3" id="b4_4_3" value="<%=SinDetails.getB4_4_3()%>" size="30" maxlength="30"/></th>
      <th><input type="text" class="editNoBottom"  name="b4_4_4" id="b4_4_4" value="<%=SinDetails.getB4_4_4()%>" size="30" maxlength="30"/></th>
      <th><input type="radio" name="b4_4_5" id="b4_4_5" value="0" <%=(SinDetails.isB4_4_5_1()) ? ("checked=\"checked\"") : ("") %>/></th>
      <th><input type="radio" name="b4_4_5" id="b4_4_5" value="1" <%=(SinDetails.isB4_4_5_2()) ? ("checked=\"checked\"") : ("") %>/></th>    
    </tr>  
    <tr>
      <th><input type="text" class="editNoBottom"  name="b4_5_1" id="b4_5_1" value="<%=SinDetails.getB4_5_1()%>" size="30" maxlength="30"/></th>
      <th><input type="text" class="editNoBottom"  name="b4_5_2" id="b4_5_2" value="<%=SinDetails.getB4_5_2()%>" size="30" maxlength="30"/></th>
      <th><input type="text" class="editNoBottom"  name="b4_5_3" id="b4_5_3" value="<%=SinDetails.getB4_5_3()%>" size="30" maxlength="30"/></th>
      <th><input type="text" class="editNoBottom"  name="b4_5_4" id="b4_5_4" value="<%=SinDetails.getB4_5_4()%>" size="30" maxlength="30"/></th>
      <th><input type="radio" name="b4_5_5" id="b4_5_5" value="0" <%=(SinDetails.isB4_5_5_1()) ? ("checked=\"checked\"") : ("") %>/></th>
      <th><input type="radio" name="b4_5_5" id="b4_5_5" value="1" <%=(SinDetails.isB4_5_5_2()) ? ("checked=\"checked\"") : ("") %>/></th>     
    </tr>  
    <tr>
     <th><input type="text" class="editNoBottom"  name="b4_6_1" id="b4_6_1" value="<%=SinDetails.getB4_6_1()%>" size="30" maxlength="30"/></th>
      <th><input type="text" class="editNoBottom"  name="b4_6_2" id="b4_6_2" value="<%=SinDetails.getB4_6_2()%>" size="30" maxlength="30"/></th>
      <th><input type="text" class="editNoBottom"  name="b4_6_3" id="b4_6_3" value="<%=SinDetails.getB4_6_3()%>" size="30" maxlength="30"/></th>
      <th><input type="text" class="editNoBottom"  name="b4_6_4" id="b4_6_4" value="<%=SinDetails.getB4_6_4()%>" size="30" maxlength="30"/></th>
      <th><input type="radio" name="b4_6_5" id="b4_6_5" value="0" <%=(SinDetails.isB4_6_5_1()) ? ("checked=\"checked\"") : ("") %>/></th>
      <th><input type="radio" name="b4_6_5" id="b4_6_5" value="1" <%=(SinDetails.isB4_6_5_2()) ? ("checked=\"checked\"") : ("") %>/></th>    
    </tr>  
    <tr>
      <th><input type="text" class="editNoBottom"  name="b4_7_1" id="b4_7_1" value="<%=SinDetails.getB4_7_1()%>" size="30" maxlength="30"/></th>
      <th><input type="text" class="editNoBottom"  name="b4_7_2" id="b4_7_2" value="<%=SinDetails.getB4_7_2()%>" size="30" maxlength="30"/></th>
      <th><input type="text" class="editNoBottom"  name="b4_7_3" id="b4_7_3" value="<%=SinDetails.getB4_7_3()%>" size="30" maxlength="30"/></th>
      <th><input type="text" class="editNoBottom"  name="b4_7_4" id="b4_7_4" value="<%=SinDetails.getB4_7_4()%>" size="30" maxlength="30"/></th>
      <th><input type="radio" name="b4_7_5" id="b4_7_5" value="0" <%=(SinDetails.isB4_7_5_1()) ? ("checked=\"checked\"") : ("") %>/></th>
      <th><input type="radio" name="b4_7_5" id="b4_7_5" value="1" <%=(SinDetails.isB4_7_5_2()) ? ("checked=\"checked\"") : ("") %>/></th>      
    </tr>  
  </table>
</table>

<div style="height: 150px;">&nbsp;</div>
<p style="border-style: solid;border-width:1px;">
  <br>
  Telefono del veterinario prelevatore <input type="text" class="editNoBottom" name="telefono" id="telefono" size="80" value="<%=SinDetails.getTelefono()%>"><br><br>
  Firma del prelevatore <input type="text" class="layout" readonly name="firma" id="firma" size="93" value="" >&nbsp;&nbsp;&nbsp;Timbro<br>
  <br>
  <br>
</p>

<p>Data di elaborazione
  <input type="text" class="layout" readonly name="data" id="data" value="<%=SinDetails.getData()%>" size="15" maxlength="15"/>
</p>
</form>
</body>


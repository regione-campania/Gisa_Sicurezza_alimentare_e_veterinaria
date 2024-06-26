

<%-- 
  - Copyright(c) 2004 Dark Horse Ventures LLC (http://www.centriccrm.com/) All
  - rights reserved. This material cannot be distributed without written
  - permission from Dark Horse Ventures LLC. Permission to use, copy, and modify
  - this material for internal use is hereby granted, provided that the above
  - copyright notice and this permission notice appear in all copies. DARK HORSE
  - VENTURES LLC MAKES NO REPRESENTATIONS AND EXTENDS NO WARRANTIES, EXPRESS OR
  - IMPLIED, WITH RESPECT TO THE SOFTWARE, INCLUDING, BUT NOT LIMITED TO, THE
  - IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR ANY PARTICULAR
  - PURPOSE, AND THE WARRANTY AGAINST INFRINGEMENT OF PATENTS OR OTHER
  - INTELLECTUAL PROPERTY RIGHTS. THE SOFTWARE IS PROVIDED "AS IS", AND IN NO
  - EVENT SHALL DARK HORSE VENTURES LLC OR ANY OF ITS AFFILIATES BE LIABLE FOR
  - ANY DAMAGES, INCLUDING ANY LOST PROFITS OR OTHER INCIDENTAL OR CONSEQUENTIAL
  - DAMAGES RELATING TO THE SOFTWARE.
  - 
  - Version: $Id: accounts_search.jsp 18543 2007-01-17 02:55:07Z matt $
  - Description: 
  --%> 
  
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="org.aspcfs.modules.base.Constants,org.aspcfs.utils.web.*" %>
<jsp:useBean id="SearchOpuListInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="SiteList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="ListaStati" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="tipoRicerca" class="org.aspcfs.utils.web.LookupList" scope="request"/>

<script src="javascript/aggiuntaCampiEstesiScia.js"></script>
	<jsp:useBean id="normeList" class="org.aspcfs.utils.web.LookupList"
	scope="request" /> 
<%@ include file="../utils23/initPage.jsp" %>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popLookupSelect.js"></script>
  <link href="css/tooltip.css" rel="stylesheet" type="text/css" />
<script src="javascript/tooltip.js" type="text/javascript"></script>
        <script type="text/javascript" src="dwr/engine.js"> </script>
        <script type="text/javascript" src="dwr/util.js"></script>
    <script language="JavaScript" TYPE="text/javascript" SRC="dwr/interface/SuapDwr.js"> </script>
<SCRIPT src="javascript/suapUtil.js"></SCRIPT>    
<script type="text/javascript" src="dwr/interface/PopolaCombo.js"> </script>
<script type="text/javascript" src="javascript/tabber.js"></script>

<link href="css/nonconformita.css" rel="stylesheet" type="text/css" />

<!-- RIMUOVERE APICI DA PARTITA IVA INCOLLATO -->
<script>
$(document).ready(
function pulisciPiva() {
	var piva  = document.getElementById('searchpartitaIva'),
    cleanPiva;
	cleanPiva= function(e) {
    e.preventDefault();
    var pastedText = '';
    if (window.clipboardData && window.clipboardData.getData) { // IE
        pastedText = window.clipboardData.getData('Text');
      } else if (e.clipboardData && e.clipboardData.getData) {
        pastedText = e.clipboardData.getData('text/plain');
      }
    var piva_gestito = pastedText;
    piva_gestito = piva_gestito.split('"').join(''); //rimozione apici
    piva_gestito = piva_gestito.split(' ').join(''); //rimozione spazi
    piva.value = piva_gestito;
};

piva.onpaste = cleanPiva;
	});</script>
	<!-- RIMUOVERE APICI DA PARTITA IVA INCOLLATO -->
    
   <script>
//    function getValoriComboNorme(valore)
//    {
// 	   PopolaCombo.getValoriComboNorme(valore,getValoriComboNormeCallback);
//    }
   
//    function getValoriComboNormeCallback(returnValue)
//    {
// 	   var select = document.getElementById("searchcodeIdNorma");
	   
// 	 //Azzero il contenuto della seconda select
// 	     for (var i = select.length - 1; i >= 0; i--)
// 	   	  select.remove(i);

	 
	   
         
// 	   var  indici = returnValue [0];
// 	    var valori = returnValue [1];
// 	     //Popolo la seconda Select
	    
	     
// 	    	  var NewOpt = document.createElement('option');
// 	          NewOpt.value = -1; // Imposto il valore
// 	     	 	NewOpt.text = '--SELEZIONA NORMA--'; // Imposto il testo
// 	          	NewOpt.title = valori[i];
// 	          //Aggiungo l'elemento option
// 	          try
// 	          {
// 	        	  	select.add(NewOpt, null); //Metodo Standard, non funziona con IE
// 	          }catch(e){
// 	        	  select.add(NewOpt); // Funziona solo con IE
// 	          }
	      
// 	     if (indici.length>0)
// 	     {
// 	     for(j =0 ; j<indici.length; j++){
// 	     //Creo il nuovo elemento OPTION da aggiungere nella seconda SELECT
// 	     var NewOpt = document.createElement('option');
// 	     NewOpt.value = indici[j]; // Imposto il valore
// 	     if(valori[j] != null)
// 	     	NewOpt.text = valori[j]; // Imposto il testo
// 	     	NewOpt.title = valori[j];
// 	     //Aggiungo l'elemento option
// 	     try
// 	     {
// 	   	  	select.add(NewOpt, null); //Metodo Standard, non funziona con IE
// 	     }catch(e){
// 	   	  select.add(NewOpt); // Funziona solo con IE
// 	     }
// 	     }
// 	     }

	   
//    }
   function clearForm(form){
	   var inp = form.getElementsByTagName('input');
	   for(var i in inp){
	       if(inp[i].type == "text"){
	           inp[i].value='';
	       }
	   }
	   var asl = form.searchcodeidAsl;
	   asl.value="-1";
	   
	   var stato = form.searchcodeidStato;
	   stato.value="-1";
	   
	   var sel = form.getElementsByTagName('select');
	   for(var i in sel){
	           sel[i].value='';
	   }
   }
   
   function checkForm(form){
// 	   var linea1 = form.searchattivita1.value;
// 	   var linea2 = form.searchattivita2.value;
// 	   var linea3 =form.searchattivita3.value;
// 	   var searchAttivita = form.searchattivita;
	   
// 	   var linea = "";
	   
// 	   if (linea1!=''){
// 		   linea = linea1;
// 		   if (linea2!=''){
// 			   linea = linea + "->"+linea2;
// 			   if (linea3!='')
// 				   linea = linea + "->"+linea3;
// 		   }
			   
// 	   }
// 	   if (linea!='')
// 		   searchAttivita.value = linea;
	   
	  
	   
// 	   var valorizzati = 0;
// 	   var inp = document.getElementsByTagName('input');
// 	   for(var i in inp){
// 	       if(inp[i].type == "text"){
// 	    	   if (inp[i].value !='' && inp[i].value.length>2)
// 	    		   valorizzati++;
// 	       }
// 	   }
	   
// 	   var asl = document.getElementById("searchcodeidAsl");
// 	   if (asl.value!='-1')
// 			valorizzati++;	   
	   
// 	   var stato = document.getElementById("searchcodeidStato");
// 	   if (stato.value!='-1')
// 			valorizzati++;	  
	   
	   
	   var idLinea = document.getElementsByName("idLineaProduttiva")[0].value;
	   if (idLinea!=null && idLinea!='') {
	   		document.getElementById("searchcodeidAttivita").value = idLinea;
	   }
	   else {
		   var attivita = document.getElementsByName("searchAttivita")[1].value;
		   if (attivita.trim() == ''){
			   var macroarea = document.getElementsByName("idMacroarea")[0].selectedOptions[0].text;
			   var aggregazione = document.getElementsByName("idAggregazione")[0].selectedOptions[0].text;
			   var linea = document.getElementsByName("idLineaProduttiva")[0].selectedOptions[0].text;
			   document.getElementsByName("searchAttivita")[1].value=macroarea.replace(/ /g, '%')+"%"+aggregazione.replace(/ /g, '%')+"%"+linea.replace(/ /g, '%');
		   }
	   }
	   
	 	loadModalWindow();
	   	form.submit();
   }
   
   
   function gestisciTipoAttivita(field){
	  
	   if(field.checked && field.value=='2')
		   {
		   document.getElementById("searchtargadiv").style.display="";
		   document.getElementById("tipoAttivita_fissa").checked=false;

		   }
	   else
		   {
		   document.getElementById("searchtargadiv").style.display="none";
		   document.getElementById("tipoAttivita_mobile").checked=false;

		   }
   }
   
  

   function setStatoCu(stato,form)
   {
	   form.searchstatoCu.value = stato;
   }
  function abilitaRicercaAllerte(form)
  {
	  
	  if (form.flagAllerte.checked)
		{
			document.getElementById("bloccoAllerte").style.display="block";
			form.searchcodiceAllerta.value = "Tutte";
			document.getElementById("nuova").click();
			
		}
		else
		{
			document.getElementById("bloccoAllerte").style.display="none";
			form.searchcodiceAllerta.value = "";
		}
      
  }

  function popLookupSelectorAllertaRicerca(displayFieldId, displayFieldId2, table, params) {
	  title  = '_types';
	  width  =  '600';
	  height =  '550';
	  resize =  'yes';
	  bars   =  'no';
	  
	  var posx = (screen.width - width)/2;
	  var posy = (screen.height - height)/2;
	  
	  var windowParams = 'WIDTH=' + width + ',HEIGHT=' + height + ',RESIZABLE=' + resize + ',SCROLLBARS=' + bars + ',STATUS=0,LEFT=' + posx + ',TOP=' + posy + 'screenX=' + posx + ',screenY=' + posy;
	  var newwin=window.open('LookupSelector.do?command=PopupSelectorAllertaRicercaImprese&displayFieldId=' + displayFieldId + '&displayFieldId2=' + displayFieldId2 + '&table=' + table + params, title, windowParams+'&filtroDesc=700');
	  newwin.focus();

	  if (newwin != null) {
	    if (newwin.opener == null)
	      newwin.opener = self;
	  }
	}
  
  
  <% String revString = request.getParameter("rev");
  int rev = 11;
     if (revString!=null)
	 	 rev = Integer.parseInt(revString);
  %>
  
  function ricarica(select){
	  
	  if (confirm("Attenzione. Modificare la revisione della master list causera' il ricaricamento della pagina. Proseguire?")){
			  window.location.href='OpuStab.do?command=SearchForm&rev='+select.value;
		} 
	  else {
		  select.value= <%=rev%>;
	  }
			  
	  
  }
   </script>     

<dhv:permission name="opu_digemon-view">
<%@ include file="digemon_osa_non_controllati.jsp" %>
</dhv:permission>

<%-- Trails --%>

<table class="trails" cellspacing="0">
<tr>
<td>
<a href="OpuStab.do?command=SearchForm"><dhv:label name="">Anagrafica stabilimenti</dhv:label></a> >
Ricerca
</td>
</tr>
</table>
<%-- End Trails --%>




<div class="tabber">
	<div class="tabbertab">
	<h2>Ricerca Rapida</h2>
	<form name="searchAccount1" id = "searchAccount1" action="RicercaUnica.do?command=Search" method="post">
	<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
        <tr>
          <th colspan="2">
            <strong><dhv:label name="">Ricerca Rapida</dhv:label></strong>
          </th>
        </tr>
        
        <tr>
        	<td nowrap class="formLabel" >
     		 <dhv:label name="">NORMA DI RIFERIMENTO / TIPOLOGIA</dhv:label>
   			 </td> 
    		<td> 
    		<%=normeList.getHtmlSelect("searchcodeIdNorma", -1) %>
 </td>
 </tr>
  <tr>
        	<td nowrap class="formLabel" >
     		 <dhv:label name="">CERCA IN</dhv:label>
   			 </td> 
    		<td> 
    		<%=tipoRicerca.getHtmlSelect("searchcodetipoRicerca", -1) %>
 </td>
 </tr>
 
 
   <tr id="asl">
        	<td nowrap class="formLabel">
     		 <dhv:label name="">ASL</dhv:label>
   			 </td> 
    		<td> 
				
	    <dhv:evaluate if="<%= User.getSiteId() == -1 %>" >
          <%= SiteList.getHtmlSelect("searchcodeidAsl",-1) %>
        </dhv:evaluate>
        <dhv:evaluate if="<%= User.getSiteId() != -1 %>" >
           <%= SiteList.getSelectedValue(User.getSiteId()) %>
          <input type="hidden" name="searchcodeidAsl" id="searchcodeidAsl" value="<%=User.getSiteId()%>" >
          
        </dhv:evaluate>
    
			</td>
  		</tr> 
  		
  		 <tr id="tr_stato">
        	<td nowrap class="formLabel">
     		 <dhv:label name="">Stato</dhv:label>
   			 </td> 
    		<td> 
				   <%= ListaStati.getHtmlSelect("searchcodeidStato",0) %> <img title="<%="In generale lo stato dello stabilimento si considera attivo se e' attiva almeno una delle sue linee. L'unica eccezione puo' presentarsi per gli stabilimenti gestiti da Sintesis in cui la coerenza tra 'stato delle linee' e 'stato dello stabilimento' non e' garantita.".toUpperCase() %>" class="masterTooltip" src="images/questionmark.png" width="20"/>
			</td>
  		</tr>
  		
  		
  <tr>
          <td class="formLabel">
            <dhv:label name="lab.denom">Nome/Ditta/Ragione sociale</dhv:label>
          </td>
          <td>
            <input type="text" maxlength="70" size="50" name="searchragioneSociale" id="searchRagioneSociale" value="">
          </td>
        </tr>
        
         <tr>
        	<td nowrap class="formLabel">
     		 Partita IVA
   			 </td> 
    		<td> 
				<input  type="text" maxlength="11" size="50" name="searchpartitaIva"  id="searchpartitaIva" value="">
			</td>
  		</tr>
  		
<!--   		 <tr id='targa_tr'> -->
<!--         	<td nowrap class="formLabel"> -->
<%--      		 <dhv:label name="">Targa</dhv:label> --%>
<!--    			 </td>  -->
<!--     		<td>  -->
<!-- 				<input  type="text" maxlength="15" size="50" name="searchtarga" value=""> -->
<!-- 			</td> -->
<!--   		</tr> -->
  <tr>
        	<td nowrap class="formLabel" >
     		 <dhv:label name="">Descrizione Linea</dhv:label>
   			 </td> 
    		<td> 
    		<input type="text" name="searchAttivita" style="width: 35%">
    		
    		<img title="<%="INDICARE LA DESCRIZIONE DELLA LINEA DI ATTIVITA. ESEMPIO : (COMMERCIO CARNE)".toUpperCase() %>" class="masterTooltip" src="images/questionmark.png" width="20"/>
 </td>
 </tr>
 </table>
 <input type="button" id="search" name="search" value="Ricerca" onClick="checkForm(document.forms['searchAccount1']);"/>
 <%
if (User.getRoleId()!=Role.RUOLO_COMUNE)
{
%> 
<input type="button" value="<dhv:label name="button.clear">Clear</dhv:label>" onClick="clearForm(document.forms['searchAccount1']);">

<%} %>
<input type="hidden" name="source" value="searchForm">
        </form>
	
	</div>
 
  <div class="tabbertab">
	<h2>Ricerca Avanzata</h2>
    
<!--  IMPRESA -->
<form name="searchAccount2" id = "searchAccount2" action="RicercaUnica.do?command=Search" method="post">


		<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details" id="linee">    
    <tr>
          <th colspan="2">
            <strong><dhv:label name="">Ricerca Per Norma di Riferimento / Descrizione attivit�</dhv:label></strong>
          </th>
        </tr>
<!--  <tr> -->
<!--         	<td nowrap class="formLabel" > -->
<%--      		 <dhv:label name="">NORMA</dhv:label> --%>
<!--    			 </td>  -->
<!--     		<td>  -->
<%--     		<%=normeList.getHtmlSelect("searchcodeIdNorma", -1) %> --%>
<!--  </td> -->
<!--  </tr> -->
 
 <tr>
 <td nowrap class="formLabel" >
     		 <dhv:label name="">Linea Attivit�</dhv:label>
   			 </td> 
    		<td> 
    		
    		Versione Master List
    		<select onChange="ricarica(this)">
    		<option value="8" <% if (rev==8) {%> selected <% } %>>8</option>
    		<option value="10" <% if (rev==10) {%> selected <% } %>>10</option>
    		<option value="11" <% if (rev==11) {%> selected <% } %>>11</option>
    		</select>
    		
<jsp:include page="../gestioneml/navigaml.jsp">
<jsp:param name="rev" value="<%=rev %>" />
</jsp:include>

<input type="hidden" id="searchcodeidAttivita" name="searchcodeidAttivita" value=""/>

   		
    		<img title="ATTENZIONE A NON INSERIRE VALORI DISCORDANTI CON IL FILTRO 'DESCRIZIONE ATTIVITA'" class="masterTooltip" src="images/questionmark.png" width="20"/>
 </td>
 </tr>
 
  <tr>
        	<td nowrap class="formLabel" >
     		 <dhv:label name="">Descrizione Attivit�</dhv:label>
   			 </td> 
    		<td> 
    
    		<input type="text" name="searchAttivita" style="width: 35%">
    		
    		<img title="<%="INDICARE LA DESCRIZIONE DELLA LINEA DI ATTIVITA. ESEMPIO : (COMMERCIO CARNE)".toUpperCase() %>" class="masterTooltip" src="images/questionmark.png" width="20"/>
 </td>
 </tr>
 <tr>
        	<td nowrap class="formLabel" >
     		 <dhv:label name="">CERCA IN</dhv:label>
   			 </td> 
    		<td> 
    		<%=tipoRicerca.getHtmlSelect("searchcodetipoRicerca", -1) %>
 </td>
 </tr>
 	<tr id="tr_riconoscimento">
        	<td nowrap class="formLabel">
     		 <dhv:label name="">Numero<br/>riconoscimento/<br>CUN/<br>Codice azienda</dhv:label>
   			 </td> 
    		<td> 
				<input  type="text"  maxlength="50" size="50" name="searchnumeroRiconoscimento" placeholder="">
			</td>
  		</tr> 
 
 <tr id="tr_tipo_master_list">
        	<td nowrap class="formLabel">
     		 <dhv:label name="">Tipo linea</dhv:label>
   			 </td> 
    		<td> 
			<input type="radio" id="tipoLinea_tutti" name="searchcodeidTipoLineaProduttiva" value="-1" checked/> Tutte
			<input type="radio" id="tipoLinea_reg" name="searchcodeidTipoLineaProduttiva" value="1"/> Registrabili
			<input type="radio" id="tipoLinea_ric" name="searchcodeidTipoLineaProduttiva" value="2"/> Riconosciute

			</td>
  		</tr> 
  		
 
 </table>	
	
      <table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
        <tr>
          <th colspan="2">
            <strong><dhv:label name="">Ricerca Per Impresa</dhv:label></strong>
          </th>
        </tr>
         
        <tr>
          <td class="formLabel">
            <dhv:label name="lab.denom">Nome/Ditta/Ragione sociale</dhv:label>
          </td>
          <td>
            <input type="text" maxlength="70" size="50" name="searchragioneSociale" id="searchRagioneSociale" value="">
          </td>
        </tr>
        
         <tr>
        	<td nowrap class="formLabel">
     		 Partita IVA
   			 </td> 
    		<td> 
				<input  type="text" maxlength="11" size="50" name="searchpartitaIva" value="">
			</td>
  		</tr>
  		 <tr>
        	<td nowrap class="formLabel">
     		 Codice Fiscale
   			 </td> 
    		<td> 
				<input  type="text" maxlength="16" size="50" name="searchcodiceFiscale"  id="searchcodiceFiscale" value="">
			</td>
  		</tr>
  		
 </table>
 
 <!--  STABILIMENTO -->
  <table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">    
    <tr>
          <th colspan="2">
            <strong><dhv:label name="">Ricerca Per Stabilimento (Sede Operativa)</dhv:label></strong>
          </th>
        </tr>
        
         <tr id="asl">
        	<td nowrap class="formLabel">
     		 <dhv:label name="">ASL</dhv:label>
   			 </td> 
    		<td> 
				
	    <dhv:evaluate if="<%= User.getSiteId() == -1 %>" >
          <%= SiteList.getHtmlSelect("searchcodeidAsl",-1) %>
        </dhv:evaluate>
        <dhv:evaluate if="<%= User.getSiteId() != -1 %>" >
           <%= SiteList.getSelectedValue(User.getSiteId()) %>
          <input type="hidden" name="searchcodeidAsl" id="searchcodeidAsl" value="<%=User.getSiteId()%>" >
        </dhv:evaluate>
    
			</td>
  		</tr> 
  		
           <tr>
        	<td nowrap class="formLabel">
     		 <dhv:label name="">Comune</dhv:label>
   			 </td> 
    		<td> 
				<input  type="text" maxlength="50" size="50" name="searchcomuneSedeProduttiva">
			</td>
  		</tr> 
  		
  		   <tr>
        	<td nowrap class="formLabel">
     		 <dhv:label name="">Via/Piazza</dhv:label>
   			 </td> 
    		<td> 
				<input  type="text" maxlength="50" size="50" name="searchindirizzoSedeProduttiva" value="">
			</td>
  		</tr> 
  		
  		
        <tr>
        	<td nowrap class="formLabel" >
     		 <dhv:label name="">Numero <br/>Registrazione</dhv:label>
   			 </td> 
    		<td> 
				<input  type="text" maxlength="50" size="50" name="searchnumeroRegistrazione" value="">
			</td>
  		</tr>
  
 <tr id="tr_stato">
        	<td nowrap class="formLabel">
     		 <dhv:label name="">Stato</dhv:label>
   			 </td> 
    		<td> 
				   <%= ListaStati.getHtmlSelect("searchcodeidStato",0) %>     		<img title="<%="In generale lo stato dello stabilimento si considera attivo se e' attiva almeno una delle sue linee. L'unica eccezione puo' presentarsi per gli stabilimenti gestiti da Sintesis in cui la coerenza tra 'stato delle linee' e 'stato dello stabilimento' non e' garantita.".toUpperCase() %>" class="masterTooltip" src="images/questionmark.png" width="20"/>
				   
			</td>
  		</tr>
  			  				
 </table>
 
 
 <!--  STABILIMENTO -->
  <table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">    
    <tr>
          <th colspan="2">
            <strong><dhv:label name="">Ricerca Per Altri Campi</dhv:label></strong>
          </th>
          
          <% boolean isHd = false; %>
          <dhv:permission name="schede_centralizzate-view">
          <%isHd= true;%>
          </dhv:permission>
          
           <tr id='fisse_tr' <%=(!isHd) ? "style=\"display:none\"" : "" %>>
        	<td nowrap class="formLabel">
     		 <dhv:label name="">Solo Attivit� Fisse</dhv:label> 
   			 </td> 
    		<td> 
    			<input type="checkbox" id="tipoAttivita_fissa" name="searchcodetipoAttivita" value="1" onClick="gestisciTipoAttivita(this)"/> <b><font size="1px">SOLO HD</font></b>
    			</td>
  		</tr>
 	
  		 <tr id='targa_tr'>
        	<td nowrap class="formLabel">
     		 <dhv:label name="">Solo Attivit� Mobili</dhv:label>
   			 </td> 
    		<td> 
    			<input type="checkbox" id="tipoAttivita_mobile" name="searchcodetipoAttivita" value="2" onClick="gestisciTipoAttivita(this)"/>
    			<img title="<%="IL FILTRO PER ASL NON VERR� APPLICATO ALLE IMBARCAZIONI E STABILIMENTI MOBILI".toUpperCase() %>" class="masterTooltip" src="images/questionmark.png" width="20"/>
    			 
				<div id = "searchtargadiv" style="display: none">
				<input placeholder="CERCA TARGA"  type="text" maxlength="15" size="50" name="searchtarga" id = "searchtarga" value=""> </div>
			</td>
  		</tr>
  		
  		 <tr>
        	<td nowrap class="formLabel">
     		 <dhv:label name="">MATRICOLA/NUMERO IDENTIFICATIVO SCARRABILE</dhv:label>
   			 </td> 
    		<td> 
    			<input placeholder="CERCA MATRICOLA"  type="text" maxlength="15" size="50" name="searchmatricola" id = "searchmatricola" value="">
			</td>
  		</tr>
  		
  	 	<tr id="tr_allerta">
          <td nowrap class="formLabel">
            <dhv:label name="">Attivit� Assoggettate a Controlli per Allerta</dhv:label>
          </td>
          <td>
          <input type = "checkbox" name = "flagAllerte" onclick="abilitaRicercaAllerte(document.forms['searchAccount2'])">
          
          <div id = "bloccoAllerte" style = "display: none">
          
          		<input type="hidden" id="ticketid" value="-1" name="ticketidd">
           		<input style="background-color: lightgray" readonly="readonly" type="text" size="20"  id="id_allerta" name="searchcodiceAllerta"  value="" >
      			&nbsp;[<a href="#" onClick="popLookupSelectorAllertaRicerca('id_allerta','name','ticket','');return false;">Seleziona Allerta</a>]
     			<br>
     			Controlli Aperti <input type = "radio" name = "statoCu" onclick="setStatoCu('aperti',document.forms['searchAccount2'])" checked="checked"> Controlli chiusi <input type = "radio" name = "statoCu" onclick="setStatoCu('chiusi',document.forms['searchAccount2'])"> 
     			<input type = "hidden" id='searchstatoCu' name = "searchstatoCu" value = "aperti" >
     	</div>
       </td>
        </tr>
        
        
        <tr>
          <td nowrap class="formLabel">
            <dhv:label name="">Categoria di rischio</dhv:label>
          </td>
          <td>
          <select id="searchcodecategoriaRischio" name="searchcodecategoriaRischio">
          <option value="-1">TUTTE</option>
          <%for (int i = 0; i<6; i++) { %>
          <option value="<%=i%>"><%=i %></option>
          <%} %>
          </select>
       </td>
        </tr>
        
        
 </table>
  		
  		
   	
   		
   
 <!--  RAPPRESENTANTE LEGALE -->
  <table cellpadding="4" cellspacing="0" border="0" width="100%" class="details"> 
    <tr>
          <th colspan="2">
            <strong><dhv:label name="">Ricerca Per Legale rappresentante</dhv:label></strong>
          </th>
        </tr>
        
     
  		   <tr>
        	<td nowrap class="formLabel">
     		 <dhv:label name="">Nominativo </dhv:label>
   			 </td> 
    		<td> 
				<input  type="text" maxlength="50" size="50" name="searchnomeSoggettoFisico" value="">
			</td>
  		</tr>
  		
  			 <tr>
        	<td nowrap class="formLabel">
     		 <dhv:label name="">Codice Fiscale </dhv:label>
   			 </td> 
    		<td> 
				<input  type="text" maxlength="16" size="50" name="searchcodiceFiscaleSoggettoFisico" value="">
			</td>
  		</tr> 
 </table>
 <input type="button" id="search" name="search" value="Ricerca" onClick="checkForm(document.forms['searchAccount2']);"/>
 <%
if (User.getRoleId()!=Role.RUOLO_COMUNE)
{
%> 
<input type="button" value="<dhv:label name="button.clear">Clear</dhv:label>" onClick="clearForm(document.forms['searchAccount2']);">
<%} %>
<input type="hidden" name="source" value="searchForm">
  		</form>
  		 </div>
  
</div>


<iframe src="empty.html" name="server_commands" id="server_commands" style="visibility:hidden" height="0"></iframe>







 









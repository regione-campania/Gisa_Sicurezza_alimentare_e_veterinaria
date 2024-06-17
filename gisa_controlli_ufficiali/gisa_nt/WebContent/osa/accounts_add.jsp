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
  - Version: $Id: accounts_add.jsp 18488 2007-01-15 20:12:32Z matt $
  - Description:
  --%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*,java.text.DateFormat,org.aspcfs.modules.accounts.base.*,org.aspcfs.utils.web.*,org.aspcfs.modules.contacts.base.*" %>
<jsp:useBean id="SourceList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="StageList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="TipoStruttura" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="TipoLocale" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="IstatList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="Address" class="org.aspcfs.modules.requestor.base.OrganizationAddress" scope="request"/>
<jsp:useBean id="AddressSedeOperativa" class="org.aspcfs.modules.requestor.base.OrganizationAddress" scope="request"/>
<jsp:useBean id="AddressSedeMobile" class="org.aspcfs.modules.requestor.base.OrganizationAddress" scope="request"/>
<jsp:useBean id="AddressLocale1" class="org.aspcfs.modules.requestor.base.OrganizationAddress" scope="request"/>
<jsp:useBean id="AddressLocale2" class="org.aspcfs.modules.requestor.base.OrganizationAddress" scope="request"/>
<jsp:useBean id="AddressLocale3" class="org.aspcfs.modules.requestor.base.OrganizationAddress" scope="request"/>

<jsp:useBean id="rel_ateco_linea_attivita_List" class="org.aspcfs.utils.web.LookupList" scope="request"/>

<jsp:useBean id="TitoloList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="RatingList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="IndustryList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="OrgCategoriaRischioList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="OrgPhoneTypeList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="OrgAddressTypeList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="OrgEmailTypeList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="specieAnimali" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="tipoStabulatorio" class="org.aspcfs.utils.web.LookupList" scope="request"/>


<jsp:useBean id="AccountTypeList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="OrgDetails" class="org.aspcfs.modules.osa.base.Organization" scope="request"/>
<jsp:useBean id="StateSelect" class="org.aspcfs.utils.web.StateSelect" scope="request"/>
<jsp:useBean id="CountrySelect" class="org.aspcfs.utils.web.CountrySelect" scope="request"/>
<jsp:useBean id="AccountSizeList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SiteList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SalutationList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SegmentList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SICCodeList" class="org.aspcfs.modules.admin.base.SICCodeList" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="applicationPrefs" class="org.aspcfs.controller.ApplicationPrefs" scope="application"/>
<jsp:useBean id="TimeZoneSelect" class="org.aspcfs.utils.web.HtmlSelectTimeZone" scope="request"/>
<jsp:useBean id="systemStatus" class="org.aspcfs.controller.SystemStatus" scope="request"/>
<%@ include file="../utils23/initPage.jsp" %>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/checkDate.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/checkString.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/checkPhone.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/checkNumber.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/checkEmail.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popCalendar.js"></script>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popLookupSelect.js"></script>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popCheckList.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/spanDisplay.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/checkURL.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/setSalutation.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popCalendar.js"></script>

<script type="text/javascript" src="dwr/interface/PopolaCombo.js"> </script>
<script type="text/javascript" src="dwr/engine.js"> </script>
<script type="text/javascript" src="dwr/util.js"></script>
<!-- RELATIVO AL NUOVO CALENDARIO CON MESE E ANNO FACILMENTE MODIFICABILI -->
<SCRIPT LANGUAGE="JavaScript" SRC="javascript/CalendarPopup.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="javascript/common.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">document.write(getCalendarStyles());</SCRIPT>
<script type="text/javascript" src="dwr/interface/PopolaCombo.js"> </script>
<script type="text/javascript" src="dwr/engine.js"> </script>
<script type="text/javascript" src="dwr/util.js"></script>
<SCRIPT LANGUAGE="JavaScript" ID="js19">
	var cal19 = new CalendarPopup();
	cal19.showYearNavigation();
	cal19.showYearNavigationInput();
	cal19.showNavigationDropdowns();
</SCRIPT>
<script>
function mostraData(camponote,campoData,valStato)
{

if(valStato!='0'  )
{
	if (valStato!='3')
	{
		campoData.style.display='block';
		camponote.disabled = false;
	}
	else
	{
		camponote.disabled = true;
	}
}
else
{
	campoData.style.display='none';
	camponote.disabled = false;
}
}
function showCoordinate(address,city,prov,cap,campo_lat,campo_long)
	{
   campoLat = campo_lat;
   campoLong = campo_long;
   Geocodifica.getCoordinate(address,city,prov,cap,'','','',setGeocodedLatLonCoordinate);
   
   
}
function setGeocodedLatLonCoordinate(value)
{
	campoLat.value = value[1];;
	campoLong.value =value[0];
	
} 
function doCheck(form){
	  if(form.dosubmit.value=="false") {
		  loadModalWindow();
		  return true;
	  }

	  else {
		  if(checkForm(form)) {
			  form.submit();
			  return true;
		  }
		  else
			  return false;
		  
	  }
}


function checkForm(form) {
    formTest = true;
    message = "";
    alertMessage = "";

if(form.name.value =='')
{
    	message += '- Inserire il nome Impresa \n' ;
    	formTest = false ;
}

if(form.address1city.value =='-1')
{
	message += '- Inserire il comune per sede Legale\n' ;
	formTest = false ;
}

if(form.address2city.value =='-1')
{
	message += '- Inserire il comune per sede Operativa\n' ;
	formTest = false ;
}

if(isNaN(trim(form.mediaAnimaliOspitabili.value)) ||form.mediaAnimaliOspitabili.value=='' )
{
	message += '- Inserire valore corretto per numero animali ospitabili\n' ;
	formTest = false ;
}

if((form.siteId.value =='-1' || form.siteId.value =='') && form.address2city.value !='' )
{
	message += '- Selezionare il comune della sede operativa per il settaggio dell \'asl\n' ;
	formTest = false ;
}

if(isNaN(trim(form.capacitaMax.value))  ||form.capacitaMax.value=='')
{
	message += '- Inserire valore corretto capacita max\n' ;
	formTest = false ;
}

if(form.address2latitude.value =='' || form.address2latitude.value =='0.0')
{
	message += '- Inserire la latitudine \n' ;
	formTest = false ;
}
if(form.address2longitude.value =='' || form.address2longitude.value =='0.0')
{
	message += '- Inserire la longitudine \n' ;
	formTest = false ;
}

tipoStabulatorio = document.getElementById("tipoStabulatorio");
for(i=0;i<tipoStabulatorio.length;i++)
{
	 if (tipoStabulatorio[i].selected)
	 {	 
		 if(tipoStabulatorio[i].value == "-1" ) {
				 message += label("check.vigilanza.richiedente.selezionato","- Controllare di aver selezionato una voce per il campo Tipo Stabulatorio \r\n");
			     formTest = false; 
			 	break;
		 }
	 }
}

specieAnimali = document.getElementById("specieAnimali");
for(i=0;i<specieAnimali.length;i++)
{
	 if (specieAnimali[i].selected)
	 {	 
		 if(specieAnimali[i].value == "-1" ) {
				 message += label("check.vigilanza.richiedente.selezionato","- Controllare di aver selezionato una voce per il campo Specie animali \r\n");
			     formTest = false; 
			 	break;
		 }
	 }
}


    if (formTest == false) {
        alert(label("check.form", "Form could not be saved, please check the following:\r\n\r\n") + message);
        return false;
      } else {
        var test = document.addAccount.selectedList;
        if (test != null) {
          selectAllOptions(document.addAccount.selectedList);
        }
        if(alertMessage != "") {
          confirmAction(alertMessage);
        }
        form.submit();
        return true;
      }
    }

function trim(str){
    return str.replace(/^\s+|\s+$/g,"");
}    

function popolaComuni()
{
	PopolaCombo.getValoriComuniASL(document.addAccount.address2city.value,setComuniCallback) ;
	
}

function setComuniCallback(returnValue)
{
	
	var select = document.addAccount.asl; //Recupero la SELECT
	//Azzero il contenuto della seconda select
    for (var i = select.length - 1; i >= 0; i--)
  	  select.remove(i);

    indici = returnValue [0];
    valori = returnValue [1];
    //Popolo la seconda Select
    for(j =0 ; j<indici.length; j++){
    //Creo il nuovo elemento OPTION da aggiungere nella seconda SELECT
    var NewOpt = document.createElement('option');
    NewOpt.value = indici[j]; // Imposto il valore
    NewOpt.text = valori[j]; // Imposto il testo

    //Aggiungo l'elemento option
    try
    {
  	  select.add(NewOpt, null); //Metodo Standard, non funziona con IE
  	  if(document.addAccount.siteId.value==1 || document.addAccount.siteId.value==2)
			document.addAccount.address1state.value="AV";
		if(document.addAccount.siteId.value==3)
			document.addAccount.address1state.value="BN";
		if(document.addAccount.siteId.value==4 || document.addAccount.siteId.value==5)
			document.addAccount.address1state.value="CE";
		if(document.addAccount.siteId.value==6 || document.addAccount.siteId.value==7 || document.addAccount.siteId.value==8 || document.addAccount.siteId.value==9 || document.addAccount.siteId.value==10)
			document.addAccount.address1state.value="NA";
		if(document.addAccount.siteId.value==11 || document.addAccount.siteId.value==12 || document.addAccount.siteId.value==13)
			document.addAccount.address1state.value="SA";
    }catch(e){
  	  select.add(NewOpt); // Funziona solo con IE
  	  if(document.addAccount.siteId.value==1 || document.addAccount.siteId.value==2)
				document.addAccount.address1state.value="AV";
			if(document.addAccount.siteId.value==3)
				document.addAccount.address1state.value="BN";
			if(document.addAccount.siteId.value==4 || document.addAccount.siteId.value==5)
				document.addAccount.address1state.value="CE";
			if(document.addAccount.siteId.value==6 || document.addAccount.siteId.value==7 || document.addAccount.siteId.value==8 || document.addAccount.siteId.value==9 || document.addAccount.siteId.value==10)
				document.addAccount.address1state.value="NA";
			if(document.addAccount.siteId.value==11 || document.addAccount.siteId.value==12 || document.addAccount.siteId.value==13)
				document.addAccount.address1state.value="SA";
  	  
    }
    }
        
    document.addAccount.siteId.value=document.addAccount.asl.value;
    document.addAccount.asl.style.disabled='true' ;
    }
</script>
<form id = "addAccount" name="addAccount" action="OsAnimali.do?command=Insert&auto-populate=true" method="post">
<input type="hidden" name="dosubmit" value="true" />
  
  
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td width="100%">
<a href="OsAnimali.do?command=Dashboard">Operatori Sperimentazione Animale</a> >
Aggiungi Operatore Sperimentazione Animale
</td>
</tr>
</table>

<input type="button" value="Inserisci" name="Save" onClick="this.form.dosubmit.value='true';return checkForm(document.addAccount)">
<input type="button" value="Annulla" onClick="document.addAccount.action ='OsAnimali.do';document.addAccount.submit();">

<br/><br/>
<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
  <tr>
    <th colspan="2">
      <strong>Aggiungi Operatore Sperimentazione Animale</strong>
    </th>
  </tr>
  
  <tr>
    <td nowrap class="formLabel" >
      ASL
    </td>
    <td>
    <%SiteList.setJsEvent("disabled=\"disabled\""); %>
      <%=SiteList.getHtmlSelect("asl",-1) %>
      &nbsp;(* <font color="red">L'asl viene selezionata in automatico dal sistema in funzione del comune della sede operativa</font>)
      <input type = "hidden" name = "siteId"/>
    </td>
  </tr>
  
  	<tr class="containerBody">
				<td nowrap class="formLabel" name="orgname1" id="orgname1"> Data Inizio
				</td>
				<td>
				<input readonly type="text" id="dataPresentazione" name="dataPresentazione" size="10" />
		<a href="#" onClick="cal19.select(document.forms[0].dataPresentazione,'anchor19','dd/MM/yyyy'); return false;" NAME="anchor19" ID="anchor19">
		<img src="images/icons/stock_form-date-field-16.gif" border="0" align="absmiddle"></a>
				
				</td>
			</tr>
  <tr>
    <td nowrap class="formLabel" name="orgname1" id="orgname1">
      Impresa
    </td>
    <td>
      <input  type="text" size="50" maxlength="200" name="name" value="<%= toHtmlValue(OrgDetails.getName()) %>">
   	<font color = "red">*</font>
    </td>
  </tr>
  
  <tr>
    <td nowrap class="formLabel" >
      Responsabile Legale
    </td>
    <td>
      <input  type="text" size="50" maxlength="80" name="legaleRappresentante" value="<%= toHtmlValue(OrgDetails.getNomeRappresentante()) %>">
    </td>
  </tr>
  
   <tr>
    <td nowrap class="formLabel" >
      Responsabile Animale Care
    </td>
    <td>
      <input  type="text" size="50" maxlength="80" name="responsabileAnimale" value="<%= toHtmlValue(OrgDetails.getResponsabileAnimale()) %>">
    </td>
  </tr>
  
   <tr>
    <td nowrap class="formLabel" >
      Medico Veterinario
    </td>
    <td>
      <input  type="text" size="50" maxlength="80" name="medicoVeterinario" value="<%= toHtmlValue(OrgDetails.getMedicoVeterinario()) %>">
    </td>
  </tr>
  
   <tr>
    <td nowrap class="formLabel" >
      Telefono
    </td>
    <td>
      <input  type="text" size="50" maxlength="80" name="telefono" value="<%= toHtmlValue(OrgDetails.getTelefonoRappresentante()) %>">
    </td>
  </tr>
  
   <tr>
    <td nowrap class="formLabel" >
      Fax
    </td>
    <td>
      <input  type="text" size="50" maxlength="80" name="fax" value="<%= toHtmlValue(OrgDetails.getFax()) %>">
    </td>
  </tr>
  
   <tr>
    <td nowrap class="formLabel" >
      Mail
    </td>
    <td>
      <input  type="text" size="50" maxlength="80" name="mail" value="<%= toHtmlValue(OrgDetails.getEmailRappresentante()) %>">
    </td>
  </tr>
  
    <tr>
    <td nowrap class="formLabel" >
     Autorizzazione Utilizzo
    </td>
    <td>
    <table class="noborder">
    <tr>
    <td> <textarea name="autUtilizzo" id = "autUtilizzo" cols="40" rows="6"><%= toHtmlValue(OrgDetails.getAutUtilizzo()) %> </textarea></td>
    <td>Attivo<input type ="radio" name = "statoUtilizzo" onclick="mostraData(document.getElementById('autUtilizzo'),document.getElementById('dataStatoUtilizzoDiv'),0)" value="0" <%if(OrgDetails.getStatoUtilizzo()==0){ %>checked="checked"<%} %>> Sospendi<input type ="radio" name = "statoUtilizzo" value="1" onclick="mostraData(document.getElementById('autUtilizzo'),document.getElementById('dataStatoUtilizzoDiv'),1)"  <%if(OrgDetails.getStatoUtilizzo()==1){ %>checked="checked"<%} %>> Revoca <input type ="radio" onclick="mostraData(document.getElementById('autUtilizzo'),document.getElementById('dataStatoUtilizzoDiv'),2)"  name = "statoUtilizzo" value="2" <%if(OrgDetails.getStatoUtilizzo()==2){ %>checked="checked"<%} %>>
     Non Autorizzato <input type ="radio" onclick="mostraData(document.getElementById('autUtilizzo'),document.getElementById('dataStatoUtilizzoDiv'),3)"  name = "statoUtilizzo" value="3" <%if(OrgDetails.getStatoUtilizzo()==3){ %>checked="checked"<%} %>>
   		<br/><div id = "dataStatoUtilizzoDiv" style="display: none">
   		In Data
   	    <input readonly type="text" id="dataStatoUtilizzo" name="dataStatoUtilizzo" size="10" value = "<%=OrgDetails.getDataStatoUtilizzoString() %>" />
		<a href="#" onClick="cal19.select(document.forms[0].dataStatoUtilizzo,'anchor19','dd/MM/yyyy'); return false;" NAME="anchor19" ID="anchor19">
		<img src="images/icons/stock_form-date-field-16.gif" border="0" align="absmiddle"></a>
		</div>
    
    </td>
    </tr>
     </table>
     
    </td>
  </tr>
    <tr>
    <td nowrap class="formLabel" >
      Autorizzazione Allevamento
    </td>
    <td>
    <table class="noborder">
    <tr>
    <td>  
    <textarea name="autAllevamento" id="autAllevamento" cols="40" rows="6"><%= toHtmlValue(OrgDetails.getAutAllevamento()) %> </textarea>
   </td>
    <td>Attivo<input type ="radio" onclick="mostraData(document.getElementById('autAllevamento'),document.getElementById('dataStatoAllevamentoDiv'),0)"  name = "statoAllevamento" value="0" <%if(OrgDetails.getStatoAllevamento()==0){ %>checked="checked"<%} %>>Sospendi<input type ="radio" name = "statoAllevamento" onclick="mostraData(document.getElementById('autAllevamento'),document.getElementById('dataStatoAllevamentoDiv'),1)" value="1" <%if(OrgDetails.getStatoAllevamento()==1){ %>checked="checked"<%} %>> Revoca <input type ="radio" name = "statoAllevamento" onclick="mostraData(document.getElementById('autAllevamento'),document.getElementById('dataStatoAllevamentoDiv'),2)" value="2" <%if(OrgDetails.getStatoAllevamento()==2){ %>checked="checked"<%} %>>
    Non Autorizzato <input type ="radio" onclick="mostraData(document.getElementById('autAllevamento'),document.getElementById('dataStatoAllevamentoDiv'),3)"  name = "statoAllevamento" value="3" <%if(OrgDetails.getStatoAllevamento()==3){ %>checked="checked"<%} %>>
   		<br/><div id = "dataStatoAllevamentoDiv" style="display: none">
   		In Data
   		 <input readonly type="text" id="dataStatoAllevamento" name="dataStatoAllevamento" size="10" value = "<%=OrgDetails.getDataStatoAllevamentoString() %>" />
		<a href="#" onClick="cal19.select(document.forms[0].dataStatoAllevamento,'anchor19','dd/MM/yyyy'); return false;" NAME="anchor19" ID="anchor19">
		<img src="images/icons/stock_form-date-field-16.gif" border="0" align="absmiddle"></a>
    </div>
    </td>
    </tr>
     </table>
    
    </td>
  </tr>
  
    <tr>
    <td nowrap class="formLabel" >
      Autorizzazione Fornitore
    </td>
    <td>
    <table class="noborder">
    <tr>
    <td>  
     <textarea name="autFornitore" id="autFornitore" cols="40" rows="6"><%= toHtmlValue(OrgDetails.getAutFornitore()) %> </textarea>
   </td>
    <td>Attivo<input type ="radio" name = "statoFornitore" onclick="mostraData(document.getElementById('autFornitore'),document.getElementById('dataStatoFornitoreDiv'),0)" value="0" <%if(OrgDetails.getStatoFornitore()==0){ %>checked="checked"<%} %>>Sospendi<input type ="radio" name = "statoFornitore" onclick="mostraData(document.getElementById('autFornitore'),document.getElementById('dataStatoFornitoreDiv'),1)" value="1" <%if(OrgDetails.getStatoFornitore()==1){ %>checked="checked"<%} %>> Revoca <input type ="radio" name = "statoFornitore" value="2" onclick="mostraData(document.getElementById('autFornitore'),document.getElementById('dataStatoFornitoreDiv'),2)" <%if(OrgDetails.getStatoFornitore()==2){ %>checked="checked"<%} %>>
   		Non Autorizzato<input type ="radio" name = "statoFornitore" onclick="mostraData(document.getElementById('autFornitore'),document.getElementById('dataStatoFornitoreDiv'),3)" value="3" <%if(OrgDetails.getStatoFornitore()==3){ %>checked="checked"<%} %>>
   		<br/><div id = "dataStatoFornitoreDiv" style="display: none">
   		In Data
   		<input readonly type="text" id="dataStatoFornitore" name="dataStatoFornitore" size="10" value = "<%=OrgDetails.getDataStatoFornitoreString() %>" />
		<a href="#" onClick="cal19.select(document.forms[0].dataStatoFornitore,'anchor19','dd/MM/yyyy'); return false;" NAME="anchor19" ID="anchor19">
		<img src="images/icons/stock_form-date-field-16.gif" border="0" align="absmiddle"></a>
    	</div>
    </td>
    </tr>
     </table>
     
    </td>
  </tr>
  
    <tr>
    <td nowrap class="formLabel" >
      Autorizzazione in Deroga EX ART. 8
    </td>
    <td>
    <table class="noborder">
    <tr>
    <td>  
     <textarea name="autDeroga8" id="autDeroga8" cols="40" rows="6"><%= toHtmlValue(OrgDetails.getAutDeroga8()) %> </textarea>
  </td>
    <td>Attivo<input type ="radio" name = "statoDeroga8" onclick="mostraData(document.getElementById('autDeroga8'),document.getElementById('dataStatoDeroga8Div'),0)" value="0" <%if(OrgDetails.getStatoDeroga8()==0){ %>checked="checked"<%} %>>Sospendi<input type ="radio" name = "statoDeroga8" value="1" onclick="mostraData(document.getElementById('autDeroga8'),document.getElementById('dataStatoDeroga8Div'),1)" <%if(OrgDetails.getStatoDeroga8()==1){ %>checked="checked"<%} %>> Revoca <input type ="radio" name = "statoDeroga8" value="2"  onclick="mostraData(document.getElementById('autDeroga8'),document.getElementById('dataStatoDeroga8Div'),2)"<%if(OrgDetails.getStatoDeroga8()==2){ %>checked="checked"<%} %>>
    		Non Autorizzato<input type ="radio" name = "statoDeroga8" onclick="mostraData(document.getElementById('autDeroga8'),document.getElementById('dataStatoDeroga8Div'),3)" value="3" <%if(OrgDetails.getStatoDeroga8()==3){ %>checked="checked"<%} %>>
    		
    		<br/><div id = "dataStatoDeroga8Div" style="display: none">
    		In Data
    	<input readonly type="text" id="dataStatoDeroga8" name="dataStatoDeroga8" size="10" value = "<%=OrgDetails.getDataStatoDeroga8String() %>" />
		<a href="#" onClick="cal19.select(document.forms[0].dataStatoDeroga8,'anchor19','dd/MM/yyyy'); return false;" NAME="anchor19" ID="anchor19">
		<img src="images/icons/stock_form-date-field-16.gif" border="0" align="absmiddle"></a>
    </div>
    </td>
    </tr>
     </table>
      
    </td>
  </tr>
  
    <tr>
    <td nowrap class="formLabel" >
       Autorizzazione in Deroga EX ART. 9
    </td>
    <td>
     <table class="noborder">
    <tr>
    <td> 
     <textarea id = "autDeroga9"  name="autDeroga9" cols="40" rows="6"><%= toHtmlValue(OrgDetails.getAutDeroga9()) %> </textarea>
    </td>
    <td>Attivo<input type ="radio" name = "statoDeroga9" value="0"  onclick="mostraData(document.getElementById('autDeroga9'),document.getElementById('dataStatoDeroga9Div'),0)" <%if(OrgDetails.getStatoDeroga9()==0){ %>checked="checked"<%} %>>Sospendi<input type ="radio" name = "statoDeroga9" value="1" onclick="mostraData(document.getElementById('autDeroga9'),document.getElementById('dataStatoDeroga9Div'),1)" <%if(OrgDetails.getStatoDeroga9()==1){ %>checked="checked"<%} %>> Revoca <input type ="radio" name = "statoDeroga9" value="2" onclick="mostraData(document.getElementById('autDeroga9'),document.getElementById('dataStatoDeroga9Div'),2)" <%if(OrgDetails.getStatoDeroga9()==2){ %>checked="checked"<%} %>>
   Non Autorizzato<input type ="radio" name = "statoDeroga9" value="3"  onclick="mostraData(document.getElementById('autDeroga9'),document.getElementById('dataStatoDeroga9Div'),3)" <%if(OrgDetails.getStatoDeroga9()==3){ %>checked="checked"<%} %>>
   
    <br/><div id = "dataStatoDeroga9Div" style="display: none">
    In Data
    <input readonly type="text" id="dataStatoDeroga9" name="dataStatoDeroga9" size="10" value = "<%=OrgDetails.getDataStatoDeroga9String() %>" />
		<a href="#" onClick="cal19.select(document.forms[0].dataStatoDeroga9,'anchor19','dd/MM/yyyy'); return false;" NAME="anchor19" ID="anchor19">
		<img src="images/icons/stock_form-date-field-16.gif" border="0" align="absmiddle"></a>
    </div>
    </td>
    </tr>
     </table>
     
    </td>
  </tr>

  <tr>
    <td nowrap class="formLabel" >
       Tipo Stabulatorio
    </td>
    <td>
    <%=tipoStabulatorio.getHtmlSelect("tipoStabulatorio",-1) %>
    </td>
  </tr>
  
  <tr>
    <td nowrap class="formLabel" >
      Specie animali
    </td>
    <td>
    <%=specieAnimali.getHtmlSelect("specieAnimali",-1) %>
    </td>
  </tr>
  
  
  <tr>
    <td nowrap class="formLabel" >
       N. Animali ospitabili in media
    </td>
    <td>
      <input  type="text" size="50" maxlength="80" name="mediaAnimaliOspitabili" value="<%= OrgDetails.getMediaAnimaliOspitabili() %>">
    </td>
  </tr>
  
  <tr>
    <td nowrap class="formLabel" >
       Capacita max(animali ospitabili) 
    </td>
    <td>
      <input  type="text" size="50" maxlength="80" name="capacitaMax" value="<%= OrgDetails.getCapacitaMax()%>">
    </td>
  </tr>
      </table>
    <br/><br/>
  <table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
  <tr>
    <th colspan="2">
	    <strong>Sede Legale</strong>
	  <input type="hidden" name="address1type" value="1">
	  </th>
  </tr>
 <tr>
	<td nowrap class="formLabel" name="province1" id="prov2">
      <dhv:label name="requestor.requestor_add.City">City</dhv:label>
    </td> 
    <td > 
	<select  name="address1city" id="prov12">
	<option value="-1">Nessuna Selezione</option>
            
	 <%
                Vector v2 = OrgDetails.getComuni2();
	 			Enumeration e2=v2.elements();
                while (e2.hasMoreElements()) {
                	String prov2=e2.nextElement().toString();
                	
        %>
                <option value="<%=prov2%>" ><%= prov2 %></option>	
              <%}%>
		
	</select> 
	<font color = "red">*</font>
	</td>
  	</tr>	
  	  	
  <tr>
    <td nowrap class="formLabel" id="indirizzo1">
      Indirizzo
    </td>
    <td>
      <input type="text" size="40" name="address1line1" maxlength="80" id="indirizzo12" value="">
    </td>
  </tr>
  
  
  <tr>
    <td nowrap class="formLabel" id="cap1">
      <dhv:label name="requestor.requestor_add.ZipPostalCode">Zip/Postal Code</dhv:label>
    </td>
    <td>
      <input type="text" size="28" name="address1zip" maxlength="5" value = "" id="cap">
    </td>
  </tr>  
  	 
  	<tr>
    <td nowrap class="formLabel" id="stateProv2" >
      <dhv:label name="requestor.requestor_add.StateProvince">State/Province</dhv:label>
    </td>
    <td>
          <% if (User.getSiteId() == 202) { %>
          <input type="text" readonly="readonly" size="28" name="address1state" maxlength="80" value="BN">          
          <%}%>
          <% if (User.getSiteId() == 201) { %>
          <input type="text" readonly="readonly" size="28" name="address1state" maxlength="80" value="AV">
          <%}%>
          <% if (User.getSiteId() == 203) { %>
          <input type="text" readonly="readonly" size="28" name="address1state" maxlength="80" value="CE">
          <%}%>
          <% if (User.getSiteId() == 204 || User.getSiteId() == 205 || User.getSiteId() == 206 ) { %>
          <input type="text" readonly="readonly" size="28" name="address1state" maxlength="80" value="NA">
          <%}%>
          <% if (User.getSiteId() == 207) { %>
          <input type="text" readonly="readonly" size="28" name="address1state" maxlength="80" value="SA">
          <%}%>
          <% if (User.getSiteId() == -1) { %>
          <input type="text"  size="28" name="address1state" maxlength="80" value="">
          <%}%>
    </td>
  </tr>

  
  <tr class="containerBody">
    <td class="formLabel" nowrap id="latitude2"><dhv:label name="requestor.address.latitude">Latitude</dhv:label></td>
    <td>
       	<%-- <input type="text" id="address2longitude" name="address2longitude" size="30" value="<%=AddressSedeOperativa.getLongitude() %>" id="longitude12">--%>
    	<input type="text" id="address1latitude" readonly="readonly" name="address1latitude" size="30" value="">
 	
    </td>
  </tr>
  <tr class="containerBody">
    <td class="formLabel" nowrap id="longitude2"><dhv:label name="requestor.address.longitude">Longitude</dhv:label></td>
    <td>
    	<%-- <input type="text" id="address2longitude" name="address2longitude" size="30" value="<%=AddressSedeOperativa.getLongitude() %>" id="longitude12">--%>
    	<input type="text" id="address1longitude"  readonly="readonly" name="address1longitude" size="30" value="">
    </td>
    </tr>
    <tr style="display: block">
    <td colspan="2">
    <input id="coord1button" type="button" value="Calcola Coordinate"
    onclick="javascript:showCoordinate(document.getElementById('indirizzo12').value, document.forms['addAccount'].address1city.value,document.forms['addAccount'].address1state.value, document.forms['addAccount'].address1zip.value, document.forms['addAccount'].address1latitude, document.forms['addAccount'].address1longitude);" /> 
    </td>
    </tr>
   
</table>
	
	<br/>
	<br/>
	<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
  <tr>
    <th colspan="2">
	    <strong><dhv:label name="">Sede Operativa</dhv:label></strong>
	  <input type="hidden" name="address2type" value="5">
	  </th>
  </tr>
 <tr>
	<td nowrap class="formLabel"  id="prov12">
      <dhv:label name="requestor.requestor_add.City">City</dhv:label>
    </td> 
    <td > 
	<select  name="address2city" id="prov2" onchange="popolaComuni()">
	<option value="-1">Nessuna Selezione</option>
            
	 <%
                Vector v4 = OrgDetails.getComuni2();
	 			Enumeration e4=v4.elements();
                while (e4.hasMoreElements()) {
                	String prov4=e4.nextElement().toString();
                	
        %>
                <option value="<%=prov4%>" ><%= prov4 %></option>	
              <%}%>
		
	</select> 
	<font color="red">*</font>
	</td>
  	</tr>	
  	  	
  <tr>
    <td nowrap class="formLabel" id="indirizzo1">
      Indirizzo
    </td>
    <td>
      <input type="text" size="40" name="address2line1" maxlength="80" id="indirizzo22" value="">
    </td>
  </tr>
  
  
  <tr>
    <td nowrap class="formLabel" id="cap1">
      <dhv:label name="requestor.requestor_add.ZipPostalCode">Zip/Postal Code</dhv:label>
    </td>
    <td>
      <input type="text" size="28" name="address2zip" maxlength="5" value = "" id="cap">
    </td>
  </tr>  
  	 
  	<tr>
    <td nowrap class="formLabel" id="stateProv2" >
      <dhv:label name="requestor.requestor_add.StateProvince">State/Province</dhv:label>
    </td>
    <td>
          <% if (User.getSiteId() == 202) { %>
          <input type="text" readonly="readonly" size="28" name="address2state" maxlength="80" value="BN">          
          <%}%>
          <% if (User.getSiteId() == 201) { %>
          <input type="text" readonly="readonly" size="28" name="address2state" maxlength="80" value="AV">
          <%}%>
          <% if (User.getSiteId() == 203) { %>
          <input type="text" readonly="readonly" size="28" name="address2state" maxlength="80" value="CE">
          <%}%>
          <% if (User.getSiteId() == 204 || User.getSiteId() == 205 || User.getSiteId() == 206 ) { %>
          <input type="text" readonly="readonly" size="28" name="address2state" maxlength="80" value="NA">
          <%}%>
          <% if (User.getSiteId() == 207) { %>
          <input type="text" readonly="readonly" size="28" name="address2state" maxlength="80" value="SA">
          <%}%>
          <% if (User.getSiteId() == -1) { %>
          <input type="text"  size="28" name="address2state" maxlength="80" value="">
          <%}%>
    </td>
  </tr>

  
  <tr class="containerBody">
    <td class="formLabel" nowrap id="latitude2"><dhv:label name="requestor.address.latitude">Latitude</dhv:label></td>
    <td>
       	<%-- <input type="text" id="address2longitude" name="address2longitude" size="30" value="<%=AddressSedeOperativa.getLongitude() %>" id="longitude12">--%>
    	<input type="text" id="address2latitude"  readonly="readonly" name="address2latitude" size="30" value=""> <font color = "red">*</font>
 	
    </td>
  </tr>
  <tr class="containerBody">
    <td class="formLabel" nowrap id="longitude2"><dhv:label name="requestor.address.longitude">Longitude</dhv:label></td>
    <td>
    	<%-- <input type="text" id="address2longitude" name="address2longitude" size="30" value="<%=AddressSedeOperativa.getLongitude() %>" id="longitude12">--%>
    	<input type="text" id="address2longitude"  readonly="readonly" name="address2longitude" size="30" value=""> <font color = "red">*</font>
    </td>
    </tr>
    <tr style="display: block">
    <td colspan="2">
    <input id="coord1button" type="button" value="Calcola Coordinate"
    onclick="javascript:showCoordinate(document.getElementById('indirizzo22').value, document.forms['addAccount'].address2city.value,document.forms['addAccount'].address2state.value, document.forms['addAccount'].address2zip.value, document.forms['addAccount'].address2latitude, document.forms['addAccount'].address2longitude);" /> 
    </td>
    </tr>
   
</table>
	
	<br/>
	<br/>
  
<input type="button" value="Inserisci" name="Save" onClick="this.form.dosubmit.value='true';return checkForm(document.addAccount)">
<input type="button" value="Annulla" onClick="document.addAccount.action ='OsAnimali.do';document.addAccount.submit();">
</form>


<%-- 
  - Copyright(c) 2004 Concursive Corporation (http://www.concursive.com/) All
  - rights reserved. This material cannot be distributed without written
  - permission from Concursive Corporation. Permission to use, copy, and modify
  - this material for internal use is hereby granted, provided that the above
  - copyright notice and this permission notice appear in all copies. CONCURSIVE
  - CORPORATION MAKES NO REPRESENTATIONS AND EXTENDS NO WARRANTIES, EXPRESS OR
  - IMPLIED, WITH RESPECT TO THE SOFTWARE, INCLUDING, BUT NOT LIMITED TO, THE
  - IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR ANY PARTICULAR
  - PURPOSE, AND THE WARRANTY AGAINST INFRINGEMENT OF PATENTS OR OTHER
  - INTELLECTUAL PROPERTY RIGHTS. THE SOFTWARE IS PROVIDED "AS IS", AND IN NO
  - EVENT SHALL CONCURSIVE CORPORATION OR ANY OF ITS AFFILIATES BE LIABLE FOR
  - ANY DAMAGES, INCLUDING ANY LOST PROFITS OR OTHER INCIDENTAL OR CONSEQUENTIAL
  - DAMAGES RELATING TO THE SOFTWARE.
  - 
  - Version: $Id: template1style.jsp 24329 2007-12-09 14:44:10Z srinivasar@cybage.com $
  - Description:
  --%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="ModuleBean" class="org.aspcfs.modules.beans.ModuleBean" scope="request"/>
<!-- import necessari al funzionamento della finestra modale di locking -->   
<link rel="shortcut icon" href="images/favicon.ico" />  
<link rel="stylesheet" type="text/css" href="css/modalWindow.css"></link>
  
<%
  response.setHeader("Pragma", "no-cache"); // HTTP 1.0
  response.setHeader("Cache-Control", "no-cache"); // HTTP 1.1
  response.setHeader("Expires", "-1");
%>
<!-- (C) 2000-2006 Concursive Corporation -->
<html>
<head>
<title><dhv:label name="templates.CentricCRM">Concourse Suite Community Edition</dhv:label><%= ((!ModuleBean.hasName())?"":": " + ModuleBean.getName()) %></title>
<%String cssToInclude = getServletContext().getContextPath();
cssToInclude = cssToInclude.substring(cssToInclude.indexOf("/")+1);
cssToInclude = "cssInclude_" +cssToInclude+".jsp";%>
<jsp:include page="<%=cssToInclude %>" flush="true" />
<script type="text/javascript" src="gestionecap/js/lookup.js"></script>
<script src="javascript/jquery-1.8.2.js"></script>
<script src='javascript/modalWindow.js'></script>
<script src="javascript/jquery-ui.js"></script>
<script language="JavaScript" type="text/javascript" src="javascript/customerSatisfaction.js"></script>	
<script language="JavaScript" type="text/javascript" src="javascript/popURL.js"></script>

<script language="JavaScript" TYPE="text/javascript" SRC="dwr/engine.js">
	
</script>
<script type="text/javascript" src="dwr/util.js"></script>

<script language="JavaScript" TYPE="text/javascript" SRC="dwr/interface/DwrCustomSatisfaction.js"> </script>

</head>
<body leftmargin="0" rightmargin="0" margin="0" marginwidth="0" topmargin="0" marginheight="0">
<DIV ID="modalWindow" CLASS="unlocked" style="display:none;">
		<P CLASS="wait">Attendere il completamento dell'operazione...</P>
	</DIV>
<jsp:include page="customerSatisfaction.jsp"></jsp:include>

<table border="0" width="100%">
  <tr>
    <td valign="top">
<jsp:include page='<%= (String) request.getAttribute("IncludeModule") %>' flush="true"/>
    </td>
  </tr>
</table>

<script>

$(document).ready(function() {
	
	
	 if (document.forms[0]!=null){
//		 alert(document.forms[0].getAttribute("onsubmit"))
		 var func = document.forms[0].onsubmit;
		document.forms[0].onsubmit=function(event){
			setTimestampStartRichiesta();
		//	alert(func);
			if(func!=null)
				return func();
			};
		
	 }

		 var oInput=document.createElement("INPUT");
		oInput.setAttribute("type","hidden");
		oInput.setAttribute("name","endTime");
		oInput.setAttribute("id","endTime");
		oInput.setAttribute("value",new Date().getTime());
		document.getElementById("dialogCustomerSatisfaction").appendChild(oInput);
});
</script>

<%if (request.getAttribute("customerSatisfaction")!=null){ %>
<script>openCustomerSatisfaction();</script>
<%} %>





<script type="text/javascript">

function selezionaIndirizzo(campoNazione,f, c='', regione='ALL',asl='', aslExclude='')
{
		var nazione = '106';
		if(campoNazione!='106')
			nazione = document.getElementById(campoNazione).value;
		if(nazione=='106')
			openCapWidget(f, c, regione, asl,aslExclude);
		
}

function openCapWidget(f, c='', regione='ALL', asl='', aslExclude='') 
{
	loadModalWindow();

	  var w=314;
	  var h=400;
	  var left = (screen.width/2)-(w/2)-200;
	  var top = (screen.height/2)-(h/2)-100;
	  var stl='location=0,toolbar=0,status=0,menubar=0,scrollbars=0,resizable=0,width='+w+',height='+h+', top='+top+',left='+left;

		win = window.open("javascript/cap_widget/capall.html?callbackName=" + f + "&comune=" + c + "&regione=" + regione + "&asl=" + asl + "&aslExclude=" + aslExclude + "&versione=1" + "&flag_id_asl=" + asl +"&flag_regione=" + regione.toLowerCase() , "", stl); 
		 if (win != null) { var timer = setInterval(function() { if(win.closed) { clearInterval(timer); loadModalWindowUnlock(); document.getElementById('modalWindow').style.display='none';} }, 1000); }
	}

	
	
function callbackResidenzaProprietario(addressObj) 
{ 
	if(addressObj.via!='')
	{
		document.getElementById('addressLegaleLine1Testo').value = addressObj.top + ' ' + addressObj.via + ', ' + addressObj.civ ;
		document.getElementById('viaTesto').value = addressObj.top + ' ' + addressObj.via + ', ' + addressObj.civ ;
	}
	document.getElementById('addressLegaleCityTesto').value= addressObj.comune ;
    document.getElementById('addressLegaleCity').value= addressObj.comuneId ;
    document.getElementById('cap').value= addressObj.cap ;
    document.getElementById('provinciaTesto').value=addressObj.prov;
	document.getElementById('addressLegaleCountry').value=addressObj.provinciaId;
	document.getElementById('searchcodeIdprovincia').value=addressObj.provinciaId;
	document.getElementById('searchcodeIdComune').value=addressObj.comuneId;
    loadModalWindowUnlock();
}



function callbackResidenzaProprietarioCessione(addressObj) 
{ 
	if(addressObj.via!='')
		document.getElementById('indirizzo').value = addressObj.top + ' ' + addressObj.via + ', ' + addressObj.civ ;
    if(addressObj.comune!='')
    	document.getElementById("idComune").value = comuni[addressObj.comune];
    if(addressObj.prov!='')
    	document.getElementById("idProvincia").value = province[addressObj.prov];
    document.getElementById('cap').value= addressObj.cap ;
    loadModalWindowUnlock();
}

function callbackResidenzaProprietarioAdozioneFuoriAsl(addressObj) 
{ 
	if(addressObj.via!='')
		document.getElementById('indirizzo').value = addressObj.top + ' ' + addressObj.via + ', ' + addressObj.civ ;
    if(addressObj.comune!='')
    	document.getElementById("idComune").value = comuni[addressObj.comune];
    if(addressObj.prov!='')
    	document.getElementById("idProvincia").value = province[addressObj.prov];
    document.getElementById('cap').value= addressObj.cap ;
    loadModalWindowUnlock();
}


function callbackResidenzaProprietarioModificaResidenza(addressObj) 
{ 
	if(addressObj.via!='')
		document.getElementById('via').value = addressObj.top + ' ' + addressObj.via + ', ' + addressObj.civ ;
    if(addressObj.comune!='')
    	document.getElementById("idComuneModificaResidenza").value = comuni[addressObj.comune];
    if(addressObj.prov!='')
    	document.getElementById("idProvinciaModificaResidenza").value = province[addressObj.prov];
    document.getElementById('cap').value= addressObj.cap ;
    loadModalWindowUnlock();
}

function callbackResidenzaProprietarioModifica(addressObj) 
{ 
	if(addressObj.via!='')
		document.getElementById('viaTesto').value = addressObj.top + ' ' + addressObj.via + ', ' + addressObj.civ ;
    if(addressObj.comune!='')
    {
    	document.getElementById("searchcodeIdComune").value = comuni[addressObj.comune];
    	document.getElementById("searchcodeIdComuneSelect").value = comuni[addressObj.comune];
	}
    document.getElementById('cap').value= addressObj.cap ;
    loadModalWindowUnlock();
}

function callbackResidenzaProprietarioModificaColonia(addressObj) 
{ 
	if(addressObj.via!='')
		document.getElementById('viaSedeOperativa').value = addressObj.top + ' ' + addressObj.via + ', ' + addressObj.civ ;
    if(addressObj.comune!='')
    {
    	document.getElementById("idComuneSedeOperativa").value = comuni[addressObj.comune];
    	document.getElementById("idComuneSedeOperativaSelect").value = comuni[addressObj.comune];
	}
    document.getElementById('cap').value= addressObj.cap ;
    loadModalWindowUnlock();
}

function callbackResidenzaProprietarioModificaIndirizzo(addressObj) 
{ 
	if(addressObj.via!='')
		document.getElementById('via').value = addressObj.top + ' ' + addressObj.via + ', ' + addressObj.civ ;
    if(addressObj.comune!='')
    {
    	document.getElementById("idComuneModificaResidenza").value = comuni[addressObj.comune];
    	document.getElementById("idComuneModificaResidenzaSelect").value = comuni[addressObj.comune];
    }
    if(addressObj.prov!='')
    {
    	document.getElementById("idProvinciaModificaResidenza").value = province[addressObj.prov];
    	document.getElementById("idProvinciaModificaResidenzaSelect").value = province[addressObj.prov];
    }
    document.getElementById('cap').value= addressObj.cap ;
    document.getElementById("idAslNuovoProprietarioSelect").value = elencoAsl[addressObj.asl];
    document.getElementById("idAslNuovoProprietario").value = elencoAsl[addressObj.asl];
    loadModalWindowUnlock();
}

function callbackResidenzaProprietarioInserimentoColonia(addressObj) 
{ 
	if(addressObj.via!='')
	{
		document.getElementById('via').value = addressObj.top + ' ' + addressObj.via + ', ' + addressObj.civ ;
		document.getElementById('viaTesto').value = addressObj.top + ' ' + addressObj.via + ', ' + addressObj.civ ;
	}
    if(addressObj.comune!='')
    {
    	document.getElementById("searchcodeIdComune").value = comuni[addressObj.comune];
    	document.getElementById("searchcodeIdComuneSelect").value = addressObj.comune;
    }
    if(addressObj.prov!='')
    {
    	if(document.getElementById("searchcodeIdprovincia")!=null)
    		document.getElementById("searchcodeIdprovincia").value = province[addressObj.prov];
    	if(document.getElementById("searchcodeIdprovinciaSelect")!=null)
    		document.getElementById("searchcodeIdprovinciaSelect").value = addressObj.prov;
    }
    document.getElementById('cap').value= addressObj.cap ;
    loadModalWindowUnlock();
}






function wrapper(cb, dataObj) 
{
	switch (cb) {
	case 'callbackResidenzaProprietario': 
		callbackResidenzaProprietario(dataObj);
		break;
	case 'callbackResidenzaProprietarioCessione': 
		callbackResidenzaProprietarioCessione(dataObj);
		break;
	case 'callbackResidenzaProprietarioAdozioneFuoriAsl': 
		callbackResidenzaProprietarioAdozioneFuoriAsl(dataObj);
		break;
	case 'callbackResidenzaProprietarioModificaResidenza': 
		callbackResidenzaProprietarioModificaResidenza(dataObj);
		break;	
	case 'callbackResidenzaProprietarioModificaIndirizzo': 
		callbackResidenzaProprietarioModificaIndirizzo(dataObj);
		break;	
	case 'callbackResidenzaProprietarioModifica': 
		callbackResidenzaProprietarioModifica(dataObj);
		break;
	case 'callbackResidenzaProprietarioModificaColonia':
		callbackResidenzaProprietarioModificaColonia(dataObj);
		break;
	case 'callbackResidenzaProprietarioInserimentoColonia':
		callbackResidenzaProprietarioInserimentoColonia(dataObj);
		break;	
	default:
		alert('not managed');
	}
}

$('form').submit(function() {
	loadModalWindow();

}); 


$('a').click(
		function() {
			if ((this.href.indexOf('#') == -1 
					&& this.href.indexOf('javascript:') == -1)
					&& (this.href.indexOf('GestioneDocumenti') == -1)
					&& (this.href.indexOf('GestioneAllegati') == -1)
					&& this.href.indexOf('vecchio') == -1
					&& this.id!="elencocomunicoinvolti"
			
			
			) {
				loadModalWindow();
			}

		}); 

	    
</script>
</body>
</html>


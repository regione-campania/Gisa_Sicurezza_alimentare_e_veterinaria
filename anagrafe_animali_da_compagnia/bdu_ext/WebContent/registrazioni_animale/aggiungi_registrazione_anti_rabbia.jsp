<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv"%>
<%@ page
	import="java.io.*,java.util.*,org.aspcfs.utils.web.*,org.aspcfs.modules.opu.base.*,org.aspcfs.modules.registrazioniAnimali.base.*"%>

<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean"
	scope="session" />
<jsp:useBean id="EventoInserimentoVaccinazioni"
	class="org.aspcfs.modules.registrazioniAnimali.base.EventoInserimentoVaccinazioni"
	scope="session" />
<jsp:useBean id="tipoVaccinoInoculato" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="tipoFarmaco" class="org.aspcfs.utils.web.LookupList" scope="request" />


<meta charset="utf-8" />
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />

<!-- <script src="https://code.jquery.com/jquery-1.9.1.js"></script> -->
<!-- <script src="https://code.jquery.com/ui/1.10.3/jquery-ui.js"></script> -->


<script language="javascript" SRC="javascript/CalendarPopup2.js"></script>
<script language="javascript" SRC="javascript/jquery-ui.js"></script>
<script language="JavaScript" TYPE="text/javascript"SRC="javascript/dateControl.js"></script>
<!-- 
<script language="javascript" ID="js19">
var cal19 = new CalendarPopup();
cal19.showYearNavigation();
cal19.showYearNavigationInput();
</SCRIPT>
 -->

<script type="text/javascript" src="dwr/interface/DwrUtil.js"> </script>
<script type="text/javascript" src="dwr/engine.js"> </script>
<script type="text/javascript" src="dwr/util.js"></script>

<script language="JavaScript" TYPE="text/javascript"
	SRC="dwr/interface/Animale.js"> </script>

<script type="text/javascript">

$( document ).ready( function(){
	calenda('dataVaccinazione','','0');
	calenda('dataScadenzaVaccino','','');
});

// function verificaMicrochipPerRegistrazioneAntiRabbia(microchip){
// 	var formTest = true;
// 	var message = "";

// //	dwr.util.useLoadingMessage('testttt');
// 	 dwr.util.useLoadingImage('images/ajax-loader.gif');
// 	if( !( (microchip.value.length == 15) && ( /^([0-9]+)$/.test( microchip.value )) ) )
//      {
//     	  message += label("", "- La lunghezza del microchip deve essere di 15 caratteri numerici\r\n");
//        	formTest = false;
//      }
// 	var ok = false;
// 	//alert($('#flagCattura').is(':checked'));
// 	if (formTest){
// 	//	alert("controllo animale");
// 	Animale.verificaMCperRegRabbia(microchip.value, {
// 		callback:function(data) {
// 		if (data.idEsito == '-1'){
// 			$(microchip).focus();
// 			$(microchip).css('background-color', 'red');
// 			$('#numeroLottoVaccino').attr("disabled", "true");
// 			$('#nomeVaccino').attr("disabled", "true");
// 			$('#dataVaccinazione').attr("disabled", "true");
// 			alert(data.descrizione);
// 			return false;
// 		}else{
// 			$(microchip).css('background-color', 'white');
// 			$('#numeroLottoVaccino').removeAttr('disabled');
// 			$('#nomeVaccino').removeAttr('disabled');
// 			$('#dataVaccinazione').removeAttr('disabled');
// 			$('#dataScadenzaVaccino').removeAttr('disabled');
// 			$('#produttoreVaccino').removeAttr('disabled');
			
// 		//	alert('WHITE');
// 			return true;
// 		}
// 		},
// 		timeout:8000,
// 		async:false

// 		});

// 	//return ok;
// 	}else{

// 		 alert(label("check.form", "Form could not be saved, please check the following:\r\n\r\n") + message);
// 	     return false;
// 	}
// }


function verificaMicrochipPerRegistrazioneAntiRabbia(microchip, data){
	var formTest = true;
	var message = "";

//	dwr.util.useLoadingMessage('testttt');
	 dwr.util.useLoadingImage('images/ajax-loader.gif');
	if( !( (microchip.value.length == 15) && ( /^([0-9]+)$/.test( microchip.value )) ) )
     {
		message += label("", "- La lunghezza del microchip deve essere di 15 caratteri numerici\r\n");
    	document.getElementById('microchip').value = '';
		document.getElementById('dataVaccinazione').value = '';
       	formTest = false;
     }
	var ok = false;
	//alert($('#flagCattura').is(':checked'));
	if (formTest){
	//	alert("controllo animale");
	Animale.verificaMCperRegRabbiaDataEffettivaVaccinazione(microchip.value, data.value, {
		callback:function(data) {
		if (data.idEsito == '-1'){
			$(microchip).focus();
			$(microchip).css('background-color', 'red');
			document.getElementById('microchip').value = '';
			document.getElementById('dataVaccinazione').value = '';
			$('#numeroLottoVaccino').attr("disabled", "true");
			$('#dosaggio').attr("disabled","true");
			$('#nomeVaccino').attr("disabled", "true");
			//$('#dataVaccinazione').attr("disabled", "true");
			alert(data.descrizione);
			return false;
		}else{
			$(microchip).css('background-color', 'white');
		//	$('#dataVaccinazione').removeAttr('disabled');
			$('#dosaggio').removeAttr('disabled');
			$('#numeroLottoVaccino').removeAttr('disabled');
			$('#dataScadenzaVaccino').removeAttr('disabled');
			
		//	alert('WHITE');
			return true;
		}
		},
		timeout:8000,
		async:false

		});

	//return ok;
	}else{

		 alert(label("check.form", "Form could not be saved, please check the following:\r\n\r\n") + message);
	     return false;
	}
}


function checkForm(form){
	 formTest = true;
	 message = "";
	lanciaControlloDate();
	
	 if (form.numeroLottoVaccino == null || form.numeroLottoVaccino.value == "" ){

		   	message += label("", "- Inserisci il lotto del vaccino utilizzato.\r\n");
			formTest = false;
	 }
	 
	 if (form.dosaggio == null || form.dosaggio.value == ""){
		 	message += label("", "- Inserisci il dosaggio del vaccino.\r\n");
			formTest = false;
	 }
	 
	 if($('#farmaco').val() == '-1'){
			message += "- Selezionare farmaco \r\n";
			formTest = false;
	 }
	 
	if (formTest){
	//	alert($("#dataVaccinazione").val());
	Animale.verificaMCperRegRabbiaDataEffettivaVaccinazione(microchip.value, $("#dataVaccinazione").val(), {
		callback:function(data) {
		if (data.idEsito == '-1'){
			$(microchip).focus();
			$(microchip).css('background-color', 'red');
			message = data.descrizione;
			formTest =  false;
			document.getElementById('microchip').value = '';
			document.getElementById('dataVaccinazione').value = '';
		}else{
			$(microchip).css('background-color', 'white');
			//alert('WHITE');
			formTest =  true;
		}
		},
		timeout:8000,
		async:false

		});
	}

    if (formTest == false) {
    	 alert(label("check.form", "Non puoi proseguire:\r\n\r\n") + message);
      return false;
    }else{
      //  alert('else return true');
	return true;
        }
}



dwr.util.useLoadingImage = function useLoadingImage(imageSrc) {
	//alert(imageSrc);
	  var loadingImage;
	  if (imageSrc) loadingImage = imageSrc;
	  else loadingImage = "images/c9_ajax-loader.gif";
	  dwr.engine.setPreHook(function() {
	    var disabledImageZone = dwr.util.byId('disabledImageZone');
	  //  alert(disabledImageZone);
	    if (!disabledImageZone) {
		//    alert('not');
	      disabledImageZone = document.createElement('div');
	      disabledImageZone.setAttribute('id', 'disabledImageZone');
	      disabledImageZone.style.position = "absolute";
	      disabledImageZone.style.zIndex = "1000";
	      disabledImageZone.style.left = "0px";
	      disabledImageZone.style.top = "0px";
	      disabledImageZone.style.width = "100%";
	      disabledImageZone.style.height = "100%";
	      var imageZone = document.createElement('img');
	      imageZone.setAttribute('id','imageZone');
	      imageZone.setAttribute('src','c9_ajax-loader.gif');
	      imageZone.src='c9_ajax-loader.gif';
	      imageZone.style.position = "absolute";
	      imageZone.style.top = "0px";
	      imageZone.style.right = "0px";
	      disabledImageZone.appendChild(imageZone);
	      document.body.appendChild(disabledImageZone);
	    }
	    else {
	     $('#imageZone').attr('src',imageSrc);	    
	      disabledImageZone.style.visibility = 'visible';

	    }
	  });
	  dwr.engine.setPostHook(function() {
		  disabledImageZone.style.visibility = 'hidden';
	  });
	}
	
$('#dataVaccinazione').change(function() { });
</script>


<%@ include file="../initPage.jsp"%>
<dhv:evaluate if="<%=!isPopup(request)%>">
	<%-- Trails --%>
	<table class="trails" cellspacing="0">
		<tr>
			<td width="100%"><a href="ProfilassiRabbia.do"><dhv:label
				name="">Profilassi Rabbia</dhv:label></a> > <dhv:label name="">Aggiungi vaccinazione</dhv:label>
				
			</td>
		</tr>
	</table>
	<%-- End Trails --%>
</dhv:evaluate>
<body>


<form name="add"
	id="idForm"
	action="ProfilassiRabbia.do?command=Insert&auto-populate=true"
	method="post"></br>

<span id="datireg" class="datireg">
<table cellpadding="2" cellspacing="0" border="0" width="100%"
	class="details">
	<tr>
		<th colspan="2"><strong><dhv:label name="">Dati da inserire</dhv:label></strong>
		</th>
	</tr>
	<tr>
		<td class="formLabel"><dhv:label name="">Microchip</dhv:label></td>
		<td><input type="text" name="microchip" id="microchip" value=""
		maxlength="15" /> 
		<input type="button" value="Vedi Proprietario" onclick="if($('#microchip').val()!=''){popURL('MyCFS.do?command=RicercaProprietarioLP&mc='+$('#microchip').val()+'&popup=true','AccountDetails','650','500','yes','yes')}else{alert('Inserisci prima in microchip')}"/> 
			<div id="disabledImageZone" style="visibility: hidden; color: red;">Verifica microchip in corso <br><img id="imageZone" src="" name="imageZone" /> </div>
		</td>
	</tr>
	<input type="hidden" name="idTipoVaccino" id="idTipoVaccino" value="1" />
	<tr>
		<td class="formLabel"><dhv:label name="">Data vaccinazione</dhv:label></td>
		<td><input  class="date_picker" type="text" name="dataVaccinazione" id="dataVaccinazione" size="10"
			value="" nomecampo="dataVaccinazione" tipocontrollo="T2"
			labelcampo="Data Vaccinazione"  	onchange="javascript:verificaMicrochipPerRegistrazioneAntiRabbia(document.forms[0].microchip, document.forms[0].dataVaccinazione);"  />&nbsp;</td>
	</tr>
	<tr>
		<td class="formLabel"><dhv:label name="">Tipo vaccino inoculato</dhv:label></td>
		<td><%=tipoVaccinoInoculato.getHtmlSelect("idTipologiaVaccinoInoculato", -1) %></td>
	</tr>
	<tr>
		<td class="formLabel"><dhv:label name="">Farmaco</dhv:label></td>
		<td><%=tipoFarmaco.getHtmlSelect("farmaco", -1) %></td>
	</tr>
	<tr>
		<td class="formLabel"><dhv:label name="">Dosaggio</dhv:label></td>
		<td><input type="text" name="dosaggio"
			id="dosaggio" value="" disabled="disabled" /></td>
	</tr>
	<tr>
		<td class="formLabel"><dhv:label name="">Numero Lotto vaccino</dhv:label></td>
		<td><input type="text" name="numeroLottoVaccino"
			id="numeroLottoVaccino" value="" disabled="disabled" /></td>
	</tr>
	<tr>
	<td class="formLabel"><dhv:label name="">Data scadenza vaccino</dhv:label></td>
		<td><input disabled="disabled" class="date_picker" type="text" name="dataScadenzaVaccino" id="dataScadenzaVaccino" size="10"
			value="" nomecampo="dataScadenzaVaccino" tipocontrollo="T2,T27" onclick="checkDataFine('dataVaccinazione','dataScadenzaVaccino')"
			labelcampo="Data Scadenza Vaccino" />&nbsp;</td>
	</tr>

</table>
</span> </br>
</br>
<input type="hidden" name="idVeterinarioEsecutoreAccreditato" id="idVeterinarioEsecutoreAccreditato" value="<%=User.getUserId() %>" />
<table cellpadding="4" cellspacing="0" border="0" width="100%"
	class="details">
	<tr>
		<th colspan="2"><strong>NOTE</strong></th>
	</tr>
	<tr class="containerBody">
		<td valign="top" class="formLabel"><dhv:label name="">Note</dhv:label>
		</td>
		<td><textarea name="note" rows="3" cols="50"><%=toString(EventoInserimentoVaccinazioni.getNote())%></textarea>
		</td>
	</tr>
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
			<td><textarea name="noteInternalUseOnly" rows="3" cols="50"><%=toString(EventoInserimentoVaccinazioni
								.getNoteInternalUseOnly())%></textarea></td>
		</tr>
	</table>
</dhv:permission> <input type="button" onclick="if(checkForm(document.getElementById('idForm'))){document.getElementById('idForm').submit();}" value="Invia dati e stampa certificato di avvenuta vaccinazione" id="invia" /></form>
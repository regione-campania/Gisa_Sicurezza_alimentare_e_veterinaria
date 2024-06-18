<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv"%>
<%@ page
	import="java.io.*,java.util.*,org.aspcfs.utils.web.*,org.aspcfs.modules.opu.base.*,org.aspcfs.modules.registrazioniAnimali.base.*"%>
	
<link rel="stylesheet" href="https://code.jquery.com/ui/1.9.1/themes/base/jquery-ui.css" />
<!-- <script src="https://code.jquery.com/jquery-1.8.2.js"></script> -->
<!-- <script src="https://code.jquery.com/ui/1.9.1/jquery-ui.js"></script> -->

<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean"
	scope="session" />
<jsp:useBean id="coloniaDaModificare"
	class="org.aspcfs.modules.opu.base.ColoniaInformazioni"
	scope="request" />
<jsp:useBean id="stabilimentoColonia"
	class="org.aspcfs.modules.opu.base.Stabilimento"
	scope="request" />
<jsp:useBean id="operatoreColonia" 	class="org.aspcfs.modules.opu.base.Operatore"
	scope="request" />
<jsp:useBean id="AslList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />
	
	

<script language="javascript" SRC="javascript/CalendarPopup2.js"></script>
<script language="JavaScript" TYPE="text/javascript"
	SRC="javascript/dateControl.js"></script>
<!-- 
<script language="javascript" ID="js19">
var cal19 = new CalendarPopup();
cal19.showYearNavigation();
cal19.showYearNavigationInput();
</SCRIPT>
 -->

<script language="JavaScript">

$( 'document' ).ready( function(){
	calenda('dataCambioDimensioneColonia','','0');
});

function doCheck(form){
	formTest = true;
	message = "";
//	alert($('#nuovaDimensione').val());
	if ($('#nuovaDimensione').val() == null || $('#nuovaDimensione').val() == ''){
		//alert('ddd');
		formTest = false;
		message += "Specifica una nuova dimensione della colonia \r\n";
	}

	if ($('#dataCambioDimensioneColonia').val() == null || $('#dataCambioDimensioneColonia').val() == ''){
		//alert('ddd');
		formTest = false;
		message += "Specifica una data per il nuovo censimento \r\n";
	}

	if (parseInt($('#nuovaDimensione').val(), 10) < parseInt($('#nrGattiCensiti').val(), 10)){
		formTest = false;
		message += "La nuova dimensione della colonia � minore dei gatti gi� censiti. Specifica un numero diverso o procedi alla modifica dei gatti gi� appartenenti alla colonia \r\n";
		}

	 
    if (formTest == false) {
      alert(label("check.form", "Impossibile proseguire, per favore verifica i seguenti problemi:\r\n\r\n") + message);
      return false;
    }
    else
    {
    	
    	
    	return true;
    }
}


</script>

<%@ include file="../initPage.jsp"%>
<dhv:evaluate if="<%= !isPopup(request) %>">
	<%-- Trails --%>
	<table class="trails" cellspacing="0">
		<tr>
			<td width="100%"><a href="OperatoreAction.do"><dhv:label
				name="">Colonia</dhv:label></a> > <dhv:label
				name="">Modifica dimensione colonia</dhv:label>
			</td>
		</tr>
	</table>
	<%-- End Trails --%>
</dhv:evaluate>
<body>

<form name="modificaDimensioneColonia"
	action="OperatoreAction.do?command=ModificaDimensioneColonia&auto-populate=true"
	method="post" onsubmit="javascript:return checkForm();">


<table cellpadding="4" cellspacing="0" border="0" width="100%"
	class="details">
	<tr>
		<th colspan="2"><strong><dhv:label name="">Informazioni colonia</dhv:label></strong>
		</th>
	</tr>

	<tr>
		<td class="formLabel" nowrap> Asl di riferimento </td>
		<td><%=AslList.getSelectedValue(stabilimentoColonia.getIdAsl()) %></td>
		<input type="hidden" name="idAslRiferimento" id="idAslRiferimento"
			value="<%=User.getSiteId() %>" />
	</tr>
	<tr>
		<td class="formLabel" nowrap>Protocollo</td>
		<td><%=coloniaDaModificare.getNrProtocollo() %></td>
	</tr>
	<input type="hidden" name="idRelazioneStabilimentoLineaProduttiva" id="idRelazioneStabilimentoLineaProduttiva" value="<%=coloniaDaModificare.getId() %>"/>

	<tr>
		<td class="formLabel" nowrap>Referente</td>
		<td><%=toHtml(operatoreColonia.getRappLegale().getNome() + "  " + operatoreColonia.getRappLegale().getCognome() )%></td>
	</tr>
	<tr>
		<td class="formLabel" nowrap>Dimensione attuale colonia</td>
		<td><%=(coloniaDaModificare.getNrGattiTotale()) %>
		<input type="hidden" name="dimensioneDaModificare" id="dimensioneDaModificare" value="<%=coloniaDaModificare.getNrGattiTotale() %>"/>
		<input type="hidden" name="opId" id="opId" value="<%=coloniaDaModificare.getId() %>"/>
		<input type="hidden" name="nrGattiCensiti" id="nrGattiCensiti" value="<%=coloniaDaModificare.getTotaleIdentificatiSterilizzati() %>" />
		</td>
	</tr>
</table>
</br>
</br>
<table cellpadding="4" cellspacing="0" border="0" width="100%"
	class="details">
	<tr>
		<th colspan="2"><strong><dhv:label name="">Dati della registrazione</dhv:label></strong>
		</th>
	</tr>
	<tr>
		<td class="formLabel" nowrap>Data nuovo censimento</td>
		<td><input type="text" name="dataCambioDimensioneColonia" size="10" id="dataCambioDimensioneColonia" class="date_picker"
				value=""
				nomecampo="dataCambioDimensioneColonia" tipocontrollo="" labelcampo="Data modifica dimensione colonia" />&nbsp;
			<font color="red">*</font></td>
	</tr>
	<tr><td>Nuova dimensione della colonia</td><td>
	<input type="text" value="" id="nuovaDimensione"
		name="nuovaDimensione" /></td></tr>

<tr><td>&nbsp;</td><td>
	<input type="button" value="invia" id="invia"
		name="invia" onclick="if(doCheck(this.form)){this.form.submit()}" /></td></tr>
</table>

</br>
</br>






</form>
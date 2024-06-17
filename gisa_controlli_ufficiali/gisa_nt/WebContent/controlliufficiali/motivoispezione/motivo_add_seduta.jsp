<jsp:useBean id="listaMotiviIspezione" class="java.util.ArrayList" scope="request"/>
<jsp:useBean id="SiteIdList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="Errore" class="java.lang.String" scope="request"/>

<%@ page import="org.aspcfs.modules.vigilanza.base.MotivoIspezione" %>
<%@ page import="org.aspcfs.modules.oia.base.OiaNodo"%>
<%@ page import="java.util.ArrayList"%>

<%@ include file="../../utils23/initPage.jsp" %>

<script src='javascript/modalWindow.js'></script>
<script src="javascript/jquery-1.8.2.js"></script>
<script src="javascript/jquery-ui.js"></script>
<link rel="stylesheet" type="text/css" href="css/modalWindow.css"></link>

<% ArrayList<OiaNodo> listaDialog = (ArrayList<OiaNodo>)request.getAttribute("StrutturaAsl");
String idCbAttivitaObbligatoria = "";
%>	

<div class="documentaleNonStampare">
<DIV ID='modalWindow' CLASS='unlocked'><P CLASS='wait'>Attendere il completamento dell'operazione...</P></DIV>
</div>


<script>


function removeMotivoRiga(idRiga){
	var row = document.getElementById(idRiga);
    row.parentNode.removeChild(row);
    var cb = document.getElementById("cb_"+idRiga);
   	if (cb.checked)
    	cb.checked = false;
}

function checkMotivo(checkbox){
	
	var i = checkbox.value;	
	var idMotivoIspezione = document.getElementById("idMotivoIspezione_"+i).value;	
	var idPiano = document.getElementById("idPiano_"+i).value;	
	var descrizioneTipoMotivo = document.getElementById("descrizioneTipoMotivo_"+i).value;	
	var descrizioneMotivo = document.getElementById("descrizioneMotivo_"+i).value;	
	var idRiga = idMotivoIspezione+"_"+idPiano;
	
	if (checkbox.checked){
		
		// Find a <table> element with id="myTable":
		var table = document.getElementById("tableMotiviSelezionati");
		var rowCount = table.rows.length;
		
// 		if (rowCount > 2) {
// 			alert("Impossibile selezionare un secondo motivo.");
// 			checkbox.checked=false;
// 			return false;
// 		}
		
		var row = table.insertRow(rowCount);
		row.id = idRiga;
		// Insert new cells (<td> elements) at the 1st and 2nd position of the "new" <tr> element:
		var cell1 = row.insertCell(0);
		var cell2 = row.insertCell(1);
		var cell3 = row.insertCell(2);

		// Add some text to the new cells:
		cell1.innerHTML = descrizioneTipoMotivo + "<input type='hidden' id='idMotivoIspezione_"+idRiga+"' name = 'idMotivoIspezione' value = '"+idMotivoIspezione+"'/> <input type='hidden' id='descrizioneMotivoIspezione_"+idRiga+"' name = 'descrizioneMotivoIspezione' value = '"+descrizioneTipoMotivo+"'/> <input type='hidden' id='idPiano_"+idRiga+"' name = 'idPiano' value = '"+idPiano+"'/> <input type='hidden' id='descrizionePiano_"+idRiga+"' name = 'descrizionePiano' value = '"+descrizioneMotivo+"'/> <input type='hidden' id='perContoDi_"+idRiga+"' name = 'perContoDi' value = ''/>";
		cell2.innerHTML = descrizioneMotivo + ' <a href="#" onClick="removeMotivoRiga(\''+idRiga+'\')" id="cancella_cb_'+idMotivoIspezione+'_'+(idPiano > 0 ? idPiano : -1)+'">CANCELLA</a>';
		cell3.innerHTML = '<div id="perContoDiDescrizione_'+idRiga+'"></div> <a href="#" onClick="openPerContoDi(\''+idRiga+'\')">Seleziona Per Conto Di</a>'; 

	}
	else {
		removeMotivoRiga(idRiga);
	}

	}

function openPerContoDi(idRiga){
	
	var tableMotiviSelezionati = document.getElementById("tableMotiviSelezionati");
	var tableMotivi = document.getElementById("tableMotivi");
	var tablePerContoDi = document.getElementById("tablePerContoDi");
	tableMotivi.style.display = "none";
	tablePerContoDi.style.display = "block";
	
	var rows = tableMotiviSelezionati.getElementsByTagName("tr") ;
	for (var i=0; i<rows.length; i++) {
	    if (rows[i].id == idRiga)
	    	rows[i].style.backgroundColor = "yellow";
	    else
	    	rows[i].style.backgroundColor = "";
	}
	
	document.getElementById("idRigaSelezionata").value = idRiga;
	
}

function setPerContoDi(radio){
	var tableMotiviSelezionati = document.getElementById("tableMotiviSelezionati");
	var tableMotivi = document.getElementById("tableMotivi");
	var tablePerContoDi = document.getElementById("tablePerContoDi");
	var idRiga = document.getElementById("idRigaSelezionata").value;
	
	var val = radio.value;
	var uo = radio.getAttribute("uo");
	
	document.getElementById("perContoDi_"+idRiga).value = val;
	document.getElementById("perContoDiDescrizione_"+idRiga).innerHTML = uo;

	document.getElementById("idRigaSelezionata").value = '';
	radio.checked = false;
	
	var rows = tableMotiviSelezionati.getElementsByTagName("tr") ;
	for (var i=0; i<rows.length; i++) {
	    rows[i].style.backgroundColor = "";
	}
	
	tableMotivi.style.display = "block";
	tablePerContoDi.style.display = "none";

}

function checkFormMotivi(form){
	
	var tableMotiviSelezionati = document.getElementById("tableMotiviSelezionati");
		
	var rows = tableMotiviSelezionati.getElementsByTagName("tr") ;
	
	if (rows.length <=2) {
		alert('Selezionare un motivo!');
		return false;
	}
	
	var idMotivoIspezione = '';
	var idPiano = '';
	var perContoDi = '';
	
	var descrizioneMotivoIspezione = '';
	var descrizionePiano = '';
	var descrizionePerContoDi = '';
	
	
	var div = window.opener.listaMotivi;
	div.innerHTML = '';
	
	for (var i=2; i<rows.length; i++) {
		var idRiga = rows[i].id;
		
		idMotivoIspezione = document.getElementById("idMotivoIspezione_"+idRiga).value;
		idPiano = document.getElementById("idPiano_"+idRiga).value;
		
		if (idMotivoIspezione == '' || (idMotivoIspezione == '89' && idPiano == '')){
			alert('Selezionare correttamente il motivo.');
			return false;
		}
		
		descrizioneMotivoIspezione = document.getElementById("descrizioneMotivoIspezione_"+idRiga).value;
		descrizionePiano = document.getElementById("descrizionePiano_"+idRiga).value;
		
		perContoDi = document.getElementById("perContoDi_"+idMotivoIspezione+"_"+idPiano).value;
		
		if (perContoDi == ''){
			alert('Selezionare correttamente il per conto di.');
			return false;
		}
		
		descrizionePerContoDi = document.getElementById("perContoDiDescrizione_"+idMotivoIspezione+"_"+idPiano).innerHTML;
	
		var _idMotivo = document.createElement('input');
		_idMotivo.id = 'idMotivo_' + idMotivoIspezione;
		_idMotivo.name = 'idMotivoTemp';
		_idMotivo.value = idMotivoIspezione;
		_idMotivo.type = 'hidden';
		div.appendChild(_idMotivo);
		
		var _idPiano = document.createElement('input');
		_idPiano.id = 'idPiano_' + idPiano;
		_idPiano.name = 'idPianoTemp';
		_idPiano.value = idPiano;
		_idPiano.type = 'hidden';
		div.appendChild(_idPiano);
		
		var _idPerContoDi = document.createElement('input');
		_idPerContoDi.id = 'idPerContoDi_' + perContoDi;
		_idPerContoDi.name = 'idPerContoDiTemp';
		_idPerContoDi.value = perContoDi;
		_idPerContoDi.type = 'hidden';
		div.appendChild(_idPerContoDi);
	
		var _descrizioneMotivo = document.createElement('label');
		_descrizioneMotivo.id = 'descrizioneMotivo_' + idMotivoIspezione;
		_descrizioneMotivo.name = 'descrizioneMotivo';
		_descrizioneMotivo.innerHTML = '<br/><i>'+descrizioneMotivoIspezione+'</i><br/>';
		div.appendChild(_descrizioneMotivo);
	
		var _descrizionePiano = document.createElement('label');
		_descrizionePiano.id = 'descrizionePiano_' + idPiano;
		_descrizionePiano.name = 'descrizionePiano';
		_descrizionePiano.innerHTML = '<b>'+descrizionePiano+'</b><br/>';
		div.appendChild(_descrizionePiano);
		
		var _descrizionePerContoDi = document.createElement('label');
		_descrizionePerContoDi.id = 'descrizionePerContoDi_' + perContoDi;
		_descrizionePerContoDi.name = 'descrizionePerContoDi';
		_descrizionePerContoDi.innerHTML = descrizionePerContoDi+'<br/>';
		div.appendChild(_descrizionePerContoDi);
	
	}
	
	window.close();
}

</script>

<script>

function filtraRigheMotivi() {
	  // Declare variables
	  var input, filter, table, tr, td, i, txtValue;
	  input1 = document.getElementById("myInputTipoMotivo");
	  input2 = document.getElementById("myInputDescrizioneMotivo");
	  
	  filter1 = input1.value.toUpperCase();
	  filter2 = input2.value.toUpperCase();
	  
	  table = document.getElementById("tableMotivi");
	  tr = table.getElementsByTagName("tr");

	  // Loop through all table rows, and hide those who don't match the search query
	  for (i = 0; i < tr.length; i++) {
	    td0 = tr[i].getElementsByTagName("td")[0];
	    td1 = tr[i].getElementsByTagName("td")[1];
	    td2 = tr[i].getElementsByTagName("td")[2];
	    
	    if (td0) {
	      txtValue0 = td0.textContent || td0.innerText;
	      txtValue1 = td1.textContent || td1.innerText;
	      txtValue2 = td2.textContent || td2.innerText;
	      
	      if (txtValue1.toUpperCase().indexOf(filter1) > -1 && txtValue2.toUpperCase().indexOf(filter2) > -1) {
	        tr[i].style.display = "";
	      } else {
	        tr[i].style.display = "none";
	      }
	    }
	  }
	}
	
	
function filtraRighePerContoDi() {
  // Declare variables
  var input, filter, table, tr, td, i, txtValue;
  input0 = document.getElementById("myInputAsl");
  input1 = document.getElementById("myInputTipologia");
  input2 = document.getElementById("myInputDescrizione");
  input3 = document.getElementById("myInputStruttura");
  
  filter0 = input0.value.toUpperCase();
  filter1 = input1.value.toUpperCase();
  filter2 = input2.value.toUpperCase();
  filter3 = input3.value.toUpperCase();
  
  table = document.getElementById("tablePerContoDi");
  tr = table.getElementsByTagName("tr");

  // Loop through all table rows, and hide those who don't match the search query
  for (i = 0; i < tr.length; i++) {
    td0 = tr[i].getElementsByTagName("td")[0];
    td1 = tr[i].getElementsByTagName("td")[1];
    td2 = tr[i].getElementsByTagName("td")[2];
    td3 = tr[i].getElementsByTagName("td")[3];
    
    if (td0) {
      txtValue0 = td0.textContent || td0.innerText;
      txtValue1 = td1.textContent || td1.innerText;
      txtValue2 = td2.textContent || td2.innerText;
      txtValue3 = td3.textContent || td3.innerText;
      
      if (txtValue0.toUpperCase().indexOf(filter0) > -1 && txtValue1.toUpperCase().indexOf(filter1) > -1 && txtValue2.toUpperCase().indexOf(filter2) > -1 && txtValue3.toUpperCase().indexOf(filter3) > -1 ) {
        tr[i].style.display = "";
      } else {
        tr[i].style.display = "none";
      }
    }
  }
}
</script>


<% if (Errore!=null && !Errore.equals("") && !Errore.equals("null")){ %>
<script>
alert('<%=Errore%>');
</script>
<% } %>
<form id = "addMotivi" name="addMotivi" action="Vigilanza.do?command=InsertMotivoCUNew&auto-populate=true" method="post">

<table class="details" id="tableMotiviSelezionati" name="tableMotiviSelezionati" cellpadding="10" cellspacing="10" width="100%" style="border-collapse: collapse">
 <tr><th colspan="3">Motivi</th></tr>
 <tr><th>Tipo motivo</th><th>Descrizione</th><th>Per conto di</th></tr>
</table>

<br/>

<center><input type="button" value="conferma" onClick="checkFormMotivi(this.form)"/></center>

</form>
 
<br/><br/><br/>

<table class="details" id ="tableMotivi" name="tableMotivi" cellpadding="10" cellspacing="10" width="100%" style="border-collapse: collapse">

<tr>
<th>Seleziona</th>
<th>Tipo motivo</th>
<th>Descrizione</th>
</tr>

<tr>
<th></th>
<th><input type="text" id="myInputTipoMotivo" onkeyup="filtraRigheMotivi()" placeholder="FILTRA TIPO MOTIVO" size="20"></th>
<th><input type="text" id="myInputDescrizioneMotivo" onkeyup="filtraRigheMotivi()" placeholder="FILTRA DESCRIZIONE" size="20"></th>
<th></th>
</tr>

<% 
for (int i = 0; i<listaMotiviIspezione.size(); i++) {
MotivoIspezione motivo = (MotivoIspezione) listaMotiviIspezione.get(i); 
if ("ATTIVITA-ISPEZIONE OBBLIGATORIA".equalsIgnoreCase(motivo.getTipoAttivita()))
	idCbAttivitaObbligatoria = "cb_"+motivo.getIdMotivoIspezione()+"_"+motivo.getIdPiano();
%>

<tr>
<td><input type="checkbox" value="<%=i %>" onClick="checkMotivo(this)" id ="cb_<%= motivo.getIdMotivoIspezione()%>_<%=motivo.getIdPiano()%>"/></td>
<td><%= motivo.getIdMotivoIspezione() == 89 ? motivo.getDescrizioneMotivoIspezione() : "ATTIVITA" %></td>
<td><%= motivo.getIdMotivoIspezione() == 89 ? motivo.getDescrizionePiano() : motivo.getDescrizioneMotivoIspezione() %></td>

<input type="hidden" id="idMotivoIspezione_<%=i %>" name="idMotivoIspezione_<%=i %>" value="<%= motivo.getIdMotivoIspezione() %>"/>
<input type="hidden" id="idPiano_<%=i %>" name="idPiano_<%=i %>" value="<%= motivo.getIdMotivoIspezione() == 89 ? motivo.getIdPiano() : "-1" %>"/>
<input type="hidden" id="descrizioneTipoMotivo_<%=i %>" name="descrizioneTipoMotivo_<%=i %>" value="<%= motivo.getIdMotivoIspezione() == 89 ? motivo.getDescrizioneMotivoIspezione() : "ATTIVITA" %>"/>
<input type="hidden" id="descrizioneMotivo_<%=i %>" name="descrizioneMotivo_<%=i %>" value="<%= motivo.getIdMotivoIspezione() == 89 ? motivo.getDescrizionePiano() : motivo.getDescrizioneMotivoIspezione() %>"/>

</tr>

<% } %>
</table>


<table cellpadding="4" cellspacing="0" width="100%" class="details" id="tablePerContoDi" style="display:none">
<tr><th colspan="5">
<font color="red">Attenzione! Di seguito sono riportate tutte le strutture presenti nello strumento di calcolo per cui � stato eseguito il "Salva e Chiudi".<br>
Qualora non fossero presenti le strutture desiderate, controllare che figurino correttamente nello strumento di calcolo e che quest'ultimo sia stato Salvato/Chiuso.
</font>
</th></tr>
<tr>
<th>ASL</th>
<th>TIPOLOGIA STRUTTURA</th>
<th>DESCRIZIONE STRUTTURA</th>
<th>STRUTTURA DI APPARTENENZA</th>
<th></th>
</tr>

<tr>
<th><input type="text" id="myInputAsl" onkeyup="filtraRighePerContoDi()" placeholder="FILTRA ASL" size="10"></th>
<th><input type="text" id="myInputTipologia" onkeyup="filtraRighePerContoDi()" placeholder="FILTRA TIPOLOGIA" size="20"></th>
<th><input type="text" id="myInputDescrizione" onkeyup="filtraRighePerContoDi()" placeholder="FILTRA DESCRIZIONE" size="20"></th>
<th><input type="text" id="myInputStruttura" onkeyup="filtraRighePerContoDi()" placeholder="FILTRA STRUTTURA" size="20"></th>
<th></th>
</tr>
	
	<%
	if(listaDialog.size()>0){
	for (OiaNodo nodoAsl : listaDialog)
	{
		if(nodoAsl.getLista_nodi().size()>0)
		{
			for (OiaNodo nodoFiglio :nodoAsl.getLista_nodi() )
			{
				if (nodoFiglio.getTipologia_struttura()!=13 && nodoFiglio.getTipologia_struttura()!=14)
				{
				%>
				
				<tr>
				<td><%= SiteIdList.getSelectedValue( nodoFiglio.getId_asl())%></td>
				<td><%= toHtml(nodoFiglio.getDescrizione_tipologia_struttura())%></td>
				<td><label id="descrizionePerContoDi<%=nodoFiglio.getId()%>"><%=nodoFiglio.getDescrizione_lunga() %></label></td>
				<td><%=nodoAsl.getDescrizione_lunga() %></td>
				<td><input type="radio" onClick="setPerContoDi(this)" uo="<%=nodoAsl.getDescrizione_lunga().replaceAll("\"", "")+"->"+nodoFiglio.getDescrizione_lunga().replaceAll("\"", "")  %>" name = "uoSelect" value="<%=nodoFiglio.getId()%>" ></td>
				</tr>
				
				<%}
			}
			
			for (OiaNodo nodoFiglio :nodoAsl.getLista_nodi() )
			{
				if(nodoFiglio.getLista_nodi().size()>0)
				{
									
					for (OiaNodo nipote :nodoFiglio.getLista_nodi() )
					{
						if (nipote.getTipologia_struttura()!=13 && nipote.getTipologia_struttura()!=14)
						{
						%>
						<tr>
				
			<td><%= SiteIdList.getSelectedValue( nipote.getId_asl())%></td>
				<td><%= toHtml(nipote.getDescrizione_tipologia_struttura())%></td>
				<td><%=nipote.getDescrizione_lunga() %></td>
				<td><label id="descrizionePerContoDi<%=nipote.getId()%>"><%=nodoFiglio.getDescrizione_lunga() %></label></td>
				<td><input type="radio" onClick="setPerContoDi(this)" uo="<%=nodoFiglio.getDescrizione_lunga().replaceAll("\"", "")+"->"+nipote.getDescrizione_lunga().replaceAll("\"", "")  %>" name = "uoSelect" value="<%=nipote.getId()%>" ></td>
				
					</tr>	<%}
						
					}
				}
				
				
			}
		}
		
	}
	}
	else
	{
		%>
		<tr>
		<td colspan="5">ATTENZIONE! NESSUN STRUTTURA PRESENTE</td>
		</tr>
		<%
	}
	%>
	
</table>

<input type="hidden" id="idRigaSelezionata" name="idRigaSelezionata"/>


<script>


 var openerMotivi = opener.document.getElementsByName("idMotivoTemp");
 var openerPiani = opener.document.getElementsByName("idPianoTemp");
 var openerPerContoDi = opener.document.getElementsByName("idPerContoDiTemp"); 

 	for (var i = 0; i<openerMotivi.length; i++) {
 		var idMotivo = openerMotivi[i].value;
 		var idPiano = openerPiani[i].value;
 		var idPerContoDi = openerPerContoDi[i].value; 
 		var descrizionePerContoDi = opener.document.getElementById("descrizionePerContoDi_"+idPerContoDi).innerHTML;
 		document.getElementById("cb_"+idMotivo+"_"+idPiano).checked = true;	
 		checkMotivo(document.getElementById("cb_"+idMotivo+"_"+idPiano));
 		document.getElementById("perContoDi_"+idMotivo+"_"+idPiano).value = idPerContoDi; 
 		document.getElementById("perContoDiDescrizione_"+idMotivo+"_"+idPiano).innerHTML = descrizionePerContoDi;
		
 	}




</script>

<% if (idCbAttivitaObbligatoria!=null && !"".equals(idCbAttivitaObbligatoria)){ %>
<script>
if (document.getElementById("<%=idCbAttivitaObbligatoria%>").checked == false) {
	document.getElementById("<%=idCbAttivitaObbligatoria%>").click();
}
	document.getElementById("<%=idCbAttivitaObbligatoria%>").disabled = true;
	document.getElementById("cancella_<%=idCbAttivitaObbligatoria%>").style.display = "none";
</script>
<% } %>


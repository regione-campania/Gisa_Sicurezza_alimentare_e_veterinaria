<%@page import="java.util.*"%>
<%@ page import="java.util.*,java.text.DateFormat,java.text.SimpleDateFormat,org.aspcfs.modules.accounts.base.*,org.aspcfs.modules.opu.base.*,org.aspcfs.modules.contacts.base.*,org.aspcfs.modules.base.Constants" %>
<%@page import="org.aspcfs.modules.gestioneanagrafica.base.*"%>
<jsp:useBean id="ListaOperazioni" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="StabilimentoDettaglio" class="org.aspcfs.modules.opu.base.Stabilimento" scope = "request"/>

<script src="javascript/vendor/moment.min.js"></script>
<script src="javascript/noscia/addNoScia.js"></script>
<script type="text/javascript" src="dwr/interface/DWRnoscia.js"> </script>
<script type="text/javascript" src="dwr/interface/SuapDwr.js"> </script>

<script  src="dwr/interface/PopolaCombo.js"> </script>
<script type="text/javascript" src="dwr/engine.js"> </script>
<script type="text/javascript" src="dwr/util.js"></script>
<script src="javascript/gestioneanagrafica/add.js"></script>

<%
	boolean flagLineeScia = false;
	for(int i = 0; i < StabilimentoDettaglio.getListaLineeProduttive().size(); i++ ){
		LineaProduttiva l = (LineaProduttiva) StabilimentoDettaglio.getListaLineeProduttive().get(i);
		if(!l.getFlags().isNoScia())
		{
			flagLineeScia = true;
			break;
		}
	}
	%>

<table class="trails" cellspacing="0">
	<tr>
		<td>
			<a href="OpuStab.do?command=SearchForm">ANAGRAFICA STABILIMENTI</a> > 
			<a href="GestioneAnagraficaAction.do?command=Details&altId=${altId}"> SCHEDA</a> >  RIATTIVA LINEE SOSPESE
		</td>
	</tr>
</table>
<% ArrayList<LineaVariazione> listaLinee = (ArrayList<LineaVariazione>) request.getAttribute("ListaLinee"); %>
<input type="hidden" id="numero_linee" value="<%=listaLinee.size() %>" />

<form class="form-horizontal" role="form" method="post" action="GestioneAnagraficaAction.do?command=GestioneSospendiRiattiva" onsubmit="return validateForm();">
<b>MODIFICA SCHEDA: RIATTIVA LINEE SOSPESE</b><br>
<input type="hidden" id="stabId" name="stabId" value="<%=StabilimentoDettaglio.getIdStabilimento()%>"/>
<input type="hidden" id="altId" name="altId" value="<%=StabilimentoDettaglio.getAltId()%>"/>

<div id="dati_pratica" style="border: 1px solid black; background: #BDCFFF">
<br>
&nbsp;&nbsp;&nbsp;&nbsp;NUMERO PRATICA: ${numeroPratica} <br>
&nbsp;&nbsp;&nbsp;&nbsp;DATA PEC / DATA SCIA: ${dataPratica} <br>
<br>
<input type="hidden" id="numeroPratica" name="numeroPratica" value="${numeroPratica}"/>
<input type="hidden" id="idTipologiaPratica" name="idTipologiaPratica" value="${tipoPratica}"/>
<input type="hidden" id="idComunePratica" name="idComunePratica" value="${comunePratica}"/>
<input type="hidden" id="causaleRicevuta" value="${id_causale}">
</div>
<br/>

<%if(flagLineeScia){ %>

	<jsp:include page="include/sezione_gestione_causale.jsp"/>
	
	<div id="operazione_scheda" style="display: none">
<% } else { %>
	<input type="hidden" id="id_causale" name="_b_id_causale" value="5">
	<input type="hidden" id="data_pratica" name="_b_data_pratica" value="<%=(new SimpleDateFormat("dd-MM-yyyy")).format(Calendar.getInstance().getTime())%>">
	<input type="hidden" id="nota_pratica" name="_b_nota_pratica" value="cambio stato: riattivazione linea">
	<div id="operazione_scheda">
<% } %>

<br>

<%if (listaLinee.size()==0) {%>
	<br><br>
	<center>
	<font size="5">
		NESSUNA LINEA MODIFICABILE TRAMITE RIATTIVAZIONE LINEE SOSPESE
	</font>
	<br><br>
	<center>
	<button type="button" id="torna" class="yellowBigButton" style="width: 250px;"
		onClick="loadModalWindowCustom('Attendere Prego...'); window.location.href='GestionePraticheAction.do?command=ListaPraticheStabilimenti'">Annulla</button>
	</center>
<%} else {%>
	<center>
	<table class="details" id="tabella_stab" cellspacing="0" border="0" width="100%" cellpadding="4">
	<tbody>
		<tr>
			<td class="formLabel"><p>riattiva tutte le linee di attivita' sospese</p></td>
			<td>
				<input type="hidden" id="data_inizio_stab" value="<%=StabilimentoDettaglio.getDataInizioAttivitaString().replaceAll("/", "-") %>">
				&nbsp;RIATTIVARE TUTTE LE LINEE SOSPESE &nbsp; 
				<input type="checkbox" id="riattiva_stabilimento" onclick="gestisciRiattivazioneStab(this)"/>&nbsp;
				<br><font color="red">* spuntando questo campo si sceglie di riattivare tutte le linee sospese dello stabilimento
									(se lo stabilimento ha linee cessate esse non appariranno in questo elenco perch� non possono essere riattivate
									tramite questa operazione)
					</font>
			</td>
		</tr>
		
		<tr id="tr_tipo_operazione" style="display: none">
			<td class="formLabel" style="width:10%"> <p>OPERAZIONE</p></td>
			<td>
				<select id="tipo_operazione" >						
					<option value=""></option>
					<option value="1">RIATTIVAZIONE</option>					
				</select>
			</td>
		</tr>
		
		<tr id="tr_data_riattivazione" style="display: none">
			<td class="formLabel" style="width:10%"> <p>DATA RIATTIVAZIONE</p> </td>
			<td>
				<input placeholder="DATA RIATTIVAZIONE" type="text" id="data_riattivazione" autocomplete="off" onkeydown="return false" size="15" style="text-align:center;">
			</td>
		</tr>
		
	</tbody>
	</table>
	<br>
	<table id="tabella_linee" class="details" width="100%" cellspacing="0" cellpadding="4" border="0">
		<tr>
			<th colspan="6">riattivazione linee sospese</th>
		</tr>
		<%for(int i=0; i < listaLinee.size(); i++){%>
			
			<tr class="row<%=1%2 %>">
				<td colspan="6">
					<b>linea attivit�</b>:&nbsp;&nbsp;&nbsp;&nbsp;<%=listaLinee.get(i).getDesc_linea() %>
					<input type="hidden" id="lineaattivita_<%=i%>_rel_stab_lp" name="_b_lineaattivita_<%=i%>_rel_stab_lp" 
						value="<%=listaLinee.get(i).getId_rel_stab_lp() %>" />
				</td>
			</tr>
			<tr class="row<%=1%2 %>">
				<td><b>STATO</b></td>
				<td>
					<%=listaLinee.get(i).getDesc_stato_lp() %>
					<input type="hidden" id="lineaattivita_<%=i%>_stato" name="_b_lineaattivita_<%=i%>_stato" 
						value="<%=listaLinee.get(i).getId_stato_lp() %>"/>
					<br>
					(<%=listaLinee.get(i).getDesc_stato_secondo_livello() %>)
				</td>
				<td><b>OPERAZIONE</b></td>
				<td>
					<select id="lineaattivita_<%=i%>_tipo_operazione" name="_b_lineaattivita_<%=i%>_tipo_operazione" onchange="gestione_cambio_stato('<%=i%>')">
						<%if(listaLinee.get(i).getId_stato_lp() == 0){ %>
							<option value="-1"></option>
							<option value="2">SOSPENSIONE VOLONTARIA</option>
							<!-- <option value="3">SOSPENSIONE FORZATA</option> -->
							<!-- <option value="4">SOSPENSIONE D'UFFICO</option> -->
						<%} %>
						<%if(listaLinee.get(i).getId_stato_lp() == 4){ %>
							<option value="-1"></option>
						<%} %>
						<%if(listaLinee.get(i).getId_stato_lp() == 2){ %>
							<option value="-1"></option>
							<option value="1">RIATTIVAZIONE</option>
						<%} %>
					</select>
				</td>
				<td><b>DATA RIATTIVAZIONE</b></td>
				<td align="center">
					<input type="text" size="10" onkeydown="return false" style="text-align:center;" placeholder="data" 
						id="lineaattivita_<%=i%>_data_variazione" name="_b_lineaattivita_<%=i%>_data_variazione"/>
						
					<input type="hidden" id="data_sospensione_lp_<%=i%>" name="data_sospensione_lp_<%=i%>" 
						value="<%=listaLinee.get(i).getDataUltimaVariazione().replaceAll("/", "-") %>">
				</td>
			</tr>
			<tr class="row<%=1%2 %>" style="display: none;">
				<td><b>CONTROLLO UFFICIALE</b></td>
				<td colspan="5">
					<input type="text" id="lineaattivita_<%=i %>_id_cu" name="_b_lineaattivita_<%=i %>_id_cu" readonly/> 
					[<a href="#" onclick="document.getElementById('lineaattivita_<%=i %>_id_cu').value=''">CANCELLA</a>]
					<%if(listaLinee.get(i).getLista_cu().size()>0 && listaLinee.get(i).getLista_cu().get(0) != 0) {%>
						<%for(int j=0; j<listaLinee.get(i).getLista_cu().size(); j++){ %>
							<a href="#" onclick="document.getElementById('lineaattivita_<%=i %>_id_cu').value=<%=listaLinee.get(i).getLista_cu().get(j) %>"><%=listaLinee.get(i).getLista_cu().get(j) %></a>
						<%} %>
					<%} %>
				</td>
			</tr>
			<%if(i != listaLinee.size()-1 ){ %>
				<tr>
					<td colspan="6"></td>
				</tr>
			<%} %>
		<%} %>
	</table>
	</center>
	<br><br>
	<center>
	
	<button type="submit" class="yellowBigButton" style="width: 250px;">Salva</button>
	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	
	<button type="button" id="torna" class="yellowBigButton" style="width: 250px;"
		onClick="loadModalWindowCustom('Attendere Prego...'); window.location.href='GestionePraticheAction.do?command=ListaPraticheStabilimenti'">Annulla</button>
	
	</center>
	<br>
<%} %>
</div>
</form>

<script>

function validateForm(){
	
	if(document.getElementById('riattiva_stabilimento').checked){
		var tipo_operazione_riattivazione = document.getElementById('tipo_operazione').value;
		var data_operazione = document.getElementById('data_riattivazione').value;
		
		for(i=0; i<numero_linee; i++){
			document.getElementById('lineaattivita_' + i + '_tipo_operazione').value = tipo_operazione_riattivazione;
			document.getElementById('lineaattivita_' + i + '_data_variazione').value = data_operazione;
		}
	} else { // se non si mette il check su sospendi intero osa
		//verifica di aver modificato almeno una linea
		var numero_linee_variate = 0;
		for(i=0; i<numero_linee; i++){
			if(document.getElementById('lineaattivita_' + i + '_tipo_operazione').value != '-1'){
				numero_linee_variate ++;
			}
		}
		if(numero_linee_variate == 0){
			alert('Attenzione, non � stata variata nessuna linea di attivit�');
			return false
		}
		
		//verifica date tra cu e data variazione
		for(i=0; i<numero_linee; i++){
			if(document.getElementById('lineaattivita_' + i + '_tipo_operazione').value != '-1' 
						&& document.getElementById('lineaattivita_' + i + '_id_cu').value != ''){
				
				var id_cu = document.getElementById('lineaattivita_' + i + '_id_cu').value;
				var data_variazione = document.getElementById('lineaattivita_' + i + '_data_variazione').value;
				var url = "GestioneAnagraficaControlloDateCuVariazione.do?command=Search&id_cu="+id_cu+"&data_variazione="+data_variazione;
				var esito = "";
				var request = $.ajax({
					url : url,
					dataType : "json",
					async: false
				});
	
				request.done(function(result) {
					esito = result.esito;
				});
				
				request.fail(function(jqXHR, textStatus) {
					console.log('Error');
				});
				
				if(esito == '0'){
					var messaggio = "Impossibile aggiornare lo stato per la linea associata al controllo "
									+id_cu+". Data di variazione indicata ("
									+data_variazione+") risulta antecedente alla data del CU";
					alert(messaggio);
					return false;
				}
			}
		}
	}
	
	loadModalWindowCustom('Attendere Prego...');
	return true;
}

var numero_linee = document.getElementById('numero_linee').value;
if(numero_linee != '0'){
	for(i=0; i<numero_linee; i++){

		var data_inizio_linea_da_riattivare = document.getElementById('data_sospensione_lp_' + i).value;
		popup_date_riattiva('lineaattivita_' + i + '_data_variazione', data_inizio_linea_da_riattivare);
	}
	
	//setto limite inferiore data riattivazione come max tra le data_inizio_linea_da_riattivare
	var data_start = document.getElementById('data_inizio_stab').value.split('-');
	var data_riferimento = new Date(data_start[2] + '-' + data_start[1] + '-' + data_start[0]);
	popup_date_riattiva('data_riattivazione', document.getElementById('data_inizio_stab').value);
	for(i=0; i<numero_linee; i++){
		
		var data_linea = document.getElementById('data_sospensione_lp_' + i).value.split('-');
		var data_iesima_linea = new Date(data_linea[2] + '-' + data_linea[1] + '-' + data_linea[0]);
		if(data_iesima_linea > data_riferimento){
			document.getElementById('data_inizio_stab').value = document.getElementById('data_sospensione_lp_' + i).value;
			data_riferimento = data_iesima_linea;
		}
	}
	popup_date_riattiva('data_riattivazione', document.getElementById('data_inizio_stab').value);
}

function gestione_cambio_stato(iesima_linea){
	
	var data_inizio_linea_da_riattivare = document.getElementById('data_sospensione_lp_' + iesima_linea).value;
	if(document.getElementById('lineaattivita_' + iesima_linea + '_tipo_operazione').value != '-1'){
		document.getElementById('lineaattivita_' + iesima_linea + '_data_variazione').setAttribute('required', '');
		popup_date_riattiva('lineaattivita_' + iesima_linea + '_data_variazione', data_inizio_linea_da_riattivare);
		//popup_date('lineaattivita_' + iesima_linea + '_data_variazione');
	} else {
		document.getElementById('lineaattivita_' + iesima_linea + '_data_variazione').removeAttribute('required');
		document.getElementById('lineaattivita_' + iesima_linea + '_data_variazione').value = '';
		popup_date_riattiva('lineaattivita_' + iesima_linea + '_data_variazione', data_inizio_linea_da_riattivare);
		//popup_date('lineaattivita_' + iesima_linea + '_data_variazione');
	}
}

if(document.getElementById('causaleRicevuta').value != '1'){
	document.getElementById('dati_pratica').style.display = 'none';
	document.getElementById('torna').onclick = function(){
		loadModalWindowCustom('Attendere Prego...');
		window.location.href='GestioneAnagraficaAction.do?command=Details&altId='+ document.getElementById('altId').value;
	};
}else{
	document.getElementById('id_causale').value = "1";
	document.getElementById('specifica_causale').style='display: none';
	document.getElementById('operazione_scheda').style='display:'
}

function popup_date_riattiva(elemento_html_data, min_data){
	$( '#' + elemento_html_data ).datepicker({
		  dateFormat: 'dd-mm-yy',
		  changeMonth: true,
		  changeYear: true,
		  yearRange: '-100:+3',
		  minDate: min_data,	  
		  maxDate: 0,
		  dayNamesMin : [ 'do', 'lu', 'ma', 'me', 'gi', 've', 'sa' ],
		  monthNamesShort :['Gennaio','Febbraio','Marzo','Aprile','Maggio','Giugno', 'Luglio','Agosto','Settembre','Ottobre','Novembre','Dicembre'],
		  beforeShow: function(input, inst) {
              setTimeout(function () {
                         var offsets = $('#' + elemento_html_data).offset();
                         var top = offsets.top - 100;
                         var left = offsets.left - 50;
                         inst.dpDiv.css({ top: top, left: left});
                         $(".ui-datepicker-next").hide();
							$(".ui-datepicker-prev").hide();
							$(".ui-state-default").css({'font-size': 15});
							$(".ui-datepicker-title").css({'text-align': 'center'});
							$(".ui-datepicker-calendar").css({'text-align': 'center'});
               });
             },
        onChangeMonthYear: function(year, month, inst) {
              setTimeout(function () {
                         var offsets = $('#' + elemento_html_data).offset();
                         var top = offsets.top - 100;
                         var left = offsets.left - 50;
                         inst.dpDiv.css({ top: top, left: left});
                         $(".ui-datepicker-next").hide();
							$(".ui-datepicker-prev").hide();
							$(".ui-state-default").css({'font-size': 15});
							$(".ui-datepicker-title").css({'text-align': 'center'});
							$(".ui-datepicker-calendar").css({'text-align': 'center'});
               });
             }                                                  
		});
}

function gestisciRiattivazioneStab(campo_check){
	if(campo_check.checked){
		document.getElementById('tabella_linee').style.display = 'none';
		document.getElementById('tr_tipo_operazione').style.display = '';
		document.getElementById('tr_data_riattivazione').style.display = '';
		document.getElementById('data_riattivazione').setAttribute('required', '');
		document.getElementById('tipo_operazione').setAttribute('required', '');
		for(i=0; i<numero_linee; i++){
			document.getElementById('lineaattivita_' + i + '_tipo_operazione').value = '-1';
			document.getElementById('lineaattivita_' + i + '_id_cu').value = '';
			document.getElementById('lineaattivita_' + i + '_data_variazione').removeAttribute('required');
			document.getElementById('lineaattivita_' + i + '_data_variazione').value = '';
			var data_inizio_linea_da_riattivare = document.getElementById('data_sospensione_lp_' + i).value;
			popup_date_riattiva('lineaattivita_' + i + '_data_variazione', data_inizio_linea_da_riattivare);
		}
	} else {
		document.getElementById('tabella_linee').style.display = '';
		document.getElementById('tr_tipo_operazione').style.display = 'none';
		document.getElementById('tr_data_riattivazione').style.display = 'none';
		document.getElementById('data_riattivazione').removeAttribute('required');
		document.getElementById('data_riattivazione').value = '';
		document.getElementById('tipo_operazione').removeAttribute('required');
		document.getElementById('tipo_operazione').value = '';		
	}
}

</script>



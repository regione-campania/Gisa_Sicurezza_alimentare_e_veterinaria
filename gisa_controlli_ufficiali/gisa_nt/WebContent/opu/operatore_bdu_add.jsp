<%@page import="org.aspcfs.modules.opu.base.Stabilimento"%>

<%@page import="org.aspcfs.modules.opu.base.LineaProduttiva"%>

<%@page import="org.aspcfs.modules.opu.base.LineaProduttivaList"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.aspcfs.modules.opu.base.SoggettoFisico"%><jsp:useBean id="newStabilimento"
	class="org.aspcfs.modules.opu.base.Stabilimento" scope="request" />
<!-- sede inserita -->
<jsp:useBean id="AslList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />

<jsp:useBean id="ListaLineeProduttive"
	class="org.aspcfs.modules.opu.base.LineaProduttivaList" scope="request" />

<script language="JavaScript" TYPE="text/javascript"
	SRC="javascript/gestoreCodiceFiscale.js"></script>


<script>
function CalcolaCF() {
	
  		var nomeCalc=""; var cognomeCalc=""; var comuneCalc=""; var nascitaCalc ="";
  		var giorno=""; var mese=""; var anno=""; var sesso="";var comuneResidenza= "" ;
  
  		if ( document.forms[0].sesso[0].checked )
  			sesso = "M";
  		else
  			sesso = "F";
			
  		if ( document.forms[0].nome.value != "" ) {
  			nomeCalc =  document.forms[0].nome.value;
			nomeCalc=nomeCalc.replace(/^\s+|\s+$/g,"").replace(/'/g,"");
  		}
  	
  		if ( document.forms[0].cognome.value  != "" ) {
  			cognomeCalc = document.forms[0].cognome.value;
  			cognomeCalc=cognomeCalc.replace(/^\s+|\s+$/g,"").replace(/'/g,"");
  		}    
  
  		if ( document.forms[0].comuneNascita.value != "" ) {
  			comuneCalc = document.forms[0].comuneNascita.value;
  		}  

  		

  		
  	
  		if ( document.forms[0].dataNascita.value != "" ) {
  			nascitaCalc = document.forms[0].dataNascita.value;
  			giorno = nascitaCalc.substring(0,2);
  			mese = nascitaCalc.substring(3,5);
  			anno = nascitaCalc.substring(6,10);
  		}  
		

  	if (cognomeCalc!="" && nomeCalc!="" && giorno!= "" && mese!="" && anno!= "" && sesso!= "" && comuneCalc!=""){
  	  	codCF= CalcolaCodiceFiscaleCompleto(cognomeCalc, nomeCalc, giorno, mese, anno, sesso, comuneCalc);
  	  	if (codCF=='[Comune non presente in banca dati]')
  	  	  	alert(codCF);
  	  	else
		document.getElementById('codFiscaleSoggetto').value=codCF ;
		
  		}
  	else
  	  	alert('Inserire tutti i campi necessari per il calcolo del codice fiscale ed il comune di residenza');
  		
  	}
    

  
</script>

<script> 

var tipologia_privato = '<%=LineaProduttiva.idAggregazionePrivato%>' ;
var tipologia_sindaco = '<%=LineaProduttiva.idAggregazioneSindaco%>' ;
var tipologia_sindaco_fr = '<%=LineaProduttiva.idAggregazioneSindacoFR%>' ;
var tipologia_colonia = '<%=LineaProduttiva.idAggregazioneColonia%>' ;
function Associa()
{
var selectIndirizzo= document.getElementById('via');
alert("id: "+selectIndirizzo.selectedIndex);
var indText = selectIndirizzo.options[selectIndirizzo.selectedIndex].innerHTML;
alert("via: "+indText);
document.getElementById('via').value=selectIndirizzo.selectedIndex;
alert("Nuova via: "+document.getElementById('via').value);
document.getElementById('viaTesto	').value=indText;
alert("Nuova viaTesto: "+document.getElementById('viaTesto').value);
alert("ok");
}
function mostra_pagina()
{//alert(tipologia_colonia);

	if(document.getElementById('idLineaProduttiva').value == tipologia_privato || 
			document.getElementById('idLineaProduttiva').value == tipologia_sindaco || 
			document.getElementById('idLineaProduttiva').value == tipologia_sindaco_fr || 
			document.getElementById('idLineaProduttiva').value == tipologia_colonia

			)
	{
		//document.getElementById('info_stabilimento').style.display="none";
		
		document.getElementById('info_impresa').style.display="none";
		document.getElementById('info_sede').style.display="none";
		document.getElementById('bdu').value = "no";

	}
	else
	{
		document.getElementById('bdu').value = "si";
		document.getElementById('info_sede').style.display="";
		
		//document.getElementById('info_stabilimento').style.display="";
		document.getElementById('info_impresa').style.display="";
		
		
		}
}


function checkLineaProduttiva(){
//	alert('check');
	document.forms[0].doContinueLp.value = 'false';
//	alert(document.forms[0].doContinueLp.value);
	document.forms[0].submit();
}
</script>


<table cellpadding="4" cellspacing="0" border="0" width="100%"
	class="details">
	<tr>
		<th colspan="2"><strong>TIPOLOGIA PROPRIETARIO</strong></th>
	</tr>
	<tr>
		<td nowrap class="formLabel"><dhv:label
			name="opu.stabilimento.linea_produttiva"></dhv:label></td>
		<td><select name="idLineaProduttiva" id="idLineaProduttiva"
			onchange="checkLineaProduttiva()" <%=(User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_LLP")))? "disabled=\"disabled\" " : "" %>  >
			<option value="-1"><dhv:label
				name="opu.stabilimento.linea_produttiva"></dhv:label></option>
			<%
				Iterator itLinee = ListaLineeProduttive.iterator();
				while (itLinee.hasNext()) {
					LineaProduttiva lp = (LineaProduttiva) itLinee.next();
			%>
			<dhv:evaluate if ="<%=( User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_SYSADMINASL")) 
			|| User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_HD1")) ||
			User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_HD2"))) %>">
				<option value="<%=lp.getId()%>"
					<%=(LineaProduttivaScelta.getIdRelazioneAttivita() == lp
									.getId()) ? "selected" : ""%>><%=lp.getAttivita()%>
				</option>
						</dhv:evaluate>
			<dhv:evaluate if="<%=(User.getRoleId() != new Integer(ApplicationProperties.getProperty("ID_RUOLO_SYSADMINASL")) 
			&& User.getRoleId() != new Integer(ApplicationProperties.getProperty("ID_RUOLO_HD1")) &&
			User.getRoleId() != new Integer(ApplicationProperties.getProperty("ID_RUOLO_HD2"))) %>"> 
				<dhv:evaluate if="<%=(lp.getId() == LineaProduttiva.idAggregazionePrivato || lp.getId() == LineaProduttiva.idAggregazioneColonia)%>">
								<option value="<%=lp.getId()%>"
					<%=(LineaProduttivaScelta.getIdRelazioneAttivita() == lp
									.getId()) ? "selected" : ""%>><%=lp.getAttivita()%>
					</option>	
				</dhv:evaluate>
			</dhv:evaluate>
	
				<%
					}
				%>


		</select></td>
	</tr>
</table>
<br>
<input type="hidden" name="doContinueLp" id="doContinueLp" value="" />
<%
	if (LineaProduttivaScelta.getIdRelazioneAttivita() > 0) {
%>

<%
	int i = LineaProduttivaScelta.getIdRelazioneAttivita();
		String label_operatore = "opu.operatore_" + i;
		String label_operatore_rag_sociale = "opu.operatore.ragione_sociale_"
				+ i;
%>
<div id="info_impresa">
<table cellpadding="4" cellspacing="0" border="0" width="100%"
	class="details">
	<tr>
		<th colspan="2"><strong><dhv:label
			name="<%=label_operatore%>"></dhv:label></strong></th>
	</tr>





	<tr>
		<td nowrap class="formLabel"><dhv:label
			name="<%=label_operatore_rag_sociale%>"></dhv:label></td>
		<td><input type="text" size="20" maxlength="200"
			id="ragioneSociale" name="ragioneSociale"
			value="<%=(Operatore.getRagioneSociale() != null) ? Operatore
								.getRagioneSociale()
								: ""%>">
		<font color="red">*</font></td>
	</tr>

	<tr>
		<td nowrap class="formLabel"><dhv:label name="opu.operatore.piva"></dhv:label>
		</td>
		<td><input type="text" size="20" maxlength="11" id="partitaIva"
			name="partitaIva"
			value="<%=(Operatore.getPartitaIva() != null) ? Operatore
						.getPartitaIva() : ""%>">
		<font color="red">*</font></td>
	</tr>

	<tr>
		<td nowrap class="formLabel"><dhv:label name="opu.operatore.cf"></dhv:label>
		</td>
		<td><input type="text" size="20" maxlength="16" id="codFiscale"
			name="codFiscale"
			value="<%=(Operatore.getCodFiscale() != null) ? Operatore
						.getCodFiscale() : ""%>">


		</td>
	</tr>

	<tr>
		<td valign="top" nowrap class="formLabel"><dhv:label
			name="opu.operatore.note"></dhv:label></td>
		<td><TEXTAREA NAME="note" ROWS="3" COLS="50"><%=toString(Operatore.getNote())%></TEXTAREA></td>
	</tr>

</table>
</div>

<br>
<br>
<%
	String label_soggetto_fisico = "opu.soggetto_fisico_" + i;
%>

<%
if (request.getAttribute("Errore")!=null)
{
	SoggettoFisico soggetto = (SoggettoFisico)request.getAttribute("SoggettoEsistente");
	%>
	<font color = "red">Attenzione : il soggetto che si sta censendo risulta anagrafato per un'altra asl. Rivolgersi al Servisio di HelpDesk</font>
	<%
}
%>
<table cellpadding="4" cellspacing="0" border="0" width="100%"
	class="details" >
	<tr>
		<th colspan="2"><strong><dhv:label
			name="<%=label_soggetto_fisico%>"></dhv:label></strong></th>
	</tr>
<dhv:evaluate if="<%=(LineaProduttivaScelta.getIdRelazioneAttivita() != LineaProduttiva.idAggregazioneSindaco && LineaProduttivaScelta.getIdRelazioneAttivita() != LineaProduttiva.idAggregazioneSindacoFR) %>">

	<tr>
		<td class="formLabel"><dhv:label name="opu.sede_legale.inregione"></dhv:label>
		</td>
		<td><select  name="inregione" onchange="checkLineaProduttiva()" id="inregione">
			<option value="si"
				<%=(!stabilimento.isFlagFuoriRegione()) ? "selected"
								: ""%>>SI</option>
			<option value="no"
				<%=(stabilimento.isFlagFuoriRegione()) ? "selected"
						: ""%>>NO</option>
		</select></td>
	</tr>

</dhv:evaluate>

<dhv:evaluate if="<%=(LineaProduttivaScelta.getIdRelazioneAttivita() == LineaProduttiva.idAggregazioneSindaco) %>">

	<tr>
		<td class="formLabel"><dhv:label name="opu.sede_legale.inregione"></dhv:label>
		</td>
		<td><select disabled name="inregione" onchange="checkLineaProduttiva()" id="inregione">
			<option value="si"
				<%=(!stabilimento.isFlagFuoriRegione()) ? "selected"
								: ""%>>SI</option>
		</select></td>
	</tr>

</dhv:evaluate>

<dhv:evaluate if="<%=(LineaProduttivaScelta.getIdRelazioneAttivita() == LineaProduttiva.idAggregazioneSindacoFR) %>">

	<tr>
		<td class="formLabel"><dhv:label name="opu.sede_legale.inregione"></dhv:label>
		</td>
		<td><select disabled name="inregione" onchange="checkLineaProduttiva()" id="inregione">
			<option value="no"
				<%=(stabilimento.isFlagFuoriRegione()) ? "selected"
						: ""%>>NO</option>
		</select></td>
	</tr>

</dhv:evaluate>

	
	<tr>
		<td class="formLabel" nowrap><dhv:label

			name="opu.soggetto_fisico.nome"></dhv:label></td>
		<td><input type="text" size="30" maxlength="50" id="nome" name = "nome">
		
	</tr>
	<tr>
		<td class="formLabel" nowrap><dhv:label
			name="opu.soggetto_fisico.cognome"></dhv:label></td>
		<td><input class="todisable" type="text" size="30" maxlength="50" id="cognome"
			name="cognome" value=""><font color="red">*</font></td>
	</tr>
	

	<tr id="">
		<td class="formLabel" nowrap><dhv:label
			name="opu.soggetto_fisico.sesso"></dhv:label></td>
		<td><input class="todisable" type="radio" name="sesso" id="sesso1" value="M"
			checked="checked">M <input type="radio" name="sesso"
			id="sesso2" value="F">F</td>
	</tr>


	
	<tr>
		<td nowrap class="formLabel"><dhv:label
			name="opu.soggetto_fisico.data_nascita"></dhv:label></td>
		<td><input class="todisable" readonly type="text" id="dataNascita"
			name="dataNascita" size="10" /> <a href="#"
			onClick="cal19.select(document.forms[0].dataNascita,'anchor19','dd/MM/yyyy'); return false;"
			NAME="anchor19" ID="anchor19"> <img
			src="images/icons/stock_form-date-field-16.gif" border="0"
			align="absmiddle"></a></td>
	</tr>
	<tr>
		<td class="formLabel" nowrap><dhv:label
			name="opu.soggetto_fisico.comune_nascita"></dhv:label></td>
		<td><input class="todisable" type="text" size="30" maxlength="50"
			id="comuneNascita" name="comuneNascita" value=""></td>
	</tr>
	<tr>
		<td class="formLabel" nowrap><dhv:label
			name="opu.soggetto_fisico.provincia_nascita"></dhv:label></td>
		<td><input class="todisable" type="text" size="30" maxlength="50"
			id="provinciaNascita" name="provinciaNascita" value=""></td>
	</tr>
	
	<tr>
		<td class="formLabel" nowrap><dhv:label name="opu.soggetto_fisico.provincia_residenza"></dhv:label></td>
			
				<td>
				
				<dhv:evaluate if="<%=(User.getSiteId() <= 0 ) || (stabilimento.isFlagFuoriRegione())%>">
				<script>
		 $(function() {
		       
		        $( "#addressLegaleCountry" ).combobox();
		       
		    });
		    </script>
			<select class="todisable" name="addressLegaleCountry" id="addressLegaleCountry">
			<option value="-1">Inserire le prime 4 lettere</option>
			
		</select>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(dopo aver digitato le prime 5 lettere apparir� in automatico la lista delle province che iniziano con le lettere digitate)
		<font color="red">(*)</font> <%-- ComuniList.getHtmlSelect("searchcodeIdComune", -1) --%>
		<input type="hidden" name="addressLegaleCountryTesto"
			id="addressLegaleCountryTesto" /> <!--      <input type="text" size="30" maxlength="50" id = "" name="addressLegaleCountry" value="">-->
		
		</dhv:evaluate> 
		<dhv:evaluate if="<%=(User.getSiteId() > 0 ) && ! stabilimento.isFlagFuoriRegione()%>">
		
			<%=provinciaAsl.getDescrizione()%>
			<input type="hidden" name="addressLegaleCountry".
				 id="addressLegaleCountry" value="<%=provinciaAsl.getCodice()%>" />
		</dhv:evaluate>
				
				</td>
	</tr>
	
	<tr>
		<td class="formLabel" nowrap><dhv:label
			name="opu.soggetto_fisico.comune_residenza"></dhv:label></td>
		<td><select class="todisable" name="addressLegaleCity" id="addressLegaleCity">
			<option value="-1">Inserire le prime 4 lettere</option>
			
		</select>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(dopo aver digitato le prime 5 lettere apparir� in automatico la lista dei comuni che iniziano con le lettere digitate)
		<font color="red">(*)</font> <%-- ComuniList.getHtmlSelect("searchcodeIdComune", -1) --%>
		<input type="hidden" name="addressLegaleCityTesto"
			id="addressLegaleCityTesto" /> <!--      <input type="text" size="30" maxlength="50" id = "" name="addressLegaleCountry" value="">-->
		</td>
	</tr>


	
		
	
	<tr>
		<td class="formLabel" nowrap><dhv:label
			name="opu.soggetto_fisico.indirizzo"></dhv:label></td>
		<td><select  name="addressLegaleLine1" id="addressLegaleLine1">
			<option value="-1" selected="selected">Inserire le prime 4 lettere</option>
			
		</select>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(dopo aver digitato le prime 5 lettere apparir� in automatico la lista degli indirizzi che iniziano con le lettere digitate)
		<font color="red">(*)</font> <input type="hidden"
			name="addressLegaleLine1Testo" id="addressLegaleLine1Testo" /> 
		</td>
	</tr>

	
	<tr>
		<td class="formLabel" nowrap><dhv:label
			name="opu.soggetto_fisico.cf"></dhv:label></td>
		<td>
		<input readonly="readonly"  type="text" name="codFiscaleSoggetto"
			id="codFiscaleSoggetto" />  <font color="red">(*)</font>
			<!-- %if(stabilimento.isFlagFuoriRegione()){ %-->
			<input type = "checkbox" name = "estero" id = "estero" value="NO" onclick="if(this.checked){this.value='true';document.getElementById('calcoloCF').style.visibility='hidden';document.getElementById('codFiscaleSoggetto').readOnly=false;} else {this.value='false';document.getElementById('calcoloCF').style.visibility='visible';document.getElementById('codFiscaleSoggetto').readOnly=true;document.getElementById('codFiscaleSoggetto').value='';}" >Provenienza Estera
			<!-- %} %-->	
			<input type="button" id = "calcoloCF" value="Calcola Codice Fiscale" onclick="javascript:CalcolaCF()"></input></td>
	</tr>
	<tr>
		<td class="formLabel" nowrap><dhv:label
			name="opu.soggetto_fisico.didentita"></dhv:label></td>
		<td>
		 <input class="todisable" type="text" name="documentoIdentita"
			id="documentoIdentita" value=""/> </td>
	</tr>

	<tr>
		<td class="formLabel" nowrap><dhv:label
			name="opu.soggetto_fisico.mail"></dhv:label></td>
		<td><input class="todisable" type="text" size="30" maxlength="50" id="email"
			name="email" value=""></td>

	</tr>

	<tr>
		<td class="formLabel" nowrap><dhv:label
			name="opu.soggetto_fisico.telefono"></dhv:label></td>
		<td><input class="todisable" type="text" size="30" maxlength="50" id="telefono1"
			name="telefono1" value=""></td>

	</tr>

	<tr>
		<td class="formLabel" nowrap><dhv:label
			name="opu.soggetto_fisico.telefono2"></dhv:label></td>
		<td><input class="todisable" type="text" size="30" maxlength="50" id="telefono2"
			name="telefono2" value=""></td>

	</tr>

	<tr>
		<td class="formLabel" nowrap><dhv:label
			name="opu.soggetto_fisico.fax"></dhv:label></td>
		<td><input class="todisable" type="text" size="30" maxlength="50" id="fax"
			name="fax" value=""></td>

	</tr>
	

</table>

<br />
<br>
<div id="info_sede">
<%
	String label_sede_legale = "opu.sede_legale_" + i;
%>
<table cellpadding="4" cellspacing="0" border="0" width="100%"
	class="details">
	<tr>
		<th colspan="2"><strong><dhv:label
			name="<%=label_sede_legale%>"></dhv:label></strong></th>
	</tr>

	<tr>
		<td class="formLabel"><dhv:label name="opu.sede_legale.inregione"></dhv:label>
		</td>
		<td><select name="inregioneSedeLegale" id="inregioneSedeLegale">
			<option value="si">SI</option>
			<option value="no">NO</option>
		</select></td>
	</tr>
	<tr>

		<td nowrap class="formLabel"><dhv:label
			name="opu.sede_legale.provincia"></dhv:label></td>
		<td><select name="searchcodeIdprovincia"
			id="searchcodeIdprovincia">
			<option value="-1">Inserire le prime 4 lettere</option>
		</select>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(dopo aver digitato le prime 5 lettere apparir� in automatico la lista delle province che iniziano con le lettere digitate)
		<font color="red">(*)</font> <input type="hidden"
			name="searchcodeIdprovinciaTesto" id="searchcodeIdprovinciaTesto" />
		</td>
	</tr>
	<tr>
		<td nowrap class="formLabel" name="province" id="province"><dhv:label
			name="opu.sede_legale.comune"></dhv:label></td>
		<td><select name="searchcodeIdComune" id="searchcodeIdComune">
			<option value="-1">Inserire le prime 4 lettere</option>
		</select>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(dopo aver digitato le prime 5 lettere apparir� in automatico la lista dei comuni che iniziano con le lettere digitate)
		<font color="red">(*)</font> <%-- ComuniList.getHtmlSelect("searchcodeIdComune", -1) --%>
		<input type="hidden" name="searchcodeIdComuneTesto"
			id="searchcodeIdComuneTesto" /></td>
	</tr>
	<tr>
		<td nowrap class="formLabel"><dhv:label
			name="opu.sede_legale.indirizzo"></dhv:label></td>
		<td><select name="via" id="via">
			<option value="-1" selected="selected">Inserire le prime 4 lettere</option>
		</select>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(dopo aver digitato le prime 5 lettere apparir� in automatico la lista degli indirizzi che iniziano con le lettere digitate)
		<font color="red">(*)</font> <input type="hidden" name="viaTesto"
			id="viaTesto" /></td>
	</tr>
	<tr>
		<td nowrap class="formLabel"><dhv:label name="opu.sede_legale.co"></dhv:label>
		</td>
		<td><input type="text" size="40" name="presso" maxlength="80"
			value="<%=""%>"></td>
	</tr>


	<%-- tr>
		<td nowrap class="formLabel"><dhv:label
			name="opu.sede_legale.cap"></dhv:label></td>
		<td><input type="text" size="28" id="cap" name="cap"
			maxlength="5" value="<%=toHtmlValue("")%>"></td>
	</tr--%>



	<tr class="containerBody">
		<td class="formLabel" nowrap><dhv:label
			name="opu.sede_legale.latitudine"></dhv:label></td>
		<td><input type="text" id="latitudine" name="latitudine"
			size="30" value=""></td>
	</tr>
	<tr class="containerBody">
		<td class="formLabel"><dhv:label
			name="opu.sede_legale.longitudine"></dhv:label></td>
		<td><input type="text" id="longitudine" name="longitudine"
			size="30" value=""></td>
	</tr>
	<!--<tr style="display: block">
		<td colspan="2"><input id="coordbutton" type="button"
			value="Calcola Coordinate"
			onclick="javascript:showCoordinate(document.getElementById('via').value, document.forms['addSede'].comune.value,document.forms['addSede'].provincia.value, document.forms['addSede'].cap.value, document.forms['addSede'].latitudine, document.forms['addSede'].longitudine);" />
		</td>
	</tr>  -->
	
</table>
</div>

</br>
</br>


<script type="text/javascript">
//alert(document.forms[0].doContinueLp.value);
mostra_pagina();
</script>





<!-- STABILIMENTO -->

<%
	}
%>


<%@page import="it.us.web.util.properties.Application"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>
<%@page import="java.util.Date"%>
<script type="text/javascript" src="js/vam/cc/esamiIstopatologici/add.js"></script>

<form action="vam.izsm.esamiIstopatologici.Edit.us?toDetailLLPP=on" name="form" method="post" class="marginezero" onsubmit="javascript:return checkformIzsm(this);">    

    <h4 class="titolopagina">		
		Inserimento Esito Esame Istopatologico numero ${esame.numero} richiesto dal Dott. ${esame.enteredBy.nome} ${esame.enteredBy.cognome} 
		
		<input type="hidden" name="idEsame" value="${esame.id }" />	
		<input type="hidden" name="idDiagnosiHidden" id="idDiagnosiHidden" value="${esame.tipoDiagnosi.id}" />
		<input type="hidden" name="whoUmanaPadreHidden" id="whoUmanaPadreHidden" value="${esame.whoUmana.padre.id }" />	
		<input type="hidden" name="whoUmanaHidden" id="whoUmanaHidden" value="${esame.whoUmana.id }" />
		<input type="hidden" name="idCc" value="${esame.cartellaClinica.id }" />	
    </h4>
    
    <br>
	<!-- input type="button" value="Immagini" onclick="javascript:avviaPopup( 'vam.cc.esamiIstopatologici.GestioneImmagini.us?id=${esame.id }&cc=${cc.id}' );" / -->
	<c:if test="${esame.outsideCC==false}">
		<input type="button" value="Necroscopia" onclick="javascript:if(${esame.cartellaClinica.autopsia!=null}){avviaPopup( 'vam.cc.autopsie.DetailDaIsto.us?idCc=${esame.cartellaClinica.id}' );}else{if(${esame.cartellaClinica.accettazione.animale.necroscopiaNonEffettuabile==false}){alert('Necroscopia non inserita');}else{alert('Necroscopia dichiarata come non effettuabile');}}" />
	</c:if>

    <table class="tabella">
        <tr class="even">
    		<th colspan="2">
    			Esame Istopatologico numero ${esame.numero} , richiesto  
    			in data <fmt:formatDate type="date" value="${esame.dataRichiesta}" pattern="dd/MM/yyyy" />
    		</th>
    	</tr>
    	
    	<tr class='odd'>
    		<td>
    			 Laboratorio di destinazione
    		</td>
    		<td>
    			 ${esame.lass.description}
    			 <c:if test="${esame.lass.id==19}">
    			 	: ${esame.laboratorioPrivato} 
    			 </c:if>
    		</td>
    		<td>
    		</td>
        </tr>
    	
    	<tr class="even">
    		<td style="width:30%">
    			 Numero rif. Mittente
    		</td>
    		<td style="width:70%">  
    			${esame.numeroAccettazioneSigla}
    		</td>
        </tr>

		<tr class="odd">
    		<td style="width:30%">
    			 Tipo Prelievo
    		</td>
    		<td style="width:70%">  
    			${esame.tipoPrelievo.description }
    		</td>
        </tr> 
        
        <tr class="odd">
    		<td style="width:30%">
    			 Tumore
    		</td>
    		<td style="width:70%">  
    			${esame.tumore.description }
    		</td>
        </tr> 
        
        <tr class="odd">
    		<td style="width:30%">
    			 Sede Lesione e Sottospecifica
    		</td>
    		<td style="width:70%">  
    			${esame.sedeLesione }  
    		</td>
        </tr>  
        
        <%
        //Abilitazione 287
		if(Application.get("flusso_287").equals("true"))
		{
		%>
        
        
        <tr class="odd">
    		<td style="width:30%">
    			 Trattamenti ormonali
    		</td>
    		<td style="width:70%">  
    			${esame.trattOrm}
    		</td>
        </tr>  
        
        <tr class="odd">
    		<td style="width:30%">
    			 Stato generale
    		</td>
    		<td style="width:70%">  
    			${esame.statoGenerale} ${esame.statoGeneraleLookup}
    		</td>
        </tr>   
        
        <%
}
%>
        
        <tr>
    		<td style="width:30%">
    			 Tumori Precedenti
    		</td>
    		<td style="width:70%"> 
    			${esame.tumoriPrecedenti.description }  
    		</td>
        </tr>    
        
   <c:if test="${esame.tumoriPrecedenti.id == 2 && (esame.t || esame.n || esame.m || esame.dataDiagnosi!=null || esame.diagnosiPrecedente)}">
        <tr>
    		<td style="width:30%">
    			 Data diagnosi
    		</td>
    		<td style="width:70%"> 
    			<fmt:formatDate type="date" value="${esame.dataDiagnosi}" pattern="dd/MM/yyyy" />  
    		</td>
        </tr>  
         <tr>
    		<td style="width:30%">
    			 Diagnosi precedente
    		</td>
    		<td style="width:70%"> 
    			${esame.diagnosiPrecedente}
    		</td>
        </tr>  
        <tr>
    		<td style="width:30%">
    			 T
    		</td>
    		<td style="width:70%"> 
    			${esame.t }  
    		</td>
        </tr>    
        
        <tr>
    		<td style="width:30%">
    			 N
    		</td>
    		<td style="width:70%"> 
    			${esame.n }  
    		</td>
        </tr>  
        
        <tr>
    		<td style="width:30%">
    			 M
    		</td>
    		<td style="width:70%">  
    			${esame.m }  
    		</td>
        </tr> 
    </c:if>
    
    
    <c:if test="${esame.tumoriPrecedenti.id == 2 && (esame.t1 || esame.n1 || esame.m1 || esame.dataDiagnosi1!=null || esame.diagnosiPrecedente1)}">
         <tr>
    		<td style="width:30%">
    			 Data diagnosi
    		</td>
    		<td style="width:70%"> 
    			<fmt:formatDate type="date" value="${esame.dataDiagnosi1}" pattern="dd/MM/yyyy" />  
    		</td>
        </tr>  
         <tr>
    		<td style="width:30%">
    			 Diagnosi precedente
    		</td>
    		<td style="width:70%"> 
    			${esame.diagnosiPrecedente1}  
    		</td>
        </tr> 
        <tr>
    		<td style="width:30%">
    			 T
    		</td>
    		<td style="width:70%"> 
    			${esame.t1 }  
    		</td>
        </tr>    
        
        <tr>
    		<td style="width:30%">
    			 N
    		</td>
    		<td style="width:70%"> 
    			${esame.n1 }  
    		</td>
        </tr>  
        
        <tr>
    		<td style="width:30%">
    			 M
    		</td>
    		<td style="width:70%">  
    			${esame.m1 }  
    		</td>
        </tr> 
    </c:if>
    
     <c:if test="${esame.tumoriPrecedenti.id == 2 && (esame.t2 || esame.n2 || esame.m2 || esame.dataDiagnosi2!=null || esame.diagnosiPrecedente2)}">
        <tr>
    		<td style="width:30%">
    			 Data diagnosi
    		</td>
    		<td style="width:70%"> 
    			<fmt:formatDate type="date" value="${esame.dataDiagnosi2}" pattern="dd/MM/yyyy" />  
    		</td>
        </tr>  
         <tr>
    		<td style="width:30%">
    			 Diagnosi precedente
    		</td>
    		<td style="width:70%"> 
    			${esame.diagnosiPrecedente2}  
    		</td>
        </tr> 
        <tr>
    		<td style="width:30%">
    			 T
    		</td>
    		<td style="width:70%"> 
    			${esame.t2 }  
    		</td>
        </tr>    
        
        <tr>
    		<td style="width:30%">
    			 N
    		</td>
    		<td style="width:70%"> 
    			${esame.n2 }  
    		</td>
        </tr>  
        
        <tr>
    		<td style="width:30%">
    			 M
    		</td>
    		<td style="width:70%">  
    			${esame.m2 }  
    		</td>
        </tr> 
    </c:if>
    
     <c:if test="${esame.tumoriPrecedenti.id == 2 && (esame.t3 || esame.n3 || esame.m3 || esame.dataDiagnosi3!=null || esame.diagnosiPrecedente3)}">
        <tr>
    		<td style="width:30%">
    			 Data diagnosi
    		</td>
    		<td style="width:70%"> 
    			<fmt:formatDate type="date" value="${esame.dataDiagnosi3}" pattern="dd/MM/yyyy" />  
    		</td>
        </tr>  
         <tr>
    		<td style="width:30%">
    			 Diagnosi precedente
    		</td>
    		<td style="width:70%"> 
    			${esame.diagnosiPrecedente3}  
    		</td>
        </tr> 
        <tr>
    		<td style="width:30%">
    			 T
    		</td>
    		<td style="width:70%"> 
    			${esame.t3 }  
    		</td>
        </tr>    
        
        <tr>
    		<td style="width:30%">
    			 N
    		</td>
    		<td style="width:70%"> 
    			${esame.n3 }  
    		</td>
        </tr>  
        
        <tr>
    		<td style="width:30%">
    			 M
    		</td>
    		<td style="width:70%">  
    			${esame.m3 }  
    		</td>
        </tr> 
    </c:if>
     <c:if test="${esame.tumoriPrecedenti.id == 2 && (esame.t4 || esame.n4 || esame.m4 || esame.dataDiagnosi4!=null || esame.diagnosiPrecedente4)}">
        <tr>
    		<td style="width:30%">
    			 Data diagnosi
    		</td>
    		<td style="width:70%"> 
    			<fmt:formatDate type="date" value="${esame.dataDiagnosi4}" pattern="dd/MM/yyyy" />  
    		</td>
        </tr>  
         <tr>
    		<td style="width:30%">
    			 Diagnosi precedente
    		</td>
    		<td style="width:70%"> 
    			${esame.diagnosiPrecedente4}  
    		</td>
        </tr> 
        <tr>
    		<td style="width:30%">
    			 T
    		</td>
    		<td style="width:70%"> 
    			${esame.t4 }  
    		</td>
        </tr>    
        
        <tr>
    		<td style="width:30%">
    			 N
    		</td>
    		<td style="width:70%"> 
    			${esame.n4 }  
    		</td>
        </tr>  
        
        <tr>
    		<td style="width:30%">
    			 M
    		</td>
    		<td style="width:70%">  
    			${esame.m4 }  
    		</td>
        </tr> 
    </c:if>
    
    <c:if test="${esame.tumoriPrecedenti.id == 2 && (esame.t5 || esame.n5 || esame.m5 || esame.dataDiagnosi5!=null || esame.diagnosiPrecedente5)}">
        <tr>
    		<td style="width:30%">
    			 Data diagnosi
    		</td>
    		<td style="width:70%"> 
    			<fmt:formatDate type="date" value="${esame.dataDiagnosi5}" pattern="dd/MM/yyyy" />  
    		</td>
        </tr>  
         <tr>
    		<td style="width:30%">
    			 Diagnosi precedente
    		</td>
    		<td style="width:70%"> 
    			${esame.diagnosiPrecedente5}  
    		</td>
        </tr> 
        <tr>
    		<td style="width:30%">
    			 T
    		</td>
    		<td style="width:70%"> 
    			${esame.t5 }  
    		</td>
        </tr>    
        
        <tr>
    		<td style="width:30%">
    			 N
    		</td>
    		<td style="width:70%"> 
    			${esame.n5 }  
    		</td>
        </tr>  
        
        <tr>
    		<td style="width:30%">
    			 M
    		</td>
    		<td style="width:70%">  
    			${esame.m5 }  
    		</td>
        </tr> 
    </c:if>
        
        <tr class="odd">
    		<td style="width:30%" >
    			 Dimensione (centimetri)
    		</td>
    		<td style="width:70%"> 
    			${esame.dimensione }
    		</td>
        </tr> 
        
        <tr>
    		<td style="width:30%">
    			 Interessamento Linfonodale
    		</td>
    		<td style="width:70%">  
    			${esame.interessamentoLinfonodale.description }  
    		</td>
        </tr> 
        
        <tr>
        	<th colspan="2">
        		Risultato
        	</th>
        </tr>
        
        
        <tr>
    		<td style="width:30%">
    			  Data Esito <font color="red"> *</font>
    		</td>
    		<td style="width:70%">      			
    			 <input 
    			 	type="text" 
    			 	id="dataEsito" 
    			 	name="dataEsito" 
    			 	maxlength="32" 
    			 	size="50" 
    			 	readonly="readonly" 
    			 	style="width:246px;" 
					value="<fmt:formatDate type="date" value="${esame.dataEsito }" pattern="dd/MM/yyyy" />"/>
    			 <img src="images/b_calendar.gif" alt="calendario" id="id_img_2" />
 					<script type="text/javascript">
      					 Calendar.setup({
        					inputField     :    "dataEsito",     // id of the input field
        					ifFormat       :    "%d/%m/%Y",      // format of the input field
       						button         :    "id_img_2",  // trigger for the calendar (button ID)
       						// align          :    "Tl",           // alignment (defaults to "Bl")
        					singleClick    :    true,
        					timeFormat		:   "24",
        					showsTime		:   false
   							 });					    
  					 </script>   
    		</td>
        </tr>
        
        
        <tr>
    		<td style="width:30%">
    			  Descrizione Morfologica
    		</td>
    		<td style="width:70%">  
    			 <textarea rows="5" cols="60" name="descrizioneMorfologica" id="descrizioneMorfologica" >${esame.descrizioneMorfologica }</textarea>
    		</td>
        </tr>
        
        <tr class="odd">
    		<td style="width:30%">
    			 Diagnosi
    		</td>
    		<td style="width:70%">  
    			 <select name="idTipoDiagnosi" id="idTipoDiagnosi" onchange="selezionaDivTipoDiagnosi(this.value)">
    			 	<c:forEach items="${tipoDiagnosis }" var="temp">
    			 		<option value="${temp.id }" <c:if test="${temp == esame.tipoDiagnosi }">selected="selected"</c:if>>${temp.description }</option>
    			 	</c:forEach>
    			 </select>
    			 
    			 <div id="tipoDiagnosi-1" name="tipoDiagnosi-1">
    			 	<input type="hidden" name="idWhoUmana" value="-1" />
    			 </div>
    			 
    			 
    			 <div id="whoUmanaDiv" name="whoUmanaDiv" style="display: none;">	
    			 	<input type="hidden" name="idWhoUmana" id="idWhoUmana" value="${esame.whoUmana.id }"/>
    			 	
    			 	 <select name="padreWhoUmana" id="padreWhoUmana" onchange="selezionaDivWhoUmana(this.value),updateIdWhoUmana()">
	    			 	<c:forEach items="${whoUmanaPadre }" var="temp">
	    			 		<option value="${temp.id }" <c:if test="${temp == esame.whoUmana.padre || temp == esame.whoUmana }">selected="selected"</c:if> >${temp.codice } - ${temp.description }</option>
	    			 	</c:forEach>
	    			 </select>
	    			 <c:forEach items="${whoUmanaPadre }" var="temp">
    			 	 <div <c:if test="${temp.id > 1 }"> style="display: none;" </c:if> id="div_who_umana_${temp.id }" name="div_who_umana_${temp.id }">
    			 		<c:if test="${empty temp.figli }">
    			 			<input type="hidden" name="idWhoUmana" id="idWhoUmana" value="${temp.id }" <c:if test="${temp.id > 0 }">disabled="disabled"</c:if> />
    			 		</c:if>
    			 		<c:if test="${not empty temp.figli }">
    			 			 <select name="idWhoUmana${temp.id }" id="idWhoUmana${temp.id }" disabled="disabled" onchange="updateIdWhoUmana()">
			    			 	<c:forEach items="${temp.figli }" var="figlio">
			    			 		<c:if test="${empty figlio.figli }">
			    			 			<option value="${figlio.id }" <c:if test="${figlio == esame.whoUmana }">selected="selected"</c:if> >${figlio.codice } - ${figlio.description }</option>
			    			 		</c:if>
			    			 		<c:if test="${not empty figlio.figli}">
			    			 			<optgroup label="${figlio.description }">
			    			 				<c:forEach items="${figlio.figli }" var="nipote" >
			    			 					<option value="${nipote.id }" <c:if test="${nipote == esame.whoUmana }">selected="selected"</c:if> >${nipote.codice } - ${nipote.description }</option>
			    			 				</c:forEach>
			    			 			</optgroup>
			    			 		</c:if>
			    			 	</c:forEach>
			    			 </select>
    			 		</c:if>
    			 	 </div>
    			  </c:forEach>
    			 </div>
    			 
    			 <div id="whoAnimaleDiv" name="whoAnimaleDiv" style="display: none;">
    			 	Who animale
    			 </div>
    			 
    			 <div id="nonTumoraleDiv" name="nonTumoraleDiv" style="display: none;">
    			 	<textarea rows="5" cols="60" name="diagnosiNonTumorale" id="diagnosiNonTumorale" >${esame.diagnosiNonTumorale }</textarea>
    			 </div>
    			 
    			 
    		</td>
        </tr>  
        
        <tr>
    		<td colspan="2">    
    			<font color="red">* </font> Campi obbligatori
				<br/>	
				<c:choose>
					<c:when test="${esame.dataEsito!=null}">
						<input type="submit" value="Modifica" onclick="attendere();"/>
					</c:when>
    				<c:otherwise>
    					<input type="submit" value="Salva"/>
    				</c:otherwise>
				</c:choose>
    			<input type="button" value="Torna alla Lista" onclick="attendere();location.href='vam.richiesteIstopatologici.ListLLPP.us'">
    		</td>
        </tr>
	</table>
</form>

<script type="text/javascript">

var padreSedeLesionePrecedente = -1;

function selezionaDivSedeLesione( idPadre )
{
	toggleDiv( "div_sedi_" + padreSedeLesionePrecedente );
	toggleDiv( "div_sedi_" + idPadre );

	padreSedeLesionePrecedente = idPadre;
}

function updateTNM( idTumPrec )
{
	var div = document.getElementById( "tnm" );

	if( idTumPrec == 2 )
	{
		div.style.display = "block";
		protect( div, false );
	}
	else
	{
		div.style.display = "none";
		protect( div, true );
	}
}

var padreWhoUmanaPrecedente = 1;

function selezionaDivWhoUmana( idPadre )
{
	toggleDiv( "div_who_umana_" + padreWhoUmanaPrecedente );
	toggleDiv( "div_who_umana_" + idPadre );

	padreWhoUmanaPrecedente = idPadre;
}


function updateIdWhoUmana()
{
	var indiceDiv = document.getElementById( 'padreWhoUmana' ).value;
	if(document.getElementById('idWhoUmana' + indiceDiv)!=null)
		document.getElementById( 'idWhoUmana' ).value = document.getElementById( 'idWhoUmana' + indiceDiv ).value;
	else
		document.getElementById( 'idWhoUmana' ).value = indiceDiv;
}

var padreTipoDiagnosiPrecedente = "tipoDiagnosi-1";

function selezionaDivTipoDiagnosi( idDiagnosi )
{
	var divx = "tipoDiagnosi-1";
	
	switch ( idDiagnosi )
	{
	case "1":
		divx = "whoUmanaDiv";
		break;
	case "2":
		divx = "whoAnimaleDiv";
		break;
	case "3":
		divx = "nonTumoraleDiv";
		break;
	}

	//document.getElementById( padreTipoDiagnosiPrecedente ).style.display = "none";
	//document.getElementById( divx ).style.display = "block";
	toggleDiv( padreTipoDiagnosiPrecedente );
	toggleDiv( divx );

	switch ( idDiagnosi )
	{
	case "1":
		updateIdWhoUmana();
		break;
	case "2":
		
		break;
	case "3":
		
		break;
	}

	padreTipoDiagnosiPrecedente = divx;
}
	
</script>



<script type="text/javascript">
	selezionaDivTipoDiagnosi(document.getElementById('idDiagnosiHidden').value);
</script>

<c:if test="${esame.whoUmana.padre != null}">
	<script type="text/javascript">
		setTimeout( 'selezionaDivWhoUmana( document.getElementById("whoUmanaPadreHidden").value)', 700 );
	</script>
</c:if>
<c:if test="${esame.whoUmana.padre == null && esame.whoUmana != null}">
	<script type="text/javascript">
		setTimeout( 'selezionaDivWhoUmana( document.getElementById("whoUmanaHidden").value)', 700 );
	</script>
</c:if>

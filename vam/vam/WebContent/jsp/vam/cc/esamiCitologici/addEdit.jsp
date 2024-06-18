<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/ustl.tld" prefix="us" %>
<%@page import="java.util.Date"%>

<script language="JavaScript" type="text/javascript" src="js/vam/cc/esamiCitologici/addEdit.js"></script>

<form action="vam.cc.esamiCitologici.AddEdit.us" name="form" method="post" class="marginezero" onsubmit="javascript:return checkform(this);">    

  

    <jsp:include page="/jsp/vam/cc/menuCC.jsp"/>
    
	  <h4 class="titolopagina">
		<c:if test="${!modify }" >     
			Nuovo Esame Citologico
		</c:if>
		<c:if test="${modify }" >
			Modifica Esame Citologico numero  <c:out value="${esame.numero}"/>
    			
    			<input type="hidden" name="modify" value="on" />
    			<input type="hidden" name="id" value="${esame.id }" />
		</c:if>
    </h4>  
    
    <table class="tabella">
        <tr>
        	<th colspan="2">
        		Dati dell'esame
        	</th>
        </tr>
    	<tr class="odd">
    		<td style="text-align: left;">
    			 Data Richiesta<font color="red"> *</font>
    		</td>
    		<td style="text-align: left;">
    			 <input 
    			 	type="text" 
    			 	id="dataRichiesta" 
    			 	name="dataRichiesta" 
    			 	maxlength="32" 
    			 	size="50" 
    			 	readonly="readonly" 
    			 	style="width:246px;" 
					<c:if test="${modify }"> value="<fmt:formatDate type="date" value="${esame.dataRichiesta}" pattern="dd/MM/yyyy" />" </c:if>
					<c:if test="${!modify }"> value="<fmt:formatDate type="date" value="<%=new Date() %>" pattern="dd/MM/yyyy" />" </c:if> />
    			 <img src="images/b_calendar.gif" alt="calendario" id="id_img_1" />
 					<script type="text/javascript">
      					 Calendar.setup({
        					inputField     :    "dataRichiesta",     // id of the input field
        					ifFormat       :    "%d/%m/%Y",      // format of the input field
       						button         :    "id_img_1",  // trigger for the calendar (button ID)
       						// align          :    "Tl",           // alignment (defaults to "Bl")
        					singleClick    :    true,
        					timeFormat		:   "24",
        					showsTime		:   false
   							 });					    
  					 </script>   
    		</td>
    	</tr>
    	<tr class="even">
    		<td style="text-align: left;">
    			 Data Esito<font color="red"> *</font>
    		</td>
			<td style="text-align: left;">
    			 <input 
    			 	type="text" 
    			 	id="dataEsito" 
    			 	name="dataEsito" 
    			 	maxlength="32" 
    			 	size="50" 
    			 	readonly="readonly" 
    			 	style="width:246px;" 
					value="<fmt:formatDate type="date" value="${esame.dataEsito }" pattern="dd/MM/yyyy" />" />
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
		
		<tr class="odd">
			<td style="text-align: left;">
				Tipo Prelievo<font color="red"> *</font>
			</td>
			<td style="text-align: left;">
    			<select name="idTipoPrelievo" id="idTipoPrelievo" onchange="javascript:mostraAltro()" style="width:250px;">
    				<option value="">&lt;-- Selezionare Tipo Prelievo --&gt;</option>
					<c:forEach items="${tipiPrelievo}" var="temp" >
						<option value="${temp.id}"
							<c:if test="${esame.tipoPrelievo.id == temp.id}">selected="selected"</c:if>
						>${temp.descrizione}</option>
					</c:forEach> 
				</select>
			</td>
        </tr>
        
        <tr class="odd">
			<td style="text-align: left;" id="tipoPrelievoAltroTd1">
				<c:if test="${esame.tipoPrelievo.id==4}">
					Specificare altro<font color="red"> *</font>
				</c:if>
			</td>
			<td style="text-align: left;">
    			<input type="text" name="tipoPrelievoAltro" id="tipoPrelievoAltro" value="${esame.tipoPrelievoAltro}"
    				<c:choose>
    					<c:when test="${esame.tipoPrelievo.id!=4 || esame==null}">
    						style="width:246px;display:none";
    					</c:when>
    					<c:otherwise>
							style="width:246px;";
						</c:otherwise>
					</c:choose>
    			>
			</td>
        </tr>
        
        <tr class="odd">
			<td style="text-align: left;">
				Matrice<font color="red"> *</font>
			</td>
			<td style="text-align: left;">
    			<select  name="padreDiagnosi" id="padreDiagnosi" onchange="selezionaDivDiagnosi(document.getElementById('padreDiagnosi').value);" >
    			 	 	<option value="-1">&lt;-- Selezionare voce --&gt;</option>
	    			 	<c:forEach items="${diagnosiPadre }" var="temp">
	    			 		<option value="${temp.id }" <c:if test="${temp == esame.diagnosi.padre || temp == esame.diagnosi }">selected="selected"</c:if> >${temp.description }</option>
	    			 	</c:forEach>
	    			 </select>
			</td>
        </tr>
        
        
        <tr class="even">
			<td style="text-align: left;">
				Aspetto della lesione
			</td>
			<td style="text-align: left;">
    			<input type="text" name="aspettoLesione" value="${esame.aspettoLesione}" style="width:246px;">
	    	</td>
        </tr>
          
        <tr class="odd">
    		<td style="width:30%">
    			 Diagnosi <font color="red">*</font>
    		</td>
    		<td style="width:70%">  
    		
    		<select id="idDiagnosiPadre" name="idDiagnosiPadre" onchange="selezionaDivDiagnosi(document.getElementById('padreDiagnosi').value);" >
				<option value="-1"> &lt;-- Selezionare una voce --&gt;</option>
				<option value="1">Sospetto benigno</option>
				<option value="2">Sospetto maligno</option>
				<option value="3">Non diagnostico</option>
			</select>
		
    			 </td>
        </tr>
          
       <tr class="odd">
    		<td style="width:30%">
    			 Diagnosi del tumore<font color="red">*</font>
    		</td>
    		<td style="width:70%">  
    			 	<input type="hidden" name="idDiagnosi" id="idDiagnosi" value="${esame.diagnosi.id }"/>
    			 	
    			 	 <select style="display:none;" name="padreDiagnosi" id="padreDiagnosi" onchange="selezionaDivDiagnosi(this.value);updateIdDiagnosi();">
    			 	 	<option value="-1">&lt;-- Selezionare voce --&gt;</option>
	    			 	<c:forEach items="${diagnosiPadre }" var="temp">
	    			 		<option value="${temp.id }" <c:if test="${temp == esame.diagnosi.padre || temp == esame.diagnosi }">selected="selected"</c:if> >${temp.description }</option>
	    			 	</c:forEach>
	    			 </select>
	    			 <c:forEach items="${diagnosiPadre }" var="temp">
    			 	 <div <c:if test="${temp.id > 1 }"> style="display: none;" </c:if> id="div_diagnosi_${temp.id }" name="div_diagnosi_${temp.id }">
    			 		<c:if test="${empty temp.figli }">
    			 			<input type="hidden" name="idDiagnosi" id="idDiagnosi" value="${temp.id }" <c:if test="${temp.id > 0 }">disabled="disabled"</c:if> />
    			 		</c:if>
    			 		<c:if test="${not empty temp.figli }">
    			 			 <select name="idDiagnosi${temp.id }" id="idDiagnosi${temp.id }" disabled="disabled" onchange="updateIdDiagnosi();">
    			 			 <option value="-1" >&lt; Selezionare voce --&gt;</option>
			    			 		
			    			 	<c:forEach items="${temp.figli }" var="figlio">
			    			 		<c:if test="${empty figlio.figli }">
			    			 			<option value="${figlio.id }" <c:if test="${figlio == esame.diagnosi }">selected="selected"</c:if> >${figlio.description }</option>
			    			 		</c:if>
			    			 		<c:if test="${not empty figlio.figli}">
			    			 			<optgroup label="${figlio.description }">
			    			 				<c:forEach items="${figlio.figli }" var="nipote" >
			    			 					<option value="${nipote.id }" <c:if test="${nipote == esame.diagnosi }">selected="selected"</c:if> >${nipote.description }</option>
			    			 				</c:forEach>
			    			 			</optgroup>
			    			 		</c:if>
			    			 	</c:forEach>
			    			 </select>
    			 		</c:if>
    			 	 </div>
    			  </c:forEach>
    			 
    			 
    		</td>
        </tr>   
          
        <tr>
    		<td colspan="2">    
    			<font color="red">* </font> Campi obbligatori
				<br/>
				<c:if test="${!modify }" >
					<input type="submit" value="Salva" />
				</c:if>
				<c:if test="${modify }" >
					<input type="submit" value="Modifica" />
				</c:if>
    			<input type="button" value="Annulla" onclick="location.href='vam.cc.esamiCitologici.List.us'">
    		</td>
        </tr>
	</table>
</form>

<script type="text/javascript">
function checkForm(form)
{
	//non fa nulla perch� dovrebbe controllare solo la data (che gi� di suo non puo' essere vuota)
};
</script>




<script type="text/javascript">
var padreDiagnosiPrecedente = 1;

function selezionaDivDiagnosi( idPadreSelezionato )
{
	//Variabili
	//idPadreSelezionato 
	var sospettoMaligno = document.getElementById('idDiagnosiPadre').value == 2; //sospetto maligno = 2
	//padreDiagnosiPrecedente diagnosi precedente selezionata
	
	//Cose da fare
	//nascondere vecchio div aperto
	if(padreDiagnosiPrecedente>1)
	{
		document.getElementById("div_diagnosi_" + padreDiagnosiPrecedente).style.display="none";
		protect( document.getElementById("div_diagnosi_" + padreDiagnosiPrecedente), true );
		document.getElementById('idDiagnosi').value="";
	}
	//nascondere nuovo div aperto
	if(!sospettoMaligno || idPadreSelezionato <=1)
	{
		document.getElementById("div_diagnosi_" + idPadreSelezionato).style.display="none";
		protect( document.getElementById("div_diagnosi_" + idPadreSelezionato), true );
		document.getElementById('idDiagnosi').value="";
	}
	//attivare nuovo div
	if(sospettoMaligno && idPadreSelezionato >1)
	{
		document.getElementById("div_diagnosi_" + idPadreSelezionato).style.display="block";
		protect( document.getElementById("div_diagnosi_" + idPadreSelezionato), false );
	}
	padreDiagnosiPrecedente = idPadreSelezionato;
	
	//toggleDiv( "div_diagnosi_" + padreDiagnosiPrecedente );
	//toggleDiv( "div_diagnosi_" + idPadreSelezionato );

	
}


	toggleDiv( "diagnosiDiv" );

	function updateIdDiagnosi()
	{
		var indiceDiv = document.getElementById( 'padreDiagnosi' ).value;
		document.getElementById( 'idDiagnosi' ).value = document.getElementById( 'idDiagnosi' + indiceDiv ).value;
	}
	
	
	
	
	
</script>

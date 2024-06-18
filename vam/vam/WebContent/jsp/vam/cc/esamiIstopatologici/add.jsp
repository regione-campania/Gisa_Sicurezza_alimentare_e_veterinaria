<%@page import="it.us.web.util.properties.Application"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>
<%@page import="java.util.Date"%>
<script language="JavaScript" type="text/javascript" src="js/vam/cc/esamiIstopatologici/add.js"></script>


<form action="vam.cc.esamiIstopatologici.Add.us" name="form" id="form" method="post" class="marginezero" onsubmit="javascript:return checkform(this)">    
	
	<fmt:formatDate value="${cc.accettazione.animale.dataSmaltimentoCarogna}" pattern="dd/MM/yyyy" var="dataSmaltimento"/>
    <input type="hidden" name="dataSmaltimento" id="dataSmaltimento" value="${dataSmaltimento}" />  
    
    <jsp:include page="/jsp/vam/cc/menuCC.jsp"/>
    
    <h4 class="titolopagina">
		<c:if test="${!modify }" >     
			Nuova richiesta Esame Istopatologico
		</c:if>
		<c:if test="${modify }" >
			Modifica Richiesta Esame Istopatologico numero ${esame.numero} richiesto dal Dott. ${esame.enteredBy.nome} ${esame.enteredBy.cognome} 
    			
    			<input type="hidden" name="modify" value="on" />
    			<input type="hidden" name="id" value="${esame.id }" />
		</c:if>
    </h4>	 
    
       
    
    
    
    <table class="tabella">
        <tr>
        	<th colspan="2">
        		Richiesta
        	</th>
        </tr>
    	<tr class="even">
    		<td>
    			Data Richiesta<font color="red"> *</font>
    		</td>
    		<td style="width:50%">    			 
    			 <input 
    			 	type="text" 
    			 	id="dataRichiesta" 
    			 	name="dataRichiesta" 
    			 	maxlength="32" 
    			 	size="50" 
    			 	readonly="readonly" 
    			 	style="width:246px;" 
					<c:if test="${modify }"> value="<fmt:formatDate type="date" value="${esame.dataRichiesta }" pattern="dd/MM/yyyy" />" </c:if>
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
        
        <tr class='odd'>
    		<td>
    			 Laboratorio di destinazione
    		</td>
    		<td>
    			 <select name="lookupAutopsiaSalaSettoria">
    			 	<option value="">&lt;---Selezionare---&gt;</option>
				 	<c:forEach items="${listAutopsiaSalaSettoria}" var="t" >
				 	<c:if test="${t.id!=19}">
				 		<c:if test="${q.esterna && viewOptEsterna=='true'}">
				 			<optgroup label="<------- Esterna ------->" style="font-style: italic">
							<c:set value="false" var="viewOptEsterna"/>
				 		</c:if>
				 		<c:if test="${!q.esterna && viewOptInterna=='true'}">
				 			<optgroup label="<------- Interna ------->" style="font-style: italic">
				 			<c:set value="false" var="viewOptInterna"/>
				 		</c:if>
				 		<c:if test="${t.id==7}">
				 		<optgroup label="Universit&agrave;">
				 	</c:if>
				 	<c:if test="${t.id==6}">
				 		</optgroup>
				 		<optgroup label="IZSM">
				 	</c:if>	
				    	<option value="${t.id }" <c:if test="${t.id==esame.lass.id}">selected="selected"</c:if> >${t.description }</option>
				    	</c:if>
					</c:forEach>
					</optgroup>
		      	</select>
    		</td>
        </tr>  
        
        <tr class="even">
    		<td>
    			Numero rif. Mittente</br>
    			<input type="radio" name="tipoAccettazione" id="idTipoAccettazione1" value="IZSM" <c:if test="${esame.tipoAccettazione=='IZSM' || esame==null}">checked="checked"</c:if><c:if test="${cc.autopsia.tipoAccettazione!=null}">disabled="disabled"</c:if>/>
			    <label for="idTipoAccettazione1">IZSM</label>
				<input type="radio" name="tipoAccettazione" id="idTipoAccettazione2" value="Unina" <c:if test="${esame.tipoAccettazione=='Unina'}">checked="checked"</c:if><c:if test="${cc.autopsia.tipoAccettazione!=null}">disabled="disabled"</c:if>/>
				<label for="idTipoAccettazione2">Unina</label>
				<input type="radio" name="tipoAccettazione" id="idTipoAccettazione3" value="Asl" <c:if test="${esame.tipoAccettazione=='Asl' || esame==null}">checked="checked"</c:if><c:if test="${cc.autopsia.tipoAccettazione!=null}">disabled="disabled"</c:if>/>
			    <label for="idTipoAccettazione1">Asl</label>
				<input type="radio" name="tipoAccettazione" id="idTipoAccettazione4" value="Criuv" <c:if test="${esame.tipoAccettazione=='Criuv'}">checked="checked"</c:if><c:if test="${cc.autopsia.tipoAccettazione!=null}">disabled="disabled"</c:if>/>
				<label for="idTipoAccettazione2">Criuv</label>
				<c:if test="${cc.autopsia.tipoAccettazione!=null}">
					<input type="hidden" name="tipoAccettazione"  value="${cc.autopsia.tipoAccettazione}"/>
				</c:if>
    		</td>
    		<td>
				<input type="text" name="numeroAccettazioneSigla" size="50" style="width:246px;" 
				<c:choose>
					<c:when test="${modify}">
						value="${esame.numeroAccettazioneSigla}"
					</c:when>
					<c:otherwise>
						value="${cc.accettazione.animale.numAccNecroscopicoIstoPrecedente}"
					</c:otherwise>
				</c:choose>
				
				<c:if test="${cc.autopsia.numeroAccettazioneSigla!=null}">
					readonly="readonly" 
				</c:if>
				
				/>
			</td>
    		<td>
    		</td>
        </tr>
          
		<tr class="odd">
    		<td style="width:30%">
    			 Tipo Prelievo
    		</td>
    		<td style="width:70%">  
    			 <select name="idTipoPrelievo" id="idTipoPrelievo">
    			 	<c:forEach items="${tipoPrelievos }" var="temp">
    			 		<option value="${temp.id }" <c:if test="${temp == esame.tipoPrelievo }">selected="selected"</c:if>>${temp.description }</option>
    			 	</c:forEach>
    			 </select>
    		</td>
        </tr> 
        
        <tr class="odd">
    		<td style="width:30%">
    			 Sede Lesione e Sottospecifica<font color="red"> *</font> 
    		</td>
    		<td style="width:70%">  
    			 <select name="padreSedeLesione" id="padreSedeLesione" onchange="selezionaDivSedeLesione(this.value)">
    			 	<c:forEach items="${sediLesioniPadre }" var="temp">
    			 		<option value="${temp.id }" <c:if test="${temp.id == esame.sedeLesione.padre.padre.id || temp.id == esame.sedeLesione.padre.id || temp.id == esame.sedeLesione.id }">selected="selected"</c:if> >${temp.codice } - ${temp.description }</option>
    			 	</c:forEach>
    			 </select>
    			 <br/>
    			 <c:forEach items="${sediLesioniPadre }" var="temp">
    			 	<div <c:if test="${temp.id > 0 }"> style="display: none;" </c:if> id="div_sedi_${temp.id }" name="div_sedi_${temp.id }">
    			 		<c:if test="${empty temp.figli }">
    			 			<input type="hidden" name="idSedeLesione" id="idSedeLesione" value="${temp.id }" <c:if test="${temp.id > 0 }">disabled="disabled"</c:if> />
    			 		</c:if>
    			 		<c:if test="${not empty temp.figli }">
    			 			 <select name="idSedeLesione" id="idSedeLesione" disabled="disabled">
			    			 	<c:forEach items="${temp.figli }" var="figlio">
			    			 		<c:if test="${empty figlio.figli }">
			    			 			<option value="${figlio.id }" <c:if test="${figlio == esame.sedeLesione }">selected="selected"</c:if> >${figlio.codice } - ${figlio.description }</option>
			    			 		</c:if>
			    			 		<c:if test="${not empty figlio.figli}">
			    			 			<optgroup label="${figlio.description }">
			    			 				<c:forEach items="${figlio.figli }" var="nipote" >
			    			 					<option value="${nipote.id }" <c:if test="${nipote == esame.sedeLesione }">selected="selected"</c:if> >${nipote.codice } - ${nipote.description }</option>
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
        
        
        <tr class="odd">
    		<td style="width:30%">
    			 Tumore
    		</td>
    		<td style="width:70%">  
    			  <select name="idTumore" id="idTumore">
    			 	<option value="">&lt;---Selezionare---&gt;</option>
    			 		<c:forEach items="${tumores }" var="temp">
    			 		<option value="${temp.id }" <c:if test="${temp == esame.tumore }">selected="selected"</c:if>>${temp.description }</option>
    			 	</c:forEach>
    			 </select>
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
    			 <input type="text" name="trattOrm" id="trattOrm" size="50" value="${esame.trattOrm }"/>
    		</td>
        </tr> 
        
        <tr class="odd">
    		<td style="width:30%">
    			 Stato generale
    		</td>
    		<td style="width:70%">  
    			  <select name="idStatoGeneraleLookup" id="idStatoGeneraleLookup">
    			 	<option value="">&lt;---Selezionare---&gt;</option>
    			 		<c:forEach items="${statoGeneraleLookups }" var="temp">
    			 		<option value="${temp.id }" <c:if test="${temp == esame.statoGeneraleLookup }">selected="selected"</c:if>>${temp.description }</option>
    			 	</c:forEach>
    			 </select>
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
    			<select name="idTumoriPrecedenti" id="idTumoriPrecedenti" onchange="updateTNM(this.value);">
    			 	<c:forEach items="${tumoriPrecedentis }" var="temp">
    			 		<option value="${temp.id }" <c:if test="${temp == esame.tumoriPrecedenti }">selected="selected"</c:if> >${temp.description }</option>
    			 	</c:forEach>
    			 </select>
    			 
    			 
    			 <div id="tnm" name="tnm" style="display: none">
    			 
    			 Data diagnosi  <input 
    			 	type="text" 
    			 	id="dataDiagnosi" 
    			 	name="dataDiagnosi" 
    			 	maxlength="32" 
    			 	size="50" 
    			 	readonly="readonly" 
    			 	style="width:150px;" 
					value="" 
				  />
    			 <img src="images/b_calendar.gif" alt="calendario" id="id_img_2" />
 					<script type="text/javascript">
      					 Calendar.setup({
        					inputField     :    "dataDiagnosi",     // id of the input field
        					ifFormat       :    "%d/%m/%Y",      // format of the input field
       						button         :    "id_img_2",  // trigger for the calendar (button ID)
       						// align          :    "Tl",           // alignment (defaults to "Bl")
        					singleClick    :    true,
        					timeFormat		:   "24",
        					showsTime		:   false
   							 });					    
  					 </script> &nbsp;&nbsp;&nbsp;
  					 
  					 
    			 	Diagnosi precedente <input type="text" name="diagnosiPrecedente" id="diagnosiPrecedente"   value="${esame.diagnosiPrecedente }"/>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	&nbsp;&nbsp;&nbsp;
    			 	
    			 	
    			 	T <select name="t" id="t"><option value="">--</option><option value="T0">T0</option><option value="T1">T1</option><option value="T2">T2</option><option value="T3">T3</option><option value="T4">T4</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	N <select name="n" id="n"><option value="">--</option><option value="N0">N0</option><option value="N1">N1</option><option value="N2">N2</option><option value="N3">N3</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	M <select name="m" id="m"><option value="">--</option><option value="M0">M0</option><option value="M1">M1</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	<input type="button" value="+" onclick="aggiungiRigaTNM();">
    			 </div>
    			 <div id="tnm1" name="tnm1" style="display: none">
    			 <br/>
    			 Data diagnosi  <input 
    			 	type="text" 
    			 	id="dataDiagnosi1" 
    			 	name="dataDiagnosi1" 
    			 	maxlength="32" 
    			 	size="50" 
    			 	readonly="readonly" 
    			 	style="width:150px;" 
					value="" 
				  />
    			 <img src="images/b_calendar.gif" alt="calendario" id="id_img_3" />
 					<script type="text/javascript">
      					 Calendar.setup({
        					inputField     :    "dataDiagnosi1",     // id of the input field
        					ifFormat       :    "%d/%m/%Y",      // format of the input field
       						button         :    "id_img_3",  // trigger for the calendar (button ID)
       						// align          :    "Tl",           // alignment (defaults to "Bl")
        					singleClick    :    true,
        					timeFormat		:   "24",
        					showsTime		:   false
   							 });					    
  					 </script> &nbsp;&nbsp;&nbsp;
  					 
  					 
    			 	Diagnosi precedente <input type="text" name="diagnosiPrecedente1" id="diagnosiPrecedente1"   value="${esame.diagnosiPrecedente1 }"/>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	&nbsp;&nbsp;&nbsp;
    			 	
    			 	
    			 	T <select name="t1" id="t1"><option value="">--</option><option value="T0">T0</option><option value="T1">T1</option><option value="T2">T2</option><option value="T3">T3</option><option value="T4">T4</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	N <select name="n1" id="n1"><option value="">--</option><option value="N0">N0</option><option value="N1">N1</option><option value="N2">N2</option><option value="N3">N3</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	M <select name="m1" id="m1"><option value="">--</option><option value="M0">M0</option><option value="M1">M1</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	
    			 </div>
    			 <div id="tnm2" name="tnm2" style="display: none">
    			 <br/>
    			 Data diagnosi  <input 
    			 	type="text" 
    			 	id="dataDiagnosi2" 
    			 	name="dataDiagnosi2" 
    			 	maxlength="32" 
    			 	size="50" 
    			 	readonly="readonly" 
    			 	style="width:150px;" 
					value="" 
				  />
    			 <img src="images/b_calendar.gif" alt="calendario" id="id_img_4" />
 					<script type="text/javascript">
      					 Calendar.setup({
        					inputField     :    "dataDiagnosi2",     // id of the input field
        					ifFormat       :    "%d/%m/%Y",      // format of the input field
       						button         :    "id_img_4",  // trigger for the calendar (button ID)
       						// align          :    "Tl",           // alignment (defaults to "Bl")
        					singleClick    :    true,
        					timeFormat		:   "24",
        					showsTime		:   false
   							 });					    
  					 </script> &nbsp;&nbsp;&nbsp;
  					 
  					 
    			 	Diagnosi precedente <input type="text" name="diagnosiPrecedente2" id="diagnosiPrecedente2"   value="${esame.diagnosiPrecedente2 }"/>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	&nbsp;&nbsp;&nbsp;
    			 	
    			 	
    			 	T <select name="t2" id="t2"><option value="">--</option><option value="T0">T0</option><option value="T1">T1</option><option value="T2">T2</option><option value="T3">T3</option><option value="T4">T4</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	N <select name="n2" id="n2"><option value="">--</option><option value="N0">N0</option><option value="N1">N1</option><option value="N2">N2</option><option value="N3">N3</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	M <select name="m2" id="m2"><option value="">--</option><option value="M0">M0</option><option value="M1">M1</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	
    			 </div>
    			 <div id="tnm3" name="tnm3" style="display: none">
    			 <br/>
    			 Data diagnosi  <input 
    			 	type="text" 
    			 	id="dataDiagnosi3" 
    			 	name="dataDiagnosi3" 
    			 	maxlength="32" 
    			 	size="50" 
    			 	readonly="readonly" 
    			 	style="width:150px;" 
					value="" 
				  />
    			 <img src="images/b_calendar.gif" alt="calendario" id="id_img_5" />
 					<script type="text/javascript">
      					 Calendar.setup({
        					inputField     :    "dataDiagnosi3",     // id of the input field
        					ifFormat       :    "%d/%m/%Y",      // format of the input field
       						button         :    "id_img_5",  // trigger for the calendar (button ID)
       						// align          :    "Tl",           // alignment (defaults to "Bl")
        					singleClick    :    true,
        					timeFormat		:   "24",
        					showsTime		:   false
   							 });					    
  					 </script> &nbsp;&nbsp;&nbsp;
  					 
  					 
    			 	Diagnosi precedente <input type="text" name="diagnosiPrecedente3" id="diagnosiPrecedente3"   value="${esame.diagnosiPrecedente3 }"/>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	&nbsp;&nbsp;&nbsp;
    			 	
    			 	
    			 	T <select name="t3" id="t3"><option value="">--</option><option value="T0">T0</option><option value="T1">T1</option><option value="T2">T2</option><option value="T3">T3</option><option value="T4">T4</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	N <select name="n3" id="n3"><option value="">--</option><option value="N0">N0</option><option value="N1">N1</option><option value="N2">N2</option><option value="N3">N3</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	M <select name="m3" id="m3"><option value="">--</option><option value="M0">M0</option><option value="M1">M1</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	
    			 </div>
    			 <div id="tnm4" name="tnm4" style="display: none">
    			 <br/>
    			 Data diagnosi  <input 
    			 	type="text" 
    			 	id="dataDiagnosi4" 
    			 	name="dataDiagnosi4" 
    			 	maxlength="32" 
    			 	size="50" 
    			 	readonly="readonly" 
    			 	style="width:150px;" 
					value="" 
				  />
    			 <img src="images/b_calendar.gif" alt="calendario" id="id_img_6" />
 					<script type="text/javascript">
      					 Calendar.setup({
        					inputField     :    "dataDiagnosi",     // id of the input field
        					ifFormat       :    "%d/%m/%Y",      // format of the input field
       						button         :    "id_img_4",  // trigger for the calendar (button ID)
       						// align          :    "Tl",           // alignment (defaults to "Bl")
        					singleClick    :    true,
        					timeFormat		:   "24",
        					showsTime		:   false
   							 });					    
  					 </script> &nbsp;&nbsp;&nbsp;
  					 
  					 
    			 	Diagnosi precedente <input type="text" name="diagnosiPrecedente4" id="diagnosiPrecedente4"   value="${esame.diagnosiPrecedente4 }"/>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	&nbsp;&nbsp;&nbsp;
    			 	
    			 	
    			 	T <select name="t4" id="t4"><option value="">--</option><option value="T0">T0</option><option value="T1">T1</option><option value="T2">T2</option><option value="T3">T3</option><option value="T4">T4</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	N <select name="n4" id="n4"><option value="">--</option><option value="N0">N0</option><option value="N1">N1</option><option value="N2">N2</option><option value="N3">N3</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	M <select name="m4" id="m4"><option value="">--</option><option value="M0">M0</option><option value="M1">M1</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	
    			 </div>
    			 <div id="tnm5" name="tnm5" style="display: none">
    			 <br/>
    			 Data diagnosi  <input 
    			 	type="text" 
    			 	id="dataDiagnos5" 
    			 	name="dataDiagnosi5" 
    			 	maxlength="32" 
    			 	size="50" 
    			 	readonly="readonly" 
    			 	style="width:150px;" 
					value="" 
				  />
    			 <img src="images/b_calendar.gif" alt="calendario" id="id_img_7" />
 					<script type="text/javascript">
      					 Calendar.setup({
        					inputField     :    "dataDiagnosi5",     // id of the input field
        					ifFormat       :    "%d/%m/%Y",      // format of the input field
       						button         :    "id_img_7",  // trigger for the calendar (button ID)
       						// align          :    "Tl",           // alignment (defaults to "Bl")
        					singleClick    :    true,
        					timeFormat		:   "24",
        					showsTime		:   false
   							 });					    
  					 </script> &nbsp;&nbsp;&nbsp;
  					 
  					 
    			 	Diagnosi precedente <input type="text" name="diagnosiPrecedente5" id="diagnosiPrecedente5"   value="${esame.diagnosiPrecedente5 }"/>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	&nbsp;&nbsp;&nbsp;
    			 	
    			 	
    			 	T <select name="t5" id="t5"><option value="">--</option><option value="T0">T0</option><option value="T1">T1</option><option value="T2">T2</option><option value="T3">T3</option><option value="T4">T4</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	N <select name="n5" id="n5"><option value="">--</option><option value="N0">N0</option><option value="N1">N1</option><option value="N2">N2</option><option value="N3">N3</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	M <select name="m5" id="m5"><option value="">--</option><option value="M0">M0</option><option value="M1">M1</option></select>&nbsp;&nbsp;&nbsp;&nbsp;
    			 	
    			 </div>
    		</td>
        </tr>    
        
        <tr class="odd">
    		<td style="width:30%">
    			 Dimensione (centimetri)
    		</td>
    		<td style="width:70%"> 
    			<input maxlength="3" type="text" name="dimensione" id="dimensione" size="5" value="${esame.dimensione }"/>
    		</td>
        </tr> 
        
        <tr>
    		<td style="width:30%">
    			 Interessamento Linfonodale
    		</td>
    		<td style="width:70%">  
    			<select name="idInteressamentoLinfonodale" id="idInteressamentoLinfonodale">
    			 	<c:forEach items="${interessamentoLinfonodales }" var="temp">
    			 		<option value="${temp.id }" <c:if test="${temp == esame.interessamentoLinfonodale }">selected="selected"</c:if> >${temp.description }</option>
    			 	</c:forEach>
    			 </select>
       		</td>
        </tr> 
        
        

<tr>
        	<th colspan="2">
        		Risultato
        	</th>
        </tr>
        <tr class="odd">
    		<td style="width:30%">
    			 Data Esito
    		</td>
    		<td style="width:70%">  
    			<fmt:formatDate type="date" value="${esame.dataEsito}" pattern="dd/MM/yyyy" />   
    		</td>
        </tr>
        <tr>
    		<td style="width:30%">
    			 Descrizione Morfologica
    		</td>
    		<td style="width:70%">  
    			${esame.descrizioneMorfologica }  
    		</td>
        </tr>
        
        <tr class="odd">
    		<td style="width:30%">
    			 Diagnosi
    		</td>
    		<td style="width:70%">  
    			${esame.tipoDiagnosi.description }: ${esame.whoUmana } ${esame.diagnosiNonTumorale } 
    		</td>
        </tr> 
        
                
        <tr>
    		<td colspan="2">    
    			<font color="red">* </font> Campi obbligatori
				<br/>
				<c:if test="${!modify }" >
					<input type="submit" value="Salva" />
					<input type="button" value="Salva e Continua" onclick="if(checkform(document.getElementById('form'))==true){document.getElementById('form').action='vam.cc.esamiIstopatologici.AddAndContinue.us';document.getElementById('form').submit();attendere();}" />
				</c:if>
				<c:if test="${modify }" >
		    		<input type="submit" value="Salva" />	
				</c:if>
    			<!--  input
				type="button" value="Immagini"
				onclick="javascript:avviaPopup( 'vam.cc.esamiIstopatologici.GestioneImmagini.us?id=${esame.id }&cc=${cc.id}' );" /-->
    			<input type="button" value="Annulla" onclick="attendere();location.href='vam.cc.esamiIstopatologici.List.us'">
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
	document.getElementById( 'idWhoUmana' ).value = document.getElementById( 'idWhoUmana' + indiceDiv ).value;
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


	<c:if test="${modify }">
		setTimeout( 'updateTNM(${esame.tumoriPrecedenti.id}),selezionaDivTipoDiagnosi("${esame.tipoDiagnosi.id}")', 500 );
	</c:if>
	<c:if test="${modify && esame.sedeLesione.padre != null && esame.sedeLesione.padre.padre == null }" >
		setTimeout( 'selezionaDivSedeLesione( ${esame.sedeLesione.padre.id } )', 600 );
	</c:if>
	<c:if test="${modify && esame.sedeLesione.padre.padre != null }" >
	setTimeout( 'selezionaDivSedeLesione( ${esame.sedeLesione.padre.padre.id } )', 600 );
</c:if>
	<c:if test="${modify && esame.sedeLesione.padre == null }" >
		setTimeout( 'selezionaDivSedeLesione( ${esame.sedeLesione.id } )', 600 );
	</c:if>
	<c:if test="${modify && esame.whoUmana.padre != null}">
		setTimeout( 'selezionaDivWhoUmana( ${esame.whoUmana.padre.id } )', 700 );
	</c:if>
	<c:if test="${modify && esame.whoUmana.padre == null && esame.whoUmana != null}">
		setTimeout( 'selezionaDivWhoUmana( ${esame.whoUmana.id } )', 700 );
	</c:if>
	
	
	function aggiungiRigaTNM()
	{
		if(document.getElementById('tnm1').style.display=='none')
		{
			document.getElementById('tnm1').style.display='block';
		}
		else if(document.getElementById('tnm2').style.display=='none')
		{
			document.getElementById('tnm2').style.display='block';
		}
		else if(document.getElementById('tnm3').style.display=='none')
		{
			document.getElementById('tnm3').style.display='block';
		}
		else if(document.getElementById('tnm4').style.display=='none')
		{
			document.getElementById('tnm4').style.display='block';
		}
		else if(document.getElementById('tnm5').style.display=='none')
		{
			document.getElementById('tnm5').style.display='block';
		}
	}
</script>
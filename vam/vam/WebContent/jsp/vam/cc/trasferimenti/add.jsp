<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/ustl.tld" prefix="us" %>
<%@page import="java.util.Date"%>
<script language="JavaScript" type="text/javascript" src="js/vam/cc/trasferimenti/add.js"></script>
<script type='text/javascript' src='dwr/engine.js'></script>
<script type='text/javascript' src='dwr/interface/Test.js'></script>
<script type='text/javascript' src='dwr/util.js'></script>


<form action="vam.cc.trasferimenti.Add.us" method="post" name="myForm" id="myForm">

	<fmt:formatDate value="${cc.dataApertura}" pattern="dd/MM/yyyy" var="ccDataApertura"/>
	<input type="hidden" name="dataApertura" id="dataApertura" value="${ccDataApertura}" />

	<jsp:include page="/jsp/vam/cc/menuCC.jsp"/>
   	<h4 class="titolopagina">
	   	Nuova Richiesta Trasferimento <c:if test="${urgenza }"><strong>(in urgenza)</strong></c:if>
	</h4>
		
	
	<table class="tabella">
		
		<tr>
        	<th colspan="4">
        		Dati Richiesta Trasferimento <c:if test="${urgenza }"><strong>(in urgenza)</strong></c:if>
        	</th>
        </tr>
        
		<tr class="even">
    		<td style="text-align: left">
        		 <strong>Data&nbsp;</strong>
				 <c:choose>
   					<c:when test="${cc.dayHospital}">					
						<fmt:formatDate type="date" value="${cc.dataApertura}" pattern="dd/MM/yyyy" var="dataPrecompilata"/> 		
 			 		</c:when>
					<c:otherwise>
						<c:set value="" var="dataPrecompilata"/>
 			 		</c:otherwise>
 			 	 </c:choose>
				
        		 <input type="text" value="${dataPrecompilata}" id="dataRichiesta" name="dataRichiesta" maxlength="10" size="10" readonly="readonly" />
				 
				 <c:if test="${cc.dayHospital==false}">
				 	<img src="images/b_calendar.gif" alt="calendario" id="id_img_1" /> <font color="red">* </font>
					<script type="text/javascript">
							Calendar.setup({
								inputField  :    "dataRichiesta",      // id of the input field
								ifFormat    :    "%d/%m/%Y",  // format of the input field
								button      :    "id_img_1",  // trigger for the calendar (button ID)
								// align    :    "rl,      // alignment (defaults to "Bl")
								singleClick :    true,
								timeFormat	:   "24",
								showsTime	:   false
							});					    
					</script> 
				 </c:if>
				
    		</td>
    	</tr>
    	<tr>
    		<th style="text-align: center;" colspan="4">
    			 <strong><br/>Motivazioni/Operazioni Richieste <font color="red">* </font></strong>
    		</th>
    	</tr>
    	<tr>
    		<!--  td valign="top" width="25%">
    			 <table width="100%">
					<tr>
						<th>
							Richieste Varie
						</th>
					</tr>
					<c:forEach items="${operazioniNonBdr}" var="temp" >
						<c:if test="${temp.id == idRichiesteVarie.esameNecroscopico}">
							<tr>
								<td>
									<input type="checkbox"  onchange="popolaOpSelezionate('${temp.id}')" name="op_${temp.id }" id="op_${temp.id }" 
										<us:contain collection="${accettazione.operazioniRichieste }" item="${temp }" >checked="checked"</us:contain> />
									<label for="op_${temp.id }">${temp.description }</label>
								</td>
							</tr>
						</c:if>
					</c:forEach>
				</table>
    		</td-->
			<td valign="top" width="25%" colspan="2">
				<table width="100%">
					<tr>
						<th>
							Approfondimento diagnostico medicina
						</th>
					</tr>
					<c:forEach items="${operazioniPsADM}" var="temp" >
							<tr>
								<td>
									<input type="checkbox" onchange="popolaOpSelezionate('${temp.id}')" name="op_${temp.id }" id="op_${temp.id }" 
										<us:contain collection="${accettazione.operazioniRichieste }" item="${temp }" >checked="checked"</us:contain> />
									<label for="op_${temp.id }">${temp.description }</label>
								</td>
							</tr>
					</c:forEach>
				</table>
			</td>
			<td valign="top" width="25%">
				<table width="100%">
					<tr>
						<th>
							Alta specialit� chirurgica
						</th>
					</tr>
					<c:forEach items="${operazioniPsASC}" var="temp" >
						<tr>
							<td>
								<input type="checkbox" onchange="popolaOpSelezionate('${temp.id}')"  name="op_${temp.id }" id="op_${temp.id }" 
									<us:contain collection="${accettazione.operazioniRichieste }" item="${temp }" >checked="checked"</us:contain> />
								<label for="op_${temp.id }">${temp.description }</label>
							</td>
						</tr>
					</c:forEach>
				</table>
			</td>
			<td valign="top" width="25%">
				<table width="100%">
					<tr>
						<th>
							Diagnostica specialistica strumentale
						</th>
					</tr>
					<c:forEach items="${operazioniPsDSS}" var="temp" >
						<tr>
							<td>
								<input type="checkbox" onchange="popolaOpSelezionate('${temp.id}')"  name="op_${temp.id }" id="op_${temp.id }" 
									<us:contain collection="${accettazione.operazioniRichieste }" item="${temp }" >checked="checked"</us:contain> />
								<label for="op_${temp.id }">${temp.description }</label>
							</td>
						</tr>
					</c:forEach>
				</table>
			</td>
		</tr>
		
		<tr><td colspan="4">&nbsp;</td></tr>
		
		<tr class="even">
			<td style="text-align: right;"><strong>Note</strong></td>
			<td style="text-align: left;" colspan="3">
				<textarea rows="10" cols="60" name="notaRichiesta">${param.notaRichiesta }</textarea>
			</td>
		</tr>
		
		<tr><td colspan="4">&nbsp;</td></tr>
		
		<%-- c:if test="${urgenza }" ora anche quando non c'� urgenza viene permessa la selezione della clinica --%>
		<c:if test="${true }">
			<tr>
				<td style="text-align: right;"><strong>Clinica di Destinazione</strong></td>
				<td style="text-align: left;" colspan="3">
					<c:if test="${urgenza }"><input type="hidden" name="urgenza" value="on" /></c:if>
					<select name="clinicaDestinazioneId" id="clinicaDestinazioneId">
						<c:set var="idAslVecchia" value="-1" />
						<c:forEach items="${cliniche }" var="clinica">
						<c:if test="${utente.clinica.id !=  clinica.id}">
							<c:if test="${clinica.lookupAslNoH.id !=  idAslVecchia}">
								<c:set var="idAslVecchia" value="${clinica.lookupAslNoH.id }" />
								<c:if test="${idAslVecchia != -1 }">
									</optgroup>
								</c:if>
								<optgroup label="${clinica.lookupAslNoH }">
							</c:if>
							<option value="${clinica.id }" <c:if test="${clinica.id == param.clinicaDestinazioneId }">selected="selected"</c:if> >${clinica.nome} ${clinica.lookupComuniNOH.description}</option>
						</c:if>
						</c:forEach>
						<c:if test="${idAslVecchia != -1 }">
							</optgroup>
						</c:if>
					</select>
				</td>
			</tr>
			
			<tr><td colspan="4">&nbsp;</td></tr>
			
		</c:if>
	
	<tr>
		<td>&nbsp;</td>
		<td colspan="3" style="text-align: left;">	
		 	<font color="red">* Campi obbligatori</font><br/> 
			<input type="submit" value="Salva" onclick="return checkform('${utente.id}','${cc.accettazione.animale.id}');" />
			<input type="button" value="Annulla" onclick="attendere(), location.href='vam.cc.trasferimenti.List.us'">
		 </td>
	 </tr>
 	</table>

</form>

<script type="text/javascript">
//function checkForm( form )
//{
	//cambiata la logica, controlli eseguiti server side
	/*
	if( document.myForm.notaRichiesta.value != "" )
	{
		return true;
	}
	else
	{
		alert( "Inserire il motivo della richiesta" );
		return false;
	}
	*/
//}

var opSelezionate = new Array();
</script>

<script>
dwr.engine.setErrorHandler(errorHandler);
dwr.engine.setTextHtmlHandler(errorHandler);

function errorHandler(message, exception){
    //Session timedout/invalidated

    if(exception && exception.javaClassName== 'org.directwebremoting.impl.LoginRequiredException'){
        alert(message);
        //Reload or display an error etc.
        window.location.href=window.location.href;
    }
    else
        alert('Errore Nella Chiamata Remota : '+exception.javaClassName);
 }
</script>
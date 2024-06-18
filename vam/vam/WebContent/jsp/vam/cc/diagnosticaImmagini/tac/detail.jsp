<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>

    
    <jsp:include page="/jsp/vam/cc/menuCC.jsp"/>
    <h4 class="titolopagina">
     		Dettaglio TAC
    </h4>
    
    <table class="tabella">
    	
    	<tr>
        	<th colspan="3">
        		Informazioni preliminari
        	</th>
        </tr>
    	<tr>
    		<td style="width:50%">
    			 Data Richiesta:&nbsp;
    			 <fmt:formatDate type="date" value="${tac.dataRichiesta}" pattern="dd/MM/yyyy" var="dataRichiesta"/> 		
    			 ${dataRichiesta}
    		</td>
    		<td style="width:50%">
    			 Data Esito:&nbsp;
    			 <fmt:formatDate type="date" value="${tac.dataEsito}" pattern="dd/MM/yyyy" var="dataEsito"/> 		
    			 ${dataEsito}
    		</td>
			
		</tr>
    	</table>
    	
    	<table class="tabella">
    	<tr>
        	<th colspan="3">
        		Informazioni Aggiuntive
        	</th>
        </tr>
        <tr class="odd">
			<td>Inserito da</td>
			<td>${tac.enteredBy} il <fmt:formatDate value="${tac.entered}" pattern="dd/MM/yyyy"/></td>
		</tr>
		<c:if test="${tac.modifiedBy!=null}">
			<tr class="even">
				<td>Modificato da</td><td>${tac.modifiedBy} il <fmt:formatDate value="${tac.modified}" pattern="dd/MM/yyyy"/></td>
			</tr>
		</c:if>
        <tr class="odd">
        <td style="width:50%">
				Note
		</td>
    	<td>
			${tac.note}
		</td>
		</tr>	
        <tr class='even'>
    		<td colspan="3">
    			<input type="button" value="Modifica" onclick="if(${cc.dataChiusura!=null}){ 
    				if(myConfirm('Cartella Clinica chiusa. Vuoi procedere?')){location.href='vam.cc.diagnosticaImmagini.tac.ToEdit.us?idTac=${tac.id}'}
    				}else{location.href='vam.cc.diagnosticaImmagini.tac.ToEdit.us?idTac=${tac.id}'}">
    			<input type="button" value="Lista TAC" onclick="location.href='vam.cc.diagnosticaImmagini.tac.List.us'">
    		</td>
        </tr>
	</table>

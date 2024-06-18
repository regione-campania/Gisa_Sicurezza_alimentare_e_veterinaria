<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>


<jsp:include page="/jsp/vam/cc/menuCC.jsp"/>
<h4 class="titolopagina">
     		Dettaglio ECG
</h4>

<table class="tabella">
<%--     	<tr>
    		<th colspan="2">
    			ECG effettuato dal Dott. ${ecg.enteredBy.nome} ${ecg.enteredBy.cognome} 
    			in data <fmt:formatDate type="date" value="${ecg.dataRichiesta}" pattern="dd/MM/yyyy" var="dataRichiesta"/>
    			 <c:out value="${dataRichiesta}"/>
    		</th>
    	</tr> --%>
    	
    	<tr class="odd">
    		<td colspan="2">
    			DURATA
				Velocit� carta:
				<ul>
					<li>
						50 mm/sec > 1 quadratino = 0.02 mm/sec
					</li>
					<li>
						25 mm/sec > 1 quadratino = 0.04 mm/sec
					</li>
				</ul>
				
				AMPIEZZA
				<ul>
					<li>
						1cm = 1mv > 1 quadratino = 0.1 mv
					</li>
					<li>
						2cm = 1mv
					</li>
				</ul>
    		</td>
    	</tr> 
    	
    	<th colspan="2">
    		Misurazioni effettuate in II derivazione (50mm/sec)
    	</th>
    	
    	<tr>
    		<td style="width:30%">
    			 Ritmo
    		</td>
    		<td style="width:70%"> 
    			<c:if test="${ecg.ritmo=='S'}">
    				Sinusale
    			</c:if> 
    			<c:if test="${ecg.ritmo=='A'}">
    				Aritmico
    			</c:if> 
    		</td>
        </tr>
        

		<tr class="odd">
    		<td style="width:30%">
    			 Frequenza (in bpm)
    		</td>
    		<td style="width:70%">  
    			${ecg.frequenza}
    		</td>
        </tr>     
        
        <tr>
    		<td style="width:30%">
    			 Ampiezza onda P (in quadratini)
    		</td>
    		<td style="width:70%">  
    			 ${ecg.ampiezzaOndaP} 
    		</td>
        </tr>   
        
        <tr class="odd">
    		<td style="width:30%">
    			 Durata onda P (in quadratini)
    		</td>
    		<td style="width:70%"> 
    			${ecg.durataOndaP}  
    		</td>
        </tr>    
        
        <tr>
    		<td style="width:30%">
    			 Ampiezza onda R (in quadratini)
    		</td>
    		<td style="width:70%"> 
    			${ecg.ampiezzaOndaR}  
    		</td>
        </tr>    
        
        <tr class="odd">
    		<td style="width:30%">
    			 Durata PR (in quadratini)
    		</td>
    		<td style="width:70%"> 
    			${ecg.durataPR}  
    		</td>
        </tr>  
        
        <tr>
    		<td style="width:30%">
    			 Durata complesso QRS (in quadratini)
    		</td>
    		<td style="width:70%">  
    			${ecg.durataComplessoQRS}  
    		</td>
        </tr> 
        
        <tr class="odd">
    		<td style="width:30%" >
    			 Durata ST (in quadratini)
    		</td>
    		<td style="width:70%"> 
    			${ecg.durataSTInQuadratini} 
    				<c:if test="${ecg.durataST=='T'}">
    					- Sottoslivellato
    				</c:if> 
    				<c:if test="${ecg.durataST=='P'}">
    					- Sopraslivellato
    				</c:if>
    		</td>
        </tr> 
        
        <tr>
    		<td style="width:30%">
    			 Ampiezza onda T (in quadratini)
    		</td>
    		<td style="width:70%">  
    			${ecg.ampiezzaOndaT}  
    		</td>
        </tr> 
        
        <tr class="odd">
    		<td style="width:30%">
    			 Intervallo QT (in quadratini)
    		</td>
    		<td style="width:70%">  
    			${ecg.intervalloQT}  
    		</td>
        </tr> 
        
        <tr>
    		<td style="width:30%">
    			 Intervallo RR (in quadratini)
    		</td>
    		<td style="width:70%">  
    			${ecg.intervalloRR}  
    		</td>
        </tr> 
        
        <tr class="odd">
    		<td style="width:30%">
    			  QT corretto
    		</td>
    		<td style="width:70%">  
    			${ecg.QTCorretto}  
    		</td>
        </tr> 
        
        <tr>
    		<td style="width:30%">
    			 Diagnosi
    		</td>
    		<td style="width:70%"> 
    			<c:if test="${ecg.diagnosi=='N'}">
    				esame ECG nella norma
    			</c:if> 
    			<c:if test="${ecg.diagnosi=='P'}">
    				<c:forEach items="${ecg.aritmie}" var="aritmia">
    					${aritmia.nome} <br/>
    				</c:forEach>
    			</c:if>
    			<c:if test="${ecg.diagnosi==null}">
    				Non specificato
    			</c:if>
    		</td>
        </tr> 
    	</table>
    	 <table class="tabella">
			<tr>
				<th colspan="3">
				       		Altre Informazioni
				 </th>
			 </tr> 	  
			<tr class="odd">
				<td>Inserito da</td>
				<td>${ecg.enteredBy} il <fmt:formatDate value="${ecg.entered}" pattern="dd/MM/yyyy"/></td>
			</tr>
			<c:if test="${ecg.modifiedBy!=null}">
			<tr class="even">
				<td>Modificato da</td><td>${ecg.modifiedBy} il <fmt:formatDate value="${ecg.modified}" pattern="dd/MM/yyyy"/></td>
			</tr>
			</c:if>
		</table>  	

    			<input type="button" value="Modifica" onclick="if(${cc.dataChiusura!=null}){ 
    				if(myConfirm('Cartella Clinica chiusa. Vuoi procedere?')){location.href='vam.cc.ecg.ToEdit.us?idEcg=${ecg.id}'}
    				}else{location.href='vam.cc.ecg.ToEdit.us?idEcg=${ecg.id}'}">
	    		<input type="button" value="Lista ECG" onclick="location.href='vam.cc.ecg.List.us'">

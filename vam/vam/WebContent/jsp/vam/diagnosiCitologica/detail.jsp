<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>

<h4 class="titolopagina">
     		Dettaglio Esame Istopatologico
</h4>


<br>
<c:set var="tipo" scope="request" value="stampaIstoSingoloLP"/>
<c:set var="idEsame" scope="request" value="${esame.id }"/>
<c:import url="../../jsp/documentale/homeRichiesteIsto.jsp"/>
<!-- input type="button" value="Stampa la richiesta" onclick="location.href='vam.richiesteIstopatologici.Pdf.us?id=${esame.id }'" /-->
<input type="hidden" name="liberoProfessionista" value="${liberoProfessionista }" />
    
<table class="tabella">
    	
        <tr>
    		<th colspan="2">
    			Esame Istopatologico numero ${esame.numero} , richiesto 
    			in data <fmt:formatDate type="date" value="${esame.dataRichiesta}" pattern="dd/MM/yyyy" />
    		</th>
    	</tr>

		<tr class="odd">
    		<td style="width:30%">
    			 Peso Animale
    		</td>
    		<td style="width:70%">  
    			${esame.peso}
    		</td>
        </tr>     
        <tr class="even">
    		<td style="width:30%">
    			 Alimentazioni
    		</td>
    		<td style="width:70%">  
    		
    			<c:forEach items="${la}" var="a">
						
						${a.description} - 							
		    					      											
				</c:forEach>					
    		   		
    			
    		</td>
        </tr>     
        <tr class="odd">
    		<td style="width:30%">
    			 Habitat
    		</td>
    		<td style="width:70%">  
    			<c:forEach items="${lh}" var="h">
						
						${h.description} - 							
		    					      											
				</c:forEach>		
    		</td>
        </tr>     



        <tr class='even'>
    		<td>
    			 Laboratorio di destinazione
    		</td>
    		<td>
    			 ${esame.lass.description}
    		</td>
    		<td>
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
        
        <tr>
    		<td style="width:30%">
    			 Tumori Precedenti
    		</td>
    		<td style="width:70%"> 
    			${esame.tumoriPrecedenti.description }  
    		</td>
        </tr>    
        
    <c:if test="${esame.tumoriPrecedenti.id == 2 }">
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
        
        <tr class="odd">
    		<td style="width:30%">
    			 Sede Lesione e Sottospecifica
    		</td>
    		<td style="width:70%">  
    			${esame.sedeLesione }  
    		</td>
        </tr> 
        <tr>
        	<th colspan="2">
        		Risultato
        	</th>
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
  				<c:choose>
					<c:when test="${ liberoProfessionista == true}">																	
						<input type="button" value="Torna alla Home" onclick="location.href='Home.us'">
  					</c:when>										
					<c:otherwise>								
						<input type="button" value="Modifica" onclick="location.href='vam.richiesteIstopatologici.ToEdit.us?modify=on&idEsame=${esame.id }'">
	    				<input type="button" value="Torna alla Home Page" onclick="location.href='Home.us'">
  					</c:otherwise>
				</c:choose>     				
	    	</td>
    	</tr>
        
    	
   	</table>

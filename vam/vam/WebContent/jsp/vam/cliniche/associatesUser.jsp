<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<script language="JavaScript" type="text/javascript" src="js/vam/cliniche/associatesUser.js"></script>

<form action="vam.cliniche.AssociatesUser.us" name="form" method="post" class="marginezero">

 <input type="hidden" name="categorieSelezionate" value=""/>
    
    <h4 class="titolopagina">
     		Associazione Utente/Clinica
    </h4>
    <table class="tabella">
    	<tr>
        	<th>
        		Utente
        	</th>
        	<th>
        		Cliniche
        	</th>
        	<th>
        		Operazioni
        	</th>
        </tr>
        
        <c:set var="indiceRiga" value="1"/>
        <c:forEach var="utentiAssociati" items="${utentiAssociati}">
        		<tr class="${indiceRiga % 2 == 0 ? 'odd' : 'even'}">
    				<td>
    					<input type="hidden" value="${utentiAssociati.id}" name="idUtenteGiaAssegnato" />
           				<c:out value="${utentiAssociati.username}"/>: <c:out value="${utentiAssociati.nome}"/> <c:out value="${utentiAssociati.cognome}"/>
    				</td>
    		
    				<td>
  		          		<a style="cursor:pointer;text-decoration:underline;color:blue;" onclick="avviaPopupPiccola(this, 'vam.cliniche.DetailPopup.us?id=${utentiAssociati.clinica.id}', 800, 600);"><c:out value="${utentiAssociati.clinica.nome}"/></a> <br/>
    				</td>
    				<td>
    					<input type="button" value="Modifica" onclick="location.href='vam.cliniche.ToAssociatesUserEdit.us?idUtente=${utentiAssociati.id}'"  />
    				</td>
        		</tr>
        		<c:set var="indiceRiga" value="${indiceRiga+1}"/>
        </c:forEach>
        
    	<tr class="${indiceRiga % 2 == 0 ? 'odd' : 'even'}">
    		<td>
    			<select name="idUtente">
					<option value="">&lt;--- Selezionare Utente ---&gt;</option>
    				
    				<c:forEach var="utenteNonAssociato" items="${utentiNonAssociati}">
            			<option value="<c:out value="${utenteNonAssociato.id}"/>"><c:out value="${utenteNonAssociato.username}"/>: ${utenteNonAssociato.nome} ${utenteNonAssociato.cognome}</option>
            		</c:forEach>
    			</select>
    		</td>
    		
    		<td>
    			<select name="clinica" id="clinica">
    				<option value="">&lt;--- Selezionare Clinica ---&gt;</option>
    				<c:forEach var="clinica" items="${elencoCliniche}">
    					<option value="${clinica.id}">${clinica.nome}</option>
    				</c:forEach>
    			</select>
    		</td>
    		<td>
    			<input type="button" value="Associa" onclick="javascript:checkform();"/>
    		</td>
        </tr>
        
	</table>
</form>
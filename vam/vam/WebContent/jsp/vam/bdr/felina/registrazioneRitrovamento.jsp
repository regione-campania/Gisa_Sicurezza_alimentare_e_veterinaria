<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>

<%@page import="it.us.web.util.vam.CaninaRemoteUtil"%>
<%@page import="it.us.web.bean.BUtente"%>
<%@page import="java.util.Date"%>

<form action="vam.bdr.felina.Ritrovamento.us" method="post">

	<input type="submit" value="Procedi" onclick="return checkForm() && myConfirm('Sicuro di voler procedere col salvataggio della registrazione di ritrovamento in BDR?');" />
	
	<fieldset>
		<legend>Registrazione Ritrovamento ${accettazione.animale.lookupSpecie.description } ${accettazione.animale.identificativo }</legend>
		
		<input type="hidden" name="idAccettazione" value="${accettazione.id }" />
		
		<table class="tabella">
			<tr class="even" >
				<td>Data</td>
				<td>
					<input 
						type="text" 
						value="<fmt:formatDate type="date" value="<%=new Date() %>" pattern="dd/MM/yyyy" />"
						id="dataRitrovamento" 
						name="dataRitrovamento" 
						maxlength="10" 
						size="10" 
						readonly="readonly" />
						<img src="images/b_calendar.gif" alt="calendario" id="id_img_1" />
						<script type="text/javascript">
							Calendar.setup({
								inputField  :    "dataRitrovamento",      // id of the input field
								ifFormat    :    "%d/%m/%Y",  // format of the input field
								button      :    "id_img_1",  // trigger for the calendar (button ID)
								// align    :    "rl,      // alignment (defaults to "Bl")
								singleClick :    true,
								timeFormat	:   "24",
								showsTime	:   false
							});					    
						</script>
				</td>
			</tr>
			<tr>
		        <td>
		       		 Provincia e Comune<font color="red"> *</font>
		        </td>
		        <td>
		        	<select id="provincia"  name="provincia" onChange="javascript: chooseProvincia(this.value)">
						<option value=""  SELECTED>&lt;--- Selezionare la provincia ---&gt;</option>
	    				<option value="AV" >  Avellino  	</option>
	    				<option value="BN" >  Benevento  </option>
	            		<option value="CE" >  Caserta 	</option>
	            		<option value="NA" >  Napoli 	</option>  
	            		<option value="SA" >  Salerno 	</option>  
		    		</select>      		             
		        </td>
		        <td>    
			        	<select name="comuneBN" id="comuneBN">
							<option value="0">&lt;--- Selezionare il comune BN  ---&gt;</option>
		    				<c:forEach var="bn" items="${listComuniBN}">
		            			<option value="<c:out value="${bn.codiceIstat}"/>">            				
		            				${bn.description}
		    					</option>
		            		</c:forEach>
		    			</select>      
			        	<select name="comuneNA" id="comuneNA">
							<option value="0">&lt;--- Selezionare il comune NA  ---&gt;</option>
		    				<c:forEach var="na" items="${listComuniNA}">
		            			<option value="<c:out value="${na.codiceIstat}"/>">            				
		            				${na.description}
		    					</option>
		            		</c:forEach>
		    			</select>      
			        	<select name="comuneSA" id="comuneSA">
							<option value="0">&lt;--- Selezionare il comune SA  ---&gt;</option>
		    				<c:forEach var="sa" items="${listComuniSA}">
		            			<option value="<c:out value="${sa.codiceIstat}"/>">            				
		            				${sa.description}
		    					</option>
		            		</c:forEach>
		    			</select>      
			        	<select name="comuneCE" id="comuneCE">
							<option value="0">&lt;--- Selezionare il comune CE  ---&gt;</option>
		    				<c:forEach var="ce" items="${listComuniCE}">
		            			<option value="<c:out value="${ce.codiceIstat}"/>">            				
		            				${ce.description}
		    					</option>
		            		</c:forEach>
		    			</select>      
			        	<select name="comuneAV" id="comuneAV">
							<option value="0">&lt;--- Selezionare il comune AV  ---&gt;</option>
		    				<c:forEach var="av" items="${listComuniAV}">
		            			<option value="<c:out value="${av.codiceIstat}"/>">            				
		            				${av.description}
		    					</option>
		            		</c:forEach>
		    			</select>      
		        </td>
        	</tr>
			<tr class="odd" >
				<td>Indirizzo</td>
				<td> <input type="text" size="30" maxlength="20" name="luogoRitrovamento" /> </td>
			</tr>
			<tr class="even" >
				<td>Note</td>
				<td>
					<textarea rows="3" cols="30" name="noteRitrovamento"  maxLength="300" ></textarea>
				</td>
			</tr>
		</table>
	</fieldset>
	
	<br/>
	<input type="submit" value="Procedi" onclick="return checkForm() && myConfirm('Sicuro di voler procedere col salvataggio della registrazione di ritrovamento in BDR?');" />
	
</form>

<script type="text/javascript">
function chooseProvincia(provincia) {
	if (provincia == 'BN') {
		document.getElementById( 'comuneBN' ).style.display = "";
		document.getElementById( 'comuneNA' ).style.display = "none";
		document.getElementById( 'comuneSA' ).style.display = "none";
		document.getElementById( 'comuneCE' ).style.display = "none";
		document.getElementById( 'comuneAV' ).style.display = "none";
		
	}
	else if (provincia == 'NA') {
		document.getElementById( 'comuneBN' ).style.display = "none";
		document.getElementById( 'comuneNA' ).style.display = "";
		document.getElementById( 'comuneSA' ).style.display = "none";
		document.getElementById( 'comuneCE' ).style.display = "none";
		document.getElementById( 'comuneAV' ).style.display = "none";
	}	
	else if (provincia == 'AV') {
		document.getElementById( 'comuneBN' ).style.display = "none";
		document.getElementById( 'comuneNA' ).style.display = "none";
		document.getElementById( 'comuneSA' ).style.display = "none";
		document.getElementById( 'comuneCE' ).style.display = "none";
		document.getElementById( 'comuneAV' ).style.display = "";
	}
	else if (provincia == 'SA') {
		document.getElementById( 'comuneBN' ).style.display = "none";
		document.getElementById( 'comuneNA' ).style.display = "none";
		document.getElementById( 'comuneSA' ).style.display = "";
		document.getElementById( 'comuneCE' ).style.display = "none";
		document.getElementById( 'comuneAV' ).style.display = "none";
	}
	else if (provincia == 'CE') {
		document.getElementById( 'comuneBN' ).style.display = "none";
		document.getElementById( 'comuneNA' ).style.display = "none";
		document.getElementById( 'comuneSA' ).style.display = "none";
		document.getElementById( 'comuneCE' ).style.display = "";
		document.getElementById( 'comuneAV' ).style.display = "none";
	}
	else if (provincia == 'X') {
		document.getElementById( 'comuneBN' ).style.display = "none";
		document.getElementById( 'comuneNA' ).style.display = "none";
		document.getElementById( 'comuneSA' ).style.display = "none";
		document.getElementById( 'comuneCE' ).style.display = "none";
		document.getElementById( 'comuneAV' ).style.display = "none";
	}
}

function checkForm()
{
	var provincia = document.getElementById("provincia");
	if(provincia.value=="")
	{
		alert("Selezionare la provincia");
		document.getElementById('provincia').focus();
		return false;	
	}
	var comune = document.getElementById("comune"+provincia.value);
	if(provincia.value!="" && comune.value=="0")
	{
		alert("Selezionare il comune");
		document.getElementById('provincia').focus();
		return false;	
	}
	if(document.getElementById("indirizzo").value=="")
	{
		alert("Inserire l'indirizzo");
		document.getElementById('indirizzo').focus();
		return false;	
	}
	return true;
}
</script>

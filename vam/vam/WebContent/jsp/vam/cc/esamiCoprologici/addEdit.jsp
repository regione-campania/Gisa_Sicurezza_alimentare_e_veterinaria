<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/ustl.tld" prefix="us" %>

<%@page import="java.util.Date"%>

<form action="vam.cc.esamiCoprologici.AddEdit.us" name="form" method="post" class="marginezero" onsubmit="javascript:return checkForm(this);">    

  

    <jsp:include page="/jsp/vam/cc/menuCC.jsp"/>
    
	  <h4 class="titolopagina">
		<c:if test="${!modify }" >     
			Nuovo Esame Coprologico
		</c:if>
		<c:if test="${modify }" >
			Modifica Esame Coprologico 
    			
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
    	<tr>
    		<td style="text-align: right;">
    			 Data Richiesta<font color="red"> *</font>
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
    		<td style="text-align: right;">
    			 Data Esito
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
          

        
		<tr>
			<th style="text-align: left;">Elminti</th>
			<th style="text-align: left;">Protozoi</th>
		</tr>
		
		<tr class="odd">
    		<td style="vertical-align: top">
				<c:forEach items="${elminti}" var="temp" >
					<input type="checkbox" name="el_${temp.id }" id="el_${temp.id }" 
						<us:contain collection="${esame.elminti }" item="${temp }" >checked="checked"</us:contain> />
					<label for="el_${temp.id }">${temp.description }</label> <br/>
				</c:forEach> 
    		</td>
    		<td style="vertical-align: top">
    			<c:forEach items="${protozoi}" var="temp" >
					<input type="checkbox" name="pr_${temp.id }" id="pr_${temp.id }" 
						<us:contain collection="${esame.protozoi }" item="${temp }" >checked="checked"</us:contain> />
					<label for="pr_${temp.id }">${temp.description }</label> <br/>
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
    			<input type="button" value="Annulla" onclick="location.href='vam.cc.esamiCoprologici.List.us'">
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

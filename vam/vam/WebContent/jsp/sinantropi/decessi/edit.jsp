<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>
<script language="JavaScript" type="text/javascript" src="js/sinantropi/decessi/edit.js"></script>


<form action="sinantropi.decessi.Edit.us" name="form" method="post" onsubmit="javascript:return checkform(this);">

	<input type="hidden" name="idSinantropo" value="${s.id}"/>

	<h4 class="titolopagina">
	   	Modifica di Decesso
	</h4>
	<jsp:include page="/jsp/sinantropi/menuSin.jsp"/>  
	<script type="text/javascript">
				ddtabmenu.definemenu("ddtabs2",2);		
	</script> 
		
	<table class="tabella">
		
		<tr>
        	<th colspan="3">
        		Dati generali
        	</th>
        </tr>
        
        <tr class="even">
    		<td>
    			 Data Decesso<font color="red"> *</font>
    		</td>
    		<td>   
    			<fmt:formatDate type="date" value="${s.dataDecesso}" pattern="dd/MM/yyyy" var="dataDecesso"/> 		 		 		
    			 <input type="text" id="dataDecesso" name="dataDecesso" maxlength="32" size="50" readonly="readonly" style="width:246px;" value="${dataDecesso}"/>
    			 <img src="images/b_calendar.gif" alt="calendario" id="id_img_3" />
 					<script type="text/javascript">
      					 Calendar.setup({
        					inputField     :    "dataDecesso",     // id of the input field
        					ifFormat       :    "%d/%m/%Y",      // format of the input field
       						button         :    "id_img_3",  // trigger for the calendar (button ID)
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
	    		Causa del decesso<font color="red"> *</font>
    		</td>
    		<td>
		        <select name="causaMorte">
		        	<option value="0">&lt;--- Selezionare la causa del decesso ---&gt;</option>
    				
		        	 <c:forEach items="${listCMI}" var="temp" >	    	 
		        		
		        		<option value="<c:out value="${temp.id}"/>"
            				<c:if test="${temp.id == s.lookupCMI.id}">
  		          				<c:out value="selected=selected"></c:out> 
    						</c:if>           			
            			>
            				${temp.description}
    					</option>			        	 	       	 				
					</c:forEach>
		        </select>
	        </td>	        
	      </tr>
        
        <tr class='odd'>   
		<td>
		</td>
		<td>  
			<font color="red">* </font> Campi obbligatori
			<br> 	
			<input type="submit" value="Modifica" />			
	 	</td>
	 	<td>
	 	</td>
 	</tr>

</table>

</form>
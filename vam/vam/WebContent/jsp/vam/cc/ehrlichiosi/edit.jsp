<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>
<%@page import="java.util.Date"%>
<script language="JavaScript" type="text/javascript" src="js/vam/cc/ehrlichiosi/edit.js"></script>


<form action="vam.cc.ehrlichiosi.Edit.us" method="post" onsubmit="javascript:return checkform(this);">

	<input type="hidden" name="idEhrlichiosi" value="<c:out value="${e.id}"/>"/>
	
	
	
	<jsp:include page="/jsp/vam/cc/menuCC.jsp"/>
	<h4 class="titolopagina">
	   	Modifica Ehrlichiosi
	</h4>
		
	
	<table class="tabella">
		
		<tr>
        	<th colspan="3">
        		Dati Ehrlichiosi
        	</th>
        </tr>
			
		<tr class="even">
    		<td>
    			 Data Richiesta
    			 <fmt:formatDate value="${e.dataRichiesta}" pattern="dd/MM/yyyy" var="dataRichiesta"/>   			 
    			 <input type="text" id="dataRichiesta" name="dataRichiesta" maxlength="32" size="50" readonly="readonly" style="width:246px;" value="${dataRichiesta}"/>
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
    		<td>
    			 Data Esito
    			 <fmt:formatDate value="${e.dataEsito}" pattern="dd/MM/yyyy" var="dataEsito"/>   			 
    			 <input type="text" id="dataEsito" name="dataEsito" maxlength="32" size="50" readonly="readonly" style="width:246px;" value="${dataEsito}"/>
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
	        <td>
	       		 Esito
	        </td>
        <td>
	        <select name="esito">				
   				<c:forEach var="listE" items="${listEsiti}">
           			<option value="<c:out value="${listE.id}"/>"
           			
           				<c:if test="${listE.id == e.lee.id}">
  		          			<c:out value="selected=selected"></c:out> 
    					</c:if>   
           			
           			>            				
           				${listE.description}
   					</option>
           		</c:forEach>
	    	</select> 
	    	      
        </td>
        </tr>
	
	<tr>
		<td>
		</td>
		<td>	
			<input type="submit" value="Modifica" />
			<input type="button" value="Annulla" onclick="attendere(), location.href='vam.cc.ehrlichiosi.List.us'">
		 </td>
	 </tr>
 	</table>

</form>

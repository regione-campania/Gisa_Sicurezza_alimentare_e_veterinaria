<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt" %>
<%@page import="java.util.Date"%>
<script language="JavaScript" type="text/javascript" src="js/vam/cc/leishmaniosi/add.js"></script>


<form action="vam.cc.leishmaniosi.Add.us" method="post" onsubmit="javascript:return checkform(this);">

	
	
	<jsp:include page="/jsp/vam/cc/menuCC.jsp"/>
	<h4 class="titolopagina">
	   	Nuova Leishmaniosi
	</h4> 
		
	
	<table class="tabella">
		
		<tr>
        	<th colspan="3">
        		Dati Leishmaniosi
        	</th>
        </tr>
			
		<tr class="even">
    		<td>
    			 Data Prelievo Leishmaniosi
    		</td>
    		<td>    		
    			 <fmt:formatDate type="date" value="<%=new Date() %>" pattern="dd/MM/yyyy" var="dataOdierna"/> 		
    			 <input type="text" id="dataPrelievoLeishmaniosi" name="dataPrelievoLeishmaniosi" maxlength="32" size="50" readonly="readonly" style="width:246px;" value="${dataOdierna}"/>
    			 <img src="images/b_calendar.gif" alt="calendario" id="id_img_1" />
 					<script type="text/javascript">
      					 Calendar.setup({
        					inputField     :    "dataPrelievoLeishmaniosi",     // id of the input field
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
    		</td>
        </tr>
        
        <tr class="odd">
    		<td>
    			 Data Esito Leishmaniosi
    		</td>
    		<td>    		
    			 <input type="text" id="dataEsitoLeishmaniosi" name="dataEsitoLeishmaniosi" maxlength="32" size="50" readonly="readonly" style="width:246px;"/>
    			 <img src="images/b_calendar.gif" alt="calendario" id="id_img_2" />
 					<script type="text/javascript">
      					 Calendar.setup({
        					inputField     :    "dataEsitoLeishmaniosi",     // id of the input field
        					ifFormat       :    "%d/%m/%Y",      // format of the input field
       						button         :    "id_img_2",  // trigger for the calendar (button ID)
       						// align          :    "Tl",           // alignment (defaults to "Bl")
        					singleClick    :    true,
        					timeFormat		:   "24",
        					showsTime		:   false
   							 });					    
  					 </script>   
    		</td>
    		<td>
    		</td>
        </tr>
        
        
        <tr class="even">
	        <td>
	       		 Esito
	        </td>
        <td>
	        <select name="esito">				
   				<c:forEach var="listE" items="${listEsiti}">
           			<option value="<c:out value="${listE.id}"/>">            				
           				${listE.description}
   					</option>
           		</c:forEach>
	    	</select>              
        </td>
        </tr>
        
        
        <tr class="odd">
	        <td>
	       		 Ordinanza Sindaco
	        </td>
        <td>
	        <input type=text name="ordinanzaSindaco" maxlength="12" size="50"/>  
        </td>
        <td>
        	Del        
   		 	<input type="text" id="dataOrdinanzaSindaco" name="dataOrdinanzaSindaco" maxlength="32" size="50" readonly="readonly" style="width:246px;"/>
			 <img src="images/b_calendar.gif" alt="calendario" id="id_img_3" />
			<script type="text/javascript">
					Calendar.setup({
 					inputField     :    "dataOrdinanzaSindaco",     // id of the input field
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
	
	<tr>
		<td>
		</td>
		<td>	
			<input type="submit" value="Salva"/>
			<input type="button" value="Annulla" onclick="attendere(), location.href='vam.cc.leishmaniosi.List.us'">
		 </td>
	 </tr>
 	</table>

</form>


<link rel="stylesheet" type="text/css" href="css/jmesa.css"></link>		
		<script type="text/javascript" src="javascript/jquery-1.3.min.js"></script>
		<script type="text/javascript" src="javascript/jquery.bgiframe.pack.js"></script>
		<script type="text/javascript" src="javascript/jquery.jmesa.js"></script>
		<script type="text/javascript" src="javascript/jmesa.js"></script>

<script>
function chiamaAction(stringa1){
	var scroll = document.body.scrollTop;
	location.href=stringa1+scroll;
}

</script>	
<p>
			Utilizzare le caselle vuote sopra l'intestazione per effettuare la ricerca per microchip, nome, cognome e codice fiscale del proprietario e/o per comune	</p>
		
		
		
		<%
		if(request.getAttribute("errore")!=null){
			
			%>
			<font color="red">
			<%=request.getAttribute("errore")+"<br><br>" %>
			</font>
			
			<% 
			
		}
		
		%>
		
		
		
		
	<%
	String aggiunto="false";
	if(request.getAttribute("aggiunto")!=null)
	 aggiunto=(String)request.getAttribute("aggiunto");
	
	%>

		
	 <%
  Integer numeroCani =(Integer) request.getAttribute("numeroChip");
  
  %>
		<!-- <a href="javascript:chiamaAction('McNonStandardList.do?command=Add&maxRows=15&15_sw_=true&15_tr_=true&15_p_=<%=numeroCani %>&15_mr_=15&scroll=')">Inserisci Microchip non standard</a> -->
		
		<br />
						<br />
		<form name="aiequidiForm" action="McNonStandardList.do?aggiunto=<%=aggiunto %>">
		
	     
	     <%if(request.getAttribute("add")!=null) {%>
	     <input type="hidden" name="add" value="add">
	     
	     <%} %>
	     
	     
	      <jmesa:htmlColumn property="chkbox" title=" " worksheetEditor="org.jmesa.worksheet.editor.CheckboxWorksheetEditor" filterable="false" sortable="false"/>
	     
	     <%if(request.getAttribute( "tabella" )!=null) {%>
	       <%=request.getAttribute( "tabella" )%>
	       <%} %>
	    <jmesa:tableFacade editable="true" >   <jmesa:htmlRow uniqueProperty="serial_number">   </jmesa:htmlRow></jmesa:tableFacade>
	    
	    <script type="text/javascript">
            function onInvokeAction(id) {
                $.jmesa.setExportToLimit(id, '');
                $.jmesa.createHiddenInputFieldsForLimitAndSubmit(id);
            }
            function onInvokeExportAction(id) {
                var parameterString = $.jmesa.createParameterStringForLimit(id);
				
                 location.href = 'McNonStandardList.do?&' + parameterString;
            }
    </script>
	    </form>
	   
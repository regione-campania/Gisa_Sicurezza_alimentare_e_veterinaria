<form action="vam.accettazione.AddSmaltimentoCarogna.us" name="form" method="post" id="form" class="marginezero">


<%
int idAcc = Integer.parseInt(request.getParameter("idAcc"));
String dataAcc = request.getParameter("dataAcc");
%>

<input type="hidden" name="dataApertura" id="dataApertura" value="<%=dataAcc%>"> 
<input type="hidden" name="idAccettazione" value="<%=idAcc%>" />
		
<table class="tabella">
       	<tr>
    		<td>
    			 Data<font color="red"> *</font>
    		</td>
    		<td>
    			 <input type="text" id="dataSmaltimentoCarogna" name="dataSmaltimentoCarogna" maxlength="32" size="50" readonly="readonly" style="width:246px;" value=""/>
    		</td>
        </tr>
                
             
        <tr class='even'>
    		
        </tr>
                
             
        <tr class='odd'>
	        <td>
	    		Ditta Autorizzata
    		</td>
    		<td>
		        <input type="text" id="dittaAutorizzata" name="dittaAutorizzata" maxlength="255" size="50%" value="">
	        </td>
	        <td>
	        </td>
        </tr>
        
        <tr class='even'>
	        <td>
	    		DDT
    		</td>
    		<td>
		        <input type="text" id="ddt" name="ddt" maxlength="255" size="50%" value="">
	        </td>
	        <td>
	        </td>
        </tr>
        
        <tr class='odd'>
	        <td>
	    		 <font color="red">* </font> Campi obbligatori
    		</td>
    		<td>
	        </td>
	        <td>
	        </td>
        </tr>
      </table>
</form>


<script type="text/javascript">
$( "#dataSmaltimentoCarogna" ).datepicker(
		{
			 dateFormat: 'dd/mm/yy', 
			 showOn: "button",
			 buttonImage: "images/calendar.gif",
			 buttonImageOnly: true,
			 monthNames: ["Gennaio", "Febbraio", "Marzo", "Aprile", "Maggio", "Giugno", "Luglio", "Agosto", "Settembre", "Ottobre", "Novembre", "Dicembre"],
			 dayNamesMin: ["Dom","Lun","Mar","Mer","Gio","Ven","Sab"],
			 firstDay: 1
		}
		   );
$("#ui-datepicker-div").css("z-index",10000); 	
</script>
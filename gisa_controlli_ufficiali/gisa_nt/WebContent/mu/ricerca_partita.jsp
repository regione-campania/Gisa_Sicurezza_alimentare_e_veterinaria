<script>
function checkForm(form){
	var numero = form.numero.value;
	var mod4 = form.mod4.value;
	var message = '';
	var esito = true;
	if (numero.length < 5 && mod4.length < 3){
		message += 'Inserire almeno cinque caratteri nel campo NUMERO PARTITA o tre nel campo MOD 4.';
		esito = false;
	}
		if (esito==false)
			alert (message);
		return esito;
}
</script>

<table class="trails" cellspacing="0">
	<tr>
		<td>
			<a href="MacellazioneUnica.do?command=List&orgId=51251">Home macellazioni
		</td>
	</tr>
</table>

 <form name="ricercaPartita" id="ricercaPartita" action="MacellazioneUnica.do?command=CercaPartita" method="post" >
 
<input type="hidden" id="idMacello" name="idMacello" value="<%=request.getParameter("orgId")%>"/> 
<table class="details" layout="fixed" width="50%">
<col width="180px">
<th colspan="2">Ricerca partita</th> 
<tr><td class="formLabel">Stato partita</td> <td><input type="text" id="statoPartita" name="statoPartita"/></td></tr>
<tr><td class="formLabel">Numero partita</td> <td><input type="text" id="numero" name="numero"/></td></tr>
<tr><td class="formLabel">Numero mod. 4</td> <td><input type="text" id="mod4" name="mod4"/></td></tr>
</table>

<input type="button" value="CERCA" onClick="if (checkForm(this.form)){this.form.submit();}"/> 

</form>
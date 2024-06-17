<script src='javascript/modalWindow.js'></script>
<script src="javascript/jquery-1.8.2.js"></script>
<script src="javascript/jquery-ui.js"></script>
<link rel="stylesheet" type="text/css" href="css/modalWindow.css"></link>
<DIV ID='modalWindow' CLASS='unlocked'><P CLASS='wait'>Attendere il completamento dell'operazione...</P></DIV>

<jsp:useBean id="Capo" class="org.aspcfs.modules.macellazioniopu.base.Capo" scope="request" />

<script>
function checkForm(form){
	var msg="";
	
	if (form.note.value=='')
		alert("Note di cancellazione obbligatorie");
	else{
		loadModalWindow();
		form.submit();
	}
	}

</script>




<form id="cancellazione" name="cancellazione"
	action="MacellazioniOpu.do?command=CancellaCapo&auto-populate=true"
	method="post">

<table class="details" width="100%" cellpadding="4">
<tr><th colspan="2">Cancellazione</th></tr>

<tr>
<td>Matricola</td>
<td><%=Capo.getCd_matricola() %></td>
</tr>

<tr>
<td>Note cancellazione</td>
<td><textarea id="note" name="note" rows="5" cols="20"></textarea> <font color="red">*</font></td>
</tr>

<tr>
<td colspan="2"><input type="button" value="CONFERMA" onClick="checkForm(this.form)"/></td>
</tr>

</table>

<input type="hidden" id="idCapo" name="idCapo" value="<%=Capo.getId()%>"/> 
</form>




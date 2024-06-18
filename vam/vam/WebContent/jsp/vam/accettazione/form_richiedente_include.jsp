
<table class="tabella" style="width: 99%">
	<tr align="right">
		<td width="33%">Nome <font color="red">*</font><input value="${accettazione.richiedenteNome }" type="text" id="richiedenteNome" name="richiedenteNome" disabled="disabled" maxlength="64"> </td>
		<td width="33%">Cognome <font color="red">*</font><input value="${accettazione.richiedenteCognome }" type="text" id="richiedenteCognome" name="richiedenteCognome" disabled="disabled" maxlength="64"> </td>
		<td width="33%">Telefono <input value="${accettazione.richiedenteTelefono }" type="text" name="richiedenteTelefono" disabled="disabled" maxlength="16"> </td>
		<td width="33%">&nbsp;</td>
	</tr>
	<tr align="right">
		<td width="33%">Codice Fiscale <input value="${accettazione.richiedenteCodiceFiscale }" type="text" name="richiedenteCodiceFiscale" maxlength="16" disabled="disabled" maxlength="64"> </td>
		<td width="33%">Documento <input value="${accettazione.richiedenteDocumento }" type="text" name="richiedenteDocumento" disabled="disabled" maxlength="64"> </td>
		<td width="33%">Residenza <input value="${accettazione.richiedenteResidenza }" type="text" name="richiedenteResidenza" disabled="disabled" maxlength="64"> </td>
		<td width="33%">&nbsp;</td>
	</tr>
</table>

<script>
	function controllaInfo(){
		var ck = document.getElementById("richiedenteProprietario"); //ckbox coincide con il proprietario
		var e = document.getElementById("tipoRichiedente"); 		 //select tipi di proprietario
		var strUser = e.options[e.selectedIndex].value; 
		if(strUser==1){		//privato
			if (ck!=null){
				if(ck.checked==false){
					if (document.getElementById("richiedenteNome").value=="") return 1;
					if (document.getElementById("richiedenteCognome").value=="") return 1;
				}
				else return 0;
			}
			else {
				if (document.getElementById("richiedenteNome").value=="") return 1;
				if (document.getElementById("richiedenteCognome").value=="") return 1;
			}
		}
	}
</script>

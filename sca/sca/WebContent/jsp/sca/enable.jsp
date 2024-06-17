<jsp:useBean id="UserRecord" class="it.us.web.bean.guc.Utente" scope="request"/>

<div id="content" align="center">

	<div align="center">
		<a href="Home.us" style="margin: 0px 0px 0px 50px"><img src="images/lista.png" height="18px" width="18px" />Lista Utenti</a>
		<a href="guc.Detail.us?id=${UserRecord.id}" style="margin: 0px 0px 0px 50px"><img src="images/detail.gif" height="18px" width="18px" />Dettaglio Utente</a>
		<a href="guc.ToEdit.us?id=${UserRecord.id}" style="margin: 0px 0px 0px 50px"><img src="images/edit.gif" height="18px" width="18px" />Modifica Utente</a>
		<a href="guc.ToAdd.us" style="margin: 0px 0px 0px 50px"><img src="images/add.png" height="18px" width="18px" />Aggiungi Utente</a>
	</div>

	<h4 class="titolopagina">Attiva/Disattiva Utente</h4>
	
	<form name="enableUser" action="guc.Enable.us" method="post">
		
		<%if(UserRecord.isEnabled()){ %>
		<h4>Utente attualmente attivo. Premere "Invio" per confermare la disattivazione.</h4>
		<%}else{ %>
		<h4>Utente attualmente disattivo. Premere "Invio" per confermare la riattivazione.</h4>
		<%} %>
		<input type="hidden" name="id" value="${UserRecord.id}" ></input>
		<input type="submit" value="Invio">
	</form>
 	
</div>


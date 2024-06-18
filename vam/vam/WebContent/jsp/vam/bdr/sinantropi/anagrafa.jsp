<%@page import="it.us.web.util.vam.CaninaRemoteUtil"%>
<%@page import="it.us.web.bean.BUtente"%>
<%
	String sinantropo = (String)request.getAttribute("sinantropo");
	String sinantropoDesc = "";
	String action = "ToAdd";
	if(sinantropo.equals("sin"))
		sinantropoDesc = "Sinantropo";
	else if(sinantropo.equals("mar"))
	{
		sinantropoDesc = "Animale Marino";
		action = "ToAddMarini";
	}
	else if(sinantropo.equals("zoo"))
	{
		sinantropoDesc = "Animale dello Zoo/Circo";
		action = "ToAddZoo";
	}
%>

Inserimento Registrazioni <%=sinantropoDesc%>: <b>${param['identificativo']}</b>
<br/>
Operazioni da registrare: Iscrizione Anagrafe

<input type="button" value="Operazione Completata" onclick="javascript:attendere(),anagrafeCompletata();" />
<input type="button" value="Annulla" onclick="javascript:if(myConfirm('Sicuro di voler annullare l\'operazione?')){ annulla(); };" />

<br/>&nbsp;<br/>

<iframe 
	id="myFrame" name="myFrame"  frameborder="0"  vspace="0"  
	hspace="0" marginwidth="0" marginheight="0"
	width="95%"  scrolling=yes  height="900"
	style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; Z-INDEX: 999; BORDER-LEFT: black 1px solid; BORDER-BOTTOM: black 1px solid;"
	src="sinantropi.<%=action%>.us?interactiveMode=y&identificativo=${param['identificativo']}">
</iframe>

<script type="text/javascript">
function annulla()
{
	location.href='vam.accettazione.FindAnimale.us?identificativo=${param['identificativo'] }';
};

function anagrafeCompletata()
{
	location.href='vam.bdr.sinantropi.AnagrafeCompletata.us?identificativo=${param['identificativo'] }';
};
</script>

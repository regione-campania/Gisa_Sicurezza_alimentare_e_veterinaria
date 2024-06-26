<%@page import="org.aspcfs.modules.macellazioninewsintesis.utils.ConfigTipo"%>
<%@page import="org.aspcfs.modules.macellazioninewsintesis.base.Partita"%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv"%>
<%@page import="org.aspcfs.modules.util.imports.ApplicationProperties"%>
<jsp:useBean id="OrgDetails" class="org.aspcfs.modules.sintesis.base.SintesisStabilimento" scope="request" />
<jsp:useBean id="Partita" class="org.aspcfs.modules.macellazioninewsintesis.base.Partita" scope="request" />
<jsp:useBean id="partite" class="java.util.ArrayList" scope="request" />
<!-- RELATIVO AL NUOVO CALENDARIO CON MESE E ANNO FACILMENTE MODIFICABILI -->
<SCRIPT LANGUAGE="JavaScript" SRC="javascript/CalendarPopup.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="javascript/common.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">document.write(getCalendarStyles());</SCRIPT>
<SCRIPT LANGUAGE="JavaScript" ID="js19">
var cal19 = new CalendarPopup();
cal19.showYearNavigation();
cal19.showYearNavigationInput();
cal19.showNavigationDropdowns();
</SCRIPT>
<script type="text/javascript">

function gestisciCampoDataMacellazione(){
	var select = document.getElementById('comboDateMacellazione'); //Recupero la SELECT

	 var NewOpt = document.createElement('option');
	 NewOpt.value=document.getElementById('campoDataMacellazione').value;
	 NewOpt.text=document.getElementById('campoDataMacellazione').value;
	 NewOpt.selected = true;
	 try{
	 select.add(NewOpt, null); //Metodo Standard, non funziona con IE
	 }
	 catch(e){
		 select.add(NewOpt); 
	 }
	//document.getElementById('campoDataMacellazione').disabled = true;
	 
	//document.getElementById('campoDataMacellazione').style.display = "";
	//document.getElementById('comboDateMacellazione').disabled = true;
	//document.getElementById('comboDateMacellazione').style.display = "none";
}
		
</script>
<!-- ******************************************************************** -->

	<head>
		<link rel="stylesheet" type="text/css" href="css/jmesa.css"></link>
		
		<script type="text/javascript" src="javascript/jquery.bgiframe.pack.js"></script>
		<script type="text/javascript" src="javascript/jquery.jmesa.js"></script>
		<script type="text/javascript" src="javascript/jmesa.js"></script>
		
	</head>

<table class="trails" cellspacing="0">
	<tr>
		<td>
			<%
				if (request.getParameter("return") == null)
				{
			%>
				
					<a href="StabilimentoSintesisAction.do?command=DettaglioStabilimento&altId=<%=OrgDetails.getAltId() %>">Scheda Stabilimento</a> >
			<%
				}
				else if (request.getParameter("return").equals("dashboard"))
				{}
			%>
			<a href="MacellazioniNewSintesis.do?command=List&altId=<%=OrgDetails.getAltId()%>">Macellazioni</a> > Lista Sedute della partita <%=Partita.getCd_partita() %>
		</td>
	</tr>
</table>
<%
ConfigTipo configTipo = (ConfigTipo)request.getSession().getAttribute("configTipo");
%>


<%@page import="org.aspcfs.modules.util.imports.ApplicationProperties"%>
<%@page import="java.util.ArrayList"%>
<%@ include file="../utils23/initPage.jsp"%>

<%
	String param1 = "altId=" + OrgDetails.getAltId()+"&stabId=" + OrgDetails.getIdStabilimento(); request.setAttribute("Operatore",OrgDetails.getOperatore());
%>
<dhv:container 
	name="sintesismacelli"
	selected="macellazioni" 
	object="Operatore"  
	param="<%=param1 %>" 
	appendToUrl='<%= addLinkParams(request, "popup|popupType|actionId") %>' 
	>

<dhv:permission name="stabilimenti-stabilimenti-macellazioni-view">
	<a href="MacellazioniDocumentiNewSintesis.do?command=ToRegistroMacellazioni&<%=param1 %>"><input type="button" value="Registro Macellazioni"/></a>
</dhv:permission>

<dhv:permission name="stabilimenti-stabilimenti-macellazioni-view">
	<!-- a href="MacellazioniDocumentiNewSintesis.do?command=ToMod10&<%=param1 %>"><input type="button" value="Modello 10"/></a -->
</dhv:permission>

<%if(ApplicationProperties.getProperty("visibilita_link_macelli").equals("si")){ %>
<dhv:permission name="stabilimenti-stabilimenti-macellazioni-view">
	<a href="MacellazioniDocumentiNewSintesis.do?command=ToMortiStalla&<%=param1 %>">Anim. morti in stalla/trasporto</a>
</dhv:permission>



<dhv:permission name="stabilimenti-stabilimenti-macellazioni-view">
	<a href="MacellazioniDocumentiNewSintesis.do?command=ToBSE&<%=param1 %>">Modulo BSE</a>
</dhv:permission>



<dhv:permission name="stabilimenti-stabilimenti-macellazioni-view">
	<a href="MacellazioniDocumentiNewSintesis.do?command=ToAbbattimento&<%=param1 %>">Abbattimento</a>
</dhv:permission>


<br/><br/>


<dhv:permission name="stabilimenti-stabilimenti-macellazioni-view">
	<a href="MacellazioniNewSintesis.do?command=PrintBRCRilevazioneMacelli&file=BRC_rilevazione_macelli.xml&<%=param1 %>">BRC rilevazione macelli</a>
</dhv:permission>

<dhv:permission name="stabilimenti-stabilimenti-macellazioni-view">
	<a href="MacellazioniNewSintesis.do?command=PrintTBCRilevazioneMacelli&file=TBC_rilevazione_macelli.xml&<%=param1 %>">TBC rilevazione macelli</a>
</dhv:permission>

<dhv:permission name="stabilimenti-stabilimenti-macellazioni-view">
	<a href="MacellazioniNewSintesis.do?command=ToModelloIdatidosi&<%=param1 %>">Modello idatidosi</a>
</dhv:permission>

<dhv:permission name="stabilimenti-stabilimenti-macellazioni-view">
	<a href="MacellazioniNewSintesis.do?command=PrintModelloMarchi&file=modello_marchi.xml&<%=param1 %>">Modello marchi</a>
</dhv:permission>

<dhv:permission name="stabilimenti-stabilimenti-macellazioni-view">
	<a href="MacellazioniNewSintesis.do?command=PrintMacellazioneAnimaliInfetti&file=macellazione_animali_infetti.xml&<%=param1 %>">Macellazione animali infetti</a>
</dhv:permission>

<dhv:permission name="stabilimenti-stabilimenti-macellazioni-view">
	<a href="MacellazioniNewSintesis.do?command=PrintDisinfezioneMezziTrasporto&file=disinfezione_mezzi_di_trasporto.xml&<%=param1 %>">Disinfezione mezzi di trasporto</a>
</dhv:permission>
<%} %>


&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red"><br/><%=toHtmlValue( (String)request.getAttribute( "messaggio" ) ) %></font>

 
<br/>
<%
	if(!partite.isEmpty())
	{
		String specie1 = "Ovini";
		String specie2 = "Caprini";
		if (Partita.isSpecie_suina()){ 
			specie1="Cinghiali";
			specie2 = "Suini";
		}
%>
		Lista sedute macellazioni partita <%=Partita.getCd_partita() %><br/>
		
		Numero capi <%=specie1 %> partita: <%=Partita.getCd_num_capi_ovini() %><br/>
		
		Numero capi <%=specie2 %> partita: <%=Partita.getCd_num_capi_caprini() %>
		
		<form name="macellazioniForm" method="post" action="MacellazioniNewSintesis.do?command=List">
			<input type="hidden" name="altId" value="<%=OrgDetails.getAltId() %>" />
	       <%=request.getAttribute( "tabella" )%>
	    </form>
<%
	}
	else
	{
		out.println("Nessuna seduta di macellazione aggiunta alla partita " + Partita.getCd_partita());
	}
%>	 
	    
	 <script type="text/javascript">
            function onInvokeAction(id) {
                $.jmesa.setExportToLimit(id, '');
                $.jmesa.createHiddenInputFieldsForLimitAndSubmit(id);
            }
            function onInvokeExportAction(id) {
                var parameterString = $.jmesa.createParameterStringForLimit(id);
                alert(parameterString);
                //location.href = 'MacellazioniNewSintesis.do?command=List&' + parameterString;
            }
    </script>
 
</dhv:container>
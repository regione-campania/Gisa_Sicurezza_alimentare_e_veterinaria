
<%-- <jsp:useBean id="TipoImpresaList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="TipoSocietaList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="TipoAttivita" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="TipoCarattere" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="TipoMobili" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="NazioniList" class="org.aspcfs.utils.web.LookupList" scope="request" /> --%>

<%-- <jsp:useBean id="ToponimiList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="newStabilimento" class="org.aspcfs.modules.suap.base.Stabilimento" scope="request" />
<jsp:useBean id="fissa" class="java.lang.String" scope="request" />
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session" /> --%>

<link rel="stylesheet" href="css/jquery-ui.css" />
<link rel="stylesheet" href="css/opu.css" />
<link rel="stylesheet" type="text/css" href="css/jquery.calendars.picker.css">
<link href="javascript/datepicker/jquery.datepick.css" rel="stylesheet">
<!-- <script src="javascript/suap.jquery.steps.js"></script> -->
 
<script type="text/javascript" src="javascript/jquery.calendars.js"></script>
<script type="text/javascript" src="javascript/jquery.calendars.plus.js"></script>
<script type="text/javascript" src="javascript/jquery.plugin.js"></script>
<script type="text/javascript" src="javascript/jquery.calendars.picker.js"></script>
<script src="javascript/parsedate.js"></script>
<script src="javascript/jquery-ui.js"></script>
<SCRIPT src="javascript/opu.js"></SCRIPT>
<SCRIPT src="javascript/upload.js"></SCRIPT>
<!-- SCRIPT src="javascript/suapCittadinoUtil.js"></SCRIPT> -->
<script src="javascript/gestoreCodiceFiscale.js"></script>
<script src ="javascript/aggiuntaCampiEstesiScia.js"></script>
<!-- <script language="JavaScript" TYPE="text/javascript" SRC="gestione_documenti/generazioneDocumentale.js"></script> -->
<script src="javascript/jquery.form.js"></script>
<script type="text/javascript" src="dwr/interface/SuapDwr.js"> </script>
<script type="text/javascript" src="dwr/engine.js"> </script>
<script type="text/javascript" src="dwr/util.js"></script>
<script src="javascript/datepicker/jquery.plugin.js"></script>
<script src="javascript/datepicker/jquery.datepick.js"></script>


<SCRIPT LANGUAGE="JavaScript" SRC="javascript/CalendarPopup.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="javascript/common.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">document.write(getCalendarStyles());</SCRIPT>
<SCRIPT LANGUAGE="JavaScript" ID="js19">
	var cal99 = new CalendarPopup();
	cal99.showYearNavigation();
	cal99.showYearNavigationInput();
	cal99.showNavigationDropdowns();
</SCRIPT> 



<%@ include file="../utils23/initPage.jsp" %>

<%@page import="org.aspcfs.modules.opu.base.*" %>
<jsp:useBean id="linee" scope="request" class="org.aspcfs.modules.opu.base.LineaProduttivaList" />
<jsp:useBean id="fallBackUrl" scope="request" class="java.lang.String" />
<jsp:useBean id="idStab" scope="request" class="java.lang.String" />
 <table class="trails" cellspacing="0">
	<tr>
	<td width="100%">
	<a href=""><dhv:label name="">Anagrafica stabilimenti</dhv:label></a> >
	<a href="OpuStab.do?command=SearchForm"><dhv:label name="">Ricerca</dhv:label></a> >
	<a href="RicercaUnica.do?command=Search"><dhv:label name="">Risultato ricerca</dhv:label></a> >
	<a href="<%=fallBackUrl %>"><dhv:label name="">Scheda Anagrafica Impresa</dhv:label></a> >
	
	Dati Anagrafici Aggiuntivi
	</td>
	</tr>
</table>
<div style="display: none;"> 
            &nbsp;&nbsp;<img id="calImg" src="images/cal.gif" alt="Popup" class="trigger"> 
        </div>

<%
	if(linee.size() == 0 )
	{
	%>
		<script>
			alert("non risultano esserci linee per lo stabilimento selezionato");
			document.location.href = '<%=fallBackUrl %>';
		</script>
	
   <%} 
	else { %>
		 
		
		<%
		out.print("<table width=\"100%\" class=\"details\"><tr><th>Linea d'attivita'</th><th>&nbsp;</th></tr>");
		for(Object lineaO : linee)
		{
			LineaProduttiva linea = (LineaProduttiva) lineaO;
			/*out.print( "window.linee['"+linea.getId()+"']={ 'idLineaML' : '"+linea.getIdRelazioneAttivita()+"', 'idStabRelLpOpu' : '"+linea.getId_rel_stab_lp()+"' };"	
					);*/
			%>
			
			<tr  >
				
					<td style="width:50%" class="td_to_click" id="td_to_click-<%=linea.getId_rel_stab_lp() %>">
						<%=linea.getDescrizione_linea_attivita() %>
					</td>
					<td style="width: 1%; display: none;"   class="td_to_expand" id="td-<%=linea.getId_rel_stab_lp() %>" >
						<form  id="form-<%=linea.getId_rel_stab_lp() %>">
							<table id="table_campi-<%=linea.getId_rel_stab_lp()%>"></table>
							<input type="hidden" name="idRelStabLp" value="<%=linea.getId_rel_stab_lp() %>" />
						</form>
					</td>
				
			</tr>
			
			<%
		} 
		
		//aggiungiCampiEstesiDaOpu
		out.print("</table>");
		%>
		
	<%} %>
	
	
 
 <script>
 
 	/*action="Opustab.do?command=AggiornaCampiEstesiDiAnagrafica"*/
 	function salvaCampiAnagPerLinea(evt)
 	{
 		var idRelStabLp = evt.data.idstabrellp;
 		var form = document.forms['form-'+idRelStabLp];
 		var formjq = $(form);
 		 
 		
 		if(formjq.find("input:invalid").length > 0)
 		{ /*ho almeno un campo non valido */
 			alert("Attenzione ! Uno o piu' valori incongruenti");
 			return;
 		}
 		 
 		$.ajax(
 		{
 			method : 'post'
 			,dataType : 'json'
 			,url : "OpuStab.do?command=AggiornaCampiEstesiDiAnagrafica"
 			,data : formjq.serialize()
 			,success : function(data){
 				var risp = data.risultato.toUpperCase();
 				if(risp == 'OK')
 				{
 					alert("Dati salvati correttamente");
 				}
 				else
 				{
 					alert("Qualcosa e' andato storto");
 				}
 			}
 			,error : function(data){
 				
 				alert("Qualcosa e' andato storto nell'interrogazione del server");
				document.location.href = '<%=fallBackUrl %>';
 				
 			}
 		});
 		 
 	}
 	
 	$(function(){
 		
 		
 		$("td.td_to_click").css("cursor","pointer").on("click",function(evt){
 			/*collpase tutti gli altri */
 			$("td.td_to_expand").css("display","none");
 			
 			var idRelStabLp = $(this).attr("id").split("-")[1];
 			$("td.td_to_expand#td-"+idRelStabLp).css("display","").css("background-color","rgba(0,100,255,0.2)").css("width","50%");
 			var tableCampi = $("td.td_to_expand#td-"+idRelStabLp+" #table_campi-"+idRelStabLp);
 			tableCampi.html($("<tr></tr>"));
 			
 			var callback = {callback_terminazione : function(){ /*la callback aggiunge in fondo alla tabella il bottone di submit */
 				 tableCampi.find("tr:last").after($("<tr></tr>").html($("<td></td>",{colspan : "2", align : "left"}).html($("<input></input>",{type : 'button'}).on("click",{idstabrellp : idRelStabLp},salvaCampiAnagPerLinea).val("Salva"))));
 			}};
 			
 			aggiungiCampiEstesiDaOpuDiTipoScelto(idRelStabLp,tableCampi.attr("id"),callback,'anagrafici');
 			tableCampi.css("width","100%");
 			
 		});
 		
 		/*controllo che esista almeno un campo esteso di tipo anag (e da opu) per almeno una delle linee selezionate */
 		var callback_obj2 = {
 			callback : function(data)
 			{
 				if(data.length == 0 || data.ordine.length == 0 || JSON.parse(data.ordine) == 0)
				{
 					console.log("non esistono campi estesi di tipo anagrafico (da opu) per lo stabilimento");
 					alert("Non ci sono campi aggiuntivi anagrafici per lo stabilimento selezionato");
 					document.location.href = '<%=fallBackUrl %>';
				}
 			}
 		};
 		
 		verificaEsistenzaCampiEstesiDaOpuDiTipoScelto('<%=idStab %>',callback_obj2,'anagrafici');
 		
 		
 		
 		
 	});
 </script>

 




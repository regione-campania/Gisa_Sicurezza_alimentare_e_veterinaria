<%@page import="org.aspcfs.modules.mycfs.actions.MatriciPiani"%>
<%@page import="org.aspcfs.modules.campioni.actions.Campioni"%>
<%@page import="org.aspcfs.modules.macellazioninewsintesis.base.Campione"%>
<%@ include file="../utils23/initPage.jsp"%>

<%@page import="org.aspcfs.utils.DateUtils"%>
<jsp:useBean id="Campioni"			class="java.util.ArrayList"									scope="request" />
<jsp:useBean id="Partita"				class="org.aspcfs.modules.macellazioninewsintesis.base.Partita"			scope="session" />
<jsp:useBean id="Campione"			class="org.aspcfs.modules.macellazioninewsintesis.base.Campione"		scope="request" />
<jsp:useBean id="Matrici"			class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="Tampone"			class="org.aspcfs.modules.macellazioninewsintesis.base.Tampone"		scope="request" />
<jsp:useBean id="MatriciTamponi"	class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="AnalisiTamponi"	class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="Nazioni"			class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="Regioni"			class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="Razze"				class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="Specie"			class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="PianiRisanamento"	class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="TipiMacellazione"	class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="EsitiVpm"			class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="BseList"			class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="Patologie"			class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="TipiEsame"			class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="Azioni"			class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="Gravita"			class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="Stadi"				class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="Organi"			class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="TipiAnalisi"		class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="Molecole"			class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="NonConformita"		class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="Veterinari"		class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="EsitiCampioni"		class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="MotiviCampioni"	class="org.aspcfs.utils.web.LookupList" scope="request" />

<jsp:useBean id="MolecolePNR"           class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="MolecoleBatteriologico"           class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="MolecoleParassitologico"           class="org.aspcfs.utils.web.LookupList" scope="request" />

<script type="text/javascript">
/* VECCHIA VERSIONE: nascondeva i DIV. Non va bene perch� i parametri partono comunque pi� volte
function switchMolecole( option, index )
{
	var i = option.value;
	document.getElementById( 'cmp_molecole_pnr_' + index ).style.display = ( i == 1) ? ('block') : ('none');
	document.getElementById( 'cmp_molecole_batteriologico_' + index ).style.display = ( i == 2 ) ? ('block') : ('none');
	document.getElementById( 'cmp_molecole_parassitologico_' + index ).style.display = ( i == 3 ) ? ('block') : ('none');
	document.getElementById( 'cmp_molecole_altro_' + index ).style.display = ( i == 4 ) ? ('block') : ('none');
	document.getElementById( 'cmp_molecole_listavuota_' + index ).style.display = ( i == -1 ) ? ('block') : ('none');
};
*/

//Nuova versione: cambia l'innerHTML di un div con la giusta select
function switchMolecole( option, index )
{
	i = ( option.value < 0 ) ? ( 0 ) : ( option.value );
	var selects = new Array(5);
	
	var hidden_molecola = '<input type="hidden" name="cmp_molecole_' + index + '" value="-1" />';
	var hidden_nota = '<input type="hidden" name="cmp_note_' + index + '" value="" />';
	
	selects[0] = '<select name="cmp_molecole_' + index + '"><option value="-1">-- Seleziona --</option></select>' + hidden_nota;
	selects[1] = "<%=MolecolePNR.getHtmlSelect("placeHolder", "-1") %>" + hidden_nota;
	selects[2] = "<%=MolecoleBatteriologico.getHtmlSelect("placeHolder", "-1") %>" + hidden_nota;
	selects[3] = "<%=MolecoleParassitologico.getHtmlSelect("placeHolder", "-1") %>" + hidden_nota;
	selects[4] = '<textarea rows="2" cols="40" name="cmp_note_' + index + '"></textarea>' + hidden_molecola;
	selects[5] = '<textarea rows="2" cols="40" name="cmp_note_' + index + '"></textarea>' + hidden_molecola;

	document.getElementById( 'cmp_molecole_div_' + index ).innerHTML = selects[i].replace( /placeHolder/g, 'cmp_molecole_' + index );
};
</script>
<table class="details" width="100%" border="0" cellpadding="5" cellspacing="0">
    			<tr>
    				<th colspan="6">Campioni</th>
    			</tr>
    			<tr>
    				<th>Motivo</th> <th>Matrice</th> <th>Tipo Analisi</th> <th>Molecole/Agente Etiologico</th>  <th>Esito</th> <th>Data Ricezione Esito</th>
    			</tr>
    			
    	<%	for( int index = 1; index <= 5; index++ )
    		{ 
    			Campione campione = (Campioni.size() >= index) ? ((Campione)Campioni.get( index -1 )) : (new Campione());
    	%>
    			
    			<tr class="containerBody">
    				<td>
    						<%=MotiviCampioni.getHtmlSelect( "cmp_id_motivo_" + index, campione.getId_motivo() )%>
                	</td>
                	
    				<td>
    					<input type="hidden" name="cmp_identifier_<%=index %>" value="<%=campione.getId() %>" />
    					<%=Matrici.getHtmlSelect( "cmp_matrice_" + index, campione.getMatrice() ) %>
    				</td>
          
    				<td>
    					<%TipiAnalisi.setJsEvent( "onchange=\"switchMolecole( this, " + index + ")\"" ); %>
    					<%=TipiAnalisi.getHtmlSelect( "cmp_tipo_" + index, campione.getId_tipo_analisi() ) %>
    				</td>
    				<td >
	    				<div id="cmp_molecole_div_<%=index %>" style="display: block;" >
	    				
	    				<%
	    					switch ( campione.getId_tipo_analisi() )
	    					{
	    					case 1:
	    				%>
	    					<%=MolecolePNR.getHtmlSelect( "cmp_molecole_" + index, campione.getId_molecole() ) %>
	    					<input style="width: 50p" type="hidden" name="cmp_note_<%=index %>" value="<%=toHtmlValue( campione.getNote() ) %>" />
	    				<%
	    						break;
	    					case 2:
	    				%>
	    					<%=MolecoleBatteriologico.getHtmlSelect( "cmp_molecole_" + index, campione.getId_molecole() ) %>
	    					<input "width: 50p" type="hidden" name="cmp_note_<%=index %>" value="<%=toHtmlValue( campione.getNote() ) %>" />
	    				<%
	    						break;
	    					case 3:
	    				%>
	    					<%=MolecoleParassitologico.getHtmlSelect( "cmp_molecole_" + index, campione.getId_molecole() ) %>
	    					<input type="hidden" name="cmp_note_<%=index %>" value="<%=toHtmlValue( campione.getNote() ) %>" />
	    				<%
	    						break;
	    					case 4:
	    					case 5:
	    				%>
	    					<textarea rows="2" cols="40" name="cmp_note_<%=index %>"><%=toHtmlValue( campione.getNote() ) %></textarea>
	    					<input type="hidden" name="cmp_molecole_<%=index %>" value="-1" />
	    				<%
	    						break;
	    					default:
	    				%>
	    					<select name="cmp_molecole_<%=index %>">
	    						<option value="-1">-- Seleziona --</option>
	    					</select>
	    					<input type="hidden" name="cmp_note_<%=index %>" value="" />
	    				<%
	    						break;
	    					}
	    				%>
	    					
	    					
	    				</div>
    				</td>
    				
                	<td>
                			<%=EsitiCampioni.getHtmlSelect( "cmp_id_esito_" + index, campione.getId_esito() )%>
    				</td>
    				
    				<td>
<%--    					<%
    						switch (index) {
    							case 1 : %> <zeroio:dateSelect field="cmp_data_ricezione_esito_1" form="main" showTimeZone="false" timestamp="<%=campione.getData_ricezione_esito() %>" />  <% break;
    							case 2 : %> <zeroio:dateSelect field="cmp_data_ricezione_esito_2" form="main" showTimeZone="false" timestamp="<%=campione.getData_ricezione_esito() %>" />  <% break;
    							case 3 : %> <zeroio:dateSelect field="cmp_data_ricezione_esito_3" form="main" showTimeZone="false" timestamp="<%=campione.getData_ricezione_esito() %>" />  <% break;
    							case 4 : %> <zeroio:dateSelect field="cmp_data_ricezione_esito_4" form="main" showTimeZone="false" timestamp="<%=campione.getData_ricezione_esito() %>" />  <% break;
    							case 5 : %> <zeroio:dateSelect field="cmp_data_ricezione_esito_5" form="main" showTimeZone="false" timestamp="<%=campione.getData_ricezione_esito() %>" />  <% break;
    						}
    					%>
 --%>
 						<%
	 						switch (index) {
		 	    				case 1 : %> <input type="text" id="cmp_data_ricezione_esito_1" name="cmp_data_ricezione_esito_1" size="10" value="<%=DateUtils.timestamp2string(campione.getData_ricezione_esito())%>" class="date_picker"/>&nbsp;  
		 									<a href="#" style="cursor: pointer;" onclick="svuotaData(document.forms[0].cmp_data_ricezione_esito_1);"><img src="images/delete.gif" align="absmiddle"/></a>
		 									<% break;
		 	    				case 2 : %> <input type="text" id="cmp_data_ricezione_esito_2" name="cmp_data_ricezione_esito_2" size="10" value="<%=DateUtils.timestamp2string(campione.getData_ricezione_esito())%>" class="date_picker"/>&nbsp;  
		 									<a href="#" style="cursor: pointer;" onclick="svuotaData(document.forms[0].cmp_data_ricezione_esito_2);"><img src="images/delete.gif" align="absmiddle"/></a>
		 									<% break;
		 	    				case 3 : %> <input type="text" id="cmp_data_ricezione_esito_3" name="cmp_data_ricezione_esito_3" size="10" value="<%=DateUtils.timestamp2string(campione.getData_ricezione_esito())%>" class="date_picker"/>&nbsp;  
		 									<a href="#" style="cursor: pointer;" onclick="svuotaData(document.forms[0].cmp_data_ricezione_esito_3);"><img src="images/delete.gif" align="absmiddle"/></a>
		 									<% break;
		 	    				case 4 : %> <input type="text" id="cmp_data_ricezione_esito_4" name="cmp_data_ricezione_esito_4" size="10" value="<%=DateUtils.timestamp2string(campione.getData_ricezione_esito())%>" class="date_picker"/>&nbsp;  
		 									<a href="#" style="cursor: pointer;" onclick="svuotaData(document.forms[0].cmp_data_ricezione_esito_4);"><img src="images/delete.gif" align="absmiddle"/></a>
		 									<% break;
		 	    				case 5 : %> <input type="text" id="cmp_data_ricezione_esito_5" name="cmp_data_ricezione_esito_5" size="10" value="<%=DateUtils.timestamp2string(campione.getData_ricezione_esito())%>" class="date_picker"/>&nbsp;  
		 									<a href="#" style="cursor: pointer;" onclick="svuotaData(document.forms[0].cmp_data_ricezione_esito_5);"><img src="images/delete.gif" align="absmiddle"/></a>
		 									<% break;
	 						}
 						%>
 						
 	                	
                	</td>
    				
    				
    			</tr>
    			
    		<%} %>
    			
</table>

<script type="text/javascript">

$( document ).ready( function(){
	calenda('cmp_data_ricezione_esito_1','','');
	calenda('cmp_data_ricezione_esito_2','','');
	calenda('cmp_data_ricezione_esito_3','','');
	calenda('cmp_data_ricezione_esito_4','','');
	calenda('cmp_data_ricezione_esito_5','','');
});

</script>

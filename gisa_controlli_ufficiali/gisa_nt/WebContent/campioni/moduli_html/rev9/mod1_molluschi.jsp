
<%int z = 0; %>
<!-- INIT DOCUMENTALE -->
	<%@ include file="/gestione_documenti/initDocumentale.jsp" %>
<!-- FINE INIT DOCUMENTALE -->

<!-- INIZIO HEADER -->
	<%@ include file="/campioni/moduli_html/rev9/header.jsp" %>
<!-- FINE HEADER -->

<div class="boxOrigineDocumento"><%@ include file="../../../utils23/hostName.jsp" %></div>

<table><tr>
<TD>
<div id="idbutn" style="display:block;">
<%-- <input type="button" class = "buttonClass" value ="Salva in modalit� definitiva" onclick="this.form.bozza.value='false';javascript:checkSubmit();"/>
--%>
</div>


<input id="stampaId" type="button" class = "buttonClass"  style="display:none" value ="Stampa" onClick="window.print();"/>
<input type="hidden" id = "bozza" name = "bozza" value="">

<dhv:permission name="server_documentale-view">
<%if (definitivoDocumentale!=null && definitivoDocumentale.equals("true")){ %>
<!--  BOX DOCUMENTALE -->
	  <jsp:include page="../../../gestione_documenti/boxDocumentale.jsp">
    <jsp:param name="orgId" value="<%=request.getParameter("orgId") %>" />
     <jsp:param name="ticketId" value="<%=request.getParameter("ticketId") %>" />
      <jsp:param name="tipo" value="<%=request.getParameter("tipo") %>" />
       <jsp:param name="idCU" value="<%=request.getParameter("idCU") %>" />
        <jsp:param name="url" value="<%=request.getParameter("url") %>" />
</jsp:include>
<!--  BOX DOCUMENTALE -->
<% } else {%>
<form method="post" name="form2" action="PrintModulesHTML.do?command=ViewModules">
<input id="stampaPdfId" type="button" class = "buttonClass" value ="Genera e Stampa PDF" onclick="if (confirm ('Nella prossima schermata sar� possibile recuperare l\'ultimo PDF generato a partire dal documento a schermo, \n oppure generarne uno nuovo.')){javascript:salva(this.form)}"/>
<input type="hidden" id="documentale" name ="documentale" value="ok"></input>
<input type="hidden" id="listavalori" name ="listavalori" value=""></input>
 <input type="hidden" id ="orgId" name ="orgId" value="<%=request.getParameter("orgId") %>" />
  <input type="hidden" id ="ticketId" name ="ticketId" value="<%=request.getParameter("ticketId") %>" />
   <input type="hidden" id ="tipo" name ="tipo" value="<%=request.getParameter("tipo") %>" />
    <input type="hidden" id ="idCU" name ="idCU" value="<%=request.getParameter("idCU") %>" />
      <input type="hidden" id ="url" name ="url" value="<%=request.getParameter("url") %>" />
</form>
<% } %>
</dhv:permission>
<%-- onclick="this.form.bozza.value='false';" --%>
</TD>
</TABLE>
<P class="main">L'anno <label class="layout"><%= fixValore(OrgOperatore.getAnnoReferto())%></label> 
add� <label class="layout"><%=fixValore(OrgOperatore.getGiornoReferto()) %></label>
del mese di <label class="layout"><%= fixValore(OrgOperatore.getMeseReferto().toUpperCase())%></label> 
alle ore 
<label class="layout"><%= fixValoreShort(Modulo.getListaCampiModulo().get("ora_controllo").get("ora_controllo"))%> </label>
i sottoscritti: <br/>

<% if (OrgOperatore.getComponente_nucleo()!=null) {%> <label class="layout"><%= fixValore(OrgOperatore.getComponente_nucleo()) %></label> <%} %> 
<% if (OrgOperatore.getComponente_nucleo_due()!=null) {%> <label class="layout"><%= fixValore(OrgOperatore.getComponente_nucleo_due()) %></label> <%} %> 
<% if (OrgOperatore.getComponente_nucleo_tre()!=null) {%> <label class="layout"><%= fixValore(OrgOperatore.getComponente_nucleo_tre()) %></label> <%} %> 
<% if (OrgOperatore.getComponente_nucleo_quattro()!=null) {%> <label class="layout"><%= fixValore(OrgOperatore.getComponente_nucleo_quattro()) %></label> <%} %> 
<% if (OrgOperatore.getComponente_nucleo_cinque()!=null) {%> <label class="layout"><%= fixValore(OrgOperatore.getComponente_nucleo_cinque()) %></label> <%} %> 
<% if (OrgOperatore.getComponente_nucleo_sei()!=null) {%> <label class="layout"><%= fixValore(OrgOperatore.getComponente_nucleo_sei()) %></label> <%} %> 
<% if (OrgOperatore.getComponente_nucleo_sette()!=null) {%> <label class="layout"><%= fixValore(OrgOperatore.getComponente_nucleo_sette()) %></label> <%} %> 
<% if (OrgOperatore.getComponente_nucleo_otto()!=null) {%> <label class="layout"><%= fixValore(OrgOperatore.getComponente_nucleo_otto()) %></label> <%} %> 
<% if (OrgOperatore.getComponente_nucleo_nove()!=null) {%> <label class="layout"><%= fixValore(OrgOperatore.getComponente_nucleo_nove()) %></label> <%} %> 
<% if (OrgOperatore.getComponente_nucleo_dieci()!=null) {%> <label class="layout"><%= fixValore(OrgOperatore.getComponente_nucleo_dieci()) %></label> <%} %> 

<br/>

si sono recati nell'area di produzione sede di: <br/>
<% if(OrgOperatore.isChecked(1)) { %>
   <span class="checkedItem"> &nbsp;banco naturale</span>
<% } else { %>
  <span class="NocheckedItem"> &nbsp;banco naturale</span>
<% } %> 
<% if(OrgOperatore.isChecked(2)) { %>
   <span class="checkedItem"> &nbsp;impianto molluschicoltura</span> 
<% } else { %>
  <span class="NocheckedItem"> &nbsp;impianto molluschicoltura</span>
<% } %>
<% if(OrgOperatore.isChecked(3)) { %>
   <span class="checkedItem"> &nbsp;zona di stabulazione</span>
<% } else { %>
  <span class="NocheckedItem"> &nbsp;zona di stabulazione</span>
<% } %>
<% if(OrgOperatore.isChecked(5)) { %>
   <span class="checkedItem"> &nbsp;specchio acqueo da classificare</span>
<% } else { %>
  <span class="NocheckedItem"> &nbsp;specchio acqueo da classificare</span>
<% } %>
<% if(OrgOperatore.isChecked(5)) { %>
   <span class="checkedItem"> &nbsp;impianto abusivo</span>
<% } else { %>
  <span class="NocheckedItem"> &nbsp;impianto abusivo</span>
<% } %> <br/>

classificato come classe 
<label class="layout"><%= fixValore(OrgOperatore.getClasse())%></label> 
per la produzione di <br/>
<label class="layout"><%=fixValore(OrgOperatore.getSpecieMolluschi())%></label> <br/>

sita nel Comune di <label class="layout"><%= fixValore(OrgOperatore.getComune())%></label> 
localit� <label class="layout"><%= fixValore(OrgOperatore.getRagione_sociale())%></label> codice univoco nazionale (CUN) <label class="layout"><%= fixValore(OrgOperatore.getCun())%></label>.<br><br/>
 
<U><b>Presente all'ispezione: </b></U> <br/>
 sig. 
<label class="layout"><%= fixValore(Modulo.getListaCampiModulo().get("nome_presente_ispezione").get("nome_presente_ispezione"))%> </label>
 nato a 
<label class="layout"><%= fixValore(Modulo.getListaCampiModulo().get("luogo_nascita_presente_ispezione").get("luogo_nascita_presente_ispezione"))%> </label>
 il
 <label class="layout"><%= fixValore(Modulo.getListaCampiModulo().get("data_nascita_presente_ispezione").get("data_nascita_presente_ispezione"))%> </label> 
 e residente in 
 <label class="layout"><%= fixValore(Modulo.getListaCampiModulo().get("comune_residenza_presente_ispezione").get("comune_residenza_presente_ispezione"))%> </label>
 alla via 
  <label class="layout"><%= fixValore(Modulo.getListaCampiModulo().get("indirizzo_residenza_presente_ispezione").get("indirizzo_residenza_presente_ispezione"))%> </label>
n� 
 <label class="layout"><%= fixValoreShort(Modulo.getListaCampiModulo().get("num_indirizzo_residenza_presente_ispezione").get("num_indirizzo_residenza_presente_ispezione"))%> </label> 
doc.ident. 
 <label class="layout"><%= fixValore(Modulo.getListaCampiModulo().get("doc_ident_presente_ispezione").get("doc_ident_presente_ispezione"))%> </label><br/>
 
si � proceduto con l'ausilio di</span>  <label class="layout"><%= fixValore(Modulo.getListaCampiModulo().get("ausilio").get("ausilio"))%> </label>
al prelievo di un campione di  
<label class="layout"><%= fixValoreLong(OrgCampione.getMatrice())%> </label><br/>
<%-- <label class="layout"><%= fixValore(Modulo.getListaCampiModulo().get("campione_prelevato").get("campione_prelevato"))%> </label><br/> --%>
costituito da n.  <label class="layout"><%= fixValoreShort(Modulo.getListaCampiModulo().get("num_uc").get("num_uc"))%></label> 
unit&agrave; campionarie (u.c.) del peso di circa <label class="layout"><%= fixValoreShort(Modulo.getListaCampiModulo().get("peso_aliquote").get("peso_aliquote"))%> </label> kg cadauna <br/>
contrassegnata con lettere
<% if(fixValore(Modulo.getListaCampiModulo().get("lettera").get("lettera"))=="A"){ %>
   <span class="checkedItem"> &nbsp;A</span>&nbsp;
<% } else { %>
  <span class="NocheckedItem"> &nbsp;A</span>&nbsp;
<% } %> 
<% if(fixValore(Modulo.getListaCampiModulo().get("lettera").get("lettera"))=="B"){ %>
   <span class="checkedItem"> &nbsp;B</span>&nbsp;
<% } else { %>
  <span class="NocheckedItem"> &nbsp;B</span>&nbsp;
<% } %> 
<% if(fixValore(Modulo.getListaCampiModulo().get("lettera").get("lettera"))=="C"){ %>
   <span class="checkedItem"> &nbsp;C</span>&nbsp;
<% } else { %>
  <span class="NocheckedItem"> &nbsp;C</span>&nbsp;
<% } %> 
<% if(fixValore(Modulo.getListaCampiModulo().get("lettera").get("lettera"))=="D"){ %>
   <span class="checkedItem"> &nbsp;D</span>&nbsp;
<% } else { %>
  <span class="NocheckedItem"> &nbsp;D</span>&nbsp;
<% } %>
<% if(fixValore(Modulo.getListaCampiModulo().get("lettera").get("lettera"))=="E"){ %>
   <span class="checkedItem"> &nbsp;E</span>&nbsp;
<% } else { %>
  <span class="NocheckedItem"> &nbsp;E</span>&nbsp;
<% } %>  
sono costituite da molluschi prelevati nei punti identificati con la sorveglianza sanitaria e che sono riferiti, con la tollerenza definita dalla stessa, alle seguenti coordinate geografiche: </span><br>
<br/>
<% 

int i=-1;
	int count = 0;
	Integer s = ticketDetails.getListaCoordinateCampione().size();
	if(s != null ){
		int size = s;
	 	if(size > 0){%>
	 	
<!-- 	 	COORDINATE PUNTI DI PRELIEVO <br/> -->
	 	<%
			for(int j = 0; j < size; j++) {
			%>
		  <b><%=ticketDetails.getListaCoordinateCampione().get(j).getIdentificativo() %>)</b> LAT <label class="layout"><%=ticketDetails.getListaCoordinateCampione().get(j).getLatitude()%></label> LONG <label class="layout"><%=ticketDetails.getListaCoordinateCampione().get(j).getLongitude()%></label> Op.tore: soc/sig./coop <label class="layout">_______________________________________________</label><br/>
		  	<% } 
		 } 
	 	} else { %>
	 	LAT <label class="layout"></label>
		LONG <label class="layout"></label>
		Op.tore: <label class="layout"></label>
		<% } %>
		<br/><br/>
Ciascuna unit� campionaria � costituita da molluschi raccolti <span class="NocheckedItem"> &nbsp;a diversi livelli di profondit� </span> <span class="NocheckedItem"> &nbsp;sul fondale. </span> <br>
Gli esemplari costituenti le u.c. sono stati posti in buste di plastica per alimenti sigillate con piombino recante la dicitura <br/>
<label class="layout"><%= fixValoreLong(Modulo.getListaCampiModulo().get("dicitura").get("dicitura"))%> </label><br/>
e munite di cartellini identificativi controfirmati dal rappresentante dell'impresa.
<br> <br/>
Ai fini dell'analisi del rischio si riportano le condizioni meteo-marine al momento del prelievo: <br/>
<b>cielo:</b> sereno/coperto/pioggia; 
<b>mare:</b> piatto/leggermente mosso/mosso; 
<b>vento:</b> assente/leggera brezza/teso;
<br/>

<b>proveniente da</b> 
<label class="layout"><%= fixValoreShort(Modulo.getListaCampiModulo().get("proveniente").get("proveniente"))%> </label>; 
<b>corrente marina presumibilmente proveniente da: </b> 
<label class="layout"><%= fixValoreShort(Modulo.getListaCampiModulo().get("corrente_proveniente").get("corrente_proveniente"))%></label>; 
<br/>
<b>temperatura dell'aria: </b>
<label class="layout"><%= fixValoreShort(Modulo.getListaCampiModulo().get("temperatura_aria").get("temperatura_aria"))%></label>; 
<b>temperatura dell'acqua in superficie: </b>
<label class="layout"><%= fixValoreShort(Modulo.getListaCampiModulo().get("temperatura_acqua").get("temperatura_acqua"))%></label>; 
<br/>
<b>temperatura dell'acqua a 10 metri di profondit�: </b>
<label class="layout"><%= fixValoreShort(Modulo.getListaCampiModulo().get("temperatura_acqua_10m").get("temperatura_acqua_10m"))%></label>; 
<b>data ultima mareggiata: </b>
<label class="layout"><%= fixValoreShort(Modulo.getListaCampiModulo().get("data_mareggiata").get("data_mareggiata"))%></label>; 
<br/>
<b>data ultima pioggia: </b>
<label class="layout"><%= fixValoreShort(Modulo.getListaCampiModulo().get("data_pioggia").get("data_pioggia"))%></label>; 
<b>di intensit�: </b> fine/consistente/abbondante; 
<br/>
<b>salinit� dell'acqua: </b>
<label class="layout"><%= fixValoreShort(Modulo.getListaCampiModulo().get("salinita").get("salinita"))%></label>.
<br/><br/>

Le aliquote vengono conservate e trasferite in contenitori isotermici. <br/>
Il campione � inviato all'I.Z.S.M. Sezione di <label class="layout"><%= fixValore(Modulo.getListaCampiModulo().get("sezione").get("sezione"))%></label>
per la ricerca di <label class="layout"><%= fixValore(OrgCampione.getAnaliti())%></label> da eseguirsi su ogni singola aliquota/u.c.<br><br><br>
Note: 
<label class="layout"><%= fixValore(ticketDetails.getProblem())%></label>  <br>
Letto, confermato e sottoscritto.
<br>
<P> IL PRESENTE ALL'ISPEZIONE &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;GLI OPERATORI DEL CONTROLLO UFFICIALE 

<div style="page-break-before:always"> 
<!-- INIZIO HEADER -->
	<%@ include file="/campioni/moduli_html/rev9/header.jsp" %>
<!-- FINE HEADER -->

<!-- INIZIO FOOTER -->
	<%@ include file="/campioni/moduli_html/footer.jsp" %>
<!-- FINE FOOTER -->


</div>
<br><br><br>
<%@ include file="/gestione_documenti/gdpr_footer.jsp" %>
<br/>

<%-- rimasto non utilizzato questo campo <%= fixValore(Modulo.getListaCampiModulo().get("aliquote").get("aliquote"))%> </label> --%>


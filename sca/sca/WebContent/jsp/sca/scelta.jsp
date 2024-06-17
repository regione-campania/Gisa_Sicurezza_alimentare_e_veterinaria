<%@page import="it.us.web.util.CfUtil"%>
<%@page import="com.sun.corba.se.spi.legacy.connection.GetEndPointInfoAgainException"%>
<%@ page import="org.apache.commons.lang.StringEscapeUtils"%>
<%@ page import="java.io.*"%>
<jsp:useBean id="endpoints" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="num_registrazione_stab" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="lista_partita_iva" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="canilebdu" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="roles" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="username" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="esiti" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="asl" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="errore2" class="java.lang.String" scope="request" />
<jsp:useBean id="utenteGuc" class="it.us.web.bean.guc.Utente" scope="session" />


<%@ taglib uri="/WEB-INF/fn.tld" prefix="fn" %>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<c:if test="${utenteGuc!=null}" >
<div style="clear: both;" align="right">
<c:out  value="${utenteGuc.cognome}"/>, <c:out value="${utenteGuc.nome}"/> (<c:out value="${utenteGuc.username}"/>)
<%
 boolean spidAttivato = false;
 String nomeApp = (spidAttivato)?(" da Spid/CIE"):("");
%>

<a href="login.LogoutSca.us">[Logout]</a>
</div>
</c:if>

<style>
body {
    color: #000044;
	font:  bold 15px/20px Trebouchet ms,geneva, serif;
}
table { 
    border-spacing: 12px;
    border-collapse: separate;
}
 td {
    padding: 10px;
	 border: 1px solid grey;
	 width:150px;
}
</style>
<script>
function openPopup(url){
	
	  var res;
  var result;
  	  window.open(url,'popupSelect',
        'height=1280px,width=600px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=yes,resizable=yes ,modal=yes');
	}
	</script>
<body>
<h1 style="text-align:center;background-color:#eeeeee;">
S.C.A. - Sistema Centralizzato degli Accessi GISA
<a href="#" onClick="openPopup('guida/Gisa_sca.pdf');	return false; "> 
   <img src="images/question-mark.png" width="30"/> 
   </a> 
</h1>

<%@ include file="/avviso_messaggio_urgente.jsp" %>



<script src="js/dist/sweetalert.min.js"></script>
<link rel="stylesheet" type="text/css" href="js/dist/sweetalert.css">

<!--  c:if test="${ScadenzaPassword!=null}" -->
<c:if test="false">
<script>
sweetAlert("Avviso Password Obsoleta", "${ScadenzaPassword}", "warning");
</script>
</c:if>


<%
boolean controlloCf =  false;
boolean controlloCfNonBloccante =  utenteGuc.getCodiceFiscale() == null || utenteGuc.getCodiceFiscale().length()!=16 || !(CfUtil.ControllaCF(utenteGuc.getCodiceFiscale().toUpperCase()) ).equals("");
if(endpoints.size() > 0) { %>
<div id="content">
<center>
<h3>ASL <%=asl.get(0).toString()%></h3>
<table>
<tr>
<% 	String asl_start=asl.get(0).toString();
	int conta_col = 0;
	//boolean controlloCf =  utenteGuc.getCodiceFiscale() == null || utenteGuc.getCodiceFiscale().length()!=16 || !(CfUtil.ControllaCF(utenteGuc.getCodiceFiscale().toUpperCase()) ).equals("");
	for(int i=1;i<=asl.size();i++) {
		String endp=endpoints.get(i-1).toString();
		String asl_corrente = asl.get(i-1).toString();
		String username_corrente=username.get(i-1).toString();
		String pathFile = request.getRealPath("/") + "img/"+roles.get(i-1).toString().toLowerCase().replaceAll(" ", "")+".png";
		File f = new File(pathFile);
		String img="1";
		if(f.exists()){
			img	= roles.get(i-1).toString().toLowerCase().replaceAll(" ", "");
		} 
		
	%>
	
	
		<!-- Se l'asl corrente e uguale alla precedente -->
		<%if(i<=asl.size() && asl_corrente.equals(asl_start)) { 
			++conta_col;
			if(conta_col <=3){
		%>
			<td align="center">
				<% if(!esiti.isEmpty() && esiti.get(i-1).equals((i-1))) { //significa che e un KO
					
				%>
				<a href="#" onclick="alert('ATTENZIONE! NON PUOI ACCEDERE AL SISTEMA IN QUANTO <%=StringEscapeUtils.escapeJavaScript("L'UTENTE")%> <%=username.get(i-1).toString().toUpperCase() %> RISULTA DISATTIVATO PER APPLICAZIONE, RUOLO E ASL SELEZIONATI. PER ESSERE RIATTIVATO, SI PREGA DI CONTATTARE IL SERVIZIO DI HD I LIVELLO.');"><img width="50px" style="background-color:#707070" alt="" src="img/<%=img%>.png"></a>
				<br><%=roles.get(i-1).toString()%> 
				<%=(num_registrazione_stab.get(i-1)!=null && !num_registrazione_stab.get(i-1).equals(""))?("<br>" + num_registrazione_stab.get(i-1)):("")%> 
				<%=(lista_partita_iva.get(i-1)!=null && !lista_partita_iva.get(i-1).equals(""))?("<br>" + lista_partita_iva.get(i-1)):("")%>
				<%=(canilebdu.get(i-1)!=null && !canilebdu.get(i-1).equals(""))?("<br>" + canilebdu.get(i-1)):("")%> 
				<br><font color="#013ADF"><%=endp.toUpperCase()%></font>
				<% } 
				else if( controlloCf && !endp.equalsIgnoreCase("gisa_ext"))
				{
					%>
					<a href="#" onclick="alert('IMPOSSIBILE ACCEDERE: CODICE FISCALE NON VALIDO. SI PREGA DI CONTATTARE IL SERVIZIO DI HELP DESK.');"><img width="50px" style="background-color:#707070" alt="" src="img/<%=img%>.png"></a>
							<br><%=roles.get(i-1).toString()%> 
							<%=(num_registrazione_stab.get(i-1)!=null && !num_registrazione_stab.get(i-1).equals(""))?("<br>" + num_registrazione_stab.get(i-1)):("")%> 
							<%=(lista_partita_iva.get(i-1)!=null && !lista_partita_iva.get(i-1).equals(""))?("<br>" + lista_partita_iva.get(i-1)):("")%> 
							<br><font color="#013ADF"><%=endp.toUpperCase()%></font>
				<%}
				else { %>
					<a onclick="attendere()" href="login.LoginEndpoint.us?username=<%=username_corrente%>&endpoint=<%=endp%>"><img width="50px" style="background-color:#d21242" alt="" src="img/<%=img%>.png"></a>
					<br><%=roles.get(i-1).toString()%> 
					<%=(num_registrazione_stab.get(i-1)!=null && !num_registrazione_stab.get(i-1).equals(""))?("<br>" + num_registrazione_stab.get(i-1)):("")%>
					<%=(lista_partita_iva.get(i-1)!=null && !lista_partita_iva.get(i-1).equals(""))?("<br>" + lista_partita_iva.get(i-1)):("")%>
					<%=(canilebdu.get(i-1)!=null && !canilebdu.get(i-1).equals(""))?("<br>" + canilebdu.get(i-1)):("")%>   
					<br><font color="#013ADF"><%=endp.toUpperCase()%></font>
				<% } %>
			</td>
			<% } //numero_di_colonne 
			else { 
				conta_col=0; 
				++conta_col;%>
				</tr>
				<tr>
					<td align="center">
						<% if(!esiti.isEmpty() && esiti.get(i-1).equals((i-1))) { //significa che e un KO %>
						 <a href="#" onclick="alert('ATTENZIONE! NON PUOI ACCEDERE AL SISTEMA IN QUANTO <%=username.get(i-1).toString().toUpperCase() %> RISULTA DISATTIVATO PER APPLICAZIONE, RUOLO E ASL SELEZIONATI. PER ESSERE RIATTIVATO, SI PREGA DI CONTATTARE IL SERVIZIO DI HD I LIVELLO.');"><img width="50px" style="background-color:#707070" alt="" src="img/<%=img%>.png">
						 </a>
						<br><%=roles.get(i-1).toString()%> 
						<%=(num_registrazione_stab.get(i-1)!=null && !num_registrazione_stab.get(i-1).equals(""))?("<br>" + num_registrazione_stab.get(i-1)):("")%> 
						<%=(lista_partita_iva.get(i-1)!=null && !lista_partita_iva.get(i-1).equals(""))?("<br>" + lista_partita_iva.get(i-1)):("")%>
						<%=(canilebdu.get(i-1)!=null && !canilebdu.get(i-1).equals(""))?("<br>" + canilebdu.get(i-1)):("")%> 
						<br><font color="#013ADF"><%=endp.toUpperCase()%></font>
						<% } 
						else if( controlloCf && !endp.equalsIgnoreCase("gisa_ext"))
						{
							%>
							<a href="#" onclick="alert('IMPOSSIBILE ACCEDERE: CODICE FISCALE NON VALIDO. SI PREGA DI CONTATTARE IL SERVIZIO DI HELP DESK.');"><img width="50px" style="background-color:#707070" alt="" src="img/<%=img%>.png"></a>
									<br><%=roles.get(i-1).toString()%> 
									<%=(num_registrazione_stab.get(i-1)!=null && !num_registrazione_stab.get(i-1).equals(""))?("<br>" + num_registrazione_stab.get(i-1)):("")%>  
									<%=(lista_partita_iva.get(i-1)!=null && !lista_partita_iva.get(i-1).equals(""))?("<br>" + lista_partita_iva.get(i-1)):("")%>  
									<%=(canilebdu.get(i-1)!=null && !canilebdu.get(i-1).equals(""))?("<br>" + canilebdu.get(i-1)):("")%> 
									<br><font color="#013ADF"><%=endp.toUpperCase()%></font>
						<%}
						else { %>
						<a onclick="attendere()" href="login.LoginEndpoint.us?username=<%=username_corrente%>&endpoint=<%=endp%>"><img width="50px" style="background-color:#f47836" alt="" src="img/<%=img%>.png"></a>
					<br><%=roles.get(i-1).toString()%> 
					<%=(num_registrazione_stab.get(i-1)!=null && !num_registrazione_stab.get(i-1).equals(""))?("<br>" + num_registrazione_stab.get(i-1)):("")%>  
					<%=(lista_partita_iva.get(i-1)!=null && !lista_partita_iva.get(i-1).equals(""))?("<br>" + lista_partita_iva.get(i-1)):("")%>  
					<%=(canilebdu.get(i-1)!=null && !canilebdu.get(i-1).equals(""))?("<br>" + canilebdu.get(i-1)):("")%> 
					<br><font color="#013ADF"><%=endp.toUpperCase()%></font>
				<% } %>
					</td>
					
			<% } %>
		
		<% } else { %>
		</tr>
		</table>
		<h3>ASL <%=asl_corrente%></h3>
		<% asl_start= asl_corrente;
		conta_col=0;
		%>
		<table>
			<tr>
			
			<% ++conta_col;
				if(conta_col <=3){
			%>
			<td align="center">
				<% if(!esiti.isEmpty() && esiti.get(i-1).equals((i-1))) { //significa che e un KO %>
				
					<a href="#" onclick="alert('ATTENZIONE! NON PUOI ACCEDERE AL SISTEMA IN QUANTO <%=username.get(i-1).toString().toUpperCase()%> RISULTA DISATTIVATO PER APPLICAZIONE, RUOLO E ASL SELEZIONATI. PER ESSERE RIATTIVATO, SI PREGA DI CONTATTARE IL SERVIZIO DI HD I LIVELLO.');"><img width="50px" style="background-color:#707070" alt="" src="img/<%=img%>.png" >
					</a>
					<br><%=roles.get(i-1).toString()%> 
					<%=(num_registrazione_stab.get(i-1)!=null && !num_registrazione_stab.get(i-1).equals(""))?("<br>" + num_registrazione_stab.get(i-1)):("")%>  
					<%=(lista_partita_iva.get(i-1)!=null && !lista_partita_iva.get(i-1).equals(""))?("<br>" + lista_partita_iva.get(i-1)):("")%>  
					<%=(canilebdu.get(i-1)!=null && !canilebdu.get(i-1).equals(""))?("<br>" + canilebdu.get(i-1)):("")%> 
					<br><font color="#013ADF"><%=endp.toUpperCase()%></font>
				<% } 
				else if( controlloCf && !endp.equalsIgnoreCase("gisa_ext"))
				{
					%>
					<a href="#" onclick="alert('IMPOSSIBILE ACCEDERE: CODICE FISCALE NON VALIDO. SI PREGA DI CONTATTARE IL SERVIZIO DI HELP DESK.');"><img width="50px" style="background-color:#707070" alt="" src="img/<%=img%>.png"></a>
							<br><%=roles.get(i-1).toString()%> 
							<%=(num_registrazione_stab.get(i-1)!=null && !num_registrazione_stab.get(i-1).equals(""))?("<br>" + num_registrazione_stab.get(i-1)):("")%>  
							<%=(lista_partita_iva.get(i-1)!=null && !lista_partita_iva.get(i-1).equals(""))?("<br>" + lista_partita_iva.get(i-1)):("")%>  
							<%=(canilebdu.get(i-1)!=null && !canilebdu.get(i-1).equals(""))?("<br>" + canilebdu.get(i-1)):("")%> 
							<br><font color="#013ADF"><%=endp.toUpperCase()%></font>
				<%}
				else { %>
					<a onclick="attendere()" href="login.LoginEndpoint.us?username=<%=username_corrente%>&endpoint=<%=endp%>"><img width="50px" style="background-color:#f47836" alt="" src="img/<%=img%>.png" >
					</a>
					<br><%=roles.get(i-1).toString()%> 
					<%=(num_registrazione_stab.get(i-1)!=null && !num_registrazione_stab.get(i-1).equals(""))?("<br>" + num_registrazione_stab.get(i-1)):("")%> 
					<%=(lista_partita_iva.get(i-1)!=null && !lista_partita_iva.get(i-1).equals(""))?("<br>" + lista_partita_iva.get(i-1)):("")%> 
					<%=(canilebdu.get(i-1)!=null && !canilebdu.get(i-1).equals(""))?("<br>" + canilebdu.get(i-1)):("")%>  
					<br><font color="#013ADF"><%=endp.toUpperCase()%></font>
				<% } %>	
			</td>	
			<% } else {
				conta_col=0; ++conta_col;%>
			</tr>	
			<tr>
				<td align="center">
					<% if(!esiti.isEmpty() && esiti.get(i-1).equals((i-1))) { //significa che e un KO %>
						<a href="#" onclick="alert('ATTENZIONE! NON PUOI ACCEDERE AL SISTEMA IN QUANTO <%=username.get(i-1).toString().toUpperCase() %> RISULTA DISATTIVATO PER APPLICAZIONE, RUOLO E ASL SELEZIONATI. PER ESSERE RIATTIVATO, SI PREGA DI CONTATTARE IL SERVIZIO DI HD I LIVELLO.');"><img width="50px" style="background-color:#707070" alt="" src="img/<%=img%>.png" >
						</a>
						<br><%=roles.get(i-1).toString()%>
						<%=(num_registrazione_stab.get(i-1)!=null && !num_registrazione_stab.get(i-1).equals(""))?("<br>" + num_registrazione_stab.get(i-1)):("")%>  
						<%=(lista_partita_iva.get(i-1)!=null && !lista_partita_iva.get(i-1).equals(""))?("<br>" + lista_partita_iva.get(i-1)):("")%>  
						<%=(canilebdu.get(i-1)!=null && !canilebdu.get(i-1).equals(""))?("<br>" + canilebdu.get(i-1)):("")%> 
						<br><font color="#013ADF"><%=endp.toUpperCase()%></font>			
					<% } 
					else if( controlloCf && !endp.equalsIgnoreCase("gisa_ext"))
					{
						%>
						<a href="#" onclick="alert('IMPOSSIBILE ACCEDERE: CODICE FISCALE NON VALIDO. SI PREGA DI CONTATTARE IL SERVIZIO DI HELP DESK.');"><img width="50px" style="background-color:#707070" alt="" src="img/<%=img%>.png"></a>
								<br><%=roles.get(i-1).toString()%> 
								<%=(num_registrazione_stab.get(i-1)!=null && !num_registrazione_stab.get(i-1).equals(""))?("<br>" + num_registrazione_stab.get(i-1)):("")%>  
								<%=(lista_partita_iva.get(i-1)!=null && !lista_partita_iva.get(i-1).equals(""))?("<br>" + lista_partita_iva.get(i-1)):("")%>  
								<%=(canilebdu.get(i-1)!=null && !canilebdu.get(i-1).equals(""))?("<br>" + canilebdu.get(i-1)):("")%> 
								<br><font color="#013ADF"><%=endp.toUpperCase()%></font>
					<%}
					else { %>
						<a onclick="attendere()" href="login.LoginEndpoint.us?username=<%=username_corrente%>&endpoint=<%=endp%>"><img width="50px" style="background-color:#d21242" alt="" src="img/<%=img%>.png">
						</a>
						<br><%=roles.get(i-1).toString()%>
						<%=(num_registrazione_stab.get(i-1)!=null && !num_registrazione_stab.get(i-1).equals(""))?("<br>" + num_registrazione_stab.get(i-1)):("")%> 
						<%=(lista_partita_iva.get(i-1)!=null && !lista_partita_iva.get(i-1).equals(""))?("<br>" + lista_partita_iva.get(i-1)):("")%> 
						<%=(canilebdu.get(i-1)!=null && !canilebdu.get(i-1).equals(""))?("<br>" + canilebdu.get(i-1)):("")%>  
						<br><font color="#013ADF"><%=endp.toUpperCase()%></font>
					<% } %>
				</td>
		
			<% }
		}
		%>	
						
<%} %>
</tr>
</table>	

</center>
</div>
<% } %>


<%
if(controlloCfNonBloccante)
{
%>

<script type="text/javascript">
sweetAlert("Avviso Codice Fiscale Non Valido", "Attenzione: il CF non risulta valido pertanto non sara\' possibile accedere al sistema con SPID/CIE.\nSi suggerisce di rivolgersi all'Help Desk per la risoluzione immediata del problema.", "warning");
</script>
<%
}
%>



</body>
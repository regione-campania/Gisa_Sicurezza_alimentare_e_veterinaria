<jsp:useBean id="OrgDetails" class="org.aspcfs.modules.stabilimenti.base.Organization" scope="request" />
<%@ include file="../utils23/initPage.jsp"%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv"%>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio"%>

<script>
function waitSeconds(iMilliSeconds) {
    var counter= 0
        , start = new Date().getTime()
        , end = 0;
    while (counter < iMilliSeconds) {
        end = new Date().getTime();
        counter = end - start;
    }
    alert('La modifica � stata abilitata');
}

function abilitaModifica(){
	var mod = document.getElementById("modifica");
	waitSeconds(5000);
	mod.disabled = '';
	mod.style="display:block";
}
</script>

	<%-- Trails --%>
	<table class="trails" cellspacing="0">
		<tr>
			<td><a href="Stabilimenti.do"><dhv:label
				name="stabilimenti.stabilimenti">Accounts</dhv:label></a> > 
			<a href="Stabilimenti.do?command=Details&orgId=<%=OrgDetails.getId()%>">Dettaglio</a> 
		
		</tr>
	</table>
	
	  <script language="JavaScript" TYPE="text/javascript"
	SRC="gestione_documenti/generazioneDocumentale.js"></script>
	
	<%
String param1 = "orgId=" + OrgDetails.getOrgId();
%>
	<dhv:container name="<%=(OrgDetails.isMacelloUngulati()) ? ( (OrgDetails.getStatoIstruttoria() ==0 || OrgDetails.getStatoIstruttoria() ==7 || OrgDetails.getStatoIstruttoria() ==8) ? ("stabilimenti_macellazioni_ungulati") : "stabilimenti_macellazioni_ungulati" ) : (OrgDetails.getStatoIstruttoria()==0) ? ("stabilimenti") : "stabilimenti_controllo_doc" %>" selected="details" object="OrgDetails" param="<%= param1 %>" appendToUrl='<%= addLinkParams(request, "popup|popupType|actionId") %>' hideContainer="<%= !OrgDetails.getEnabled() || OrgDetails.isTrashed() %>">
	
	
	<table style="border:1px solid black">
	<tr><td>
 <img src="images/icons/stock_print-16.gif" border="0" align="absmiddle" height="16" width="16"/>
        <input type="button" title="Stampa Scheda" value="Stampa Scheda"		onClick="openRichiestaPDF_ConExtra('<%= OrgDetails.getId() %>', '_ModificaData_', '2'); abilitaModifica();">
         	    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" value="ANNULLA"  onclick="location.href='Stabilimenti.do?command=Details&orgId=<%=OrgDetails.getId()%>'"/> </td>
        </tr>
        
        <tr><td>
       <font color="red" size="6px">ATTENZIONE! Si ricorda che prima di procedere alla modifica dello stabilimento � necessario stampare la scheda attuale.</font>
       </td></tr>

		<tr><td>
 	    <a style="text-decoration: none;" href="Stabilimenti.do?command=ModifyStabilimento2&account_number=<%=OrgDetails.getNumAut() %>"><input style="display:none" disabled type="button" id="modifica" value="Modifica"/></a>

	    </td>
        </tr>
        
</table>


</dhv:container>
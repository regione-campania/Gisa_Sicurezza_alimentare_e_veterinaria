<%@ page import="org.aspcfs.modules.macellazioninew.base.Tipo"%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv"%>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio"%>
<%@ page import="org.aspcfs.modules.stabilimenti.base.SottoAttivita,java.util.*,java.text.DateFormat,org.aspcfs.modules.stabilimenti.base.*,org.aspcfs.modules.contacts.base.*,org.aspcfs.modules.base.Constants"%>
<%@ page  import="java.util.Date"%>
<%@ include file="../utils23/initPage.jsp"%>

<link href="css/nonconformita.css" rel="stylesheet" type="text/css" />

<jsp:useBean id="OrgCategoriaRischioList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="OrgDetails" class="org.aspcfs.modules.stabilimenti.base.Organization" scope="request" />
<jsp:useBean id="SICCodeList" class="org.aspcfs.modules.admin.base.SICCodeList" scope="request" />
<jsp:useBean id="applicationPrefs" class="org.aspcfs.controller.ApplicationPrefs" scope="application" />
<jsp:useBean id="Audit" class="org.aspcfs.modules.audit.base.Audit" scope="request"/>
<jsp:useBean id="SourceList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="StageList" class="org.aspcfs.utils.web.LookupList"	scope="request" />
<jsp:useBean id="statiStabilimenti" class="org.aspcfs.utils.web.LookupList" 	scope="request" />
<jsp:useBean id="LookupClassificazione" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="LookupProdotti" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="SiteList" class="org.aspcfs.utils.web.LookupList" 	scope="request" />
<jsp:useBean id="TitoloList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="impianto" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="statoLab" class="org.aspcfs.utils.web.LookupList"	scope="request" />
<jsp:useBean id="statoLabImpianti" class="org.aspcfs.utils.web.LookupList"	scope="request" />
<jsp:useBean id="RatingList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="SegmentList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="categoriaList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="imballataList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="tipoAutorizzazioneList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session" />
<jsp:useBean id="refreshUrl" class="java.lang.String" scope="request" />
<jsp:useBean id="elencoSottoAttivita" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="impreseAssociateMercatoIttico" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="stabilimentiAssociateMercatoIttico" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="ControlloDocumentale" class="org.aspcfs.modules.stabilimenti.base.ControlloDocumentale" scope = "request"></jsp:useBean>
<script language="JavaScript" TYPE="text/javascript" SRC="gestione_documenti/generazioneDocumentale.js"></script>

<% 
	java.util.Date datamio = new java.util.Date(System.currentTimeMillis());
	Timestamp d = new Timestamp (datamio.getTime());
	ArrayList<Tipo> tipi 	 = (ArrayList<Tipo>)request.getAttribute("tipi");
	Iterator<Tipo>  tipiIter = tipi.iterator();
	String param1 = "orgId=" + OrgDetails.getOrgId();
%>

<dhv:container name="stabilimenti_macellazioni_ungulati" 
								selected="macellazioni" 
								object="OrgDetails" 
								param="<%=param1%>"
								appendToUrl='<%= addLinkParams(request, "popup|popupType|actionId") %>' 
								hideContainer="<%= !OrgDetails.getEnabled() || OrgDetails.isTrashed() %>">
								
<dhv:evaluate if="<%= !isPopup(request) %>">
	<%-- Trails --%>
	<table class="trails" cellspacing="0">
		<tr>
			<td><a href="Stabilimenti.do"><dhv:label
				name="stabilimenti.stabilimenti">Accounts</dhv:label></a> > <%
			if (request.getParameter("return") == null) {
			%>
			<a href="Stabilimenti.do?command=Search"><dhv:label
				name="stabilimenti.SearchResults">Search Results</dhv:label></a> > <%
			} else if (request.getParameter("return").equals("dashboard")) {
			%>
			<a href="Stabilimenti.do?command=Dashboard">Cruscotto</a> > 
			<%
			}
			%>
			<dhv:label name="">Lista tipi macellazione</dhv:label></td>
		</tr>
	</table>
</dhv:evaluate>

<dhv:permission name="stabilimenti-stabilimenti-report-view">
	<table width="100%" border="0">
		<tr>
			<%-- aggiunto da d.dauria--%>

			<td nowrap align="right">
			<!-- img
				src="images/icons/stock_print-16.gif" border="0" align="absmiddle"
				height="16" width="16" /> <a
				href="SchedaPrint.do?command=PrintReport&file=stabilimenti&id=<%= OrgDetails.getId() %>"><dhv:label
				name="stabilimenti.osa.print">Stampa Scheda stabilimenti</dhv:label></a-->
			</td>


			<%-- fine degli inserimenti --%>
		</tr>
	</table>
</dhv:permission>


	<input type="hidden" name="orgId" value="<%= OrgDetails.getOrgId() %>">
	<%
	String action = "Stabilimenti.do";
	if(OrgDetails.getStatoIstruttoria()==StatiStabilimenti.ISTRUTTORIA_PRELIMINARE || 
			OrgDetails.getStatoIstruttoria()==StatiStabilimenti.ISTRUTTORIA_ESISTENTE || 
			OrgDetails.getStatoIstruttoria()==StatiStabilimenti.DOCUMENTAZIONE_COMPLETATA || 
			OrgDetails.getStatoIstruttoria()==StatiStabilimenti.RICHIESTA_RICONSOCIMENTO_CONDIZIONATO ||
			OrgDetails.getStatoIstruttoria()==StatiStabilimenti.RICHIESTA_RICONSOCIMENTO_DEFINITIVO ||
			OrgDetails.getStatoIstruttoria()==StatiStabilimenti.RICONOSCIUTO_CONDIZIONATO  || 
			OrgDetails.getStatoIstruttoria()==StatiStabilimenti.RICONOSCIUTO_CONDIZIONATO_PROROGA ||
			OrgDetails.getStatoIstruttoria()==StatiStabilimenti.COMPLETATO
			)
	{
		action +="?command=Update&orgId="+OrgDetails.getOrgId()+"";
	}
	
	
	if(OrgDetails.getStatoIstruttoria()==StatiStabilimenti.INOLTRO_DEFINITIVO_REGIONE )
	{
		
		action +="?command=Modify&orgId="+OrgDetails.getOrgId();
	}
	if(OrgDetails.getStatoIstruttoria()==StatiStabilimenti.INOLTRO_CONDIZIONATO_REGIONE )
	{
		
		action +="?command=Modify&orgId="+OrgDetails.getOrgId()+"&condizionato=true";
	}
	if(OrgDetails.getStatoIstruttoria()==StatiStabilimenti.RICHIESTA_REVOCA )
	{
		
		action +="?command=Update&orgId="+OrgDetails.getOrgId()+"&revoca=true&nuovoStato=11";
	}
	
	
	
	%>
	
	<input type = "hidden" name = "orgId" value = "<%=OrgDetails.getOrgId() %>">
	<%-- STABILIMENTO IN ISTRUTTORIA PRELIMINARE 	PERMESSI DA ATTIVARE SOLO ALL'ASL --%>
	
		
	
	
		
	<!-- se l'esito del controllo documentale � 
		 andato a buon fine l'asl invia una richiesta 
		 condizionata o definitiva 
		 
	-->
	
	<dhv:evaluate if='<%= (OrgDetails.getStatoIstruttoria() == StatiStabilimenti.DOCUMENTAZIONE_COMPLETATA  )   %>'>
		<dhv:permission name="stabilimenti-stabilimenti-istruttoria-condizionata-view">
			<input type = "submit" value = "Invia per Riconoscimento Condizionato" onclick="javascript : document.addAccount.action='<%=action+"&nuovoStato=4" %>'"/>
		</dhv:permission>

	</dhv:evaluate>
		
	<%
	boolean dataisnull = false ;
	if(elencoSottoAttivita.size()>0 && elencoSottoAttivita.get(0)!=null )
	{
		Iterator it2 = elencoSottoAttivita.iterator();
		while (it2.hasNext())
		{
			SottoAttivita sa = (SottoAttivita) it2.next();	
			if (sa.getData_inizio_attivita()==null)
			{
				dataisnull = true ;
				break ;
			}
		}
	}
%>
<div id="tab1" class="tab">

	<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
		<tr>
			<th colspan="2">
				Scelta Tipologia Macellazione
			</th>
		</tr>
		<tr>
			<td colspan="2">
				<input type="button" name="tipo1" id="tipo1" value="Bovini/Bufalini/Equidi" onclick="location.href='Macellazioni.do?command=List&orgId=<%=OrgDetails.getId()%>&tipo=1';" /> <br/>
				<dhv:permission name="macellazioni-ovicaprini-view">
					<input type="button" name="tipo2"     id="tipo2" value="Ovicaprini/Suini"             onclick="location.href='MacellazioniNew.do?command=List&orgId=<%=OrgDetails.getId()%>&tipo=2';" /> <br/>
				</dhv:permission>
			</td>
		</tr>
		
	</table>
	
		</div>
		<br/>
		
			<div id="tab3" class="tab">
		</div>
		<br>
		</dhv:container>

<script type="text/javascript">
var tabber=new Yetii('tabcont1',1);
tabber.init();

function checkForm()
{
	var tipo = document.getElementById('tipo').value;
	if(tipo=='')
	{
		alert('Selezionare la tipologia di macellazione');
		return false;
	}
	else
	{
		var nuovaGestione = "New";
		if(tipo=='1')
			nuovaGestione="";
		location.href='Macellazioni' + nuovaGestione + '.do?command=List&orgId=<%=OrgDetails.getId()%>&tipo='+tipo;	
	}
}
function openPopupModulesPdf(orgId){
	var res;
	var result;
		window.open('ManagePdfModules.do?command=PrintSelectedModules&orgId='+orgId,'popupSelect',
		'height=300px,width=580px,toolbar=no,directories=no,status=no,continued from previous linemenubar=no,scrollbars=no,resizable=no ,modal=yes');
}
</script>
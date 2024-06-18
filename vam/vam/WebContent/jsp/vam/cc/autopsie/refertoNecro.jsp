<%@page import="java.util.HashSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="it.us.web.bean.BUtenteAll"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="java.util.Date"%>
<%@page import="it.us.web.bean.remoteBean.RegistrazioniSinantropiResponse"%>
<%@page import="it.us.web.bean.remoteBean.RegistrazioniFelinaResponse"%>
<%@page import="it.us.web.util.sinantropi.SinantropoUtil"%>
<%@page import="it.us.web.util.vam.FelinaRemoteUtil"%>
<%@page import="it.us.web.util.vam.CaninaRemoteUtil"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.naming.Context"%>
<%@page import="it.us.web.action.GenericAction"%>
<%@page import="it.us.web.dao.hibernate.PersistenceFactory"%>
<%@page import="it.us.web.dao.hibernate.Persistence"%>
<%@page import="it.us.web.bean.ServicesStatus"%>
<%@page import="it.us.web.bean.BUtente"%>
<%@page import="it.us.web.bean.remoteBean.RegistrazioniCaninaResponse"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/fmt.tld" prefix="fmt"%>
<%@ taglib uri="/WEB-INF/jmesa.tld" prefix="jmesa"%>
<%@page import="it.us.web.bean.vam.Autopsia"%>
<%@page import="it.us.web.bean.vam.CartellaClinica"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="it.us.web.bean.vam.lookup.LookupAutopsiaEsitiEsami"%>
<%@page import="it.us.web.bean.vam.lookup.LookupAutopsiaTipiEsami"%>
<%@page import="it.us.web.bean.vam.lookup.LookupAutopsiaOrgani"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.net.InetAddress"%>
<%@page import="it.us.web.util.properties.Application"%>

<script language="JavaScript" type="text/javascript"
	src="js/vam/cc/autopsie/detail.js"></script>

<%	

Persistence persistence = PersistenceFactory.getPersistence();
GenericAction.aggiornaConnessioneApertaSessione(request);
Context ctx = new InitialContext();
javax.sql.DataSource ds = (javax.sql.DataSource)ctx.lookup("java:comp/env/jdbc/bduS");
Connection connection = ds.getConnection();
GenericAction.aggiornaConnessioneApertaSessione(request);
Autopsia a 	         = (Autopsia)request.getAttribute("a");
CartellaClinica cc = a.getCartellaClinica();
ArrayList<LookupAutopsiaOrgani> listOrganiAutopsia	              = (ArrayList<LookupAutopsiaOrgani>)request.getAttribute("listOrganiAutopsia");
ArrayList<LookupAutopsiaTipiEsami> listTipiAutopsia 			  = (ArrayList<LookupAutopsiaTipiEsami>)request.getAttribute("listTipiAutopsia");
HashMap<String, Set<LookupAutopsiaEsitiEsami>> allOrganiTipiEsiti = (HashMap<String, Set<LookupAutopsiaEsitiEsami>>)request.getAttribute("allOrganiTipiEsiti");
BUtente utente = ((BUtente)request.getSession().getAttribute("utente"));
ServicesStatus status =new ServicesStatus();

RegistrazioniCaninaResponse res = null;
RegistrazioniFelinaResponse ref = null;
RegistrazioniSinantropiResponse ress = null;

if (cc.getAccettazione().getAnimale().getLookupSpecie().getId() == 1 && !cc.getAccettazione().getAnimale().getDecedutoNonAnagrafe()) 
	res	= CaninaRemoteUtil.getInfoDecesso( cc.getAccettazione().getAnimale().getIdentificativo(), utente, status, connection, request);
else if (cc.getAccettazione().getAnimale().getLookupSpecie().getId() == 2 && !cc.getAccettazione().getAnimale().getDecedutoNonAnagrafe()) 
	ref = FelinaRemoteUtil.getInfoDecesso( cc.getAccettazione().getAnimale().getIdentificativo(), utente, status, connection, request);
else if (cc.getAccettazione().getAnimale().getLookupSpecie().getId() == 3 && !cc.getAccettazione().getAnimale().getDecedutoNonAnagrafe()) 
	ress = SinantropoUtil.getInfoDecesso(persistence, cc.getAccettazione().getAnimale());

Date dataEvento = null;
String dataMorteCertezza = "";
String decessoValue = "";
if(res!=null)
{
	decessoValue = res.getDecessoValue();
	dataEvento = res.getDataEvento();
	dataMorteCertezza = res.getDataMorteCertezza();
}
else if(ref!=null)
{
	decessoValue = ref.getDecessoValue();
	dataEvento = ref.getDataEvento();
	dataMorteCertezza = ref.getDataMorteCertezza();
}
if(ress!=null)
{
	decessoValue = ress.getDecessoValue();
	dataEvento = ress.getDataEvento();
	dataMorteCertezza = ress.getDataMorteCertezza();
}

Context ctx2 = new InitialContext();
javax.sql.DataSource ds2 = (javax.sql.DataSource)ctx2.lookup("java:comp/env/jdbc/vamM");
Connection connectionVam = ds2.getConnection();
GenericAction.aggiornaConnessioneApertaSessione(request);
PreparedStatement pSt = connectionVam.prepareStatement("select operatore from autopsia_operatori where autopsia = " + a.getId() );
ResultSet rs = pSt.executeQuery();

Set<BUtenteAll> operatori = new HashSet<BUtenteAll>();
while(rs.next())
{
	
		BUtenteAll				utente2	= null;
		PreparedStatement	stat	= null;
		ResultSet			rs2		= null;
		
		try 
		{
			stat = connectionVam.prepareStatement("SELECT * FROM utenti_ WHERE utenti_.superutente =  " + rs.getInt("operatore"));
			rs2 = stat.executeQuery();
			
			if( rs2.next() )
			{		
				utente2 = new BUtenteAll();
				utente2.setCognome(rs2.getString("cognome"));
				utente2.setNome(rs2.getString("nome"));
			}
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		
		operatori.add(utente2);	
}
connectionVam.close();
GenericAction.aggiornaConnessioneChiusaSessione(request);

PersistenceFactory.closePersistence(persistence, false);
GenericAction.aggiornaConnessioneChiusaSessione(request);
connection.close();
GenericAction.aggiornaConnessioneChiusaSessione(request);

%>




<script language="JavaScript" type="text/javascript" src="js/vam/cc/stampaCC/popupDetails.js"></script>


<style>

@media all {
@page { margin-top: 5px}
.blue {
	 background-color:#e6f3ff;
	  border: 1px solid black;
	}
	.layout {
		  border: 1px solid black;
	}

	table.fondo {
position: absolute;
	font-size: 12px;
	margin-top: 650px;
	width:100%;
}
div.header {
	display:none;
}
.stampaSezione {
display:none;
}
.coloreIdentificativo {
	color:#000000;
}
.boxIdDocumento {  
       border: 1px solid black;
       width: 60px;
       height: 20px;
       margin-top: 15px;
       text-align: center;
       padding-top: 5px;
       font-size: 8px; 
}
.boxOrigineDocumento {
	position: absolute;
	width: 160px;
	height: 20px;
	top: 15px;
	left: 80px;
	text-align: left;
	padding-top: 10px;
	font-size: 8px;
}
table.tabella
{
	-webkit-print-color-adjust:exact;
	background-color:#E5EAE7;
	font-size:16px;
	margin:0.5%;
	width:94%;	
	border-collapse: collapse;
	
}

th
{
	background:#A8C4DC;
	color:#000044;
	font-weight:bold;
	text-align:center;
	padding: 0px;
	border: none;	
}

th.sub
{
	background:#CCCCCC;
	color:#000044;
	font-weight:bold;
	text-align:center;
	padding: 0px;
	border: none;	
}
#divTerap, #divChir {
page-break-before: always;
}


tr.odd {background-color: #FFFFFF}
tr.even {background-color: #E5EAE7;}

table.griglia  {
width:100%;
background-color:#000;
}
table.griglia td {
background-color:#FFF;

}

table.grigliaEsami  {
background-color:#000;
}
table.grigliaEsami td {
background-color:#FFF;

}

table {
line-height:1.2em;
}

.underline {
border-bottom:1px solid;
}
.esamiSangue tr td{
	font-size: 0.8em;
}
}

body{
	-webkit-print-color-adjust:exact;
    font-family: Trebuchet MS,Verdana,Helvetica,Arial,san-serif;	
}

p.intestazione{
	background: none repeat scroll 0 0 #A8C4DC;
    border: medium none;
    color: #000044;
    font-weight: bold;
    padding: 0;
    text-align: center;
    width: 50%;
    text-align:left;
    
}
.pagebreak, #divChir {
page-break-after:always;

}

#intestazione table td img {
	heigth:100px;
}
h2 {
	border:none !important;
	text-decoration: underline;
	display:inline;
}
table td h3 {
	display:inline
	}
table.griglia  {
width:100%;
background-color:#000;
}
table.griglia td {
background-color:#FFF;
text-align:center;
}

table.grigliaEsami  {
background-color:#000;
}
table.grigliaEsami td {
background-color:#FFF;
text-align:center;
}

table.bordo {
border:1px solid;
width:100%;
border-collapse: collapse;
}
.esamiSangue {
	font-size: 10px;
	}
	table.fondo {

position: absolute;
	font-size: 12px;
	width:98%;
}

	
</style>

<div class="boxIdDocumento"></div>
<div class="boxOrigineDocumento"><%@ include file="../../../../hostName.jsp" %></div>
<br/>
      
<div id="print_div" >

	<div id="intestazioneCC" style="display: block;" >
	<table class="griglia" style="margin:0 auto;" >
		<tr>
			
		<td>
			<c:choose>
				<c:when test="${a.tipoAccettazione=='Criuv'}">
					<img documentale_url="" src="images/criuv.jpg" style="height:100px"/>
				</c:when>
				<c:otherwise>
					<img documentale_url="" src="images/asl/${utente.clinica.lookupAsl}.jpg" style="height:100px"/>
				</c:otherwise>
			</c:choose>
		</td>
		
		<td>
			<c:choose>
				<c:when test="${a.tipoAccettazione=='Criuv'}">
					<h3>CRIUV</h3><br/>
					Via M.R. di Torrepadula - P.O. Frullone - Plesso Ulisse<br/>
					80143 Napoli<br/>
					Tel.  0812549555/52/56/58 - Fax 0812548740<br/>
					email: criuv@regione.campania.it
				</c:when>
				<c:otherwise>
					<c:choose>
						<c:when test="${utente.clinica.lookupAsl.id==204}">
							<h3>ASL NAPOLI 1 CENTRO - SSD EPIDEMIOLOGIA VETERINARIA</h3><br/>
							Via M.R. di Torrepadula - P.O. Frullone - Plesso Ulisse<br/>
							80143 Napoli<br/>
							Tel.  081-2549555 - Fax 081- 2548740<br/>
							email: epidevet@aslnapoli1centro.it                       
						</c:when>
						<c:otherwise>
							<h3>${utente.clinica.nome }</h3><br/>
							${utente.clinica.indirizzo }<br/>
							${utente.clinica.lookupComuni.description }
						</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>
		</td>
		<td>
			<c:choose>
				<c:when test="${a.tipoAccettazione=='Criuv'}">
					<b><i>Cod. SIGLA 282961</i></b>
				</c:when>
				<c:otherwise>
					<c:choose>
						<c:when test="${utente.clinica.lookupAsl.id==204}">
							<b><i>Cod. SIGLA 283779</i></b>
						</c:when>
						<c:otherwise>
						</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>
		</td>			
		</tr>
	
	</table></div>
	
	
		<fmt:setLocale value="en_US" /> <!-- ALTRIMENTI LA STAMPA NON FUNZIONA -->
		<br/>
    		<center><h2>Referto Esame Necroscopico</h2></center>
	
	<table width="100%" class="bordo">
	<col width="50%"><col width="50%">
	<tr><td><i>Data richiesta</i></td>
			<td><fmt:formatDate type="date" value="${a.dataAutopsia}"
				pattern="dd/MM/yyyy" var="dataAutopsia" /> ${dataAutopsia}</td>
	</tr>
		<tr><td><i>Data Necroscopia</i></td>
			<td><fmt:formatDate type="date" value="${a.dataEsito}"
				pattern="dd/MM/yyyy" var="dataEsito" /> ${dataEsito}</td>
	</tr>
	
		<tr><td><i>Operatori</i></td>
			<td>
<% 
			Iterator<BUtenteAll> opIt = operatori.iterator();
			while(opIt.hasNext())
			{
				BUtenteAll su = opIt.next();
				out.println(su.getNome() +" " + su.getCognome() +"<br/>");			
			}
%>			
		</td>
	</tr>
	
	<tr>
		<td><i>Sala settoria di destinazione</i></td>
		<td>${a.lass.description}</td>
		</tr>

	<tr>
		<td><i>Numero rif. Mittente</i></td>
		<td>${a.numeroAccettazioneSigla}</td>
		</tr>
	<tr>
		<td><i>Inserito da</i></td>
		<td>${a.enteredBy} il <fmt:formatDate value="${a.entered}" pattern="dd/MM/yyyy"/></td>			
	</tr>
	
	</table>
	
	<br/>
		<center><h2>Dati del <%=cc.getAccettazione().getAnimale().getLookupSpecie().getDescription() %></h2></center>
	<table width="100%" class="bordo">
		<col width="25%"><col width="25%">
	<tr>
	<td><i>Identificativo</i></td>
	<td>${cc.accettazione.animale.identificativo }</td>
	<td><i>Specie</i></td>
	<td><%=cc.getAccettazione().getAnimale().getLookupSpecie().getDescription() %></td>
	</tr>
	
		<tr>
<td><i>
    		<c:if test="${cc.accettazione.animale.lookupSpecie.id!=3}">
    			Razza
    			</c:if>
    		<c:if test="${cc.accettazione.animale.lookupSpecie.id==3}">
    			Famiglia/Genere
    			</c:if>
    			
    			</i></td><td><c:if test="${(cc.accettazione.animale.lookupSpecie.id == specie.cane or cc.accettazione.animale.lookupSpecie.id == specie.gatto) && cc.accettazione.animale.decedutoNonAnagrafe==false}">${anagraficaAnimale.razza}</c:if>
				<c:if test="${cc.accettazione.animale.decedutoNonAnagrafe==true}">${anagraficaAnimale.razza}</c:if>
				<c:if test="${cc.accettazione.animale.lookupSpecie.id == specie.sinantropo && cc.accettazione.animale.decedutoNonAnagrafe==false}">${cc.accettazione.animale.specieSinantropoString} - ${cc.accettazione.animale.razzaSinantropo}</c:if>
    		   </td>  	
	<td><i>Sesso</i></td>
	<td>${cc.accettazione.animale.sesso }</td>
	</tr>
	
	<tr>
	<td><i>Taglia</i></td>
	<td>${anagraficaAnimale.taglia}</td>
	<td><i>Mantello</i></td>
	<td>${anagraficaAnimale.mantello}</td>
	</tr> 
	
		<tr>
	<td><i>Sterilizzato</i></td>
	<td>${anagraficaAnimale.sterilizzato}</td>
	<td><i>Stato attuale</i></td>
	<td>${anagraficaAnimale.statoAttuale}</td>
	</tr> 
	
	
	<tr>
<c:choose>
<c:when test="${cc.accettazione.animale.lookupSpecie.id==3}">
<td><i>Et�</i></td>
<td><fmt:formatDate type="date" value="${cc.accettazione.animale.dataNascita }" pattern="dd/MM/yyyy" var="dataNascita"/>
${cc.accettazione.animale.eta} <c:if test="${dataNascita}">(${dataNascita})</c:if>
</td>
</c:when>
<c:otherwise>
<td><i>Data nascita</i></td>
<td><fmt:formatDate type="date" value="${cc.accettazione.animale.dataNascita }" pattern="dd/MM/yyyy" var="dataNascita"/>
${dataNascita}</td>
</c:otherwise></c:choose> 

<c:choose>
        	<c:when test="${cc.accettazione.animale.decedutoNonAnagrafe == true}">						
				<fmt:formatDate type="date" value="${cc.accettazione.animale.dataMorte}" pattern="dd/MM/yyyy" var="dataMorte"/>
			</c:when>
			<c:otherwise>
				<fmt:formatDate type="date" value="<%=dataEvento%>" pattern="dd/MM/yyyy" var="dataMorte"/>
			</c:otherwise>	
		</c:choose>
		
<td><i>Data del decesso</i></td>
<td>${dataMorte} - <c:choose>
					<c:when test="${cc.accettazione.animale.decedutoNonAnagrafe == true}">						
						${cc.accettazione.animale.dataMorteCertezza}
					</c:when>
					<c:otherwise>
						<%=dataMorteCertezza%>
					</c:otherwise>	
				</c:choose>	</td>
</tr>

<tr><td></td>
<td></td>
<td><i>Probabile causa del decesso</i></td>
<td>
	<c:choose>
		<c:when test="${cc.accettazione.animale.decedutoNonAnagrafe}">
	    	${cc.accettazione.animale.causaMorte.description}
	    </c:when>
	    <c:otherwise>
	    	<%=decessoValue%>
	    </c:otherwise>
	</c:choose></td>
</tr>
	
	</table>
	
	<br/>
<c:if test="${cc.accettazione.animale.decedutoNonAnagrafe==true && cc.accettazione.randagio==true}">	
	<center><h2>Ritrovamento carcassa</h2></center>
	<table width="100%" class="bordo">
		<col width="25%"><col width="25%">
	<tr>
	<td><i>Comune</i></td>
	<td>${cc.accettazione.animale.comuneRitrovamento.description}</td>
	<td><i>Provincia</i></td>
	<td>${cc.accettazione.animale.provinciaRitrovamento}</td>
	</tr>
	<tr>
	<td><i>Indirizzo</i></td>
	<td>${cc.accettazione.animale.indirizzoRitrovamento}</td>
	<td><i>Note</i></td>
	<td>${cc.accettazione.animale.noteRitrovamento}</td>
	</tr>
</table>
<br/><br/>
</c:if>



<br/>
<center><h2>Dati del Proprietario</h2></center>
	<table width="100%" class="bordo">
		<tr>
			<td><i>Cognome e nome:</i></td>
			<td>${cc.accettazione.proprietarioCognome} ${cc.accettazione.proprietarioNome}</td>
		</tr>
		<tr>
			<td><i>Codice Fiscale:</i></td>
			<td>${cc.accettazione.proprietarioCodiceFiscale}</td>
		</tr>
		<tr>
			<td><i>Comune di residenza:</i></td>
			<td>${cc.accettazione.proprietarioComune}</td>
		</tr>
		<tr>
			<td><i>Indirizzo:</i></td>
			<td>${cc.accettazione.proprietarioIndirizzo}</td>
		</tr>
		<tr>
			<td><i>Telefono:</i></td>
			<td>${cc.accettazione.proprietarioTelefono}</td>
		</tr>
	</table>

	<center><h2>Fenomeni tanatologici e diagnosi epoca della morte</h2></center>
	<table width="100%" class="bordo">
		<col width="25%">
		
		<tr>
		<td class="layout"><b>Modalit� di conservazione</b></td>
		<td class="layout"><c:out value="${a.lmc.description }" /></td>
		<c:if test="${a.temperaturaConservazione != null}">
				<td class="layout">	<i>Temperatura di conservazione</i>
					<c:out value="${a.temperaturaConservazione}" /></td>
			</c:if>
	</tr>

	<tr>
		<td class="layout"><b>Fenomeni cadaverici</b></td>
		<td class="layout"><c:forEach items="${listFenomeniCadaverici}" var="fc">
				<c:set var="fcTemp" scope="request" value="${fc}" />
				<c:set var="livello" scope="request" value="0" />
				<c:import url="../vam/cc/autopsie/ricorsioneFcDetail.jsp" />
			</c:forEach></td>
		</tr>
	</table>
	
	<br/>
	<center><h2>Esame morfologico degli organi</h2></center>
	<table width="100%" class="bordo">
	<col width="33%%">
		<c:forEach items="${organi}" var="autopsia_op">
			<tr>
				<td class="layout">${autopsia_op.lookupOrganiAutopsia.description }</td>
				<td class="layout">${autopsia_op.descrizioneReferto}</td>
				<td class="layout">${autopsia_op.noteReferto}</td>
			</tr>
		</c:forEach>
	</table>
	
	
	
<%	Iterator<Entry<String, Set<String>>> iter = a.getDettaglioEsamiForJspDetail().entrySet().iterator();
	if (iter.hasNext())
	{ 
%>
	    				<br/>
			<center><h2>Sezione Dettaglio esami</h2></center>


			<table width="100%" class="bordo">
				<tr>
					<td style="width: 15%" class="blue"><b>Organo da analizzare</b></td>
					<td style="width: 15%" class="blue"><b>Tipologia Esame</b></td>
					<td style="width: 40%" class="blue"><b>Dettaglio Richiesta</b></td>
					<td style="width: 30%" class="blue"><b>Esiti</b></td>
				</tr>

				<c:set var="i" value="1" />
				<% while(iter.hasNext())
	    				{
	    					Entry<String, Set<String>> e = iter.next();
	    			%>
				<tr">
					<td class="layout"><%=e.getKey().split(";")[0].split("---")[1]%> <input
						type="hidden" id="organo${i}"
						value="<%=e.getKey().split(";")[0].split("---")[0]%>" /> <input
						type="hidden" id="organoDesc${i}"
						value="<%=e.getKey().split(";")[0].split("---")[1]%>" /></td>
					<td class="layout"><%=e.getKey().split(";")[1].split("---")[1]%> <input
						type="hidden" id="tipo${i}"
						value="<%=e.getKey().split(";")[1].split("---")[0]%>" /> <input
						type="hidden" id="tipoDesc${i}"
						value="<%=e.getKey().split(";")[1].split("---")[1]%>" /></td>
					<td class="layout"><%=((e.getKey().split(";").length>2)?(e.getKey().split(";")[2]):(""))%>
											</td>
					<td class="layout"><input type="hidden" name="esitiTemp${i}"
						id="esitiTemp${i}" value="<%=e.getValue()%>" /> <input
						type="hidden" name="esiti${i}" id="esiti${i}"
						value="<%=e.getValue()%>" /> <%=e.getValue()%></td>
				</tr>
				<c:set var="i" value="${i+1}" />
				<%
	    			} %>
	    			</table>
	    			<%}
	    				
	    			%>


		  	<c:if test="${not empty cc.esameIstopatologicos}">
	<br/>
	<center><h2>Sezione Esami Istopatologici</h2></center>
	<table width"100%" class="bordo">
		
		<tr>
			<td style="width: 10%" class="blue"><b>Data Richiesta</b></td>
			<td style="width: 10%" class="blue"><b>Data Esito</b></td>
			<td style="width: 10%" class="blue"><b>Numero</b></td>
			<td style="width: 35%" class="blue"><b>Sede Lesione</b></td>
			<td style="width: 35%" class="blue"><b>Diagnosi</b></td>
		</tr>

		<c:set var="i" value='1' />
		<c:forEach items="${cc.esameIstopatologicos}" var="ei">

			<tr>
				<td class="layout"><fmt:formatDate type="date" value="${ei.dataRichiesta}"
						pattern="dd/MM/yyyy" var="dataRichiesta" /> <c:out
						value="${dataRichiesta}" /></td>
				<td class="layout"><fmt:formatDate type="date" value="${ei.dataEsito}"
						pattern="dd/MM/yyyy" var="dataEsito" /> <c:out
						value="${dataEsito}" /></td>
				<td class="layout"><c:out value="${ei.numero}" /></td>
				<td class="layout"><c:out value="${ei.sedeLesione }" /></td>
				<td class="layout">${ei.whoUmana } ${ei.diagnosiNonTumorale }</td>
			</tr>

			<c:set var="i" value='${i+1}' />
		</c:forEach>

	</table>
	</c:if>
	
<br/>

	<c:if test="${not empty a.cmf}">
<center><h2>Cause del decesso Finale</h2></center>
	<table width="100%" class="bordo">
<tr><td style="width: 80'%" class="blue"><b>Descrizione</b></td>
<td style="width: 20%" class="blue"><b>Provata/Sospetta</b></td></tr>

		<c:set var="i" value='1' />
		<c:forEach items="${a.cmf}" var="cmf">
			<tr>
				<td class="layout"><i><c:out value="${cmf.lookupCMF.description }" /></i>
				</td>
				<td class="layout"><c:choose>
						<c:when test="${cmf.provata == true}">
							<c:out value="(Provata)" />
						</c:when>
						<c:otherwise>
							<c:out value="(Sospetta)" />
						</c:otherwise>
					</c:choose></td>
			</tr>

			<c:set var="i" value='${i+1}' />
		</c:forEach>
	</table>
	</c:if>
	
	<br/>
	<center><h2>Diagnosi</h2></center>
	<table width="100%" class="bordo">
	<col width="25%"><col width="25%">
	<tr><td><i>Diagnosi anatomo patologica</i></td>
			<td>${a.diagnosiAnatomoPatologica }</td>
	</tr>
		<tr><td><i>Diagnosi definitiva</i></td>
			<td>${a.diagnosiDefinitiva }</td>
	</tr>
	
		<tr><td><i>Quadro patologico prevalente</i></td>
			<td>${a.patologiaDefinitiva.description}</td>
	</tr>
	
	
	
	</table>
	<br/><br/><br/>
		
		<table width="100%">
		<col width="50%">
		<tr><td><center>Data</center></td>
		<td><center>Firma</center></td></tr>
		<tr><td><center><fmt:formatDate type="date" value="<%= new java.util.Date() %>" pattern="dd/MM/yyyy"/></center></td>
	 <td><center>_______________________</center></td></tr>
        	
	
	
	</table>
	
	<br/>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
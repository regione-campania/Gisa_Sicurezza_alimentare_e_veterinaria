<%@page import="it.us.web.action.GenericAction"%>
<%@page import="it.us.web.bean.vam.CartellaClinica"%>
<%@page import="it.us.web.bean.vam.lookup.LookupOperazioniAccettazione"%>
<%@page import="it.us.web.bean.vam.Animale"%>
<%@page import="it.us.web.util.vam.CaninaRemoteUtil"%>
<%@page import="it.us.web.bean.BUtente"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.naming.InitialContext"%>
<%@ taglib uri="/WEB-INF/ustl.tld" prefix="us" %>
<script type='text/javascript' src='dwr/engine.js'></script>
<script type='text/javascript' src='dwr/interface/TestBdr.js'></script>
<script type='text/javascript' src='dwr/util.js'></script>
<script language="JavaScript" type="text/javascript" src="js/vam/bdr/registrazioniInterattive.js"></script>

<!-- <script language="JavaScript" type="text/javascript" src="js/vam/bdr/comunicazioniBduVam.js"></script>-->
<script language="JavaScript" type="text/javascript" src="js/vam/bdr/comunicazioniBduVamCambioDominio.js"></script>

<jsp:include page="/jsp/vam/cc/menuCC.jsp"/>

<h4 class="titolopagina">
     		Dimissioni
    </h4>
    
Operazione da registrare: ${cc.destinazioneAnimale.description }

<div id="continue_buttons" style="visibility: hidden;">
<br/><br/>
<input type="button" value="Inserimento Registrazioni Completato" onclick="javascript:if(registrazioneInserita('${animale.identificativo}',${animale.lookupSpecie.id},${idTipoRegBdr})){attendere(),logoutFromCanina( inserimentoRegistrazioniCompletato );}" />
</br></br>
<div id="divToolTip" style="background-color:#FFFFFF; border:2px solid black; 
border-radius:3px; color:red; font-family:Tahoma; font-size:12px; padding:2px 2px 2px 2px; 
max-width:350px; display:none;"></div>  
</div>
<br/><br/>

<%
		Context ctx = new InitialContext();
		javax.sql.DataSource ds = (javax.sql.DataSource)ctx.lookup("java:comp/env/jdbc/bduS");
		Connection connection = ds.getConnection();
		GenericAction.aggiornaConnessioneApertaSessione(request);
		
		Boolean adozioneFuoriAsl =         (Boolean)request.getAttribute("adozioneFuoriAsl");
		Boolean adozioneVersoAssocCanili = (Boolean)request.getAttribute("adozioneVersoAssocCanili");

%>
		
<us:can f="BDR" sf="ADD" og="MAIN" r="r" >
	<iframe 
		id="myFrame" name="myFrame"  frameborder="0"  vspace="0"  
		hspace="0" marginwidth="0" marginheight="0"
		width="95%"  scrolling=yes  height="800"
		style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; Z-INDEX: 999; BORDER-LEFT: black 1px solid; BORDER-BOTTOM: black 1px solid;"
		src="<%=CaninaRemoteUtil.getLoginUrl( (BUtente)session.getAttribute( "utente" ), null, (Animale)request.getAttribute("animale"), (LookupOperazioniAccettazione)request.getAttribute("operazione"), ((CartellaClinica)session.getAttribute("cc")).getAccettazione(), null, connection,request ,"2", adozioneFuoriAsl, adozioneVersoAssocCanili) %>">
	</iframe>
</us:can>

<script type="text/javascript">
var domain = window.location.hostname;
domain = domain.substring(domain.indexOf('.')+1);
document.domain = domain;
function logoutFromCanina(nextFunction  )
{
	document.getElementById('myFrame').src='<%=CaninaRemoteUtil.getLogoutUrl( (BUtente)session.getAttribute( "utente" ),request ) %>';
	setTimeout( nextFunction, 1000 );
};
function inserimentoRegistrazioniCompletato()
{
	location.href='vam.cc.dimissioni.RegistrazioniInterattiveInserite.us?idTipoRegBdr=${idTipoRegBdr}';
}

</script>

<%
connection.close();
GenericAction.aggiornaConnessioneChiusaSessione(request);
%>
<script>
dwr.engine.setErrorHandler(errorHandler);
dwr.engine.setTextHtmlHandler(errorHandler);

function errorHandler(message, exception){
    //Session timedout/invalidated

    if(exception && exception.javaClassName== 'org.directwebremoting.impl.LoginRequiredException'){
        alert(message);
        //Reload or display an error etc.
        window.location.href=window.location.href;
    }
    else
        alert('Errore Nella Chiamata Remota : '+exception.javaClassName);
 }
</script>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*,org.aspcfs.modules.osm.base.*,org.aspcfs.modules.contributo.base.*,org.aspcfs.modules.audit.base.*,org.aspcfs.utils.web.*,org.aspcfs.utils.*" %>
<%@page import="org.postgresql.jdbc2.TimestampUtils"%>
<jsp:useBean id="OrgDetails" class="org.aspcfs.modules.osm.base.Organization" scope="request"/>
<jsp:useBean id="ContributoList" class="org.aspcfs.modules.contributo.base.ContributoList" scope="request"/>
<jsp:useBean id="ContributoListInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<jsp:useBean id="Specie" class="org.aspcfs.utils.web.LookupList" scope="request"/>

<head>
	<link rel="stylesheet" type="text/css" href="css/jmesa.css"></link>
	<script type="text/javascript" src="javascript/jquery-1.3.min.js"></script>
	<script type="text/javascript" src="javascript/jquery.bgiframe.pack.js"></script>
	<script type="text/javascript" src="javascript/jquery.jmesa.js"></script>
	<script type="text/javascript" src="javascript/jmesa.js"></script>
</head>

<%@ include file="../utils23/initPage.jsp" %>
<%@ include file="../utils23/initPopupMenu.jsp" %>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/spanDisplay.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popURL.js"></SCRIPT>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popCalendar.js"></script>
<script language="JavaScript" type="text/javascript">
  <%-- Preload image rollovers for drop-down menu --%>
  

  function checkForm( form )
  {
	if( form.data.value == '' || form.id_specie.value == "-1" )
	{
		alert( "Selezionare una Data ed una Specie" );
		return false;
	}
	else
	{
		return confirm('Sicuro di voler aggiungere l\'elemento al diario?');
	}
  };
</script>

<table class="trails" cellspacing="0">
	<tr>
		<td>
			<a href="Osm.do"><dhv:label name="osm.osm">Accounts</dhv:label></a> > 
			<a href="Osm.do?command=Search"><dhv:label name="stabilimenti.SearchResults">Search Results</dhv:label></a> >
			<a href="Osm.do?command=Details&orgId=<%=OrgDetails.getOrgId()%>"><dhv:label name="osm.details">Account Details</dhv:label></a> >
			Diario di Macellazione
		</td>
	</tr>
</table>

<dhv:container name="osm" selected="diario_macellazione" object="OrgDetails" param='<%= "orgId=" + OrgDetails.getOrgId() %>' style="sidetabs" >
	
	<dhv:evaluate if="<%= !OrgDetails.isTrashed() %>">
		<dhv:permission name="osm-osm-diario-add">
		
			<form name="newDiario" action="StabDiarioMacellazione.do?command=Add" method="post" onsubmit="javascript:return checkForm(this);">
				<fieldset>
					<legend>Aggiungi</legend>
					<table >
						<tr>
							<td>
								data:<zeroio:dateSelect field="data" form="newDiario" showTimeZone="false" />
								specie:<%=Specie.getHtmlSelect( "id_specie", "-1" ) %>
								<input type="hidden" name="orgId" value="<%=OrgDetails.getOrgId() %>" />
								<input type="submit" value="Aggiungi">
							</td>
						</tr>
					</table>
				</fieldset>
			</form>
		
		</dhv:permission>
	</dhv:evaluate>

	<p>
		<font color="red" ><%=toHtmlValue( (String)request.getAttribute( "messaggio" ) ) %></font>
	</p>
		
	<form name="diarioForm" action="StabDiarioMacellazione.do?command=List">
	<input type="hidden" name="orgId" value="<%=OrgDetails.getOrgId() %>">
		<%=request.getAttribute( "tabella" )%>
	</form>
	
	<script type="text/javascript">
		function onInvokeAction(id) {
		    $.jmesa.setExportToLimit(id, '');
		    $.jmesa.createHiddenInputFieldsForLimitAndSubmit(id);
		}
		function onInvokeExportAction(id) {
		    var parameterString = $.jmesa.createParameterStringForLimit(id);
		    location.href = 'StabDiarioMacellazione.do?command=List&orgId=<%=OrgDetails.getOrgId() %>&' + parameterString;
		}
	</script>
  
</dhv:container>









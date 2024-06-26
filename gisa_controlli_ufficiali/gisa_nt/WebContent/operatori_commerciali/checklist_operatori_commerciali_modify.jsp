<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>

<%@page import="org.aspcfs.utils.web.*"									%>
<%@page import="org.aspcfs.checklist.base.*"							%>
<%@page import="com.darkhorseventures.framework.actions.ActionContext"	%>

<jsp:useBean id="applicationPrefs" class="org.aspcfs.controller.ApplicationPrefs" scope="application"	/>
<jsp:useBean id="checklistList" class="java.util.ArrayList" scope="request"								/>
<jsp:useBean id="auditChecklist" class="java.util.ArrayList" scope="request"							/>
<jsp:useBean id="auditChecklistType" class="java.util.ArrayList" scope="request"						/>
<jsp:useBean id="ControlloUfficiale" class="org.aspcfs.modules.vigilanza.base.Ticket" scope="request"	/>
<jsp:useBean id="TicketDetails" class="org.aspcfs.modules.vigilanza.base.Ticket" scope="request"		/>
<jsp:useBean id="typeList" class="org.aspcfs.utils.web.CustomLookupList" scope="request"				/>
<jsp:useBean id="OrgDetails" class="org.aspcfs.modules.operatori_commerciali.base.Organization" scope="request"		/>
<jsp:useBean id="Audit" class="org.aspcfs.checklist.base.Audit" scope="request"						/>
<jsp:useBean id="OrgCategoriaRischioList" class="org.aspcfs.utils.web.LookupList" scope="request"		/>

<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popCalendar.js">		</script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popLookupSelect.js">	</script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/spanDisplay.js">		</script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/div.js">				</script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/checkDate.js">			</script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/checkNumber.js">		</script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/checklist_controlli_modify.js"></script>

<%@ include file="../utils23/initPage.jsp" %>

<link rel="stylesheet" type="text/css" href="css/checklist.css" >
<link rel="stylesheet" type="text/css" href="css/cssDomanda.css" >

<body onload="ultimaDomanda(<%=Audit.getIdLastDomanda() %>);inizializzaPunteggio(<%=Audit.getLivelloRischio() %>);aggiornaCategoria();">
<form name="addAccountAudit"  method="post" action="CheckListOperatoriCommerciali.do?command=Update&auto-populate=true&return<%= request.getParameter("return") %>" onSubmit="return checkForm();">
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td width="100%">
  <a href="OperatoriCommerciali">Operatori Commerciali</a> > 
  <a href="OperatoriCommerciali?command=Search"><dhv:label name="accounts.SearchResults">Search Results</dhv:label></a> >
  <a href="OperatoriCommerciali?command=Details&orgId=<%= OrgDetails.getOrgId() %>">Scheda Operatore Commerciale</a> >
  <a href="OperatoriCommerciali?command=ViewVigilanza&orgId=<%=OrgDetails.getOrgId()%>"><dhv:label name="">Controlli Ufficiali</dhv:label></a> >
      <a href="OperatoriCommercialiVigilanza.do?command=TicketDetails&id=<%= request.getAttribute("idCon")%>&orgId=<%=OrgDetails.getOrgId()%>"><dhv:label name="">Controllo Ufficiale</dhv:label></a> >
  <a href="CheckListOperatoriCommerciali?command=View&id=<%= Audit.getId() %>"><dhv:label name="accounts.Audit">Check List</dhv:label></a> >
  <dhv:label name="audit.modificaAudit">Modifica Check List</dhv:label>
</td>
</tr>
</table>
<%-- End Trails --%>

<dhv:container name="operatoricommerciali" selected="audit" object="OrgDetails" param='<%= "orgId=" + OrgDetails.getOrgId() %>'>


  <input type="button" value="Annulla" onClick="window.location.href='OperatoriCommercialiVigilanza.do?command=TicketDetails&id=<%= request.getAttribute("idCon")%>&orgId=<%=OrgDetails.getOrgId()%>';this.form.dosubmit.value='false';" />

<br/>
<br/>


<%@ include file="../checklist/checklist_modify.jsp" %>



  <input type="button" value="Annulla" onClick="window.location.href='OperatoriCommercialiVigilanza.do?command=TicketDetails&id=<%= request.getAttribute("idCon")%>&orgId=<%=OrgDetails.getOrgId()%>';this.form.dosubmit.value='false';" />

</dhv:container>
</form>
</body>
<script>

if(document.getElementById("btnSaveTemp")!=null)
document.getElementById("btnSaveTemp").disabled="";
document.getElementById("btnSave2").disabled="";
document.getElementById("btnSave").disabled="";
</script>

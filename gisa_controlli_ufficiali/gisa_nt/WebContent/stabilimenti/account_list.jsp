
  
 <%@ page contentType="application/vnd.ms-excel" %>
  
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*,org.aspcfs.modules.stabilimenti.base.*, org.aspcfs.modules.base.*" %>
<jsp:useBean id="OrgList" class="org.aspcfs.modules.stabilimenti.base.OrganizationList" scope="request"/>
<jsp:useBean id="SearchOrgListInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<jsp:useBean id="SiteIdList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="OrgCategoriaRischioList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="impianto" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="statoLab" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="TypeSelect" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>


<table>

<tr><th colspan="7">Export Stabilimenti</th></tr>


<tr>
<th>Ragione Sociale</th>
<th>Stato Stabilimento</th>
<th>Sezione</th>
<th>Tipo Impianto</th>
<th>A.S.L</th>
<th>Partita IVA</th>
<th>Codice Istat</th>

</tr>

<%

Iterator it=OrgList.iterator();

while(it.hasNext()){
Organization org=(Organization) it.next();
%>
<tr>

<td><%=org.getName() %></td>
<td>la devo settare</td>
<td><%=org.getCategoria() %></td>
<td> <%=impianto.getSelectedValue(org.getImpianto())%></td>
<td>la devo settare</td>
<td>la devo settare</td>
<td>la devo settare</td>
</tr>

<%} %>


</table>
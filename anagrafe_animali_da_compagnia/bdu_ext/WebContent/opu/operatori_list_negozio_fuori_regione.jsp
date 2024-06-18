<%@page import="java.math.BigDecimal"%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*,java.text.DateFormat,org.aspcfs.modules.accounts.base.*,org.aspcfs.modules.opu.base.*,org.aspcfs.modules.contacts.base.*,org.aspcfs.modules.base.Constants" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<jsp:useBean id="SiteIdList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="TypeSelect" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="ComuniList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="tipologiaList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="jsonArray" class="org.json.JSONArray" scope="request" />

<%@ include file="../initPage.jsp" %>
<%-- Initialize the drop-down menus --%>
<%@ include file="../initPopupMenu.jsp" %>

<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/spanDisplay.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popLookupSelect.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popURL.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/modalWindow.js"></SCRIPT>
<script type="text/javascript">

function win_open_detail_proprietario(idOp){
	loadModalWindow();
  var win= window.open('OperatoreAction.do?command=Details&opId='+idOp+'&popup=true','','scrollbars=1,width=800,height=500,left=400,top=200');
  if (win != null) { var timer = setInterval(function() { if(win.closed) { clearInterval(timer); loadModalWindowUnlock();
  document.getElementById('modalWindow').style.display = 'none';
  } }, 1000); }
}



</script>

<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>

<%
String popup=isPopup(request)?"&popup=true":"";
String linkSearch="OperatoreAction.do?command=SearchForm"+popup;
%>

<td>
<% if(isPopup(request)){ %>
<dhv:label name="opu.operatore"></dhv:label> >
<% }else{ %>
<a href=<%=linkSearch%> ><dhv:label name="opu.operatore"></dhv:label></a> >
<% } %>

<dhv:label name="accounts.SearchResults">Search Results</dhv:label>
</td>
</tr>
</table>
<%-- End Trails --%>
<dhv:evaluate if="<%= (User.getRoleType() > 0) %>" >
<table class="note" cellspacing="0">
  <tr>
    <th><img src="images/icons/stock_about-16.gif" border="0" align="absmiddle"/></th>
    <td><dhv:label name="accounts.manage">Select an account to manage.</dhv:label></td>
  </tr>
</table>
</dhv:evaluate>

<dhv:pagedListStatus title='<%= showError(request, "actionError") %>' object="SearchOrgListInfo"/>
<% int columnCount = 0; %>
<table cellpadding="8" cellspacing="0" border="0" width="100%" class="pagedList">
  <tr>
  <dhv:evaluate if="<%= isPopup(request) %>">
    <th nowrap="nowrap"></th>
   </dhv:evaluate>
    <th nowrap <% ++columnCount; %>>
      <strong><dhv:label name="opu.operatore.ragione_sociale"></dhv:label></a></strong>
      <%= SearchOrgListInfo.getSortIcon("o.name") %> 
    </th>
    
   
            <th nowrap <% ++columnCount; %>>
         <dhv:label name="opu.operatore.piva"></dhv:label>
		</th>
		<th nowrap <% ++columnCount; %>>
          Sede operativa
        </th>
       
       
    
       
  </tr>
<%
	for (int i = 0; i < jsonArray.length(); i++)
	{
	    int rowid = 0;
		i++;
		JSONObject jsonObj = jsonArray.getJSONObject(i);
	 	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		while (itStab.hasNext())
		{
			Stabilimento thisStab = (Stabilimento)itStab.next();
			Iterator itLinee = thisStab.getListaLineeProduttive().iterator();
			    	
			Connection conn = GestoreConnessioni.getConnection();
					
		    i++;
		    rowid = (rowid != 1 ? 1 : 2);
		    LineaProduttiva lp = (LineaProduttiva) itLinee.next();
%>
				<tr class="row<%= rowid %>">
			  		<dhv:evaluate if="<%= isPopup(request) %>">
						<td nowrap><a href="AnimaleAction.do?command=ScegliOperatore&tipologiaSoggetto=<%=(String)request.getAttribute("TipologiaSoggetto") %>&opId=<%=lp.getId()%>">Seleziona</a></td>
					</dhv:evaluate>

					<dhv:evaluate if="<%=User.getRoleId() != new Integer(ApplicationProperties.getProperty("ID_RUOLO_LLP"))%>">
						<dhv:evaluate if="<%= isPopup(request) %>">
						<td nowrap>
						<%--  <a onclick="window.open('OperatoreAction.do?command=Details&opId=<%=lp.getId()%>&popup=<%= isPopup(request) %>','','width=800,height=500,left=400,top=200');return false;" href="OperatoreAction.do?command=Details&opId=<%=lp.getId()%>&popup=<%= isPopup(request) %>"><%= toHtml(ragione_sociale) %></a><%=chiuso%><%=canile_bloccato%>
 --%>				  
  <a onclick="win_open_detail_proprietario(<%=lp.getId()%>);return false;"><%= toHtml(ragione_sociale) %></a><%=chiuso%><%=canile_bloccato%>
 
 				   	</dhv:evaluate>
				    	<dhv:evaluate if="<%= !isPopup(request) %>">
				    	<td nowrap> <a href="OperatoreAction.do?command=Details&opId=<%=lp.getId()%>&popup=<%= isPopup(request) %>"><%= toHtml(ragione_sociale) %></a><%=chiuso%><%=canile_bloccato%>
				    	</dhv:evaluate>
			    	</dhv:evaluate>
			    	<dhv:evaluate if="<%=User.getRoleId() == new Integer(ApplicationProperties.getProperty("ID_RUOLO_LLP"))%>">
			    		<td nowrap> <%= toHtml(ragione_sociale) %><%=chiuso%><%=canile_bloccato%>
			    	</dhv:evaluate>
			       	</td>
				    <td nowrap>  <%=toHtml(tipologiaList.getSelectedValue(lp.getIdAttivita()))%>
					</td>
					<td nowrap>
			    	<%= ( (lp.getIdRelazioneAttivita() != LineaProduttiva.idAggregazionePrivato) ?  toHtml(thisOrg.getPartitaIva()) : " -- ") %>
			       </td>
			    	<td nowrap>
			       	<%= toHtml(thisOrg.getCodFiscale()) %>
					</td>
			  		<td nowrap>
					<%=thisStab.getSedeOperativa().toString() %>
					</td> 
					<td nowrap>
			      	<%=toDateasString(thisOrg.getEntered())%>
					</td>
					<td nowrap>
					<%
					if(lp.getIdRelazioneAttivita() == LineaProduttiva.idAggregazioneCanile){
						String colorFont = "green";
						if(thisOrg.getIndice()>=80 && thisOrg.getIndice()<100)
							colorFont="orange";
						else if(thisOrg.getIndice()>=100){
							colorFont="red";
						}
						String indice ="" + new BigDecimal(thisOrg.getIndice()).setScale(2 , BigDecimal .ROUND_UP).doubleValue();
						colorFont = "green";
						double occupazioneTotale     = 0;		
						if(lp!=null)
							occupazioneTotale     = (((CanileInformazioni) lp).getMqDisponibili());
						double percentuale = 0;
						if(occupazioneTotale>0 && thisOrg.getOccupazioneAttuale()>0)
							percentuale = (thisOrg.getOccupazioneAttuale()/occupazioneTotale)*100;
						percentuale = new BigDecimal(percentuale).setScale(2 , BigDecimal .ROUND_UP).doubleValue();
						if(percentuale>=80 && percentuale<100)
							colorFont="orange";
						else if(percentuale>=100)
							colorFont="red";
					%>
					<% if(thisOrg.getOccupazioneAttuale()>0){ %>
						<b><font color="<%=colorFont%>"><%=thisOrg.getOccupazioneAttuale()%> mq <%if(percentuale >0){ out.println(" (" + percentuale + " %)");} %></font></b>
					<% }else{ %>
					<b><font color='red'>N.D.</font></b>
					<%} 
					}else{
						out.print("N.D.");
					} %>
					</td>
					
					<td nowrap>
<%
					if(lp.getIdRelazioneAttivita() == LineaProduttiva.idAggregazioneCanile)
					{
						String colorFont = "green";
						double limiteNumeroCaniVivi     = Integer.parseInt(ApplicationProperties.getProperty("limite_numero_cani_vivi"));		
						double percentuale = 0;
						if(limiteNumeroCaniVivi>0 && thisOrg.getNumeroCaniVivi()>0)
							percentuale = (thisOrg.getNumeroCaniVivi()/limiteNumeroCaniVivi)*100;
						percentuale = new BigDecimal(percentuale).setScale(2 , BigDecimal .ROUND_UP).doubleValue();
						if(percentuale>=80 && percentuale<100)
							colorFont="orange";
						else if(percentuale>=100)
							colorFont="red";
					%>
					<% if(thisOrg.getNumeroCaniVivi()>0){ %>
						<b><font color="<%=colorFont%>"><%=thisOrg.getNumeroCaniVivi()%> <%if(percentuale >0){ out.println(" (" + percentuale + " %)");} %></font></b>
					<% }else{ %>
					<b><font color='red'>N.D.</font></b>
					<%} 
					}else{
						out.print("N.D.");
					} %>
					</td>

			  	</tr>
			<%	}
			  GestoreConnessioni.freeConnection(conn);	
		%>
</table>
<br />
<dhv:pagedListControl object="SearchOrgListInfo" tdClass="row1"/>

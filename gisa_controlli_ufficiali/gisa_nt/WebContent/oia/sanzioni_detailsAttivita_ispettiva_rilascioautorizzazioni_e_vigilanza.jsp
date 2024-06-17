<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*,java.text.DateFormat,org.aspcfs.modules.troubletickets.base.*,com.zeroio.iteam.base.*, org.aspcfs.modules.quotes.base.*,org.aspcfs.modules.base.EmailAddress" %>
<jsp:useBean id="TicketDetails" class="org.aspcfs.modules.sanzioni.base.Ticket" scope="request"/>
<jsp:useBean id="ticketCategoryList" class="org.aspcfs.modules.troubletickets.base.TicketCategoryList" scope="request"/>
<jsp:useBean id="product" class="org.aspcfs.modules.products.base.ProductCatalog" scope="request"/>
<jsp:useBean id="customerProduct" class="org.aspcfs.modules.products.base.CustomerProduct" scope="request"/>
<jsp:useBean id="quoteList" class="org.aspcfs.modules.quotes.base.QuoteList" scope="request"/>
<jsp:useBean id="OrgDetails" class="org.aspcfs.modules.oia.base.OiaNodo" scope="request"/>
<jsp:useBean id="Provvedimenti" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SanzioniAmministrative" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SanzioniPenali" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="Sequestri" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SiteIdList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="causeList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="ticketStateList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="resolutionList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="defectCheck" class="java.lang.String" scope="request"/>
<jsp:useBean id="defect" class="org.aspcfs.modules.troubletickets.base.TicketDefect" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></script>
<script type="text/javascript">

</script>
<%@ include file="../utils23/initPage.jsp" %>
<%String idMacchinetta=""+OrgDetails.getId(); %>
<form name="details" action="OiaSanzioni.do?command=ModifyTicket&idNodo=<%=idMacchinetta %>&auto-populate=true&idNodo=<%=idMacchinetta %>" method="post">
<input type ="hidden" name = "idC" value="<%=request.getAttribute("idC") %>">
<input type ="hidden" name = "idNC" value="<%=request.getAttribute("idNC") %>">
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="Oia.do?command=Home"><dhv:label name="">Autorit� Competenti</dhv:label></a> > 

<a href="Oia.do?command=Details&idNodo=<%=idMacchinetta %>&orgId=<%=TicketDetails.getOrgId()%>"><dhv:label name="">Scheda Dipartimento</dhv:label></a> >
<a href="OiaVigilanza.do?command=ViewVigilanza&idNodo=<%=idMacchinetta %>&orgId=<%=TicketDetails.getOrgId()%>"><dhv:label name="">Controlli Ufficiali</dhv:label></a> >
<a href="OiaVigilanza.do?command=TicketDetails&idNodo=<%=idMacchinetta %>&id=<%= request.getAttribute("idC")%>&orgId=<%=TicketDetails.getOrgId()%>"><dhv:label name="">Controllo Ufficiale</dhv:label></a> >
<a href="OiaNonConformita.do?command=TicketDetails&idNodo=<%=idMacchinetta %>&id=<%= request.getAttribute("idNC")%>&orgId=<%=TicketDetails.getOrgId()%>"><dhv:label name="">Non Conformit� Rilevata</dhv:label></a> >
 
<%--a href="Accounts.do?command=ViewSanzioni&orgId=<%=TicketDetails.getOrgId() %>"><dhv:label name="">Sanzioni Amministrative</dhv:label></a> --%>
<%
	if (defectCheck != null && !"".equals(defectCheck.trim())) {
%>
  <a href="OiaSanzioni.do?command=TicketDetails&idNodo=<%=idMacchinetta %>&Id=<%=TicketDetails.getId()%>&orgId=<%=OrgDetails.getOrgId() %>"><dhv:label name="tickets.defects.viewDefects">View Defects</dhv:label></a> >
  <a href="OiaSanzioniDefects.do?command=Details&defectId=<%= defectCheck %>"><dhv:label name="tickets.defects.defectDetails">Defect Details</dhv:label></a> >
<%
  	} else {
  %>
<%
	if ("yes"
				.equals((String) session.getAttribute("searchTickets"))) {
%>
  <a href="OiaSanzioni.do?command=SearchTicketsForm"><dhv:label name="tickets.searchForm">Search Form</dhv:label></a> >
  <a href="OiaSanzioni.do?command=SearchTickets"><dhv:label name="accounts.SearchResults">Ricerca Dipartimenti/Distretti</dhv:label></a> >
<%
  	} else {
  %> 
 <%--  <a href="Accounts.do?command=ViewSanzioni&orgId=<%=OrgDetails.getOrgId()%>"><dhv:label name="sanzioni.visualizza">Visualizza Sanzioni Amministrative</dhv:label></a> > --%>
<%
   	}
   %>
<%
	}
%>


<dhv:label name="sanzioni.dettagli">Scheda Sanzione Amministrativa</dhv:label>
</td>
</tr>
</table>
<%-- End Trails --%>
<%
	String param1 = "id=" + TicketDetails.getId() + "&orgId="+TicketDetails.getOrgId()+"&idNC="+request.getAttribute("idNC");
%>
<dhv:container name="asl" selected="vigilanza" object="OrgDetails" param='<%= "orgId=" + TicketDetails.getOrgId()+"&idNodo="+idMacchinetta %>' hideContainer='<%= isPopup(request) || (defectCheck != null && !"".equals(defectCheck.trim())) %>'>

	<%-- @include file="ticket_header_include.jsp" --%>
	
	
	<%UserBean user=(UserBean)session.getAttribute("User");
  
 
  

	%>
	<%
		if (TicketDetails.isTrashed()) {
	%>
	<dhv:permission name="oia-oia-sanzioni-delete">
		<input type="button"
			value="Ripristina"
			onClick="javascript:this.form.action='OiaSanzioni.do?command=Restore&idNodo=<%=idMacchinetta %>&id=<%= TicketDetails.getId()%>';submit();">
	</dhv:permission>
	<%
		} else if (TicketDetails.getClosed() != null) {
	%>
	<dhv:permission name="reopen-reopen-view">
		<input type="button"
			value="<dhv:label name="button.reopen">Reopen</dhv:label>"
			onClick="javascript:this.form.action='OiaSanzioni.do?command=ReopenTicket&idNodo=<%=idMacchinetta %>&id=<%= TicketDetails.getId()%><%= (defectCheck != null && !"".equals(defectCheck.trim())?"&defectCheck="+defectCheck:"") %>';submit();">
	</dhv:permission>

		<%
		} else {
	%>
	<dhv:permission name="oia-oia-sanzioni-edit">
		<input type="button"
			value="Modifica"
			onClick="javascript:this.form.action='OiaSanzioni.do?command=ModifyTicket&idNodo=<%=idMacchinetta %>&auto-populate=true<%= (defectCheck != null && !"".equals(defectCheck.trim())?"&defectCheck="+defectCheck:"") %>';submit();">
	</dhv:permission>
	<%--
      <dhv:permission name="quotes-view">
        <dhv:evaluate if="<%= TicketDetails.getProductId() > 0 %>">
          <input type="button" value="<dhv:label name="ticket.generateQuote">Generate Quote</dhv:label>" onClick="javascript:this.form.action='Quotes.do?command=Details&productId=<%= TicketDetails.getProductId() %>&id=<%= TicketDetails.getId() %>';submit();"/>
        </dhv:evaluate>
      </dhv:permission>
      --%>
	<dhv:permission name="oia-oia-sanzioni-delete">
		<%
			if ("searchResults".equals(request
								.getParameter("return"))) {
		%>
		<input type="button"
			value="<dhv:label name="global.button.delete">Delete</dhv:label>"
			onClick="javascript:popURL('OiaSanzioni.do?command=ConfirmDelete&idNodo=<%=idMacchinetta %>&id=<%= TicketDetails.getId() %>&orgId=<%= OrgDetails.getOrgId() %>&return=searchResults&popup=true', 'Delete_ticket','320','200','yes','no');">
		<%
			} else {
		%>
		<input type="button"
			value="<dhv:label name="global.button.delete">Delete</dhv:label>"
			onClick="javascript:popURL('OiaSanzioni.do?command=ConfirmDelete&idNodo=<%=idMacchinetta %>&id=<%= TicketDetails.getId() %>&orgId=<%= OrgDetails.getOrgId() %>&popup=true', 'Delete_ticket','320','200','yes','no');">
		<%
			}
		%>
	</dhv:permission>
	<dhv:permission name="oia-oia-sanzioni-edit">
		<input type="button"
			value="<dhv:label name="global.button.close">Chiudi</dhv:label>"

			onClick="javascript:this.form.action='OiaSanzioni.do?command=Chiudi&idNodo=<%=idMacchinetta %>&id=<%= TicketDetails.getId() %>';if( confirm('Sei sicuro di voler chiudere Questa Sanzione ? \n Attenzione! La pratica verr� chiusa e non sar� pi� possibile fare modifiche \n sulla scheda se non con il permesso del supervisore o dell amministratore') ){submit()};">

	</dhv:permission>
	
	
	
	<%} %>
	
	
	<table cellpadding="4" cellspacing="0" width="100%" class="details">
		<tr>
			<th colspan="2"><strong><dhv:label
				name="sanzioni.information">Scheda Sanzione Amministrativa</dhv:label></strong></th>
		</tr>
		<%--<tr class="containerBody">
    <td class="formLabel">
      <dhv:label name="sanzioni.tipo_richiesta">Ticket State</dhv:label>
    </td>
    <td>
      <dhv:label name="<%="richieste." + TicketDetails.getTipo_richiesta() %>"><%=TicketDetails.getTipo_richiesta()%></dhv:label>
    </td>
  </tr>--%>
		<dhv:include name="" none="true">
			<dhv:evaluate if="<%= SiteIdList.size() > 1 %>">
				<tr class="containerBody">
					<td nowrap class="formLabel"><dhv:label
						name="stabilimenti.site">Site</dhv:label></td>
					<td><%=SiteIdList.getSelectedValue(TicketDetails
										.getSiteId())%>
					<%
						
					%> <input type="hidden"
						name="siteId" value="<%=TicketDetails.getSiteId()%>"></td>
				</tr>
			</dhv:evaluate>
			<dhv:evaluate if="<%= SiteIdList.size() <= 1 %>">
				<input type="hidden" name="siteId" id="siteId" value="-1" />
						</dhv:evaluate>
		</dhv:include>
	
  <input type="hidden" name="id" id="id"
			value="<%=  TicketDetails.getId() %>" />
		<input type="hidden" name="orgId" id="orgId"
			value="<%=  TicketDetails.getOrgId() %>" />
			
	
	<%if(TicketDetails.getIdentificativonc()!=null){ %>
			
<tr class="containerBody">
    <td class="formLabel">
      <dhv:label name="">Identificativo Non Conformit�</dhv:label>
    </td>
   
     
      <td> 
      		<%= TicketDetails.getIdentificativonc() %>
      </td>
    
  </tr><%} %>
  
  <%if(TicketDetails.getIdentificativo()!=null){ %>
  <tr class="containerBody">
    <td class="formLabel">
      <dhv:label name="">Codice Sanzione Amministrativa</dhv:label>
    </td>
   
     
      <td>
      		<%= toHtmlValue(TicketDetails.getIdentificativo()) %>
      </td>
    
  </tr>	
		<tr class="containerBody">
			<td nowrap class="formLabel"><dhv:label
				name="sanzioni.data_richiesta">Data Accetamento</dhv:label></td>
			<td><zeroio:tz
				timestamp="<%= TicketDetails.getAssignedDate() %>" dateOnly="true"
				timeZone="<%= TicketDetails.getAssignedDateTimeZone() %>"
				showTimeZone="false" default="&nbsp;" /> 
				
				</td></tr><%} %>
				
  
  
  <%
  
  
  if(TicketDetails.getTrasgressore()!=null){
  if(!TicketDetails.getTrasgressore().equals("")){ %>
  
  <tr class="containerBody">
  <td nowrap class="formLabel">
Trasgressore
   </td>
   <td>
      <%=TicketDetails.getTrasgressore() %>
      
   </td>
</tr>
<%}}%>


<% 
if(TicketDetails.getObbligatoinSolido()!=null){
if(!TicketDetails.getObbligatoinSolido().equals("")) {%>
<tr class="containerBody">
  <td nowrap class="formLabel">
      Obbligato in solido

   </td>
   <td>
      <%= toHtmlValue(TicketDetails.getObbligatoinSolido()) %>
      
   </td>
</tr>
<%} }%>



<% 
if(TicketDetails.getObbligatoinSolido2()!=null){
if(!TicketDetails.getObbligatoinSolido2().equals("")) {%>
<tr class="containerBody">
  <td nowrap class="formLabel">
      Obbligato in solido 2

   </td>
   <td>
      <%= toHtmlValue(TicketDetails.getObbligatoinSolido2()) %>
      
   </td>
</tr>
<%} }%>



<% 
if(TicketDetails.getObbligatoinSolido3()!=null){
if(!TicketDetails.getObbligatoinSolido3().equals("")) {%>
<tr class="containerBody">
  <td nowrap class="formLabel">
      Obbligato in solido 3

   </td>
   <td>
      <%= toHtmlValue(TicketDetails.getObbligatoinSolido3()) %>
      
   </td>
</tr>
<%} }%>
  
  
  <%
  if(TicketDetails.getTipo_richiesta()!=null){
  if(!TicketDetails.getTipo_richiesta().equals("")){ %>
<tr class="containerBody">
  <td nowrap class="formLabel">
       Processo Verbale

   </td>
   <td>
      <%= toHtmlValue(TicketDetails.getTipo_richiesta()) %>
      
   </td>
</tr>
		
		<%}} %>
		
		<% 
		
			
		if(TicketDetails.getPagamento()!=0.0){
		
		%>
			<tr class="containerBody">
				<td valign="top" class="formLabel">
					Pagamento in Misura Ridotta(Euro)</td>
				<td><%=TicketDetails.getPagamento()%> </td>
			</tr>
	<%} %>
		
		
	
	<%if(TicketDetails.getAzioninonConformePer().size()!=0){ 
	
	HashMap<Integer,String> azionenonConformePer=TicketDetails.getAzioninonConformePer();
	Set<Integer> setkiavi=azionenonConformePer.keySet();
	Iterator<Integer> itera=setkiavi.iterator();

	%>
		<tr class="containerBody">
					<td nowrap class="formLabel"><dhv:label name="">Azione non Conforme Per</dhv:label>
					</td>
		
					<td>

					<%while(itera.hasNext()){
						int chiave=itera.next();
						String value=azionenonConformePer.get(chiave);
						
						%>
					<%="- " + value %>

					<%} %>

					</br>
					<% if(!TicketDetails.getDescrizione1().equals("")){%>
					<%="- Descrizione: " + TicketDetails.getDescrizione1() %>
					<%} %>
					</td>
					
			

				</tr>
				
				<%} %>
				
				
				
				<%
				
				if(TicketDetails.getNormaviolata()!=null){
				if(!TicketDetails.getNormaviolata().equals("")){ %>
				
				<tr class="containerBody">
  <td nowrap class="formLabel">
      Norma Violata

   </td>
   <td>
      <%= TicketDetails.getNormaviolata() %>
      
   </td>
</tr>
				
				
				
				<%}} %>
				
				
				
			<dhv:evaluate if="<%= hasText(TicketDetails.getProblem()) %>">
			<tr class="containerBody">
				<td class="formLabel" valign="top"><dhv:label
					name="sanzioni.note">Note</dhv:label></td>
				<td valign="top">
				Note</br>
				<%
					//Show audio files so that they can be streamed
							Iterator files = TicketDetails.getFiles().iterator();
							while (files.hasNext()) {
								FileItem thisFile = (FileItem) files.next();
								if (".wav".equalsIgnoreCase(thisFile.getExtension())) {
				%> <a
					href="TroubleTicketsDocumenti_asl.do?command=Download&stream=true&tId=<%= TicketDetails.getId() %>&fid=<%= thisFile.getId() %>"><img
					src="images/file-audio.gif" border="0" align="absbottom"><dhv:label
					name="tickets.playAudioMessage">Play Audio Message</dhv:label></a><br />
				<%
					}
							}
				%> <%=toHtml(TicketDetails.getProblem())%> <input type="hidden"
					name="problem" value="<%=toHtml(TicketDetails.getProblem())%>">
				</td>
			</tr>
		</dhv:evaluate>
			  
		<%-- <tr class="containerBody">
      <td name="punteggio" id="punteggio" nowrap class="formLabel">
        <dhv:label name="">Punteggio</dhv:label>
      </td>
    <td>
    	<%= toHtmlValue(TicketDetails.getPunteggio()) %>
      
    </td>
  </tr> --%>
		
	
		<tr class="containerBody">
			<td class="formLabel"><dhv:label
				name="accounts.accounts_calls_list.Entered">Entered</dhv:label></td>
			<td><dhv:username id="<%= TicketDetails.getEnteredBy() %>" /> <zeroio:tz
				timestamp="<%= TicketDetails.getEntered() %>"
				timeZone="<%= User.getTimeZone() %>" showTimeZone="false" /></td>
		</tr>
		<tr class="containerBody">
			<td class="formLabel"><dhv:label
				name="accounts.accounts_contacts_calls_details.Modified">Modified</dhv:label>
			</td>
			<td><dhv:username id="<%= TicketDetails.getModifiedBy() %>" /> <zeroio:tz
				timestamp="<%= TicketDetails.getModified() %>"
				timeZone="<%= User.getTimeZone() %>" showTimeZone="false" /></td>
		</tr>
	</table>
	<br />
	
&nbsp;
<br />
	<%
	

		if (TicketDetails.isTrashed()) {
	%>
	<dhv:permission name="oia-oia-sanzioni-delete">
		<input type="button"
			value="Ripristina"
			onClick="javascript:this.form.action='OiaSanzioni.do?command=Restore&idNodo=<%=idMacchinetta %>&id=<%= TicketDetails.getId()%>';submit();">
	</dhv:permission>
	<%
		} else if (TicketDetails.getClosed() != null) {
	%>
	 
	<dhv:permission name="reopen-reopen-view">
		<input type="button"
			value="<dhv:label name="button.reopen">Reopen</dhv:label>"
			onClick="javascript:this.form.action='OiaSanzioni.do?command=ReopenTicket&idNodo=<%=idMacchinetta %>&id=<%= TicketDetails.getId()%><%= (defectCheck != null && !"".equals(defectCheck.trim())?"&defectCheck="+defectCheck:"") %>';submit();">
	</dhv:permission>
	
	<%
		} else {
	%>
	<dhv:permission name="oia-oia-sanzioni-edit">
		<input type="button"
			value="Modifica"
			onClick="javascript:this.form.action='OiaSanzioni.do?command=ModifyTicket&idNodo=<%=idMacchinetta %>&auto-populate=true<%= (defectCheck != null && !"".equals(defectCheck.trim())?"&defectCheck="+defectCheck:"") %>';submit();">
	</dhv:permission>
	<%--
  <dhv:permission name="quotes-view">
    <dhv:evaluate if="<%= TicketDetails.getProductId() > 0 %>">
      <input type="button" value="<dhv:label name="ticket.generateQuote">Generate Quote</dhv:label>" onClick="javascript:this.form.action='Quotes.do?command=Display&productId=<%= TicketDetails.getProductId() %>&id=<%= TicketDetails.getId() %>';submit();"/>
    </dhv:evaluate>
  </dhv:permission>
  --%>
	<dhv:permission name="oia-oia-sanzioni-delete">
		<%
			if ("searchResults".equals(request
								.getParameter("return"))) {
		%>
		<input type="button"
			value="<dhv:label name="global.button.delete">Delete</dhv:label>"
			onClick="javascript:popURL('OiaSanzioni.do?command=ConfirmDelete&idNodo=<%=idMacchinetta %>&id=<%= TicketDetails.getId() %>&orgId=<%= TicketDetails.getOrgId() %>&return=searchResults&popup=true', 'Delete_ticket','320','200','yes','no');">
		<%
			} else {
		%>
		<input type="button"
			value="<dhv:label name="global.button.delete">Delete</dhv:label>"
			onClick="javascript:popURL('OiaSanzioni.do?command=ConfirmDelete&idNodo=<%=idMacchinetta %>&orgId=<%= TicketDetails.getOrgId() %>&id=<%= TicketDetails.getId() %>&popup=true', 'Delete_ticket','320','200','yes','no');">
		<%
			}
		%>
	</dhv:permission>
	<dhv:permission name="oia-oia-sanzioni-edit">
		<input type="button"
			value="<dhv:label name="global.button.close">Chiudi</dhv:label>"

			onClick="javascript:this.form.action='OiaSanzioni.do?command=Chiudi&idNodo=<%=idMacchinetta %>&id=<%= TicketDetails.getId() %>';if( confirm('Sei sicuro di voler chiudere Questa Sanzione ? \n Attenzione! La pratica verr� chiusa e non sar� pi� possibile fare modifiche \n sulla scheda se non con il permesso del supervisore o dell amministratore') ){submit()};">

	</dhv:permission>
	
	
	<%} %>
	
</dhv:container>
</form>

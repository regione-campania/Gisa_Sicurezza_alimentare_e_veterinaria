<%@page import="java.util.HashMap" %>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.aspcfs.modules.altriprovvedimenti.base.ElementoNonConformita"%><input type = "hidden" name = "idIspezione" value = "<%=request.getAttribute("idIspezione")%>">
<jsp:useBean id="DiffideList" class="org.aspcfs.modules.diffida.base.TicketList" scope="request"/>
<jsp:useBean id="ProvvedimentiBenessereMacellazione" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="ProvvedimentiBenessereTrasporto" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="listaLineeCU" class="java.util.ArrayList" scope="request"/>
<jsp:useBean id="listaOperatoriMercatoCU" class="java.util.ArrayList" scope="request"/>
<%@page import="org.aspcfs.modules.lineeattivita.base.LineeAttivita"%>
<%@page import="org.aspcfs.modules.sintesis.base.SintesisOperatoreMercato"%>


<tr class="containerBody">
    <td valign="top" class="formLabel">
      <dhv:label name="sanzionia.importo">Non Conformita a carico di</dhv:label>
    </td>
    <td><%=toHtmlValue(TicketDetails.getRagioneSocialeImpresaSanzionata())%>
    </td>
  </tr>
  
<input type="hidden" name = "identificativoNC" value = "<%=TicketDetails.getIdentificativo()%>">

    
<%
    	if(TicketDetails.getNon_conformita_gravi()!=null && (TicketDetails.getNon_conformita_gravi().get(0).getId_nc()!=-1))
    {

    	ArrayList<ElementoNonConformita> table=TicketDetails.getNon_conformita_gravi();
    %>
	<tr class="details">
			<th nowrap  colspan="2"  align="left"><strong>Non Conformita Gravi</strong></th>
		</tr>
<tr class="containerBody">
    <td valign="top" class="formLabel">
  	Non Conformit� Selezionate
    </td>
    <td>
      <table border="0" cellspacing="0" cellpadding="0" class="empty">
      <%
      	int i = 1 ;
            for ( ElementoNonConformita nc : table)
        	  {
      %>
        <tr>
        <td>
        <%
        	out.println("<b> Descrizione di ciascuna NC </b> "+"</br>");
        %>
        <textarea cols="55" rows="6" disabled="disabled"> <%=nc.getNote().toUpperCase()%></textarea></td>
           <td>&nbsp;</td>
           <td>&nbsp;</td>
          <td>
       
      <%
             	out.println("<b>N.C Grave </b> "+i+"</br>"); 
                  	
                 	 out.print(nc.getDescrizione_nc().toUpperCase()+"<br>");
                 	 
                    	
                    	if (nc.getId_nc_benessere_macellazione()>0)
                        	out.print(ProvvedimentiBenessereMacellazione.getSelectedValue(nc.getId_nc_benessere_macellazione()).toUpperCase()+"<br>");
                    	if (nc.getId_nc_benessere_trasporto()>0)
                        	out.print(ProvvedimentiBenessereTrasporto.getSelectedValue(nc.getId_nc_benessere_trasporto()).toUpperCase()+"<br>");
                    		

                 	 
                 	 if (listaLineeCU!=null && listaLineeCU.size()>0) { 
                 	 out.println("<b>Linea sottoposta a non conformita'</b></br>"); 
                    	for (int k = 0; k<listaLineeCU.size(); k++) {
                           LineeAttivita linea = (LineeAttivita) listaLineeCU.get(k);
                           if (linea.getId() == nc.getId_linea_nc())
                             	out.print((linea.getMacroarea()!= null ? linea.getMacroarea() + "->" : "") + (linea.getAggregazione()!=null ? linea.getAggregazione() + "->" : linea.getCategoria()!=null ? linea.getCategoria() + "->" : "") + (linea.getAttivita()!=null ? linea.getAttivita() + "->" : linea.getLinea_attivita()!=null ? linea.getLinea_attivita() : "")+"<br>");
                    	} }
                 	 

              		if (listaOperatoriMercatoCU!=null && listaOperatoriMercatoCU.size()>0) {
                		for (int k = 0; k<listaOperatoriMercatoCU.size(); k++) {
                         	 SintesisOperatoreMercato operatore = (SintesisOperatoreMercato) listaOperatoriMercatoCU.get(k);
                      	 if (operatore.getId() == nc.getId_operatore_mercato()){
                     	    out.println("<b>Operatore mercato sottoposto a non conformita'</b></br>"); 
             		 out.println("Num. Box: "+operatore.getNumBox());
                      		 out.println(operatore.getOpuStabilimento()!=null ? operatore.getOpuStabilimento().getOperatore().getRagioneSociale() : operatore.getOrgStabilimento()!=null ? operatore.getOrgStabilimento().getName() : "");
                      	 }
                	}
                		if (nc.getId_operatore_mercato()==-1)
                   		 out.println("Tutto il mercato");
                	}
              		
                 	i++;
             %>     
          </td>
          
        </tr>
       
        
        <%} %>
    </table>
    </td>
</tr>


   
   <tr class="containerBody">
    <td valign="top" class="formLabel">
   Elenco Follow Up
    </td>
    <td>
   
     <table cellpadding="4" cellspacing="0" width="100%" class = "noborder" >
		<tr style="background-color: rgb(204, 255, 153);">
		<td valign="center" align="left">
      		<strong><dhv:label name="">Descrizione Attivit�</dhv:label></strong>
    	</td>
    	<td valign="center" align="left">
      		<strong><dhv:label name="">Codice Attivit�</dhv:label></strong>
    	</td>
     <td><b><dhv:label name="sanzionia.data_richiesta">Data Esecuzione Attivit�</dhv:label></b></td>
   
  </tr>
  <tr>
  <td colspan="3">
   <div style="overflow-x;hidden;overflow-y:auto;height: 100px;width: 100%">
  <table width="100%">
      <%
       Iterator f = SanzioniList.iterator();
   	   if ( f.hasNext() ) {
       int rowid = 0;
       i =0;
       while (f.hasNext()) {      
           i++;
           rowid = (rowid != 1?1:2);
           org.aspcfs.modules.sanzioni.base.Ticket thisSan = (org.aspcfs.modules.sanzioni.base.Ticket)f.next();
         	if (thisSan.getTipo_nc()==  org.aspcfs.modules.followup.base.Ticket.NC_GRAVI)
         	{
     %>
     <tr >
      <td  valign="top" nowrap>
     <b> Sanzione</b>
      </td>
         <td  valign="top" nowrap>
   			<a href="<%=OrgDetails.getAction() %>Sanzioni.do?command=TicketDetails&id=<%= thisSan.getId() %>&idNodo=<%=request.getAttribute("idNodo") %>&idC=<%=request.getAttribute("idC")%>&idNC=<%=TicketDetails.getId()%>&altId=<%= thisSan.getAltId()%><%= addLinkParams(request, "popup|popupType|actionId") %>"><%= thisSan.getIdentificativo() %></a>
   		</td>
   		
        <td valign="top">
         <% if(!User.getTimeZone().equals(thisSan.getAssignedDate())){%>
         <zeroio:tz timestamp="<%= thisSan.getAssignedDate() %>" timeZone="<%= User.getTimeZone() %>" dateOnly="true" showTimeZone="false" default="&nbsp;"/>
         <% } else { %>
         <zeroio:tz timestamp="<%= thisSan.getAssignedDate() %>" dateOnly="true" timeZone="<%= thisSan.getAssignedDateTimeZone() %>" showTimeZone="false" default="&nbsp;"/>
         <% } %>
   		</td>
   	</tr>
   	<tr >
         <td colspan="2" valign="top">
         
           <%= toHtml(thisSan.getProblemHeader()) %>&nbsp;
           <% if (thisSan.getClosed() == null) {
        	   if(TicketDetails.isChiusura_attesa_esito()==true)
        	   {
        		   %>
        		   [<font color="orange">Pratica Temporaneamente Chiusa in Attesa di Esito di Campioni e/o Tamponi</font>]
        		   <%
        	   }
        	   else
        	   {
        		
        	   %>
             [<font color="green"><dhv:label name="project.open.lowercase1">open</dhv:label></font>]
           <%}} else {%>
             [<font color="red"><dhv:label name="project.closed.lowercase1">closed</dhv:label></font>]
           <%}%>
         </td>
       </tr>
       
     <%}}%>
   
     <%}
   	 f = DiffideList.iterator();
	   if ( f.hasNext() ) {
		int rowid = 0;
    i =0;
    while (f.hasNext()) {   
  	  
        i++;
        rowid = (rowid != 1?1:2);
        org.aspcfs.modules.diffida.base.Ticket thisSan = (org.aspcfs.modules.diffida.base.Ticket)f.next();
        
      	if (thisSan.getTipo_nc()==  org.aspcfs.modules.followup.base.Ticket.NC_GRAVI)
      	{
  %>
  <tr >
   <td  valign="top" nowrap>
  <b> Diffida</b>
   </td>
      <td  valign="top" nowrap>
			<a href="<%=OrgDetails.getAction()%>Diffida.do?command=TicketDetails&id=<%= thisSan.getId() %>&idNodo=<%=request.getAttribute("idNodo") %>&idC=<%=request.getAttribute("idC")%>&idNC=<%=TicketDetails.getId()%>&altId=<%= thisSan.getAltId()%><%= addLinkParams(request, "popup|popupType|actionId") %>"><%= thisSan.getIdentificativo() %></a>
		</td>
     <td valign="top">
      <% if(!User.getTimeZone().equals(thisSan.getAssignedDate())){%>
      <zeroio:tz timestamp="<%= thisSan.getAssignedDate() %>" timeZone="<%= User.getTimeZone() %>" dateOnly="true" showTimeZone="false" default="&nbsp;"/>
      <% } else { %>
      <zeroio:tz timestamp="<%= thisSan.getAssignedDate() %>" dateOnly="true" timeZone="<%= thisSan.getAssignedDateTimeZone() %>" showTimeZone="false" default="&nbsp;"/>
      <% } %>
		</td>
	</tr>
	<tr >
      <td colspan="2" valign="top">
      
        <%= toHtml(thisSan.getProblemHeader()) %>&nbsp;
        <% if (thisSan.getClosed() == null) { 
     	   if(TicketDetails.isChiusura_attesa_esito()==true)
     	   {
     		   %>
     		   [<font color="orange">Pratica Temporaneamente Chiusa in Attesa di Esito di Campioni e/o Tamponi</font>]
     		   <%
     	   }
     	   else
     	   {
     		
     	   %>
          [<font color="green"><dhv:label name="project.open.lowercase1">open</dhv:label></font>]
        <%}} else {%>
          [<font color="red"><dhv:label name="project.closed.lowercase1">closed</dhv:label></font>]
        <%}%>
      </td>
    </tr>
    
  <%}}%>

  <%}%>
      <%
        f = SequestriList.iterator();
   	   if ( f.hasNext() ) {
       int rowid = 0;
       i =0;
       while (f.hasNext()) {      
           i++;
           rowid = (rowid != 1?1:2);
           org.aspcfs.modules.sequestri.base.Ticket thisSan = (org.aspcfs.modules.sequestri.base.Ticket)f.next();
         	if (thisSan.getTipo_nc()==  org.aspcfs.modules.followup.base.Ticket.NC_GRAVI)
         	{
     %>
     <tr >
      <td  valign="top" nowrap>
      <b>Sequestro</b>
      </td>
         <td  valign="top" nowrap>
   			<a href="<%=OrgDetails.getAction() %>Sequestri.do?command=TicketDetails&id=<%= thisSan.getId() %>&idNodo=<%=request.getAttribute("idNodo") %>&idC=<%=request.getAttribute("idC")%>&idNC=<%=TicketDetails.getId()%>&altId=<%= thisSan.getAltId()%><%= addLinkParams(request, "popup|popupType|actionId") %>"><%= thisSan.getIdentificativo() %></a>
   		</td>
   		
        <td valign="top">
         <% if(!User.getTimeZone().equals(thisSan.getAssignedDate())){%>
         <zeroio:tz timestamp="<%= thisSan.getAssignedDate() %>" timeZone="<%= User.getTimeZone() %>" dateOnly="true" showTimeZone="false" default="&nbsp;"/>
         <% } else { %>
         <zeroio:tz timestamp="<%= thisSan.getAssignedDate() %>" dateOnly="true" timeZone="<%= thisSan.getAssignedDateTimeZone() %>" showTimeZone="false" default="&nbsp;"/>
         <% } %>
   		</td>
   	</tr>
   	<tr >
         <td colspan="2" valign="top">
         
           <%= toHtml(thisSan.getProblemHeader()) %>&nbsp;
           <% if (thisSan.getClosed() == null) { 
        	   if(TicketDetails.isChiusura_attesa_esito()==true)
        	   {
        		   %>
        		   [<font color="orange">Pratica Temporaneamente Chiusa in Attesa di Esito di Campioni e/o Tamponi</font>]
        		   <%
        	   }
        	   else
        	   {
        		
        	   %>
             [<font color="green"><dhv:label name="project.open.lowercase1">open</dhv:label></font>]
           <%}} else {%>
             [<font color="red"><dhv:label name="project.closed.lowercase1">closed</dhv:label></font>]
           <%}%>
         </td>
       </tr>
       
     <%}}%>
   
     <%}%>
      <%
       f = ReatiList.iterator();
   	   if ( f.hasNext() ) {
       int rowid = 0;
       i =0;
       while (f.hasNext()) {      
           i++;
           rowid = (rowid != 1?1:2);
           org.aspcfs.modules.reati.base.Ticket thisSan = (org.aspcfs.modules.reati.base.Ticket)f.next();
         	if (thisSan.getTipo_nc()==  org.aspcfs.modules.followup.base.Ticket.NC_GRAVI)
         	{
     %>
     <tr >
      <td  valign="top" nowrap>
     <b> Notizia di Reato</b>
      </td>
         <td  valign="top" nowrap>
   			<a href="<%=OrgDetails.getAction() %>Reati.do?command=TicketDetails&id=<%= thisSan.getId() %>&idNodo=<%=request.getAttribute("idNodo") %>&idC=<%=request.getAttribute("idC")%>&idNC=<%=TicketDetails.getId()%>&altId=<%= thisSan.getAltId()%><%= addLinkParams(request, "popup|popupType|actionId") %>"><%= thisSan.getIdentificativo() %></a>
   		</td>
   		
        <td valign="top">
         <% if(!User.getTimeZone().equals(thisSan.getAssignedDate())){%>
         <zeroio:tz timestamp="<%= thisSan.getAssignedDate() %>" timeZone="<%= User.getTimeZone() %>" dateOnly="true" showTimeZone="false" default="&nbsp;"/>
         <% } else { %>
         <zeroio:tz timestamp="<%= thisSan.getAssignedDate() %>" dateOnly="true" timeZone="<%= thisSan.getAssignedDateTimeZone() %>" showTimeZone="false" default="&nbsp;"/>
         <% } %>
   		</td>
   	</tr>
   	<tr >
         <td colspan="2" valign="top">
         
           <%= toHtml(thisSan.getProblemHeader()) %>&nbsp;
           <% if (thisSan.getClosed() == null) { 
        	   if(TicketDetails.isChiusura_attesa_esito()==true)
        	   {
        		   %>
        		   [<font color="orange">Pratica Temporaneamente Chiusa in Attesa di Esito di Campioni e/o Tamponi</font>]
        		   <%
        	   }
        	   else
        	   {
        		
        	   %>
             [<font color="green"><dhv:label name="project.open.lowercase1">open</dhv:label></font>]
           <%}} else {%>
             [<font color="red"><dhv:label name="project.closed.lowercase1">closed</dhv:label></font>]
           <%}%>
         </td>
       </tr>
       
     <%}}%>
   
     <%}%>
      <%
       f = FollowupList.iterator();
   	   if ( f.hasNext() ) {
       int rowid = 0;
       i =0;
       while (f.hasNext()) {      
           i++;
           rowid = (rowid != 1?1:2);
           org.aspcfs.modules.followup.base.Ticket thisSan = (org.aspcfs.modules.followup.base.Ticket)f.next();
         	if (thisSan.getTipo_nc()==  org.aspcfs.modules.followup.base.Ticket.NC_GRAVI)
         	{
     %>
     <tr >
      <td  valign="top" nowrap>
      <b>Followup</b>
      </td>
         <td  valign="top" nowrap>
   			<a href="<%=OrgDetails.getAction() %>Followup.do?command=TicketDetails&id=<%= thisSan.getId() %>&idNodo=<%=request.getAttribute("idNodo") %>&idC=<%=request.getAttribute("idC")%>&idNC=<%=TicketDetails.getId()%>&altId=<%= thisSan.getAltId()%><%= addLinkParams(request, "popup|popupType|actionId") %>"><%= thisSan.getIdentificativo() %></a>
   		</td>
   		
        <td valign="top">
         <% if(!User.getTimeZone().equals(thisSan.getAssignedDate())){%>
         <zeroio:tz timestamp="<%= thisSan.getAssignedDate() %>" timeZone="<%= User.getTimeZone() %>" dateOnly="true" showTimeZone="false" default="&nbsp;"/>
         <% } else { %>
         <zeroio:tz timestamp="<%= thisSan.getAssignedDate() %>" dateOnly="true" timeZone="<%= thisSan.getAssignedDateTimeZone() %>" showTimeZone="false" default="&nbsp;"/>
         <% } %>
   		</td>
   	</tr>
   	<tr >
         <td colspan="2" valign="top">
         
           <%= toHtml(thisSan.getProblemHeader()) %>&nbsp;
           <% if (thisSan.getClosed() == null) {
        	   if(TicketDetails.isChiusura_attesa_esito()==true)
        	   {
        		   %>
        		   [<font color="orange">Pratica Temporaneamente Chiusa in Attesa di Esito di Campioni e/o Tamponi</font>]
        		   <%
        	   }
        	   else
        	   {
        		
        	   %>
             [<font color="green"><dhv:label name="project.open.lowercase1">open</dhv:label></font>]
           <%}} else {%>
             [<font color="red"><dhv:label name="project.closed.lowercase1">closed</dhv:label></font>]
           <%}%>
         </td>
       </tr>
       
     <%}}%>
   
     <%}%>
  	</table></div></td></tr> 
  
        </table>
   
      
    </td>
</tr>
        
        
        <% }
   
       
    
     %>



     


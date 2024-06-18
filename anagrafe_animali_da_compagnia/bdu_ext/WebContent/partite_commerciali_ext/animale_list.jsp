<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,org.aspcfs.modules.accounts.base.*,org.aspcfs.modules.contacts.base.*,org.aspcfs.utils.web.*,org.aspcfs.modules.assets.base.*,org.aspcfs.modules.anagrafe_animali_ext.base.*,org.aspcfs.modules.partitecommerciali_ext.base.*" %>
<jsp:useBean id="animaleList" class="org.aspcfs.modules.anagrafe_animali_ext.base.AnimaleList" scope="request"/>
<jsp:useBean id="animaliListInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<jsp:useBean id="razzaList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="AslList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="LookupSpecie" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="statoList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="partita" class="org.aspcfs.modules.partitecommerciali_ext.base.PartitaCommerciale" scope="request"/>
<jsp:useBean id="mantelloList" class="org.aspcfs.utils.web.LookupList" scope="request" />

<%@ include file="../initPage.jsp" %>
<%@ include file="../initPopupMenu.jsp" %>

<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/spanDisplay.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popURL.js"></SCRIPT>
<script language="JavaScript" type="text/javascript">
  <%-- Preload image rollovers for drop-down menu --%>
  loadImages('select');
</script>
<dhv:evaluate if="<%= !isPopup(request) %>">
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
  <a href="PartiteCommerciali.do"><dhv:label name="accounts.Assets">Circuito commerciale</dhv:label></a> > 
    <a href="PartiteCommerciali.do?command=DettagliPartita&idPartita=<%=animaleList.getIdPartita() %>"><dhv:label name="">Dettagli partita</dhv:label></a> >
    <dhv:label name="">Lista animali</dhv:label>
</td>
</tr>
</table>
<%-- End Trails --%>
</dhv:evaluate>
<% 

String label = "";
String labelLiberalizza = "";

if (partita.getIdTipoPartita() == 1){
	label = "Aggiungi cane";
	labelLiberalizza = "Liberalizza tutti i cani senza vincolo";
}else if (partita.getIdTipoPartita() == 2){
	label = "Aggiungi gatto";
	labelLiberalizza = "Liberalizza tutti i gatti senza vincolo";
}else{
	label = "Aggiungi animale";
	labelLiberalizza = "Liberalizza tutti gli animali senza vincolo";
}
int idLinea = partita.getIdImportatore();
%>



<dhv:evaluate if="<%= !isPopup(request) %>">
<dhv:permission name="partite-commerciali-add">
	<a href="PartiteCommerciali.do?command=Add&amp;idPartita=<%=partita.getIdPartitaCommerciale()%>&amp;idLinea=<%=idLinea%><%= addLinkParams(request, "popup|popupType|actionId") %>"><dhv:label name=""><%=label%></dhv:label></a>
	<a href="PartiteCommerciali.do?command=LiberalizzaTutti&amp;idPartita=<%=partita.getIdPartitaCommerciale()%><%= addLinkParams(request, "popup|popupType|actionId") %>"><dhv:label name=""><%=labelLiberalizza%></dhv:label></a>
</dhv:permission>
</dhv:evaluate>
<%if (request.getAttribute("nosenzavincolo") != null) {%>
<p>	<font color="red"> <%=request.getAttribute("nosenzavincolo") %> </font></p>
<%} %>
<dhv:pagedListStatus title='<%= showError(request, "actionError") %>' object="animaliListInfo"/>

<br />





<form name="aggiungiAnimaliVincolati" action="PartiteCommerciali.do?command=AggiungiAnimaliVincolati&auto-populate=true<%= addLinkParams(request, "popup|popupType|actionId") %>" method="post">
<table class="details" cellpadding="4" cellspacing="0" border="0" width="100%" >
	<thead>
	  <tr>
	    <%-- th width="8">
	      &nbsp;
	    </th --%>
	    <th width="16%" nowrap>
	      <strong>Microchip</strong>
	    </th>
	    <th width="16%" nowrap>
	      <strong><dhv:label name="">Passaporto</dhv:label></strong>
	    </th>
	    <th width="16%">
	      <strong><dhv:label name="">Razza</dhv:label></strong>
	    </th>
	    <th width="16%" nowrap>
	      <strong><dhv:label name="">Nome</dhv:label></strong>
	    </th>
	    <th width="16%" nowrap>
	      <strong><dhv:label name="">Mantello</dhv:label></strong>
	    </th>
	    <th width="16%" nowrap>
	      <strong><dhv:label name="">Stato</dhv:label></strong>
	    </th>
	    <th width="16%" nowrap>
	      <strong><dhv:label name="">Operatore Commerciale</dhv:label></strong>
	    </th>

	  </tr>
  </thead>
  <tbody>
	  <% 
	    Iterator itr = animaleList.iterator();
	    if (itr.hasNext()){
	      int rowid = 0;
	      int i = 0;
	      while (itr.hasNext()){
	        i++;
	        rowid = (rowid != 1 ? 1 : 2);
	        Animale thisAnimale = (Animale)itr.next();
	    %>   
	    
	
	  <tr class="row<%=rowid%>">
	 	<td width="15%" nowrap>
	 	<dhv:evaluate if="<%= !isPopup(request) %>">
	      <a orderInfo="<%= toHtml(thisAnimale.getMicrochip()) %>" href="AnimaleAction.do?command=Details&animaleId=<%= thisAnimale.getIdAnimale()%>&idSpecie=<%=thisAnimale.getIdSpecie()%><%= addLinkParams(request, "popup|popupType|actionId") %>"><%= toHtml(thisAnimale.getMicrochip()) %></a>
	     </dhv:evaluate>
	     <dhv:evaluate if="<%= isPopup(request) %>">
	     <input type="hidden" name="idPartita" id="idPartita" value="<%=partita.getIdPartitaCommerciale() %>"/>
	    <input type="checkbox" value="<%= toHtml(thisAnimale.getMicrochip()) %>"  name="microchips[]" id="microchips[]"  <%=(partita.getListMicrochipAnimaliConVincolo().contains(thisAnimale.getMicrochip()))? "checked" : "" %> />
	     <%=toHtml(thisAnimale.getMicrochip())%>
	     </dhv:evaluate>
		</td>
		<td width="15%" nowrap>
	      <%= toHtml(thisAnimale.getNumeroPassaporto()) %>
	    </td>
	    <td width="15%" nowrap>
	    	 <dhv:evaluate if="<%= thisAnimale.getIdRazza() > -1 %>">
	      		<%= toHtml(razzaList.getSelectedValue(thisAnimale.getIdRazza())) %>
	      	</dhv:evaluate>
		</td>
	    <td width="15%" nowrap>
	      <%= toHtml(thisAnimale.getNome()) %>
	    </td>
	    <td width="15%" nowrap>
	    	 <dhv:evaluate if="<%= thisAnimale.getIdTipoMantello() > -1 %>">
	      		<%= toHtml(mantelloList.getSelectedValue(thisAnimale.getIdTipoMantello())) %>
	      	</dhv:evaluate>
		</td>
		<td width="15%" nowrap>
			<%=toHtml(statoList.getSelectedValue( thisAnimale.getStato() ))%>&nbsp;    
			<%if (thisAnimale.isFlagVincoloCommerciale()){ %>  
			 <font color="red">Presenza vincolo commerciale</font>
			<%} %>
		</td>
		<td width="15%" nowrap>
 	<dhv:evaluate  if="<%= partita.getOperatoreCommerciale() != null %>" >
		
				<%= toHtml(partita.getOperatoreCommerciale().getRagioneSociale())   %>
	    
	</dhv:evaluate>
	</td>
	
	   </tr>
	  
	 
	    <%  
	      }
	    }else{
	    %>
	    <tr class="containerBody">
	      <td colspan="9">
	        <dhv:label name="">Non sono stati trovati animali</dhv:label>
	      </td>
	    </tr>
	    <%
	    }
	    %>
	  </tbody>
	
   </table>
<dhv:evaluate if="<%= isPopup(request) %>"> <!-- Devo aggiungere a lista animali vincolati -->
 	<input type="submit" value="Inserisci" />
 </dhv:evaluate>
   </form>
<dhv:pagedListControl object="animaliListInfo"/>
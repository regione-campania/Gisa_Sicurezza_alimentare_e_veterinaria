

<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv"%>

<%@page import="org.aspcfs.modules.anagrafe_animali.base.Gatto"%>
<%@page import="org.aspcfs.modules.registrazioniAnimali.base.EventoReimmissione,org.aspcfs.modules.opu.base.*"%>


<jsp:useBean id="comuniList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="evento" class="org.aspcfs.modules.registrazioniAnimali.base.Evento" scope="request"/>

<%EventoReimmissione eventoF = (EventoReimmissione) evento; %>
<%@ include file="../initPage.jsp" %>
<%@ include file="../initPopupMenu.jsp" %>



<table cellpadding="4" cellspacing="0" border="0" width="100%" class="pagedList">
<th colspan="2">Dettagli della registrazione di reimmissione</th>

    <tr>  <td><b><dhv:label name="">Data di reimmissione</dhv:label></b></td>
      	  <td >
      	<%=toDateasString(eventoF.getDataReimmissione())%>&nbsp;
      </td></tr>
     	<tr><td><b><dhv:label name="">Canile detentore precedente</dhv:label></b></td>
  	<td>
  			<%
			Operatore detentoreVecchio = eventoF.getIdDetentoreOriginarioRegistrazione();
			if (detentoreVecchio != null) {
				Stabilimento stab = (Stabilimento) (detentoreVecchio
						.getListaStabilimenti().get(0));
				LineaProduttiva linea = (LineaProduttiva) (stab
						.getListaLineeProduttive().get(0));
		%> <a
			href="OperatoreAction.do?command=Details&opId=<%=linea.getId()%>"><%=toHtml(detentoreVecchio.getRagioneSociale())%></a>
		<%
			} else {
		%> -- <%
			}
		%>
  	</td>
     </tr>
     <dhv:evaluate if="<%=eventoF.getIdDetentore() > 0 %>">
       <tr><td><b><dhv:label name=""><%=(eventoF.getSpecieAnimaleId() == Gatto.idSpecie) ? "Colonia di reimmissione / Sindaco" : "Detentore"  %></dhv:label></b></td>
  	<td>
  			<%
			Operatore detentoreColonia = eventoF.getColoniaDetentore();
			if (detentoreColonia != null) {
				Stabilimento stabColonia = (Stabilimento) (detentoreColonia
						.getListaStabilimenti().get(0));
				LineaProduttiva lineaColonia = (LineaProduttiva) (stabColonia
						.getListaLineeProduttive().get(0));
		%> <a
			href="OperatoreAction.do?command=Details&opId=<%=lineaColonia.getId()%>"><%=toHtml(detentoreColonia.getRagioneSociale())%></a>
		<%
			} else {
		%> -- <%
			}
		%>
  	</td>
     </tr>
    </dhv:evaluate>

      <tr><td><b><dhv:label name="">Luogo di reimmissione</dhv:label></b></td>
  	<td>
	<%=(eventoF.getLuogoReimmissione() != null ) ? eventoF.getLuogoReimmissione() : "--" %>
	  </td>
  	</td>
     </tr>

	<!-- 	SINAAF ADEGUAMENTO  -->
	<tr><td><b><dhv:label name="">Comune di reimmissione</dhv:label></b></td>

  	<% if (eventoF.getIdComuneReimmissione()!=-1 ) {%>
  		<td><%= comuniList.getSelectedValue(eventoF.getIdComuneReimmissione())%></td>
  	 <%}  else  {	 %>
  	 <td></td>
  	 <%}  %>
     </tr>



  </table>
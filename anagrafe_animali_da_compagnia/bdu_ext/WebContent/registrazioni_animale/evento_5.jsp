<jsp:useBean id="tipoSoggettoSterilizz" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="comuniList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="evento" class="org.aspcfs.modules.registrazioniAnimali.base.Evento" scope="request"/>
<jsp:useBean id="municipalitaList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />

<%EventoCattura eventoF = (EventoCattura) evento; %>
<%@ include file="../initPage.jsp" %>
<%@ include file="../initPopupMenu.jsp" %>

<%@page import="org.aspcfs.modules.registrazioniAnimali.base.*,org.aspcfs.modules.opu.base.*"%>

<table cellpadding="4" cellspacing="0" border="0" width="100%" class="pagedList">
<th colspan="2">Dettagli della registrazione di cattura</th>

    <tr>  <td><b><dhv:label name="">Data della cattura</dhv:label></b></td>
      	  <td >
      	<%=toDateasString(eventoF.getDataCattura()) %>&nbsp;
      </td></tr>
	<tr><td><b><dhv:label name="">Verbale cattura</dhv:label></b></td>
  	<td>
  	<%=(eventoF.getVerbaleCattura() != null && !("").equals(eventoF.getVerbaleCattura())) ? eventoF.getVerbaleCattura() : ""%>
  	</td>
     </tr>
    <tr><td><b><dhv:label name="">Comune cattura</dhv:label></b></td>
  	<td>
  	<%=(eventoF.getIdComuneCattura() > 0) ?  comuniList.getSelectedValue(eventoF.getIdComuneCattura()) : "N.D."%>
  	</td>
     </tr>
     
    <tr><td><b><dhv:label name="">Municipalit�</dhv:label></b></td>
  	<td>
  	<%=(eventoF.getIdMunicipalita() > 0) ?   toHtml(municipalitaList.getSelectedValue(eventoF.getIdMunicipalita())).replace("\uFFFD", "�") : "N.D."%>
  	</td>
     </tr>
     
     
<%--     <tr><td><b><dhv:label name="">Via cattura</dhv:label></b></td>
  	<td>
  	<%=(eventoF.getIndirizzoCattura() != null && !("").equals(eventoF.getIndirizzoCattura())) ?eventoF.getIndirizzoCattura() : "--"%>
  	</td>
     </tr> --%>
     
     	<tr><td><b><dhv:label name="">Luogo cattura</dhv:label></b></td>
  	<td>
  	<%= (eventoF.getLuogoCattura() != null && !("").equals(eventoF.getLuogoCattura())) ? eventoF.getLuogoCattura() : "" %>
  	</td>
     </tr>
     
          <tr><td><b><dhv:label name="">Proprietario/Detentore</dhv:label></b></td>
  	<td>
  	<% 
 	  
 	  Operatore proprietario = eventoF.getProprietario();
 	  if (proprietario != null) { 
        Stabilimento stab = (Stabilimento) (proprietario.getListaStabilimenti().get(0));
        LineaProduttiva linea = (LineaProduttiva)( stab.getListaLineeProduttive().get(0));
 	  %>
			<a href="OperatoreAction.do?command=Details&opId=<%= linea.getId() %>"><%= toHtml(proprietario.getRagioneSociale()) %></a>
	<%}else{ %>
	--
	<%} %>/
	  <% 
	  Operatore detentore = eventoF.getDetentore();
	  if (detentore != null) { 
	        Stabilimento stab1 = (Stabilimento) (detentore.getListaStabilimenti().get(0));
	        LineaProduttiva linea1 = (LineaProduttiva)( stab1.getListaLineeProduttive().get(0));
	  %>
		<a href="OperatoreAction.do?command=Details&opId=<%= linea1.getId() %>"><%= toHtml(detentore.getRagioneSociale()) %>&nbsp;</a>
	 <%}
	  else{ %>  
	--
	 <%} %>
	  </td>
  	</td>


  </table>
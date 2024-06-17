<%@page import="org.aspcfs.modules.opu.base.Stabilimento"%>
<%@page import="org.aspcfs.modules.opu.base.StabilimentoList"%>

<jsp:useBean id="TipoImpresaListStab" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="TipoSocietaListStab" class="org.aspcfs.utils.web.LookupList" scope="request" />
<%
StabilimentoList listaStabilimentiNonModificati  = (StabilimentoList)request.getAttribute("ListaStabilimentiNonModificati");
%>
<%@ include file="../utils23/initPage.jsp"%>

<h3>ATTENZIONE : Le modifiche apportate non sono state applicate ai seguenti stabilimenti per incongruit� di informazioni</h3>
<table cellpadding="8" cellspacing="0" border="0" style="width: 100%" class="pagedList">
  <thead>
  <tr><th colspan="7">Lista Stabilimenti Su cui non � Stato Possibile applicare l'errata corrige :</th></tr>
  <tr>
  
   <th>
	<div align="center">
	<strong>Soggetto Fiico</strong>
          </div>
        </th>
        
          
          <th>
	<div align="center">
	<strong>Dati Impresa</strong>
          </div>
        </th>      

  <th>
	<div align="center">
	<strong>Numero Registrazione</strong>
          </div>
        </th>
        
          <th>
	<div align="center">
	<strong>Asl</strong>
          </div>
        </th>
          <th>
	<div align="center">
	<strong>Sede Produttiva</strong>
          </div>
        </th> 
           <th>
	<div align="center">
	<strong>SELEZIONA</strong>
          </div>
        </th>
         </tr>    
</thead>

<tbody id="bodytab">

<%
for(int i = 0 ; i < listaStabilimentiNonModificati.size();i++)
{
	Stabilimento stabilimento = (Stabilimento) listaStabilimentiNonModificati.get(i);
	%>
	
	
	
	<tr >
	
	  <td valign="center"  align="center"  nowrap style="width: 10%;">
	  <div >
	   <%=   toHtml2(stabilimento.getOperatore().getRappLegale().getCognome()) +" "+toHtml2(stabilimento.getOperatore().getRappLegale().getNome()) + " "+toHtml2(stabilimento.getOperatore().getRappLegale().getCodFiscale())   %><br>
	  <%=   toHtml2(stabilimento.getOperatore().getRappLegale().getComuneNascita()) +" "+toDateasString(stabilimento.getOperatore().getRappLegale().getDataNascita()) + " "+toHtml2(stabilimento.getOperatore().getRappLegale().getSesso())%><br>
	  <%=   toHtml2(stabilimento.getOperatore().getRappLegale().getIndirizzo().getDescrizioneComune()) +" "+toHtml2(stabilimento.getOperatore().getRappLegale().getIndirizzo().getDescrizione_provincia()) %><br>
	  <%= toHtml2(stabilimento.getOperatore().getRappLegale().getIndirizzo().getDescrizioneToponimo()) +" "+toHtml2(stabilimento.getOperatore().getRappLegale().getIndirizzo().getVia())+" "+toHtml2(stabilimento.getOperatore().getRappLegale().getIndirizzo().getCivico())%><br>
	  
	  
	  </div>
	  </td>	
	  
	   <td valign="center"  align="center"  nowrap style="width: 10%;">
	  <div >
	  <%=  "RAGIONE SOCIALE : "+ toHtml2(stabilimento.getOperatore().getRagioneSociale()) +"<br>"  %>
	   <%=  "TIPO IMPRESA : "+ TipoImpresaListStab.getSelectedValue(stabilimento.getOperatore().getTipo_impresa()) +"<br>"  %>
	   <%=  (stabilimento.getOperatore().getTipo_societa()>0)? "TIPO SOCIETA : "+ TipoImpresaListStab.getSelectedValue(stabilimento.getOperatore().getTipo_societa()) +"<br>" :"" %>
	   
	   <%= "PARTITA IVA : "+  toHtml2(stabilimento.getOperatore().getPartitaIva())+"<br>"   %>
	  <%if(stabilimento.getOperatore().getSedeLegaleImpresa()!=null){ %>
	  <%=  "SEDE LEGALE "+ toHtml2(stabilimento.getOperatore().getSedeLegaleImpresa().getDescrizioneComune()) +" "+toHtml2(stabilimento.getOperatore().getSedeLegaleImpresa().getDescrizione_provincia())  %><br>
	  <%=   toHtml2(stabilimento.getOperatore().getSedeLegaleImpresa().getDescrizioneToponimo()) +" "+toHtml2(stabilimento.getOperatore().getSedeLegaleImpresa().getVia())+" "+toHtml2(stabilimento.getOperatore().getSedeLegaleImpresa().getDescrizione_provincia())  %><br>
	  <%} %>
	  </div>
	  </td>	
	  
	  <td valign="center"  align="center"  nowrap style="width: 10%;">
	  <div >
	  <%=   toHtml2(stabilimento.getNumero_registrazione())   %>
	  </div>
	  </td>	
	  
	   <td valign="center"  align="center"  nowrap style="width: 10%;">
	  <div >
	  <%=  stabilimento.getIdAsl()   %>
	  </div>
	  </td>	
	  
	   <td valign="center"  align="center"  nowrap style="width: 10%;">
	  <div >
  <%=   (stabilimento.getSedeOperativa().getIdIndirizzo()>0) ? "SEDE OPERATIVA : "+toHtml2(stabilimento.getSedeOperativa().getDescrizioneComune()) + " "+toHtml2(stabilimento.getSedeOperativa().getVia())+ ","+toHtml2(stabilimento.getSedeOperativa().getCivico())+"<br>" :"" %>
	  <%=(stabilimento.getTipoAttivita()==1) ? "TIPO ATTIVITA : FISSA" : "TIPO ATTIVITA : MOBILE" %>
	 
	  </div>
	  </td>	
	   <td valign="center"  align="center"  nowrap style="width: 10%;">
	  <div >
		 <input type="checkbox" name="checkStab" value="<%=stabilimento.getIdStabilimento() %>" onclick="controllaModificheComunePerStabilimento(<%=stabilimento.getIdAsl() %>,'<%=stabilimento.getTipoAttivita() %>',<%=stabilimento.getOperatore().getRappLegale().getIndirizzo().getComune() %>,<%=stabilimento.getOperatore().getRappLegale().getIdAsl() %>,this)" >
	  </div>
	  </td>	
	
	</tr>
	 
	
	<%
	
}
%>
</tbody>
</table>
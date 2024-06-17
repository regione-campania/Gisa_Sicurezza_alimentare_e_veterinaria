
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv"%>
<%@ page
	import="org.aspcfs.modules.base.Constants,org.aspcfs.utils.web.*"%>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio"%>

<jsp:useBean id="ComuniList" class="org.aspcfs.utils.web.LookupList"
	scope="request" /> 
<jsp:useBean id="SiteList" class="org.aspcfs.utils.web.LookupList"
	scope="request" />

<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean"
	scope="session" />
	
<jsp:useBean id="SearchOrgListInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<jsp:useBean id="AnagraficaPartenza" class="org.aspcfs.modules.ricercaunica.base.RicercaOpu" scope = "request"></jsp:useBean>
	
	   
   <script>
   function clearForm(){
	   var inp = document.getElementById("searchAccount").getElementsByTagName('input');
	   for(var i in inp){
	       if(inp[i].type == "text"){
	           inp[i].value='';
	       }
	   }
	   
	   mostraAttivitaProduttive('attprincipale',1,-1, true,-1);
   }
   
   function checkForm(form){
	   var linea1 = document.getElementById("searchattivita1").value;
	   var linea2 = document.getElementById("searchattivita2").value;
	   var linea3 = document.getElementById("searchattivita3").value;
	   var searchAttivita = document.getElementById("searchattivita");
	   
	   var linea = "";
	   
	   if (linea1!=''){
		   linea = linea1;
		   if (linea2!=''){
			   linea = linea + "->"+linea2;
			   if (linea3!='')
				   linea = linea + "->"+linea3;
		   }
			   
	   }
	   if (linea!='')
		   searchAttivita.value = linea;
	   loadModalWindow();
	   form.submit();
   }

   </script>     


<form name="searchAccount" id = "searchAccount" action="RicercaArchiviati.do?command=Search" method="post">
<%-- Trails --%>


<%-- End Trails --%>




<!--  IMPRESA -->
      <table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
        <tr>
          <th colspan="2">
            <strong><dhv:label name=""> Dati operatore</dhv:label></strong>
          </th>
        </tr>
        
       
        <tr>
                <td class="formLabel">
                  <dhv:label name="">ASL</dhv:label>
                </td>
           <td>
           <dhv:evaluate if="<%=User.getUserRecord().getSiteId() == -1 %>" >
           <%
           SiteList.setJsEvent("onChange=popolaComboComuni()");
           %>
            <%= SiteList.getHtmlSelect("searchcodeIdAsl", ("".equals(SearchOrgListInfo.getSearchOptionValue("searchcodeIdAsl")) ? String.valueOf(Constants.INVALID_SITE) : SearchOrgListInfo.getSearchOptionValue("searchcodeIdAsl"))) %>
           </dhv:evaluate>
           <dhv:evaluate if="<%=User.getUserRecord().getSiteId() != -1 %>" >
              <input type="hidden" name="searchcodeIdAsl" value="<%= User.getUserRecord().getSiteId() %>">
              <%= SiteList.getSelectedValue(User.getUserRecord().getSiteId()) %>
           </dhv:evaluate>
           </td>
       </tr> 
 
        <tr>
          <td class="formLabel">
            <dhv:label name="lab.denom">Nome/Ditta/Ragione sociale</dhv:label>
          </td>
          <td>
            <input type="text" maxlength="70" size="50" name="searchragioneSociale" id="searchRagioneSociale" value="">
          </td>
        </tr>
        
         <tr>
        	<td nowrap class="formLabel">
     		 Partita IVA
   			 </td> 
    		<td> 
				<input  type="text" maxlength="11" size="50" name="searchpartitaIva" value="">
			</td>
  		</tr>
  		
  		<tr>
        	<td nowrap class="formLabel">
     		 <dhv:label name="">Numero di registrazione</dhv:label>
   			 </td> 
    		<td> 
				<input type="text" maxlength="50" size="50" name="searchnumeroRegistrazione" value="">
			</td>
  		</tr>
  		
        
  		 <tr>
                <td class="formLabel">
                  <dhv:label name="">Comune</dhv:label>
                </td>
                <td>
                 	<%= ComuniList.getHtmlSelectText("searchcomuneSedeProduttiva",SearchOrgListInfo.getSearchOptionValue("searchcomuneSedeProduttiva")) %>
                </td>
              </tr> 
        
  		
  		 <tr>
        	<td nowrap class="formLabel" >
     		 <dhv:label name="">Indirizzo</dhv:label>
   			 </td> 
    		<td> 
				<input  type="text" maxlength="50" size="50" name="searchindirizzoSedeProduttiva" value="">
			</td>
  		</tr>
  	  
 </table>
 <%
	if(request.getAttribute("Popup")!=null)
	{
	%>
	<input type = "hidden" name = "Popup" value="true"/>
	<%} 
 
 if(request.getAttribute("tipoOperazione")!=null)
	{
	%>
	<input type = "hidden" name = "tipoOperazione" value="<%=request.getAttribute("tipoOperazione")%>"/>
	<%} 
	%>
<input type="submit" id="search" name="search" value="Ricerca"/>


 <%
	if(request.getAttribute("Popup")!=null)
	{
	%>
<input type = "button" value="ESCI" onclick="$('#dialogRICERCA').dialog('close');">
<%} else{%>

<input type="button" value="<dhv:label name="button.clear">Clear</dhv:label>" onClick="clearForm();">
<%} 
 
 
	%>
	
	<div id="LoadingImage" style="display: none">
	Ricerca in corso Attendere ..
<img src="images/ajax-loader.gif" />
</div>
	
	<input type = "hidden" name = "rifId" value="<%=AnagraficaPartenza.getRiferimentoId() %>">
	<input type = "hidden" name = "rifIdNome" value="<%=AnagraficaPartenza.getRiferimentoIdNomeCol() %>">
	<input type = "hidden" name = "tipoRicerca" value="<%=AnagraficaPartenza.getTipoRicerca() %>">
	
	
<input type="hidden" name="source" value="searchForm">
<iframe src="empty.html" name="server_commands" id="server_commands" style="visibility:hidden" height="0"></iframe>

</form>

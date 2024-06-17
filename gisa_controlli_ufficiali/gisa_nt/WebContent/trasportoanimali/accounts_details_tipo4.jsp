<%-- 
  - Copyright(c) 2004 Dark Horse Ventures LLC (http://www.centriccrm.com/) All
  - rights reserved. This material cannot be distributed without written
  - permission from Dark Horse Ventures LLC. Permission to use, copy, and modify
  - this material for internal use is hereby granted, provided that the above
  - copyright notice and this permission notice appear in all copies. DARK HORSE
  - VENTURES LLC MAKES NO REPRESENTATIONS AND EXTENDS NO WARRANTIES, EXPRESS OR
  - IMPLIED, WITH RESPECT TO THE SOFTWARE, INCLUDING, BUT NOT LIMITED TO, THE
  - IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR ANY PARTICULAR
  - PURPOSE, AND THE WARRANTY AGAINST INFRINGEMENT OF PATENTS OR OTHER
  - INTELLECTUAL PROPERTY RIGHTS. THE SOFTWARE IS PROVIDED "AS IS", AND IN NO
  - EVENT SHALL DARK HORSE VENTURES LLC OR ANY OF ITS AFFILIATES BE LIABLE FOR
  - ANY DAMAGES, INCLUDING ANY LOST PROFITS OR OTHER INCIDENTAL OR CONSEQUENTIAL
  - DAMAGES RELATING TO THE SOFTWARE.
  - 
  - Version: $Id: accounts_details.jsp 19045 2007-02-07 18:06:22Z matt $
  - Description: 
  --%>
  
  
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*,java.text.DateFormat,org.aspcfs.modules.trasportoanimali.base.*,org.aspcfs.modules.contacts.base.*, org.aspcfs.modules.base.Constants" %>
<jsp:useBean id="SourceList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="StageList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="IstatList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="statoLab" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SiteList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="AnimaliPropri" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="RatingList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="TitoloList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="role" class="org.aspcfs.modules.admin.base.Role" scope="request"/>
<jsp:useBean id="OrgDetails" class="org.aspcfs.modules.trasportoanimali.base.Organization" scope="request"/>
<jsp:useBean id="OrgCategoriaRischioList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SegmentList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="TipoStruttura" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="TipoLocale" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SICCodeList" class="org.aspcfs.modules.admin.base.SICCodeList" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="applicationPrefs" class="org.aspcfs.controller.ApplicationPrefs" scope="application"/>
<jsp:useBean id="refreshUrl" class="java.lang.String" scope="request"/>

<SCRIPT LANGUAGE="JavaScript" SRC="javascript/CalendarPopup.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">document.write(getCalendarStyles());</SCRIPT>
<SCRIPT LANGUAGE="JavaScript" ID="js19">
	var cal19 = new CalendarPopup();
	cal19.showYearNavigation();
	cal19.showYearNavigationInput();
	cal19.showNavigationDropdowns();
</SCRIPT>
<script>


$(document).ready(function() {	

	
	//select all the a tag with name equal to modal
	$('a[name=modal]').click(function(e) {
		//Cancel the link behavior
		e.preventDefault();
		
		//Get the A tag
		var id = $(this).attr('href');
	
		//Get the screen height and width
		var maskHeight = $(document).height();
		var maskWidth = $(window).width();
	
		//Set heigth and width to mask to fill up the whole screen
		$('#mask').css({'width':maskWidth,'height':maskHeight});
		
		//transition effect		
		$('#mask').fadeIn(1000);	
		$('#mask').fadeTo("slow",0.8);	
	
		//Get the window height and width
		var winH = $(window).height();
		var winW = $(window).width();
              
		//Set the popup window to center
		$(id).css('top',  winH/2-$(id).height()/2);
		$(id).css('left', winW/2-$(id).width()/2);
	
		//transition effect
		$(id).fadeIn(2000); 
	
	});
	
	//if close button is clicked
	$('.window .close').click(function (e) {
		//Cancel the link behavior
		e.preventDefault();
		
		$('#mask').hide();
		$('.window').hide();
	});		
	
	//if mask is clicked
	$('#mask').click(function () {
		$(this).hide();
		$('.window').hide();
	});			
	
});

</script>
<style>
body {
font-family:verdana;
font-size:15px;
}

a {color:#333; text-decoration:none}
a:hover {color:#ccc; text-decoration:none}

#mask {
  position:absolute;
  left:0;
  top:0;
  z-index:9000;
  background-color:#000;
  display:none;
}
  
#boxes .window {
  position:absolute;
  left:0;
  top:0;
  width:675px;
  height:358;
  display:none;
  z-index:9999;
  padding:20px;
}

#boxes #dialog # {
  width:675px; 
  height:380;
  padding:10px;
  background-color:#ffffff;
}

 #dialog4 {
  width:675px; 
  height:380;
  padding:10px;
  background-color:#ffffff;
}

#boxes #dialog1 {
  width:375px; 
  height:203px;
}

#dialog1 .d-header {
  background:url(images/login-header.png) no-repeat 0 0 transparent; 
  width:375px; 
  height:150px;
}

#dialog1 .d-header input {
  position:relative;
  top:60px;
  left:100px;
  border:3px solid #cccccc;
  height:22px;
  width:200px;
  font-size:15px;
  padding:5px;
  margin-top:4px;
}

#dialog1 .d-blank {
  float:left;
  background:url(images/login-blank.png) no-repeat 0 0 transparent; 
  width:267px; 
  height:53px;
}

#dialog1 .d-login {
  float:left;
  width:108px; 
  height:53px;
}

#boxes #dialog2 {
  background:url(images/notice.png) no-repeat 0 0 transparent; 
  width:326px; 
  height:229px;
  padding:50px 0 20px 25px;
}
</style>
<%@ include file="../utils23/initPage.jsp" %>

<link rel="stylesheet" type="text/css" href="css/jmesa.css"></link>
		
		<script type="text/javascript" src="javascript/jquery.bgiframe.pack.js"></script>
		<script type="text/javascript" src="javascript/jquery.jmesa.js"></script>
		<script type="text/javascript" src="javascript/jmesa.js"></script>
		<script type="text/javascript" src="javascript/gestioneStatoTrasportoAnimali.js"></script>
	<script>
function chiamaActionVeicoli(stringa1,stringa2){
	var scroll = document.body.scrollTop;
	location.href=stringa1+scroll+stringa2;
}

</script>	
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popURL.js"></script>
<%if (refreshUrl!=null && !"".equals(refreshUrl)){ %>
<script language="JavaScript" TYPE="text/javascript">
parent.opener.window.location.href='<%=refreshUrl%><%= request.getAttribute("actionError") != null ? "&actionError=" + request.getAttribute("actionError") :""%>';
</script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popURL.js"></script>




<%}%>

<dhv:evaluate if="<%= !isPopup(request) %>">
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="TrasportoAnimali.do"><dhv:label name="">Trasporto animali</dhv:label></a> > 
<% if (request.getParameter("return") == null) { %>
<a href="TrasportoAnimali.do?command=Search"><dhv:label name="requestor.SearchResults">Search Results</dhv:label></a> >
<%} else if (request.getParameter("return").equals("dashboard")) {%>
<a href="TrasportoAnimali.do?command=Dashboard">Cruscotto</a> >
<%}%>

<dhv:label name="trasportoanimali.details">Scheda Trasportatore "conto proprio" di Equidi </dhv:label>

</td>
</tr>
</table>

<%-- End Trails --%>
</dhv:evaluate>

<br>
<br>
<%@ include file="../../controlliufficiali/diffida_list.jsp" %>
<%--<table width="100%" border="0">
    <tr>
    	<td nowrap align="right">
    		<img src="images/icons/stock_print-16.gif" border="0" align="absmiddle" height="16" width="16"/>
    		<%
    		String url;
    		url = application.getRealPath("/") + "FilePdf" + "\\" + "Tipo_1.pdf" ;
    		%>
        	<a href="FilePdf/Tipo_1.pdf" target="_blank"><dhv:label name="">Stampa Dettaglio richiesta</dhv:label></a>
    	</td>
    </tr>
    <tr>
    	<td nowrap align="right">
    		<img src="images/icons/stock_print-16.gif" border="0" align="absmiddle" height="16" width="16"/>

        	<a href=""><dhv:label name="">Stampa Certificazione</dhv:label></a>
    	</td>
    </tr>
    <tr>
    	<td nowrap align="right">
    		<img src="images/icons/stock_print-16.gif" border="0" align="absmiddle" height="16" width="16"/>
    	
        	<a href=""><dhv:label name="">Check list</dhv:label></a>
    	</td>
    </tr>
</table>--%>
<%--dhv:permission name="trasportoanimali-trasportoanimali-report-view"--%>


  <script language="JavaScript" TYPE="text/javascript"
	SRC="gestione_documenti/generazioneDocumentale.js"></script>
	
	<img src="images/icons/stock_print-16.gif" border="0" align="absmiddle" height="16" width="16"/>
        <input type="button" title="Stampa Scheda" value="Stampa Scheda"		onClick="openRichiestaPDF2('<%= OrgDetails.getId() %>', '-1', '-1', '-1', '49');">
        
  <table width="100%" border="0">
    <tr>
      <td nowrap align="right">
      	<%-- if (!OrgDetails.getAccountNumber().equals("") ){ --%> 
      	     	 <br>
        
    	<img src="images/icons/stock_print-16.gif" border="0" align="absmiddle" height="16" width="16"/>
        <!-- input type="button" title="Allegato H (AUTODICHIARAZIONE)" value="Allegato H (AUTODICHIARAZIONE)"	onClick="javascript:window.location.href='TrasportoAnimali.do?command=PrintReport&file=AllegatoH.pdf&id=<%= OrgDetails.getId() %>';"-->
 		
 		 <input type="button" title="Allegato H (AUTODICHIARAZIONE)" value="Allegato H (AUTODICHIARAZIONE)"	onClick="openRichiestaPDF('<%= OrgDetails.getId() %>', '-1', '-1', '-1', 'AllegatoH.pdf', 'AllegatoTrasporti');">	
 		
 		
       <%-- } else { %>
    	
       <br>
    	 <img src="images/icons/stock_print-16.gif" border="0" align="absmiddle" height="16" width="16"/>
        <input type="button"  disabled = "disabled" title="Allegato G (AUTODICHIARAZIONE)" value="Allegato C (AUTORIZZAZIONE)"	onClick="javascript:window.location.href='TrasportoAnimali.do?command=PrintReport&file=Allegato_C.xml&id=<%= OrgDetails.getId() %>';">
 		
       	<%} --%>
        
       </td>
    </tr>
  </table>
<%--/dhv:permission--%>

<% String param1 = "orgId=" + OrgDetails.getOrgId(); %>
<dhv:container name="trasportoanimali" selected="details" object="OrgDetails" param="<%= param1 %>" appendToUrl='<%= addLinkParams(request, "popup|popupType|actionId") %>' hideContainer="<%= !OrgDetails.getEnabled() || OrgDetails.isTrashed() %>">
<input type="hidden" name="orgId" value="<%= OrgDetails.getOrgId() %>">
<dhv:evaluate if="<%=OrgDetails.isTrashed()%>">
    <dhv:permission name="trasportoanimali-trasportoanimali-edit">
      <input type="button" value="Ripristina"	onClick="javascript:window.location.href='TrasportoAnimali.do?command=Restore&orgId=<%= OrgDetails.getOrgId() %>';">
    </dhv:permission>
</dhv:evaluate>



<dhv:evaluate if="<%=(!OrgDetails.isTrashed() && OrgDetails.getStato().equals("Attivo"))%>">  
  
  <%-- if ((!OrgDetails.getAccountNumber().equals(""))&& (User.getActualUserId() != 1)){ %>
  <dhv:permission name="trasportoanimali-trasportoanimali-edit">
  <input type="button" disabled="disabled" title="Non � possibile effettuare la modifica in quanto � gi� stato generato il Numero Registrazione" value="Modifica"	onClick="javascript:window.location.href='TrasportoAnimali.do?command=Modify&orgId=<%= OrgDetails.getOrgId() %><%= addLinkParams(request, "popup|actionplan") %>';"></dhv:permission>
  <%} else { --%>
  
  
  <%--dhv:evaluate if="<%=(OrgDetails.getEnabled())%>"--%>
    <dhv:permission name="trasportoanimali-trasportoanimali-edit">
    <input type="button" value="Modifica"	onClick="javascript:window.location.href='TrasportoAnimali.do?command=Modify&orgId=<%= OrgDetails.getOrgId() %><%= addLinkParams(request, "popup|actionplan") %>';">
    </dhv:permission>
  <%--/dhv:evaluate--%>
  <%--} --%>
  
  
  <dhv:evaluate if="<%=!(OrgDetails.getEnabled())%>">
    <dhv:permission name="trasportoanimali-trasportoanimali-edit">
      <input type="button" value="<dhv:label name="global.button.Enable">Enable</dhv:label>" 	onClick="javascript:window.location.href='TrasportoAnimali.do?command=Enable&orgId=<%= OrgDetails.getOrgId() %>';">
    </dhv:permission>
  </dhv:evaluate>
  
    <dhv:permission name="trasportoanimali-trasportoanimali-delete">
    <input type="button" value="<dhv:label name="">Elimina</dhv:label>" onClick="javascript:popURLReturn('TrasportoAnimali.do?command=ConfirmDelete&id=<%=OrgDetails.getId()%>&popup=true','TrasportoAnimali.do?command=Search', 'Delete_account','320','200','yes','no');">
    </dhv:permission>
  
  
 <script language="JavaScript" TYPE="text/javascript">
function enable() {
var b = document.getElementById("modB");
var c = document.getElementById("modC");
b.disabled=false;
c.disabled=false;
}
</script>

<!--dhv:permission name="trasportoanimali-trasportoanimali-edit"-->
    <%-- if (!OrgDetails.getAccountNumber().equals("")&&(OrgDetails.getAccountNumber()!=null)){ %>
 	<dhv:permission name="trasportoanimali-trasportoanimali-genera-view">

 		<input title= "Genera il Numero Registrazione" disabled="disabled" type="button" name="Genera Numero Registrazione" value="Genera Numero Registrazione"></a>

    </dhv:permission>
		
    <%} else { %>
		<dhv:permission name="trasportoanimali-trasportoanimali-genera-view">

			<input type="button" title= "Genera il Numero Registrazione" value="Genera Numero Registrazione" disabled="disabled"	onClick="javascript:window.location.href='TrasportoAnimali.do?command=GeneraCodiceOsa&orgId=<%= OrgDetails.getOrgId()%>';">

 		</dhv:permission>
    
	<%} --%>
<%--<dhv:permission name="trasportoanimali-trasportoanimali-genera-view">--%>
		<input type="button" title= "Carica gli autoveicoli" name="Carica Autoveicoli" value="Carica Autoveicoli" onClick="javascript:window.location.href='TrasportoAnimali.do?command=InsertVeicoli&carica=veicoli&orgId=<%=OrgDetails.getOrgId()%>'"></a>
	<%--/dhv:permission--%>
	

	<%if(OrgDetails.isSediCaricate()==false ){ %>
	<dhv:permission name="trasportoanimali-trasportoanimali-genera-view">
		<input type="button" title= "Carica le sedi operative degli autoveicoli" name="Carica Sedi Operative" value="Carica Sedi Operative" onClick="javascript:window.location.href='TrasportoAnimali.do?command=InsertSedi&carica=sedi&orgId=<%=OrgDetails.getOrgId()%>'"></a>
	</dhv:permission>
	<%}else{ %>
	
	<dhv:permission name="trasportoanimali-trasportoanimali-genera-view">
		<input type="button" disabled="disabled" title= "Carica le sedi operative degli autoveicoli" name="Carica Sedi Operative" value="Carica Sedi Operative" onClick="javascript:window.location.href='TrasportoAnimali.do?command=InsertSedi&carica=sedi&orgId=<%=OrgDetails.getOrgId()%>'"></a>
	</dhv:permission>
	
	<%} %>
	
	<dhv:permission name="trasportoanimali-trasportoanimali-genera-view">
		<input type="button" title= "Carica Personale" name="Carica Personalee" value="Carica Personale" onClick="javascript:window.location.href='TrasportoAnimali.do?command=InsertPersonale&carica=personale&orgId=<%=OrgDetails.getOrgId()%>'"></a>
	</dhv:permission>
<!-- /dhv:permission-->
<dhv:permission name="trasportoanimali-trasportoanimali-stato-view">
<br/><br/>
<table cellpadding="2" width="40%" bgcolor="#FF9933">
  <tr bgcolor="#FFFFFF">
    <th colspan="1" align="center" >
	    <strong><dhv:label name="">Gestione Stato: </dhv:label></strong>
	    <input type="button" value="<dhv:label name="">Sospensione</dhv:label>"	onClick="gestisciStatoTrasportoAnimali('Sospeso','<%= OrgDetails.getOrgId() %>','<%= addLinkParams(request, "popup|actionplan") %>');">
	    <input type="button" value="<dhv:label name="">Revoca</dhv:label>"	onClick="gestisciStatoTrasportoAnimali('Revocato','<%= OrgDetails.getOrgId() %>','<%= addLinkParams(request, "popup|actionplan") %>');">
	    <input type="button" value="<dhv:label name="">Cessazione</dhv:label>"	onClick="gestisciStatoTrasportoAnimali('Cessato','<%= OrgDetails.getOrgId() %>','<%= addLinkParams(request, "popup|actionplan") %>');">
    </th>
  </tr>
</table>
</dhv:permission>
</dhv:evaluate>
<dhv:evaluate if="<%=(!OrgDetails.isTrashed() && OrgDetails.getStato().equals("Sospeso"))%>">
<dhv:permission name="trasportoanimali-trasportoanimali-stato-view">
<table cellpadding="2" width="40%" bgcolor="#FF9933">
  <tr bgcolor="#FFFFFF">
    <th colspan="1" align="center" >
	    <strong><dhv:label name="">Gestione Stato: </dhv:label></strong>
	    <input type="button" value="<dhv:label name="">Riattivazione</dhv:label>"	onClick="gestisciStatoTrasportoAnimali('Attivo','<%= OrgDetails.getOrgId() %>','<%= addLinkParams(request, "popup|actionplan") %>');">
	    <input type="button" value="<dhv:label name="">Revoca</dhv:label>"	onClick="gestisciStatoTrasportoAnimali('Revocato','<%= OrgDetails.getOrgId() %>','<%= addLinkParams(request, "popup|actionplan") %>');">
	    <input type="button" value="<dhv:label name="">Cessazione</dhv:label>"	onClick="gestisciStatoTrasportoAnimali('Cessato','<%= OrgDetails.getOrgId() %>','<%= addLinkParams(request, "popup|actionplan") %>');">
    </th>
  </tr>
</table>
</dhv:permission>
</dhv:evaluate>
  <dhv:evaluate if="<%=(!OrgDetails.isTrashed() && (OrgDetails.getStato().equals("Cessato") || OrgDetails.getStato().equals("Revocato") ))%>">
  <dhv:evaluate if="<%=!(OrgDetails.getEnabled())%>">
    <dhv:permission name="trasportoanimali-trasportoanimali-edit">
      <input type="button" value="<dhv:label name="global.button.Enable">Enable</dhv:label>" 	onClick="javascript:window.location.href='TrasportoAnimali.do?command=Enable&orgId=<%= OrgDetails.getOrgId() %>';">
    </dhv:permission>
  </dhv:evaluate>
  
    <dhv:permission name="trasportoanimali-trasportoanimali-delete">
    <input type="button" value="<dhv:label name="">Elimina</dhv:label>" onClick="javascript:popURLReturn('TrasportoAnimali.do?command=ConfirmDelete&id=<%=OrgDetails.getId()%>&popup=true','TrasportoAnimali.do?command=Search', 'Delete_account','320','200','yes','no');">
    </dhv:permission>
  </dhv:evaluate>
</br>
</br>

<dhv:permission name="note_hd-view">
<jsp:include page="../note_hd/link_note_hd.jsp">
<jsp:param name="riferimentoId" value="<%=OrgDetails.getOrgId() %>" />
<jsp:param name="riferimentoIdNomeTab" value="organization" />
</jsp:include> <br><br>
</dhv:permission>

<%-- <jsp:include page="../schede_centralizzate/iframe.jsp"> --%>
<%--     <jsp:param name="objectId" value="<%=OrgDetails.getOrgId() %>" /> --%>
<%--      <jsp:param name="tipo_dettaglio" value="18" /> --%>
<%--      </jsp:include> --%>
    
<%-- <jsp:include page="../preaccettazionesigla/button_preaccettazione.jsp">
    <jsp:param name="riferimentoIdPreaccettazione" value="<%=OrgDetails.getOrgId() %>" />
    <jsp:param name="riferimentoIdNomePreaccettazione" value="orgId" />
    <jsp:param name="riferimentoIdNomeTabPreaccettazione" value="organization" />
    <jsp:param name="userIdPreaccettazione" value="<%=User.getUserId() %>" />
</jsp:include>  --%>
     
        <% if (1==1) { %>  
     
     <jsp:include page="../schede_centralizzate/iframe.jsp">
    <jsp:param name="objectId" value="<%=OrgDetails.getOrgId() %>" />
     <jsp:param name="tipo_dettaglio" value="49" />
     </jsp:include>     
     <% } else { %>
<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
  <tr>
    <th colspan="2">
      <strong><dhv:label name="">Scheda Trasportatore "conto proprio" di Equidi </dhv:label></strong>
    </th>
  </tr>
 <input type="hidden" name="id" value="<%=OrgDetails.getOrgId()%>" > 
  
  <tr class="containerBody">
    <td nowrap class="formLabel">
      <dhv:label name="requestor.site">A.S.L.</dhv:label>
    </td>
    <td>
      <%= SiteList.getSelectedValue(OrgDetails.getSiteId()) %>
      
      
      <input type="hidden" name="siteId" value="<%=OrgDetails.getSiteId()%>" >
    </td>
  </tr>
  
   <!-- Data richiesta autorizzazione -->
			<tr style="display: none">
      			<td nowrap class="formLabel">
        			<dhv:label name="requestor.requestor_add.AlertDate">Alert Date</dhv:label>
      			</td>
      			<td>
      			<input readonly type="text" id="alertDate" name="alertDate" size="10" value="<%= toDateString(OrgDetails.getAlertDate()) %>"/>
		<a href="#" onClick="cal19.select(document.forms[0].alertDate,'anchor19','dd/MM/yyyy'); return false;" NAME="anchor19" ID="anchor19">
		<img src="images/icons/stock_form-date-field-16.gif" border="0" align="absmiddle"></a>
        			<font color="red">*</font>
				        <%=showAttribute(request, "alertDateError")%>
				        <%=showWarningAttribute(request, "alertDateWarning")%>
        
      			</td>
    		</tr>
    		<tr class="containerBody">
      			<td nowrap class="formLabel">
        			<dhv:label name="">Data Presentazione Autodichiarazione</dhv:label>
      			</td>
      			<td>
      				        			<zeroio:tz timestamp="<%= OrgDetails.getDate1() %>" dateOnly="true" showTimeZone="false" default="&nbsp;" /></td>
    		</tr>
		
  			<tr class="containerBody">
    			<td nowrap class="formLabel" name="orgname1" id="orgname1">
      				<dhv:label name="">Cognome Trasportatore</dhv:label>
    			</td>
    			<td>
         	<%= OrgDetails.getCognomeRappresentante() %>&nbsp; 
    		</td>
  			</tr>
	  	<tr class="containerBody">
    			<td nowrap class="formLabel" name="orgname1" id="orgname1">
      				<dhv:label name="">Nome Trasportatore</dhv:label>
    			</td>
    			<td>	         	
    				<%= OrgDetails.getNomeRappresentante() %>&nbsp; 
    			</td>
  			</tr>

	  		<tr class="containerBody">
    			<td nowrap class="formLabel" name="codiceFiscale1" id="codiceFiscale1">
      				<dhv:label name="">Codice Fiscale Trasportatore</dhv:label>
    			</td>
    			<td>
         	<%= OrgDetails.getCodiceFiscaleRappresentante() %>&nbsp; 
    			</td>
  			</tr>
	 
		    <tr class="containerBody">
			      <td nowrap class="formLabel">
			        <dhv:label name="">Proprietario/Detentore di<BR><BR>(In caso di selezione<br> multipla tenere premuto<br> il tasto Ctrl)</dhv:label>
			      </td>
			      <td>
			     	 <%String  selezione="";

			    		HashMap<Integer,String> lista=OrgDetails.getListaAnimali();
			    		Iterator<Integer> valori=OrgDetails.getListaAnimali().keySet().iterator();
			    		
			    		while(valori.hasNext()){
			    			String Sel=lista.get(valori.next());
			    			
			    			selezione+=Sel+" - ";
			    		}
			    		
			    		out.print(selezione); %>
      				<input type="hidden" name="specieA" value="<%=OrgDetails.getListaAnimali()%>" >
			       </td>
			    </tr>
			    <tr class="containerBody">
  				<td  class="formLabel" nowrap>
  					<dhv:label name="">Stato</dhv:label>
  				</td>
  				<td>
  					       <%= toHtmlValue(OrgDetails.getStato()) %>
  					       <%if(OrgDetails.getData_cambio_stato() != null && OrgDetails.getUtente_cambio_stato() != -1){ %>
  					        - Data operazione: <zeroio:tz timestamp="<%= OrgDetails.getData_cambio_stato() %>" timeZone="<%= User.getTimeZone() %>" showTimeZone="false" />
  					        - Operazione effettuata da: <dhv:username id="<%= OrgDetails.getUtente_cambio_stato() %>"/>
  					       <%} %>
  			   </td>  				
  			</tr>
  			
		</table>
		
		<BR/>
		
		<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
		<TR><TH colspan="2">LISTA LINEE PRODUTTIVE</TH></TR>
  		<tr class="containerBody"><td  class="formLabel" nowrap>Altra Normativa</td><td class="containerBody">TRASPORTO ANIMALI</td></tr>
  		</table>
		  
		<br>
<dhv:include name="organization.addresses" none="true">


<%  
  Iterator iaddress = OrgDetails.getAddressList().iterator();
  Object address[] = null;
  int i = 0;
  if (iaddress.hasNext()) {
    while (iaddress.hasNext()) {
      OrganizationAddress thisAddress = (OrganizationAddress)iaddress.next();
%>  
<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
  <tr>
    <th colspan="2">
      <dhv:evaluate if="<%= thisAddress.getType() == 1 %>">
	    <strong><dhv:label name="">Indirizzo Residenza</dhv:label></strong>
	  </dhv:evaluate>
	  <dhv:evaluate if="<%= thisAddress.getType() == 5 %>">
	    <strong><dhv:label name="">Informazioni Abitazione/Allevamento</dhv:label></strong>
	  </dhv:evaluate>  
	  </th>
  </tr>
  <% if(thisAddress.getType() == 5){ %>
  <dhv:evaluate if="<%=((!OrgDetails.getBanca().equals(""))||(OrgDetails.getBanca()!=null))%>">
  			<tr class="containerBody">
    			<td nowrap class="formLabel" name="name1" id="name1">
      				<dhv:label name="">Abitazione/Allevamento</dhv:label>
    			</td>
    			<td>
    			<%=toHtmlValue(OrgDetails.getBanca())%>
      			</td>
  			</tr>
	</dhv:evaluate>
  <%} %>
    <tr class="containerBody">
      <td nowrap class="formLabel" valign="top">
        Indirizzo
      </td>
      <td>
                      <%= ( thisAddress.getType() == 1 && thisAddress.getCity().equals("-1"))?(toHtml(thisAddress.getCountry())):(toHtml(thisAddress.toString())) %>&nbsp;
        <%--<%= toHtml(thisAddress.toString()) %>&nbsp;--%>
        <dhv:evaluate if="<%=thisAddress.getPrimaryAddress()%>">        
          <dhv:label name="trasportoanimali.primary.brackets">(Primary)</dhv:label>
        </dhv:evaluate>
      </td>
    </tr>
  <%--<dhv:evaluate if="<%= thisAddress.getStreetAddressLine2()%>">
    <dhv:evaluate if="<%=thisAddress.getType() == 1 %>">
      <tr class="containerBody">
       <td nowrap class="formLabel">
          <dhv:label name="">C/O</dhv:label>
       </td>
       <td>
        <input type="text" size="40" name="address1line2" maxlength="80" value="<%= thisAddress.getStreetAddressLine2() %>">
      </td>
  </tr>
  </dhv:evaluate>
 </dhv:evaluate>--%>
    </table><br>
<%
    }
  } else {
%>
<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
  <tr>
    <th colspan="2">
	    <strong><dhv:label name="requestor.requestor_add.Addresses">Addresses</dhv:label></strong>
	  </th>
  </tr>
    <tr class="containerBody">
      <td colspan="2">
        <font color="#9E9E9E"><dhv:label name="contacts.NoAddresses">No addresses entered.</dhv:label></font>
      </td>
    </tr>
    </table><br>
<%}%>


</dhv:include>

<% } %>
 <br>		
 
 
 
 <%
		Integer numeroPersonale=(Integer)request.getAttribute("numeroPersonale");
		Integer numeroSedi=(Integer)request.getAttribute("numeroSedi");
		Integer numeroAutoveicoli=(Integer)request.getAttribute("numeroAutoveicoli");
		
		%>
 
<%if(request.getAttribute( "tabella" )!=null && request.getAttribute( "tabella2" )!=null && request.getAttribute( "tabella3" )!=null)  {
%>
		
		<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details" id="responsabile">
			<tr>
				<th colspan="2">
					<strong>
						<dhv:label name="">Autoveicoli e Sedi Operative Autoveicoli</dhv:label>
					</strong>
				</th>
			</tr>
			
			
		<tr>
		<p>
			Utilizzare le caselle vuote sopra l'intestazione per filtrare.
		</p>
		</tr>
		
	
		<tr>
		<td>
		<br>
		<dhv:permission name="carica-autoveicoli-add">
				<a href="javascript:chiamaActionVeicoli('VeicoliList.do?command=Add&tipoaggiunto=veicolo&scroll=','&orgId=<%=OrgDetails.getId() %>&maxRows=15&veicoli_sw_=true&veicoli_tr_=true&veicoli_p_=<%=numeroAutoveicoli %>&veicoli_mr_=15');">Inserisci Singolo Veicolo</a>
			</dhv:permission>
		
		<br>
		
		<%if(request.getAttribute( "tabella" )!=null)  {%>
		
		

		<%
		request.setAttribute("Organization",OrgDetails);
		%>
		
		
		<form name="aiequidiForm" action="VeicoliList.do?orgId=<%=OrgDetails.getOrgId() %>">
		<input type="hidden" name="orgId" value="<%=OrgDetails.getOrgId() %>">
	       <%=request.getAttribute( "tabella" )%>
	    <jmesa:tableFacade editable="true" >   <jmesa:htmlRow uniqueProperty="id">   </jmesa:htmlRow></jmesa:tableFacade>
	    
	     
	    </form>



	<script type="text/javascript">
            function onInvokeAction(id) {
            	alert($.jmesa);
                $.jmesa.setExportToLimit(id, '');
                $.jmesa.createHiddenInputFieldsForLimitAndSubmit(id);
            }
            function onInvokeExportAction(id) {
                var parameterString = $.jmesa.createParameterStringForLimit(id);
				
                 location.href = 'VeicoliList.do?&' + parameterString;
            }
    </script>



<%} %>
</td>
<td>
<br>
<dhv:permission name="carica-autoveicoli-add">
	<a href="javascript:chiamaActionVeicoli('VeicoliList.do?command=Add&tipoaggiunto=sede&scroll=','&orgId=<%=OrgDetails.getId() %>&sedi_sw_=true&sedi_tr_=true&sedi_p_=<%=numeroSedi %>&sedi_mr_=15');">Inserisci Singola Sede Operativa</a>
	</dhv:permission>
<br>
		
		<%if(request.getAttribute( "tabella2" )!=null)  {%>
		<%
		request.setAttribute("Organization",OrgDetails);
		%>
		
		
		<form name="aiequidiForm" action="VeicoliList.do?orgId=<%=OrgDetails.getOrgId() %>">
		<input type="hidden" name="orgId" value="<%=OrgDetails.getOrgId() %>">
	       <%=request.getAttribute( "tabella2" )%>
	    <jmesa:tableFacade editable="true" >   <jmesa:htmlRow uniqueProperty="id">   </jmesa:htmlRow></jmesa:tableFacade>
	    
	     
	    </form>



	<script type="text/javascript">
            function onInvokeAction(id) {
                $.jmesa.setExportToLimit(id, '');
                $.jmesa.createHiddenInputFieldsForLimitAndSubmit(id);
            }
            function onInvokeExportAction(id) {
                var parameterString = $.jmesa.createParameterStringForLimit(id);
				
                 location.href = 'VeicoliList.do?&' + parameterString;
            }
    </script>
<%} %>
</td>
</tr>
</table>

<%} %>

</br>

<p>
			Utilizzare le caselle vuote sopra l'intestazione per filtrare.
		</p>

	<%if(request.getAttribute( "tabella3" )!=null)  { %>
		<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details" id="responsabile">
			<tr>
				<th colspan="2">
					<strong>
						<dhv:label name="">Personale</dhv:label>
					</strong>
				</th>
			</tr>
			
			
		<tr>
		<td>
		<br>
		<dhv:permission name="carica-autoveicoli-add">
				<a href="javascript:chiamaActionVeicoli('VeicoliList.do?command=Add&tipoaggiunto=personale&scroll=','&orgId=<%=OrgDetails.getId() %>&maxRows=15&personale_tr_=true&personale_p_=<%=numeroPersonale %>&personale_mr_=15');">Inserisci Singola Persona</a>
		</dhv:permission>

		<br>

		<%
		request.setAttribute("Organization",OrgDetails);
		%>
		
		<form name="aiequidiForm" action="VeicoliList.do?orgId=<%=OrgDetails.getOrgId() %>">
		<input type="hidden" name="orgId" value="<%=OrgDetails.getOrgId() %>">
	       <%=request.getAttribute( "tabella3" )%>
	    <jmesa:tableFacade editable="true" >   <jmesa:htmlRow uniqueProperty="id">   </jmesa:htmlRow></jmesa:tableFacade>
	    </form>
	<script type="text/javascript">
            function onInvokeAction(id) {
                $.jmesa.setExportToLimit(id, '');
                $.jmesa.createHiddenInputFieldsForLimitAndSubmit(id);
            }
            function onInvokeExportAction(id) {
                var parameterString = $.jmesa.createParameterStringForLimit(id);
				
                 location.href = 'VeicoliList.do?&' + parameterString;
            }
    </script>
</td>
</tr>
</table>

<%} %>
</br>
		<dhv:evaluate if="<%= hasText(OrgDetails.getNotes()) %>">
<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
  <tr>
    <th colspan="2">
	    <strong><dhv:label name="requestor.requestor_add.AdditionalDetails">Additional Details</dhv:label></strong>
	  </th>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
      <dhv:label name="accounts.accountasset_include.Notes">Notes</dhv:label>
    </td>
    <td>
      <%=toHtml(OrgDetails.getNotes()) %>&nbsp;
    </td>
  </tr>
</table>
<br />
</dhv:evaluate>
<%-- %>
<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
  <tr>
    <th colspan="2">
      <strong><dhv:label name="requestor.requestor_contacts_calls_details.RecordInformation">Record Information</dhv:label></strong>
    </th>     
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
      <dhv:label name="requestor.requestor_calls_list.Entered">Entered</dhv:label>
    </td>
    <td>
      <dhv:username id="<%= OrgDetails.getEnteredBy() %>" />
      <zeroio:tz timestamp="<%= OrgDetails.getEntered() %>" timeZone="<%= User.getTimeZone() %>" showTimeZone="false" />
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
      <dhv:label name="requestor.requestor_contacts_calls_details.Modified">Modified</dhv:label>
    </td>
    <td>
      <dhv:username id="<%= OrgDetails.getModifiedBy() %>" />
      <zeroio:tz timestamp="<%= OrgDetails.getModified() %>" timeZone="<%= User.getTimeZone() %>" showTimeZone="false" />
    </td>
  </tr>
</table>--%>
</br>
<dhv:evaluate if="<%=(!OrgDetails.isTrashed() && OrgDetails.getStato().equals("Attivo"))%>">

<dhv:evaluate if="<%=OrgDetails.isTrashed()%>">
    <dhv:permission name="trasportoanimali-trasportoanimali-edit">
      <input type="button" value="Ripristina"	onClick="javascript:window.location.href='TrasportoAnimali.do?command=Restore&orgId=<%= OrgDetails.getOrgId() %>';">
    </dhv:permission>
</dhv:evaluate>
<dhv:evaluate if="<%=!OrgDetails.isTrashed()%>">
  <!--  
  <dhv:evaluate if="<%=(OrgDetails.getEnabled())%>">
    <dhv:permission name="trasportoanimali-trasportoanimali-edit"><input type="button" value="Modifica"	onClick="javascript:window.location.href='TrasportoAnimali.do?command=Modify&orgId=<%= OrgDetails.getOrgId() %><%= addLinkParams(request, "popup|actionplan") %>';"></dhv:permission>
  </dhv:evaluate>
  -->
  
 <%-- if ((!OrgDetails.getAccountNumber().equals(""))&& (User.getActualUserId() != 1)){ %>
  <dhv:permission name="trasportoanimali-trasportoanimali-edit"><input type="button" disabled="disabled" title="Non � possibile effettuare la modifica in quanto � gi� stato generato il Numero Registrazione" value="Modifica"	onClick="javascript:window.location.href='TrasportoAnimali.do?command=Modify&orgId=<%= OrgDetails.getOrgId() %><%= addLinkParams(request, "popup|actionplan") %>';"></dhv:permission>
  <%} else { --%>
  
  
  <dhv:evaluate if="<%=(OrgDetails.getEnabled())%>">
    <dhv:permission name="trasportoanimali-trasportoanimali-edit"><input type="button" value="Modifica"	onClick="javascript:window.location.href='TrasportoAnimali.do?command=Modify&orgId=<%= OrgDetails.getOrgId() %><%= addLinkParams(request, "popup|actionplan") %>';"></dhv:permission>
  </dhv:evaluate>
  <%--} --%>
  
  <dhv:evaluate if="<%=!(OrgDetails.getEnabled())%>">
    <dhv:permission name="trasportoanimali-trasportoanimali-edit">
      <input type="button" value="<dhv:label name="global.button.Enable">Enable</dhv:label>" 	onClick="javascript:window.location.href='TrasportoAnimali.do?command=Enable&orgId=<%= OrgDetails.getOrgId() %>';">
    </dhv:permission>
  </dhv:evaluate>
  <dhv:evaluate if='<%= (request.getParameter("actionplan") == null) %>'>
    <dhv:permission name="trasportoanimali-trasportoanimali-delete"><input type="button" value="<dhv:label name="">Elimina</dhv:label>" onClick="javascript:popURLReturn('TrasportoAnimali.do?command=ConfirmDelete&id=<%=OrgDetails.getId()%>&popup=true','TrasportoAnimali.do?command=Search', 'Delete_account','320','200','yes','no');"></dhv:permission>
  </dhv:evaluate>
</dhv:evaluate>
</dhv:evaluate>
</dhv:container>
<%= addHiddenParams(request, "popup|popupType|actionId") %>
<% if (request.getParameter("return") != null) { %>
<input type="hidden" name="return" value="<%=request.getParameter("return")%>">
<%}%>
<% if (request.getParameter("actionplan") != null) { %>
<input type="hidden" name="actionplan" value="<%=request.getParameter("actionplan")%>">
<%}%>
<script>
document.body.scrollTop=<%= request.getAttribute("scroll") %>;
</script>

<div id="boxes">

<%-- IL CAMPO SRC � DA AGGIUSTARE --%>
<div id="dialog4" class="window" width="600" height="380">
  <jsp:include page="gestione_stato.jsp"/>
</div>
<input type = "text" name="data_presentazione_richiesta" id="data_presentazione_richiesta" value="<%= OrgDetails.getDate1() %>">


<!-- Mask to cover the whole screen -->
  <div id="mask"></div>

</div>
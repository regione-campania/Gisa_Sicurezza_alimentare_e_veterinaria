
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv"%>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio"%>
<%@ page import="java.util.*,java.text.DateFormat,org.aspcfs.modules.abusivismi.base.*,org.aspcfs.utils.web.*,org.aspcfs.modules.contacts.base.*"%>

<%@page import="org.aspcfs.modules.accounts.base.Comuni"%>


<%@page import="org.aspcfs.modules.base.Address"%>
<%@page import="org.aspcfs.modules.operatori_commerciali.base.OrganizationEmailAddress"%><jsp:useBean id="OrgEmailTypeList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="OrgDetails" class="org.aspcfs.modules.operatori_commerciali.base.Organization" scope="request" />
<jsp:useBean id="SiteList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="tipoOperatore" class="org.aspcfs.utils.web.LookupList" scope="request" />

<jsp:useBean id="ComuniAdmin" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="Comuni" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session" />
<jsp:useBean id="applicationPrefs" class="org.aspcfs.controller.ApplicationPrefs" scope="application" />
<jsp:useBean id="systemStatus" class="org.aspcfs.controller.SystemStatus" scope="request" />
<jsp:useBean id="popup" class="java.lang.String" scope="request" />	

<%@ include file="../utils23/initPage.jsp"%>
<script language="JavaScript" TYPE="text/javascript"
	SRC="javascript/checkDate.js"></script>
<script language="JavaScript" TYPE="text/javascript"
	SRC="javascript/checkString.js"></script>
<script language="JavaScript" TYPE="text/javascript"
	SRC="javascript/checkPhone.js"></script>
<script language="JavaScript" TYPE="text/javascript"
	SRC="javascript/checkNumber.js"></script>
<script language="JavaScript" TYPE="text/javascript"
	SRC="javascript/checkEmail.js"></script>
<script language="JavaScript" TYPE="text/javascript"
	SRC="javascript/popCalendar.js"></script>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript"
	SRC="javascript/popLookupSelect.js"></script>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript"
	SRC="javascript/popCheckList.js"></script>
<script language="JavaScript" TYPE="text/javascript"
	SRC="javascript/spanDisplay.js"></script>
<script language="JavaScript" TYPE="text/javascript"
	SRC="javascript/confirmDelete.js"></script>
<script language="JavaScript" TYPE="text/javascript"
	SRC="javascript/checkURL.js"></script>
<script language="JavaScript" TYPE="text/javascript"
	SRC="javascript/setSalutation.js"></script>
<SCRIPT LANGUAGE="JavaScript" SRC="javascript/CalendarPopup.js"></SCRIPT>
	
<SCRIPT LANGUAGE="JavaScript" ID="js19">
	var cal19 = new CalendarPopup();
	cal19.showYearNavigation();
	cal19.showYearNavigationInput();
	cal19.showNavigationDropdowns();
</SCRIPT>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/jquerymini.js"></script>
<script language="JavaScript" TYPE="text/javascript">

function doCheck(form){
	  if(form.dosubmit.value=="false") {
		
		  return true;
	  }

	  else {
		  if(checkForm(form)) {
			
			  return true;
		  }
		  else
			  return false;
		  
	  }
} function checkForm(form) {
    formTest = true;
    message = "";
    alertMessage = "";
    
    
    if (form.siteId.value == "-1"){
        message += "- ASL richiesta\r\n";
        formTest = false;
     }
   
   
   if (form.name.value==""){
       message += "- Nome Impresa richiesto\r\n";
        formTest = false;
      }

   if (form.codiceFiscaleRappresentante.value==""){
       message += "- Codice Fiscale Rappresentante richiesto\r\n";
        formTest = false;
      }

   if (form.nomeRappresentante.value==""){
       message += "- Nome Rappresentante richiesto\r\n";
        formTest = false;
      }

   if (form.cognomeRappresentante.value==""){
       message += "- Cognome Rappresentante richiesto\r\n";
        formTest = false;
      }
   
   
     if (checkNullString(form.address1line1.value)){
        message += "- Indirizzo Sede Legale richiesto\r\n";
        formTest = false;
      }
     if (checkNullString(form.address2line1.value)){
         message += "- Indirizzo Sede Operativa richiesto\r\n";
         formTest = false;
       }

     if (checkNullString(form.address1city.value)){
         message += "- Comune Sede Legale richiesto\r\n";
         formTest = false;
       }
         if (form.address2city.value=="-1"){
             message += "- Comune Sede Operativa richiesto\r\n";
             formTest = false;
           }
     
     
     if (checkNullString(form.autorizzazione.value)){
         message += "- Campo Autorizzazione richiesto\r\n";
         formTest = false;
       }

        
     if (form.partitaIva && form.partitaIva.value!=""){
       	 
       	
       			/* [MATTEO CARELLA] */
       			/* validazione clientside della partita iva con l'utilizzo di jquery */
       			
       			var partitaIva = $('#partitaIva').val();
       			var regexPiva = /^[0-9]{11}$/;
				if(!regexPiva.test(partitaIva)){
					message += "- Valore errato per il campo Partita IVA, il valore deve essere di 11 caratteri numerici\r\n";
					formTest = false;
				}
				
				/* fine */
       		
    	 }
	


		
	array = document.getElementById('tipologiaOperatoreCommerciale').options ;
	for(i = 0 ; i< array.length; i ++)
	{
		if (array[i].value == '-1' && array[i].selected == true)
		{
			 message += "- Specificare la specie animali \r\n";
				 formTest = false;
				 break ;

		}
		if ((array[i].value == '5' && array[i].selected == true) || (array[i].value == '6' && array[i].selected == true) || (array[i].value == '7' && array[i].selected == true))
		{
			 message += "- Attenzione non � possibile inserire cani , gatti o furetti. Operatori importati dalla bdr ! \r\n";
				 formTest = false;
				 break ;

		}
	}
   	       

    if (formTest == false) {
      alert(label("check.form", "Form could not be saved, please check the following:\r\n\r\n") + message);
      return false;
    } else {
      var test = document.addAccount.selectedList;
      if (test != null) {
        selectAllOptions(document.addAccount.selectedList);
      }
      if(alertMessage != "") {
        confirmAction(alertMessage);
      }
      return true;
    }
  }


</script>

<script src="javascript/geocodifica.js" type="text/javascript" language="JavaScript"></script>
<script src="dwr/interface/Geocodifica.js" type="text/javascript" language="JavaScript"></script>
<script src="dwr/engine.js" type="text/javascript" language="JavaScript"></script>

<script>
var campoLat;
	var campoLong;
	function showCoordinate(address,city,prov,cap,campo_lat,campo_long)
	{
	   campoLat = campo_lat;
	   campoLong = campo_long;
	   Geocodifica.getCoordinate(address,city,prov,cap,'','','',setGeocodedLatLonCoordinate);
	   
	   
	}
	function setGeocodedLatLonCoordinate(value)
	{
		campoLat.value = value[1];;
		campoLong.value =value[0];
		
	}
</script>


<table class="trails" cellspacing="0">
<tr>
<td>
<a href="OperatoriCommerciali.do">Operatori Commerciali</a> > 

<a href="OperatoriCommerciali.do?command=Search">Risultati Ricerca</a> >
<a href="OperatoriCommerciali.do?command=Details&orgId=<%=OrgDetails.getOrgId()%>">Scheda Operatore Commerciale</a> >
Modifica 
</td>
</tr>
</table>
<form name="addAccount" action="OperatoriCommerciali.do?command=Update&auto-populate=true" onSubmit="return doCheck(this);" method="post">
	
	<input type="submit" value="Aggiorna" name="Save" onClick="this.form.dosubmit.value='true';">

	
	<br />
	<br />
	
	<table cellpadding="4" cellspacing="0" border="0" width="100%"
		class="details">
		<tr>
			<th colspan="2"><strong>Modifica Operatore Commerciale</strong>
			</th>
		</tr>

		
		<dhv:include name="abusivismi-sites" none="true">
				<dhv:evaluate if="<%= SiteList.size() > 1 %>">
					<tr>
						<td nowrap class="formLabel"><dhv:label
								name="abusivismi.site">Site</dhv:label></td>
						<td>
						<dhv:evaluate if="<%= User.getSiteId() == -1 %>">
						<%
if(OrgDetails.getListatipologiaOperatoriCommerciali().size()>0 && 
! OrgDetails.getListatipologiaOperatoriCommerciali().containsValue("CANI") && 
! OrgDetails.getListatipologiaOperatoriCommerciali().containsValue("GATTI") && 
! OrgDetails.getListatipologiaOperatoriCommerciali().containsValue("FURETTI") )
	
{
%>
<%=SiteList.getHtmlSelect("siteId",OrgDetails.getSiteId()) %>
<%}
else
{
						%>
								<%=SiteList.getSelectedValue(OrgDetails.getSiteId())%>

								<input type="hidden" name="siteId" value="<%=OrgDetails.getSiteId()%>">
<%} %>
							</dhv:evaluate> 
							
							<dhv:evaluate if="<%= User.getSiteId() != -1 %>">
								<%=SiteList.getSelectedValue(User
										.getSiteId())%>
								<input type="hidden" name="siteId" value="<%=User.getSiteId()%>">
							</dhv:evaluate><font color="red">*</font></td>
					</tr>
				</dhv:evaluate>
				<dhv:evaluate if="<%= SiteList.size() <= 1 %>">
					<input type="hidden" name="siteId" id="siteId" value="-1" />
				</dhv:evaluate>
			</dhv:include>
		
		<dhv:include name="accounts-name" none="true">
			<tr>
				<td nowrap class="formLabel" name="orgname1" id="orgname1">
					Impresa
				</td>
				<td><input type="text" size="50" maxlength="80" id="name1"
					name="name" value="<%=toHtmlValue(OrgDetails.getName())%>"><font
					color="red">*</font><%=showAttribute(request, "nameError")%></td>
			</tr>
		</dhv:include>
		
		<tr>
			<td class="formLabel" nowrap>Partita IVA</td>
			<td>
			 <%


if(OrgDetails.getListatipologiaOperatoriCommerciali().size()>0 && 
! OrgDetails.getListatipologiaOperatoriCommerciali().containsValue("CANI") && 
! OrgDetails.getListatipologiaOperatoriCommerciali().containsValue("GATTI") && 
! OrgDetails.getListatipologiaOperatoriCommerciali().containsValue("FURETTI") )
	
{
%>
				<input type="text" size="20" maxlength="11" name="partitaIva" ID='partitaIva' value="<%=toHtmlValue(OrgDetails.getPartitaIva())%>">

<%}
else
{
%>
				<input type="text" size="20" maxlength="11" readonly="readonly" name="partitaIva" ID='partitaIva' value="<%=toHtmlValue(OrgDetails.getPartitaIva())%>">


<%}
%>  
			</td>
		</tr>
		
<tr class="containerBody">
		<td nowrap class="formLabel">
    	  <dhv:label name="">Autorizzazione</dhv:label>
		</td>
		<td>
						<input type="text" size="20" maxlength="11" name="autorizzazione" ID='autorizzazione' value="<%=toHtmlValue(OrgDetails.getAutorizzazione())%>">
						<font color = "red">*</font>
		
        	 
		</td>
	</tr>
		
		<tr class="containerBody">
		<td nowrap class="formLabel">
    	  <dhv:label name="">Data</dhv:label>
		</td>
		<td>
		
		<input readonly type="text" id="dataRicezioneAutorizzazione" name="dataRicezioneAutorizzazione" size="10" value = "<%= toDateString(OrgDetails.getDataRicezioneAutorizzazione()) %>" />
		<a href="#" onClick="cal19.select(document.forms[0].dataRicezioneAutorizzazione,'anchor19','dd/MM/yyyy'); return false;" NAME="anchor19" ID="anchor19">
		<img src="images/icons/stock_form-date-field-16.gif" border="0" align="absmiddle"></a>
        
		
        	 
		</td>
	</tr>
		
			<tr class="containerBody">
		<td nowrap class="formLabel">
    	  <dhv:label name="">Specie Animali</dhv:label>
		</td>
		<td>

<%		
tipoOperatore.removeElementByLevel(5);
tipoOperatore.removeElementByLevel(6);
tipoOperatore.removeElementByLevel(7);
%>

		<%
		tipoOperatore.setMultiple(true);
		tipoOperatore.setSelectSize(7);
		
		HashMap<Integer,String> listaTipi = OrgDetails.getListatipologiaOperatoriCommerciali();
		LookupList lookupSel = new LookupList();
		Iterator<Integer> itK = listaTipi.keySet().iterator();
		while (itK.hasNext())
		{
			int id = itK.next();
			String desc = listaTipi.get(id);
			LookupElement el = new LookupElement();
			el.setCode(id);
			el.setDescription(desc);
			lookupSel.add(el);
		}
		
		%>
		<%=tipoOperatore.getHtmlSelect("tipologiaOperatoreCommerciale",lookupSel) %>	 <font color = "red"></font>
	
        	 
		</td>
	</tr>

	</table>
	<br>
	<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
  <tr>
    <th colspan="2">
      <strong><dhv:label name="">Titolare o Legale Rappresentante</dhv:label></strong>
      
    </th>
  </tr>
  
  <tr >
    <td class="formLabel" nowrap>
    
  						
      Codice Fiscale
    </td>
    <td>
   
      <input type="text" size="30" maxlength="16"  name="codiceFiscaleRappresentante" value="<%= toHtmlValue(OrgDetails.getCodiceFiscaleRappresentante()) %>"><font color="red">*</font>
    </td>
  </tr>
  <tr >
    <td class="formLabel" nowrap>
      Nome
    </td>
    <td>
      <input type="text" size="30" maxlength="50" name="nomeRappresentante" value="<%= toHtmlValue(OrgDetails.getNomeRappresentante()) %>"><font color="red">*</font>
    </td>
  </tr>
  <tr >
    <td class="formLabel" nowrap>
      Cognome
    </td>
    <td>
      <input type="text" size="30" maxlength="50" name="cognomeRappresentante" value="<%= toHtmlValue(OrgDetails.getCognomeRappresentante()) %>"><font color="red">*</font>
    </td>
  </tr>
  <tr>
      <td nowrap class="formLabel">
        <dhv:label name="">Data Nascita</dhv:label>
      </td>
      <td>
      	<input readonly type="text" id="dataNascitaRappresentante" name="dataNascitaRappresentante" size="10" />
		<a href="#" onClick="cal19.select(document.forms[0].dataNascitaRappresentante,'anchor19','dd/MM/yyyy'); return false;" NAME="anchor19" ID="anchor19">
		<img src="images/icons/stock_form-date-field-16.gif" border="0" align="absmiddle"></a>
      	
      
        <%= showAttribute(request, "alertDateError") %>
        <%= showWarningAttribute(request, "alertDateWarning") %>
        
      </td>
    </tr>
  <tr >
    <td class="formLabel" nowrap>
      <dhv:label name="">Comune di nascita</dhv:label>
    </td>
    <td>
      <input type="text" size="30" maxlength="50" name="luogoNascitaRappresentante" value="<%= toHtmlValue(OrgDetails.getLuogoNascitaRappresentante()) %>">
    </td>
  </tr>
  <tr >
    <td class="formLabel" nowrap>
      <dhv:label name="">Comune di residenza</dhv:label>
    </td>
    <td>
      <input type="text" size="30" maxlength="50" name="city_legale_rapp" value="<%= toHtmlValue(OrgDetails.getCity_legale_rapp()) %>"> 
    </td>
  </tr>
  <tr >
    <td class="formLabel" nowrap>
      <dhv:label name="">Provincia</dhv:label>
    </td>
    <td>
      <input type="text" size="30" maxlength="50" name="prov_legale_rapp" value="<%= toHtmlValue(OrgDetails.getProv_legale_rapp()) %>">
    </td>
  </tr>
  <tr >
    <td class="formLabel" nowrap>
      <dhv:label name="">Indirizzo</dhv:label>
    </td>
    <td>
      <input type="text" size="30" maxlength="50" name="address_legale_rapp" value="<%= toHtmlValue(OrgDetails.getAddress_legale_rapp()) %>">
    </td>
  </tr>
  
  
  
  <tr >
    <td class="formLabel" nowrap>
      <dhv:label name="">Email</dhv:label>
    </td>
    <td>
      <input type="text" size="30" maxlength="50" name="emailRappresentante" value="<%= toHtmlValue(OrgDetails.getEmailRappresentante()) %>">
    </td>
    
  </tr>
  
  <tr >
    <td class="formLabel" nowrap>
      <dhv:label name="">Telefono</dhv:label>
    </td>
    <td>
      <input type="text" size="30" maxlength="50" name="telefonoRappresentante" value="<%= toHtmlValue(OrgDetails.getTelefonoRappresentante()) %>">
    </td>
    
  </tr>
  
  <tr >
    <td class="formLabel" nowrap>
      <dhv:label name="">Fax</dhv:label>
    </td>
    <td>
      <input type="text" size="30" maxlength="50" name="fax" value="<%= toHtmlValue(OrgDetails.getFax()) %>">
    </td>
    
  </tr>
</table>
	
<br>		
<br>

<%
 Address Address = OrgDetails.getAddressList().getAddress(1) ;
Address AddressSedeOperativa = OrgDetails.getAddressList().getAddress(2) ;

%>



<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
  <tr>
    <th colspan="2">
	    <strong>Sede Legale</strong>
	    <input type="hidden" name="address1type" value="1">
	    <input type="hidden" name="address1id" value="<%=Address.getId() %>">
	  </th>
  <tr>
	<td nowrap class="formLabel" name="province" id="province">
      <dhv:label name="requestor.requestor_add.City">City</dhv:label>
    </td> 
    <td > 
    <table class = "noborder">
    <td>
    <input type="text" name="address1city" id="address1city" value = "<%=toHtmlValue(Address.getCity()) %>" style="display: block;">
    <font color = "red"></font>
	</td><td><div id = "sl"></div> </td></table>
	
	</td>
  	</tr>	
  <tr>
    <td nowrap class="formLabel">
      <dhv:label name="requestor.requestor_add.AddressLine1">Address Line 1</dhv:label>
    </td>
    <td>
      <input type="text" size="40" id="address1line1" name="address1line1" maxlength="80" value="<%= toHtmlValue(Address.getStreetAddressLine1()) %>"><font color="red">*</font>
    </td>
  </tr>
  <tr>
    <td nowrap class="formLabel">
      <dhv:label name="">C/O</dhv:label>
    </td>
    <td>
      <input type="text" size="40" name="address1line2" maxlength="80" value = "<%=toHtmlValue(Address.getStreetAddressLine2()) %>">
    </td>
  </tr>

  
  <tr>
    <td nowrap class="formLabel">
      <dhv:label name="requestor.requestor_add.ZipPostalCode">Zip/Postal Code</dhv:label>
    </td>
    <td>
      <input type="text" size="28" name="address1zip" maxlength="5" value = "<%=toHtmlValue(Address.getZip()) %>">
    </td>
  </tr>
  
  	<tr>
    <td nowrap class="formLabel">
      <dhv:label name="requestor.requestor_add.StateProvince">State/Province</dhv:label>
    </td>
    <td>
    	  <input type="text" size="28" name="address1state" maxlength="80" value="<%= toHtmlValue(Address.getState()) %>">          
           
    </td>
  </tr>
 

  
   <tr class="containerBody">
    <td class="formLabel" nowrap><dhv:label name="requestor.address.latitude">Latitude</dhv:label></td>
    <td>
    	<input type="text" readonly="readonly"  id="address1latitude" name="address1latitude" size="30" value="" >
    </td>
  </tr>
  <tr class="containerBody">
    <td class="formLabel" nowrap><dhv:label name="requestor.address.longitude">Longitude</dhv:label></td>
    <td><input type="text" readonly="readonly"  id="address1longitude" name="address1longitude" size="30" value="" ></td>
  </tr>
  <tr style="display: block">
    <td colspan="2">
    	<input id="coordbutton" type="button" value="Calcola Coordinate" 
    	onclick="javascript:showCoordinate(document.getElementById('address1line1').value, document.forms['addAccount'].address1city.value,document.forms['addAccount'].address1state.value, document.forms['addAccount'].address1zip.value, document.forms['addAccount'].address1latitude, document.forms['addAccount'].address1longitude);" /> 
    </td>
  </tr> 
</table>

<br>
   
    

<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
  <tr>
    <th colspan="2">
	    <strong><dhv:label name="">Sede Operativa</dhv:label></strong>
	  <input type="hidden" name="address2type" value="2">
	  <input type="hidden" name="address2id" value="<%=AddressSedeOperativa.getId() %>">
	  </th>
  </tr>
 <tr>
	<td nowrap class="formLabel" name="province1" id="prov2">
      <dhv:label name="requestor.requestor_add.City">City</dhv:label>
    </td> 
    <td > 
    <%
if(OrgDetails.getListatipologiaOperatoriCommerciali().size()>0 && 
! OrgDetails.getListatipologiaOperatoriCommerciali().containsValue("CANI") && 
! OrgDetails.getListatipologiaOperatoriCommerciali().containsValue("GATTI") && 
! OrgDetails.getListatipologiaOperatoriCommerciali().containsValue("FURETTI") )
	
{
	%>
	
	<select  name="address2city" id="prov12">
	<option value="-1">Nessuna Selezione</option>
            
	 <%
                Vector v4 = OrgDetails.getComuni2();
	 			Enumeration e4=v4.elements();
                while (e4.hasMoreElements()) {
                	String prov4=e4.nextElement().toString();
                	
        %>
                <option value="<%=prov4%>" <%if(prov4.equalsIgnoreCase(AddressSedeOperativa.getCity())) {%> selected="selected" <%} %>><%= prov4 %></option>	
              <%}%>
		
	</select> 
	<%

}
else
{
	
	out.print(AddressSedeOperativa.getCity() );
%>
              <input type = "hidden" name = "address2city" id = "address2city" value = "<%=AddressSedeOperativa.getCity() %>"> <font color = "red"></font>

<%	
}
%>
		
	<div id = "so"></div> 
	</td>
  	</tr>	
  	  	
  <tr>
    <td nowrap class="formLabel" id="indirizzo1">
      Indirizzo
    </td>
    <td>
      <input type="text" size="40" name="address2line1" maxlength="80" id="indirizzo12" value="<%= toHtmlValue(AddressSedeOperativa.getStreetAddressLine1()) %>"><font color = "red"></font>
    </td>
  </tr>
  
  
  <tr>
    <td nowrap class="formLabel" id="cap1">
      <dhv:label name="requestor.requestor_add.ZipPostalCode">Zip/Postal Code</dhv:label>
    </td>
    <td>
      <input type="text" size="28" name="address2zip" maxlength="5" value = "<%=toHtmlValue(AddressSedeOperativa.getZip()) %>" id="cap">
    </td>
  </tr>  
  	 
  	<tr>
    <td nowrap class="formLabel" id="stateProv2" >
      <dhv:label name="requestor.requestor_add.StateProvince">State/Province</dhv:label>
    </td>
    <td>
          <% if (User.getSiteId() == 202) { %>
          <input type="text" readonly="readonly" size="28" name="address2state" maxlength="80" value="BN">          
          <%}%>
          <% if (User.getSiteId() == 201) { %>
          <input type="text" readonly="readonly" size="28" name="address2state" maxlength="80" value="AV">
          <%}%>
          <% if (User.getSiteId() == 203) { %>
          <input type="text" readonly="readonly" size="28" name="address2state" maxlength="80" value="CE">
          <%}%>
          <% if (User.getSiteId() == 204 || User.getSiteId() == 205 || User.getSiteId() == 206 ) { %>
          <input type="text" readonly="readonly" size="28" name="address2state" maxlength="80" value="NA">
          <%}%>
          <% if (User.getSiteId() == 207) { %>
          <input type="text" readonly="readonly" size="28" name="address2state" maxlength="80" value="SA">
          <%}%>
          <% if (User.getSiteId() == -1) { %>
          <input type="text"  size="28" name="address2state" maxlength="80" value="">
          <%}%>
    </td>
  </tr>
  
  
   <tr class="containerBody">
    <td class="formLabel" nowrap id="latitude2">Email</td>
    <td>
				<input type="hidden" id="email1type" name="email1type" size="30" value="2">
    	    	<input type="text" id="email1address" name="email1address" size="30" value="<%=(OrgDetails.getEmailAddressList().size()>0) ? ((OrganizationEmailAddress)OrgDetails.getEmailAddressList().get(0)).getEmail() : "" %>"> 
    	    	<input type="hidden" id="email1id" name="email1id" size="30" value="<%=(OrgDetails.getEmailAddressList().size()>0) ? ((OrganizationEmailAddress)OrgDetails.getEmailAddressList().get(0)).getId() : "-1" %>">
    	    	   	
    </td>
  </tr>
  
  <tr class="containerBody">
    <td class="formLabel" nowrap id="latitude2"><dhv:label name="requestor.address.latitude">Latitude</dhv:label></td>
    <td>
    	    	<input type="text" readonly="readonly"  id="address2latitude" name="address2latitude" size="30" value="">
    	
    </td>
  </tr>
  <tr class="containerBody">
    <td class="formLabel" nowrap id="longitude2"><dhv:label name="requestor.address.longitude">Longitude</dhv:label></td>
    <td>
    	<input type="text" readonly="readonly"  id="address2longitude" name="address2longitude" size="30" value="">
    </td>
    </tr>
    
    <tr style="display: block">
    <td colspan="2">
    <input id="coord1button" type="button" value="Calcola Coordinate"
    onclick="javascript:showCoordinate(document.getElementById('indirizzo12').value, document.forms['addAccount'].address2city.value,document.forms['addAccount'].address2state.value, document.forms['addAccount'].address2zip.value, document.forms['addAccount'].address2latitude, document.forms['addAccount'].address2longitude);" /> 
    </td>
    </tr>
   
</table>
		

	<table cellpadding="4" cellspacing="0" border="0" width="100%"
		class="details">
		<tr>
			<th colspan="2"><strong><dhv:label
						name="abusivismi.abusivismi_add.AdditionalDetails">Additional Details</dhv:label></strong>
			</th>
		</tr>
		<tr>
			<td valign="top" nowrap class="formLabel"><dhv:label
					name="abusivismi.abusivismi_add.Notes">Notes</dhv:label></td>
			<td><TEXTAREA NAME="notes" ROWS="3" COLS="50"><%=toString(OrgDetails.getNotes())%></TEXTAREA></td>
		</tr>
	</table>

	<br /> <input type="hidden" name="onlyWarnings"
		value='<%=(OrgDetails.getOnlyWarnings() ? "on" : "off")%>' />
	<input type="submit"
		value="Aggiorna"
		name="Save" onClick="this.form.dosubmit.value='true';" />
	
	
	<input type="hidden" name="dosubmit" value="true" />
	<input type = "hidden" name = "id" value = "<%=OrgDetails.getId() %>">
	<input type = "hidden" name = "orgId" value = "<%=OrgDetails.getId() %>">
</form>
</body>
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
  - Version: $Id: accounts_add.jsp 18488 2007-01-15 20:12:32Z matt $
  - Description:
  --%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*,java.text.DateFormat,org.aspcfs.modules.accounts.base.*,org.aspcfs.utils.web.*,org.aspcfs.modules.contacts.base.*" %>


<jsp:useBean id="Soggetto" class="org.aspcfs.modules.opu.base.SoggettoFisico" scope="request"/>
<jsp:useBean id="Titolo" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="applicationPrefs" class="org.aspcfs.controller.ApplicationPrefs" scope="application"/>

<%@ include file="../utils23/initPage.jsp" %>

<SCRIPT LANGUAGE="JavaScript" SRC="javascript/CalendarPopup.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="javascript/common.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">document.write(getCalendarStyles());</SCRIPT>
<SCRIPT LANGUAGE="JavaScript" ID="js19">
	var cal19 = new CalendarPopup();
	cal19.showYearNavigation();
	cal19.showYearNavigationInput();
	cal19.showNavigationDropdowns();
</SCRIPT>
<%boolean popUp = false;
  if(request.getParameter("popup")!=null){
    popUp = true;
  }%>
  <%
	if (request.getAttribute("Exist") != null && !("").equals(request.getAttribute("Exist"))) 
	{
%> 
<font color="red"><%=(String) request.getAttribute("Exist")%></font>
<%
	}
%> 
<form id = "addSoggetto" name="addSoggetto" action="Soggetto.do?command=Insert&auto-populate=true" method="post">
<%= addHiddenParams(request, "actionSource|popup") %>
<input type="submit" value="Inserisci" name="Save" onClick="">
<dhv:evaluate if="<%= !popUp %>">
  <input type="submit" value="Annulla" onClick="">
</dhv:evaluate>
<dhv:evaluate if="<%= popUp %>">
  <input type="button" value="Annulla" onClick="javascript:self.close();">
</dhv:evaluate></br></br>
 <table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
  <tr>
    <th colspan="2">
      <strong><dhv:label name="">Soggetto fisico</dhv:label></strong>
      
    </th>
  </tr>
  
      <tr>
      <td nowrap class="formLabel">
        <dhv:label name="">Titolo</dhv:label>
      </td>
      <td>
 	<%= Titolo.getHtmlSelect("idTitolo", Soggetto.getIdTitolo()) %>

      </td>
    </tr>
  
  <tr >
    <td class="formLabel" nowrap>
      Codice Fiscale
    </td>
    <td>
      <input type="text" size="30" maxlength="16" name="codFiscale" value=""><font color="red">*</font>
    </td>
  </tr>
  
    <tr >
    <td class="formLabel" nowrap>
      <dhv:label name="">Sesso</dhv:label>
    </td>
    <td>
      <input type="radio" name="sesso" id="sesso" value="M" checked="checked">M
       <input type="radio" name="sesso" id="sesso" value="F">F
    </td>
  </tr>
  
  
  <tr >
    <td class="formLabel" nowrap>
      Nome
    </td>
    <td>
      <input type="text" size="30" maxlength="50" name="nome" value=""><font color="red">*</font>
    </td>
  </tr>
  <tr >
    <td class="formLabel" nowrap>
      Cognome
    </td>
    <td>
      <input type="text" size="30" maxlength="50" name="cognome" value=""><font color="red">*</font>
    </td>
  </tr>
  <tr>
      <td nowrap class="formLabel">
        <dhv:label name="">Data Nascita</dhv:label>
      </td>
      <td>
      	<input readonly type="text" id="dataNascita" name="dataNascita" size="10" />
		<a href="#" onClick="cal19.select(document.forms[0].dataNascita,'anchor19','dd/MM/yyyy'); return false;" NAME="anchor19" ID="anchor19">
		<img src="images/icons/stock_form-date-field-16.gif" border="0" align="absmiddle"></a>
      	
      
  
        
      </td>
    </tr>
  <tr >
    <td class="formLabel" nowrap>
      <dhv:label name="">Comune Nascita</dhv:label>
    </td>
    <td>
      <input type="text" size="30" maxlength="50" name="comuneNascita" value="">
    </td>
  </tr>
    <tr >
    <td class="formLabel" nowrap>
      <dhv:label name="">Provincia Nascita</dhv:label>
    </td>
    <td>
      <input type="text" size="30" maxlength="50" name="provinciaNascita" value="">
    </td>
  </tr>
  <tr >
    <td class="formLabel" nowrap>
      Comune Residenza
    </td>
    <td>
      <input type="text" size="30" maxlength="50" name="addressLegaleCountry" value="">
    </td>
  </tr>
    <tr >
    <td class="formLabel" nowrap>
      <dhv:label name="">Cap residenza</dhv:label>
    </td>
    <td>
      <input type="text" size="30" maxlength="50" name="addressLegaleZip" value="">
    </td>
  </tr>
  
  <tr >
    <td class="formLabel" nowrap>
      <dhv:label name="">Provincia residenza</dhv:label>
    </td>
    <td>
      <input type="text" size="30" maxlength="50" name="addressLegaleCity" value="">
    </td>
  </tr>
  <tr >
    <td class="formLabel" nowrap>
      <dhv:label name="">Indirizzo</dhv:label>
    </td>
    <td>
      <input type="text" size="30" maxlength="50" name="addressLegaleLine1" value="">
    </td>
  </tr>
  
  
  
  <tr >
    <td class="formLabel" nowrap>
      <dhv:label name="">Email</dhv:label>
    </td>
    <td>
      <input type="text" size="30" maxlength="50" name="email" value="">
    </td>
    
  </tr>
  
  <tr >
    <td class="formLabel" nowrap>
      <dhv:label name="">Telefono</dhv:label>
    </td>
    <td>
      <input type="text" size="30" maxlength="50" name="telefono1" value="">
    </td>
    
  </tr>
  
    <tr >
    <td class="formLabel" nowrap>
      <dhv:label name="">Telefono secondario</dhv:label>
    </td>
    <td>
      <input type="text" size="30" maxlength="50" name="telefono2" value="">
    </td>
    
  </tr>
  
  <tr >
    <td class="formLabel" nowrap>
      <dhv:label name="">Fax</dhv:label>
    </td>
    <td>
      <input type="text" size="30" maxlength="50" name="fax" value="">
    </td>
    
  </tr>
  

</table>
</br></br>
<input type="submit" value="Inserisci" name="Save" onClick="">
<dhv:evaluate if="<%= !popUp %>">
  <input type="submit" value="Annulla" onClick="">
</dhv:evaluate>
<dhv:evaluate if="<%= popUp %>">
  <input type="button" value="Annulla" onClick="javascript:self.close();">
</dhv:evaluate>
</form>

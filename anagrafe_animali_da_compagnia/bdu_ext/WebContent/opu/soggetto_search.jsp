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
  - Version: $Id: accounts_search.jsp 18543 2007-01-17 02:55:07Z matt $
  - Description: 
  --%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="org.aspcfs.modules.base.Constants,org.aspcfs.utils.web.*" %>
<jsp:useBean id="SearchSoggettoListInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<jsp:useBean id="TipoSoggettoList" class="org.aspcfs.utils.web.LookupList" scope="request"/> <!-- TIPO SOGGETTO FISICO -->
<jsp:useBean id="StatoRuoloSoggetto" class="org.aspcfs.utils.web.LookupList" scope="request"/> <!-- STATO RUOLO SOGGETTO FISICO -->
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>

<%@ include file="../initPage.jsp" %>

<script language="JavaScript">
  function clearForm() {
    <%-- Account Filters --%>
    document.forms['searchSoggetto'].codiceFiscale.value="";
    document.forms['searchSoggetto'].nome.value="";
    document.forms['searchSoggetto'].cognome.value = '';
      }
</script>

<dhv:include name="accounts-search-name" none="true">
  <body onLoad="javascript:document.searchAccount.searchAccountName.focus();clearForm();">
</dhv:include>
<form name="searchSoggetto" action="Soggetto.do?command=Search" method="post">
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="Soggetto.do"><dhv:label name="anagrafica.soggetto">Soggetto Fisico</dhv:label></a> > 
<dhv:label name="anagrafica.search">Ricerca</dhv:label>
</td>
</tr>
</table>
<%-- End Trails --%>

      <table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
        <tr>
          <th colspan="2">
            <strong><dhv:label name="">Ricerca rapida soggetto</dhv:label></strong>
          </th>
        </tr>
        <tr>
          <td class="formLabel">
            <dhv:label name="">Codice fiscale</dhv:label>
          </td>
          <td>
            <input type="text" maxlength="70" size="50" name="codiceFiscale" value="<%= SearchSoggettoListInfo.getSearchOptionValue("searchAccountName") %>">
          </td>
        </tr>

        <tr>
          <td class="formLabel">
            <dhv:label name="">Nome</dhv:label>
          </td>
          <td>
            <input type="text" maxlength="70" size="50" name="searchNome" value="<%= SearchSoggettoListInfo.getSearchOptionValue("searchAccountName") %>">
          </td>
        </tr>
        
        <tr>
          <td class="formLabel">
            <dhv:label name="">Cognome</dhv:label>
          </td>
          <td>
            <input type="text" maxlength="70" size="50" name="searchCognome" value="<%= SearchSoggettoListInfo.getSearchOptionValue("searchAccountName") %>">
          </td>
        </tr>
</table>

</br></br>
<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
        <tr>
          <th colspan="2">
            <strong><dhv:label name="">Ricerca soggetto per ruolo e/o operatore</dhv:label></strong>
          </th>
        </tr>
    <tr>
      <td nowrap class="formLabel">
        <dhv:label name="">Ruolo Soggetto</dhv:label>
      </td>
      <td>
		<%= TipoSoggettoList.getHtmlSelect("idTipo", -1) %>
	  </td>
    </tr>
    
        <tr>
      <td nowrap class="formLabel">
        <dhv:label name="">Azienda di riferimento <br> (Ragione sociale)</dhv:label>
      </td>
      <td>
		<input type="text" name="searchRagioneSociale" id="searchRagioneSociale"/>
	  </td>
    </tr>
    
     <tr>
      <td nowrap class="formLabel">
        <dhv:label name="">Stato Ruolo Soggetto</dhv:label>
      </td>
      <td>
		<%= StatoRuoloSoggetto.getHtmlSelect("statoRuolo", -1) %>
	  </td>
    </tr>
</table>

</br></br>


<%= addHiddenParams(request, "actionSource|popup") %>
<dhv:include name="accounts-search-contacts" none="false">
  <input type="checkbox" name="searchContacts" value="true" <%= "true".equals(SearchSoggettoListInfo.getCriteriaValue("searchContacts"))? "checked":""%> />
  <dhv:label name="accounts.search.includeContactsInSearchResults">Include contacts in search results</dhv:label><br />
  <br />
</dhv:include></br></br></br></br>
<input type="submit" onclick='' value="<dhv:label name="button.search">Search</dhv:label>">
<input type="button" value="<dhv:label name="button.clear">Clear</dhv:label>" onClick="javascript:clearForm();">
<input type="hidden" name="source" value="searchForm">
<iframe src="empty.html" name="server_commands" id="server_commands" style="visibility:hidden" height="0"></iframe>
<script type="text/javascript">
  </script>
</form>
</body>


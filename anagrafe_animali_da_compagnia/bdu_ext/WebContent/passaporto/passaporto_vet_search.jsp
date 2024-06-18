<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*,org.aspcfs.modules.microchip.base.*,java.text.DateFormat" %>
<jsp:useBean id="aslRifList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<%@ include file="../initPage.jsp" %>
<script language="JavaScript">
</script>
<body>
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td width="100%">
  Cerca microchip
</td>
</tr>
</table>
<%-- End Trails --%>
<form name="searchServiceContracts" action="Microchip.do?command=List&auto-populate=true" method="post">


<table cellpadding="2" cellspacing="2" border="0" width="100%">
  <tr>
    <td width="100%" valign="top">
    
	<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
	  <tr>
	    <th colspan="2">
		  <strong>Informazioni Microchip a priori</strong>
		</th>
	  </tr>
	  <tr class="containerBody">
	    <td nowrap class="formLabel">
	 	  Codice Fiscale
	    </td>
	    <td>
	      <%= request.getAttribute("codiceFiscale") %>
	      <input type="hidden" id="aslRif" name="aslRif" value = "<%= request.getAttribute("codiceFiscale") %>" />
	    </td>
	  </tr>
	  <tr class="containerBody">
	    <td nowrap class="formLabel">
	 	  Microchip
	    </td>
	    <td>
	      <input name="microchip" type="text" size="20" maxlength="15">
	    </td>
	  </tr>
	</table>
   
   </td>
  </tr>
</table>
<br />
<input type="submit" value="<dhv:label name="button.search">Search</dhv:label>">
</form>
</body>
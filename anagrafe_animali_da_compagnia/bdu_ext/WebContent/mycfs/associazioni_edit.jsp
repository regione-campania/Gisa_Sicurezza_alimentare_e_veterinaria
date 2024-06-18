<%-- Trails --%>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/spanDisplay.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/submit.js"></SCRIPT>
<script language="JavaScript" TYPE="text/javascript"  SRC="javascript/popCalendar.js"></script>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="MyCFS.do?command=Home"><dhv:label name="My Home Page" mainMenuItem="true">My Home Page</dhv:label></a> >
<a href="MyCFS.do?command=ListaAssociazioni"><dhv:label name="myitems.mailbox">Gestione associazioni</dhv:label></a> >
Modifica associazione
</td>
</tr>
</table>
<%-- End Trails --%>
<script type="text/javascript">
  function validateEmail(email) { 
	    var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\
	".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA
	-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
	    return re.test(email);
	} 
  
</script>


<jsp:useBean id="associazione" class="org.json.JSONObject" scope="request" />

<form id="nuovaAssociazione" name="nuovaAssociazione" action="MyCFS.do?command=UpdateAssociazione" method="post">

<input type="hidden" name="id" value="<%=associazione.get("id") %>" size="20" /> 

<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,org.aspcfs.modules.mycfs.base.*, org.aspcfs.modules.contacts.base.Contact" %>
<jsp:useBean id="returnUrl" class="java.lang.String" scope="request"/>
<jsp:useBean id="sendUrl" class="java.lang.String" scope="request"/>
<jsp:useBean id="forwardType" class="java.lang.String" scope="request"/>


<%@ include file="../initPage.jsp" %>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/checkString.js"></script>
<script language="JavaScript" type="text/javascript" src="javascript/popContacts.js"></script>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/submit.js"></script>
<script type="text/javascript">
function sendMessage() {
	  formTest = true;
	  message = "";
	  //if(document.newMessageForm.listView.options[0].value == "none") {
	  //  message += label("select.onerecipient","- Select at least one recipient\r\n");
	  //  formTest = false;
	  //}
	  if(checkNullString(document.nuovaAssociazione.denominazione.value)){
	    message += "- Denominazione obbligatoria\r\n";
	    formTest = false;
	  }
	  if(checkNullString(document.nuovaAssociazione.codice_fiscale.value)){
		    message += "- Codice fiscale obbligatorio\r\n";
		    formTest = false;
		  }
	  if(document.nuovaAssociazione.codice_fiscale.value!='' && document.nuovaAssociazione.codice_fiscale.value.length!=16){
		    message += "- Codice fiscale deve essere composto da 16 caratteri\r\n";
		    formTest = false;
		  }
	  if(checkNullString(document.nuovaAssociazione.sede.value)){
		    message += "- Sede obbligatoria\r\n";
		    formTest = false;
		  }
	  if(checkNullString(document.nuovaAssociazione.indirizzo.value)){
		    message += "- Indirizzo obbligatorio\r\n";
		    formTest = false;
		  }
	  if(checkNullString(document.nuovaAssociazione.rappresentante_legale.value)){
		    message += "- Rappresentante Legale obbligatorio\r\n";
		    formTest = false;
		  }
	  if(checkNullString(document.nuovaAssociazione.email.value)){
	    message += "- Mail obbligatoria\r\n";
	    formTest = false;
	  }
	  else {
		  if ( isEmail(document.nuovaAssociazione.email.value)== 0 ) {
			  message += "- Mail non valida\r\n";
			  formTest = false;
		  }
	  }
	  
	  if ( document.nuovaAssociazione.pec.value !='' && isEmail(document.nuovaAssociazione.pec.value)== 0 ) {
		  message += "- PEC non valida\r\n";
		  formTest = false;
	  }
	 
	  if (formTest) {
	    hideSendButton();
	    return true;
	  } else {
	    alert("L'associazione non pu� essere inserita. Controllare i seguenti errori:\r\n\r\n" + message);
	    return false;
	  }
	}

function hideSendButton() {
    try {
      var send1 = document.getElementById('send1');
      send1.value = label('label.sending','Sending...');
      send1.disabled=true;
    } catch (oException) {}
    try {
      var send2 = document.getElementById('send2');
      send2.value = label('label.sending','Sending...');
      send2.disabled=true;
    } catch (oException) {}
  }
  
  
function isEmail(string) {
	if (string.search(/^\w+((-\w+)|(\.\w+))*\@\w+((\.|-)\w+)*\.\w+$/) != -1)
	return 1;
	else
	return 0;
	}

function validateEmail(email) { 
    var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
} 

//SCRIPT AGGIUNTI

</script>
<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
  <tr>
    <th colspan="2">
      <strong>Modifica associazione</strong>
    </th>
  </tr>
  
  
<tr>
       <td>
       		Denominazione <font color="red">*</font>
       	</td> 
       	<td>
       		<input type="text" name="denominazione" value="<%=associazione.get("denominazione") %>" size="20" /> 
       	</td>
   	</tr>
  <tr>
       <td>
       		Codice fiscale <font color="red">*</font>
       	</td> 
       	<td>
       		<input type="text" name="codice_fiscale" value="<%=associazione.get("codice_fiscale") %>" size="20" maxlength="16"/> 
       	</td>
   	</tr>
  <tr>
       <td>
       		Sede <font color="red">*</font>
       	</td> 
       	<td>
       		<input type="text" name="sede" value="<%=associazione.get("sede") %>" size="20" /> 
       	</td>
   	</tr>
  <tr>
       <td>
       		Indirizzo <font color="red">*</font>
       	</td> 
       	<td>
       		<input type="text" name="indirizzo" value="<%=associazione.get("indirizzo") %>" size="20" /> 
       	</td>
   	</tr>
  <tr>
       <td>
       		Rappresentante legale <font color="red">*</font>
       	</td> 
       	<td>
       		<input type="text" name="rappresentante_legale" value="<%=associazione.get("rappresentante_legale") %>" size="20" /> 
       	</td>
   	</tr>
  <tr>
       <td>
       		Telefono 
       	</td> 
       	<td>
       		<input type="text" name="telefono_fisso" value="<%=associazione.get("telefono_fisso") %>" size="20"/> 
       	</td>
   	</tr>
  <tr>
       <td>
       		Telefono Mobile 
       	</td> 
       	<td>
       		<input type="text" name="telefono_mobile" value="<%=associazione.get("telefono_cellulare") %>" size="20"/> 
       	</td>
   	</tr>
  <tr>
       <td>
       		Mail <font color="red">*</font>
       	</td> 
       	<td>
       		<input type="text" name="email" value="<%=associazione.get("mail") %>" size="20" /> 
       	</td>
   	</tr>
  


    <tr>
       <td>
       		PEC
       	</td> 
       	<td>
       		<input type="text" name="pec" value="<%=associazione.get("pec") %>" size="20" /> 
       	</td>
   	</tr>
  
</table>
<br>
<input onclick="if(sendMessage()){document.nuovaAssociazione.submit();}" type="button" id="send1" value="Modifica" />
<input type="button" id="annulla" value="Annulla" onClick="javascript:window.location.href='MyCFS.do?command=ListaAssociazioni'"><br><br>
</form>


            
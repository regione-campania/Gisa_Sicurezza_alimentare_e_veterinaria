<%@ page import="java.util.*,org.aspcfs.modules.trasportoanimali.base.*, org.aspcfs.modules.base.*" %>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ include file="../utils23/initPage.jsp" %>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="fileFolder" class="com.zeroio.iteam.base.FileFolder" scope="request"/>
<script language="JavaScript">
  function checkFileForm(form) {
    var formTest = true;
    var messageText = "";

    
   
    if ( document.inputForm.file1.value == '' ){
        messageText += label("", "Il File � richiesto.\r\n");
        formTest = false;
      }
         
    if (formTest == false) {
      alert(messageText);
      return false;
    }
  }
</script>
<form method="post" name="inputForm" action="TrasportoAnimali.do?command=UploadDoc&carica=veicoli" enctype="multipart/form-data" onSubmit="return checkFileForm(this);">
<dhv:evaluate if="<%= !isPopup(request) %>">
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td width="100%">
  <a href="TrasportoAnimali.do"><dhv:label name="a">Trasporto Animali</dhv:label></a> >
  <dhv:label name="a">Importa Autoveicoli</dhv:label>
</td>
</tr>
</table>
<%-- End Trails --%>
</dhv:evaluate>

  <dhv:formMessage />
  
  <%
  String orgID=(String)session.getAttribute("orgIdVeicolo");
  %>
 
  <input type="hidden" name="siteId" value="<%=User.getSiteId()%>" >
    <input type="hidden" name="orgId" value="<%=orgID%>" >
  
  
  <br>
  <br>
  <table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
  	 <tr class="containerBody">
      <td class="formLabel">
        <dhv:label name="contacts.companydirectory_confirm_importupload.File">File</dhv:label>
      </td>
      <td>
        <input type="file" name="file1" id="file1" size="45"><font color="red">*</font>
        <!-- input type="hidden" name="file" id="file" value="LEISHMANIA_TEST.csv" size="45"-->
      </td>
    </tr>
  </table>
  <p align="center">
    * <dhv:label name="accounts.accounts_documents_upload.LargeFilesUpload">Large files may take a while to upload.</dhv:label><br>
    <dhv:label name="accounts.accounts_documents_upload.WaitForUpload">Wait for file completion message when upload is complete.</dhv:label>
  </p>
<br>
  <a href="TrasportoAnimali.do?command=AllImportRecords&orgid=<%=orgID %>" > Visualizza Tutti gli Import </a>
  <br><br>
  <input type="submit" value=" <dhv:label name="global.button.sav">Procedi</dhv:label> " name="save" onClick="return confirm('Sei sicuro di voler procedere?');"/>
  <input type="button" value="Annulla" onClick="window.location.href='TrasportoAnimali.do?command=Details&orgId=<%=orgID%>'" /><br />
  <dhv:formMessage />
  <br />
</form>

<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
  <tr>
    <th colspan="2">
      <strong><dhv:label name="contacts.companydirectory_confirm_importupload.NewImport">New Import</dhv:label></strong>
    </th>
  </tr>
  <tr class="containerBody">
  <td class="formLabel" nowrap>
    <dhv:label name="contacts.name">Name</dhv:label>
  </td>
  <td class="containerBody">
    <input type="text" name="name" value="<%= toString(ImportDetails.getName()) %>" maxlength="250" size="65"><font color="red">*</font>
    <%= showAttribute(request, "nameError") %>
  </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel" valign="top">
      <dhv:label name="">Descrizione</dhv:label>
    </td>
    <td>
      <TEXTAREA NAME="description" ROWS="3" COLS="50"><%= toString(ImportDetails.getDescription()) %></TEXTAREA>
    </td>
  </tr>
  <tr style="display:none" class="containerBody">
    <td nowrap class="formLabel" valign="top">
      <dhv:label name="campaign.comments">Comments</dhv:label>
    </td>
    <td>
      <TEXTAREA NAME="comments" ROWS="3" COLS="50"><%= toString(ImportDetails.getComments()) %></TEXTAREA>
    </td>
  </tr>
  <tr style="display:none" class="containerBody">
    <td class="formLabel" nowrap>
      <dhv:label name="contacts.source">Source</dhv:label>
    </td>
    <td class="containerBody">
      <%= SourceTypeList.getHtmlSelect("sourceType", ImportDetails.getSourceType()) %>
    </td>
  </tr>
  <tr class="containerBody">
    <td class="formLabel" valign="top">
      <dhv:label name="contacts.companydirectory_confirm_importupload.File">File</dhv:label>
    </td>
    <td>
      <table border="0" cellpadding="0" cellspacing="0" class="empty">
        <tr>
          <td valign="top">
            <input type="file" name="id" size="45">
            <%= showAttribute(request, "fileError") %><font color="red">*</font>
          </td>
        </tr>
        <tr>
          <td valign="top">
            <br><dhv:label name="calendar.fileShouldBeInCSVformat.text">* File should be in CSV format.</dhv:label><br /> <dhv:label name="accounts.accounts_documents_upload.LargeFilesUpload"> Large files may take a while to upload.</dhv:label>
          	
          		<br>* Il Formato dei file previsto � 1� riga: "Numero_Passaporto","ASL"  dalla 2� riga in poi es. "IT23334444333","203"
          
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>


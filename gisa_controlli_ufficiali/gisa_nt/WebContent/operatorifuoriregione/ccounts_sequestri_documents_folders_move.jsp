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
  - Version: $Id: accounts_tickets_documents_folders_move.jsp 11310 2005-04-13 20:05:00Z mrajkowski $
  - Description: 
  --%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,com.zeroio.iteam.base.*, org.aspcfs.modules.troubletickets.base.*" %>
<jsp:useBean id="TicketDetails" class="org.aspcfs.modules.troubletickets.base.Ticket" scope="request"/>
<jsp:useBean id="TicketDocumentListInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<jsp:useBean id="OrgDetails" class="org.aspcfs.modules.accounts.base.Organization" scope="request"/>
<jsp:useBean id="FileFolder" class="com.zeroio.iteam.base.FileFolder" scope="request"/>
<jsp:useBean id="folderHierarchy" class="com.zeroio.iteam.base.FileFolderHierarchy" scope="request"/>
<%@ include file="../utils23/initPage.jsp" %>
<table cellpadding="0" cellspacing="0" width="100%" border="0">
<tr>
  <td>
    <dhv:label name="accounts.accounts_documents_file_move.SelectFolderToMove">Select a folder to move the item to</dhv:label>:<br>
    <img src="images/icons/stock_folder-16-19.gif" border="0" align="absmiddle" />
    <%= toHtml(FileFolder.getSubject()) %>
  </td>
</tr>
</table>
&nbsp;<br>
<table cellpadding="0" cellspacing="0" width="100%" border="1" rules="cols">
  <tr class="section">
    <td valign="top" width="100%">
      <img alt="" src="images/tree7o.gif" border="0" align="absmiddle" height="16" width="19"/>
      <img alt="" src="images/icons/stock_open-16-19.gif" border="0" align="absmiddle" height="16" width="19"/>
    <dhv:evaluate if="<%= FileFolder.getParentId() != -1 %>">
      <a href="AccountSequestriDocumentsFolders.do?command=SaveMove&tId=<%= TicketDetails.getId() %>&id=<%= FileFolder.getId() %>&popup=true&folderId=0&return=AccountRichiesteDocuments&param=<%= TicketDetails.getId() %>&param2=<%= FileFolder.getParentId() %>"><dhv:label name="accounts.accounts_documents_file_move.Home">Home</dhv:label></a>
    </dhv:evaluate>
    <dhv:evaluate if="<%= FileFolder.getParentId() == -1 %>">
      <dhv:label name="accounts.accounts_documents_file_move.Home">Home</dhv:label>
      <dhv:label name="accounts.accounts_documents_file_move.CurrentFolder">(current folder)</dhv:label>
    </dhv:evaluate>
    </td>
  </tr>
<%
  int rowid = 0;
  Iterator i = folderHierarchy.getHierarchy().iterator();
  while (i.hasNext()) {
    rowid = (rowid != 1?1:2);
    FileFolder thisFolder = (FileFolder) i.next();
%>    
  <tr class="row<%= rowid %>">
    <td valign="top">
    <% for(int j=1;j<thisFolder.getLevel();j++){ %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%}%>
      <img border="0" src="images/treespace.gif" align="absmiddle" height="16" width="19">
      <img alt="" src="images/tree7o.gif" border="0" align="absmiddle" height="16" width="19"/>
      <img border="0" src="images/icons/stock_open-16-19.gif" align="absmiddle">
    <% if(FileFolder.getParentId() != thisFolder.getId() && (FileFolder.getId() != thisFolder.getId())){  %>
      <a href="AccountSequestriDocumentsFolders.do?command=SaveMove&tId=<%= TicketDetails.getId() %>&id=<%= FileFolder.getId() %>&popup=true&folderId=<%= thisFolder.getId() %>&return=AccountRichiesteDocuments&param=<%= TicketDetails.getId() %>&param2=<%= FileFolder.getParentId() %>"><%= toHtml(thisFolder.getSubject()) %></a>
    <% } else if(FileFolder.getId() == thisFolder.getId()) { %>
        <%= toHtml(thisFolder.getSubject()) %>
        (selected folder)
    <% } else {%>
      <%= toHtml(thisFolder.getSubject()) %>
      <dhv:label name="accounts.accounts_documents_file_move.CurrentFolder">(current folder)</dhv:label>
    <% } %>
    </td>
  </tr>
<%
  }
%>
</table>
<br />
<input type="button" value="Annulla" onClick="javascript:window.close()" />


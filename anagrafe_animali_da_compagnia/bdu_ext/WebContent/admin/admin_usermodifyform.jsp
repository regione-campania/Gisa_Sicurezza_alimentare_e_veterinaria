<%-- 
  - Copyright(c) 2004 Concursive Corporation (http://www.concursive.com/) All
  - rights reserved. This material cannot be distributed without written
  - permission from Concursive Corporation. Permission to use, copy, and modify
  - this material for internal use is hereby granted, provided that the above
  - copyright notice and this permission notice appear in all copies. CONCURSIVE
  - CORPORATION MAKES NO REPRESENTATIONS AND EXTENDS NO WARRANTIES, EXPRESS OR
  - IMPLIED, WITH RESPECT TO THE SOFTWARE, INCLUDING, BUT NOT LIMITED TO, THE
  - IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR ANY PARTICULAR
  - PURPOSE, AND THE WARRANTY AGAINST INFRINGEMENT OF PATENTS OR OTHER
  - INTELLECTUAL PROPERTY RIGHTS. THE SOFTWARE IS PROVIDED "AS IS", AND IN NO
  - EVENT SHALL CONCURSIVE CORPORATION OR ANY OF ITS AFFILIATES BE LIABLE FOR
  - ANY DAMAGES, INCLUDING ANY LOST PROFITS OR OTHER INCIDENTAL OR CONSEQUENTIAL
  - DAMAGES RELATING TO THE SOFTWARE.
  - 
  - Version: $Id: admin_usermodifyform.jsp 24344 2007-12-09 15:18:12Z rambabun@cybage.com $
  - Description: 
  --%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<jsp:useBean id="UserList" class="org.aspcfs.modules.admin.base.UserList"
             scope="request"/>
<jsp:useBean id="RoleList" class="org.aspcfs.modules.admin.base.RoleList"
             scope="request"/>
<jsp:useBean id="UserRecord" class="org.aspcfs.modules.admin.base.User"
             scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean"
             scope="session"/>
<jsp:useBean id="SiteIdList" class="org.aspcfs.utils.web.LookupList"
             scope="request"/>
<%@ include file="../initPage.jsp" %>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript"
        SRC="javascript/checkDate.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript"
        SRC="javascript/popCalendar.js"></SCRIPT>
<script type="text/javascript">
  function updateReportsToList() {
    var sel = document.forms['details'].elements['siteId'];
    var value = sel.options[sel.selectedIndex].value;
    var url = "Users.do?command=ReportsToJSList&form=details&widget=managerId&siteId=" + escape(value);
    window.frames['server_commands'].location.href = url;
  }
</script>

<body onLoad="javascript:document.details.username.focus();">
<form name="details" action="Users.do?command=UpdateUser&auto-populate=true"
      method="post">
<%-- Trails --%>
<table class="trails" cellspacing="0">
  <tr>
    <td>
      <a href="Admin.do"><dhv:label name="trails.admin">Admin</dhv:label></a> >
      <% if (request.getParameter("return") != null) {%>
      <% if (request.getParameter("return").equals("list")) {%>
      <a href="Users.do?command=ListUsers"><dhv:label name="admin.viewUsers">
        View Users</dhv:label></a> >
      <%}%>
      <%} else {%>
      <a href="Users.do?command=ListUsers"><dhv:label name="admin.viewUsers">
        View Users</dhv:label></a> >
      <a href="Users.do?command=UserDetails&id=<%= UserRecord.getId() %>">
        <dhv:label name="admin.userDetails">User Details</dhv:label></a> >
      <%}%>
      <dhv:label name="admin.modifyUser">Modify User</dhv:label>
    </td>
  </tr>
</table>
<%-- End Trails --%>
<dhv:container name="users" selected="details" object="UserRecord"
               param="<%= "id=" + UserRecord.getId() %>">
<% if (request.getParameter("return") != null) {%>
<input type="hidden" name="return" value="<%=request.getParameter("return")%>">
<%}%>
<dhv:permission name="admin-users-edit">
  <input type="submit"
         value="<dhv:label name="global.button.update">Update</dhv:label>">
</dhv:permission>
<% if (request.getParameter("return") != null) {%>
<% if (request.getParameter("return").equals("list")) {%>
<input type="submit"
       value="<dhv:label name="global.button.cancel">Cancel</dhv:label>"
       onClick="javascript:this.form.action='Users.do?command=ListUsers'">
<%}%>
<%} else {%>
<input type="submit"
       value="<dhv:label name="global.button.cancel">Cancel</dhv:label>"
       onClick="javascript:this.form.action='Users.do?command=UserDetails&id=<%=UserRecord.getId()%>'">
<%}%>
<dhv:permission name="admin-users-delete">
  <input type="submit"
         value="<dhv:label name="global.button.Disable">Disable</dhv:label>"
         onClick="javascript:this.form.action='Users.do?command=DisableUserConfirm&id=<%=UserRecord.getId()%>'">
</dhv:permission>
<br>
<input type="hidden" name="id" value="<%= UserRecord.getId() %>">
<input type="hidden" name="contactId" value="<%= UserRecord.getContactId() %>">
<input type="hidden" name="previousUsername"
       value="<%= ((UserRecord.getPreviousUsername() == null)?UserRecord.getUsername():UserRecord.getPreviousUsername()) %>">
<dhv:formMessage/>
<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
  <tr>
    <th colspan="2">
      <strong><dhv:label
          name="accounts.accounts_modify.ModifyPrimaryInformation">Modify
        Primary Information</dhv:label></strong>
    </th>
  </tr>
  <tr class="containerBody">
    <td class="formLabel"><dhv:label name="admin.uniqueUsername">Unique
      Username</dhv:label></td>
    <td>
      <input type="text" name="username"
             value="<%= toHtmlValue(UserRecord.getUsername()) %>">
      <font color=red>*</font> <%= showAttribute(request, "usernameError") %>
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel"><dhv:label name="admin.roleUserGroup">Role
      (User Group)</dhv:label></td>
    <td>
      <%= RoleList.getHtmlSelect("roleId", UserRecord.getRoleId()) %>
      <font color="red">*</font> <%= showAttribute(request, "roleError") %>
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
      <dhv:label name="admin.user.site">Site</dhv:label>
    </td>
    <td>
      <dhv:evaluate if="<%=User.getSiteId() == -1 %>">
        <%= SiteIdList.getHtmlSelect("siteId", UserRecord.getSiteId()) %>
        <%= showAttribute(request, "siteIdError") %>
      </dhv:evaluate>
      <dhv:evaluate if="<%=User.getSiteId() != -1 %>">
        <%= SiteIdList.getSelectedValue(UserRecord.getSiteId()) %>
        <input type="hidden" name="siteId" value="<%=UserRecord.getSiteId()%>">
      </dhv:evaluate>
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel"><dhv:label name="admin.reportsTo">Reports
      To</dhv:label></td>
    <td>
      <%= UserList.getHtmlSelect("managerId", UserRecord.getManagerId()) %>
      <%= showAttribute(request, "managerIdError") %>
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel"><dhv:label name="admin.access">
      Access</dhv:label></td>
    <td>
      <input type="checkbox" name="hasWebdavAccess"
             value="ON"<%= UserRecord.getHasWebdavAccess() ? " checked" : "" %>>
      <dhv:label name="user.allow.webdavAccess">Allow Webdav access</dhv:label>
      <br/>
      <input type="checkbox" name="hasHttpApiAccess"
             value="ON"<%= UserRecord.getHasHttpApiAccess() ? " checked" : "" %>>
      <dhv:label name="user.allow.httpApiAccess">Allow HTTP-API
        access</dhv:label>
    </td>
  </tr>
  <dhv:permission name="demo-view">
    <tr class="containerBody">
      <td nowrap class="formLabel"><dhv:label name="admin.aliasUser">Alias
        User</dhv:label></td>
      <td>
        <%= UserList.getHtmlSelect("alias", UserRecord.getAlias()) %>
      </td>
    </tr>
  </dhv:permission>
  <tr class="containerBody">
    <td nowrap class="formLabel"><dhv:label name="admin.expireDate">Expire
      Date</dhv:label></td>
    <td>
      <zeroio:dateSelect form="details" field="expires"
                         timestamp="<%= UserRecord.getExpires() %>"/>
      <%= showAttribute(request, "expiresError") %>
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel"><dhv:label
        name="accounts.accounts_contacts_portal_include.GenerateNewPassword">
      Generate new password</dhv:label></td>
    <td>
      <table border="0" cellpadding="0" cellspacing="0" class="empty">
        <tr>
          <td valign="center">
            <input type="checkbox" name="generatePass"
                   value="true" <%= "".equals(UserRecord.getContact().getPrimaryEmailAddress()) ? "disabled=\"true\"":"" %>>
          </td>
          <td width="8"></td>
          <td valign="center">
            <dhv:evaluate
                if="<%= !"".equals(UserRecord.getContact().getPrimaryEmailAddress()) %>">
              <dhv:label name="admin.newPassword.emailed">Note: New password
                will be emailed to the following address:</dhv:label>
              <%= UserRecord.getContact().getPrimaryEmailAddress() %>
            </dhv:evaluate>
            <dhv:evaluate
                if="<%= "".equals(UserRecord.getContact().getPrimaryEmailAddress()) %>">
              <dhv:label name="contacts.noContactEmailAddressFound">No Contact
                Email Address found. Please add one.</dhv:label>
            </dhv:evaluate>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<br>
<dhv:permission name="admin-users-edit">
  <input type="submit"
         value="<dhv:label name="global.button.update">Update</dhv:label>">
</dhv:permission>
<% if (request.getParameter("return") != null) {%>
<% if (request.getParameter("return").equals("list")) {%>
<input type="submit"
       value="<dhv:label name="global.button.cancel">Cancel</dhv:label>"
       onClick="javascript:this.form.action='Users.do?command=ListUsers'">
<%}%>
<%} else {%>
<input type="submit"
       value="<dhv:label name="global.button.cancel">Cancel</dhv:label>"
       onClick="javascript:this.form.action='Users.do?command=UserDetails&id=<%=UserRecord.getId()%>'">
<%}%>
<dhv:permission name="admin-users-delete">
  <input type="submit"
         value="<dhv:label name="global.button.Disable">Disable</dhv:label>"
         onClick="javascript:this.form.action='Users.do?command=DisableUserConfirm&id=<%=UserRecord.getId()%>'">
</dhv:permission>
</dhv:container>
<iframe src="empty.html" name="server_commands" id="server_commands"
        style="visibility:hidden" height="0"></iframe>
</form>
</body>
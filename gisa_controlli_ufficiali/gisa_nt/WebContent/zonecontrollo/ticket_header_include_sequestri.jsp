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
  - Version: $Id: ticket_header_include.jsp 21501 2007-05-21 20:36:25Z matt $
  - Description:
  --%>
<%@ page import="org.aspcfs.modules.base.Constants, org.aspcfs.modules.troubletickets.base.Ticket" %>
<%
  Ticket thisTicket = (Ticket)request.getAttribute("TicketDetails");
  if (thisTicket == null) {
    thisTicket = (Ticket)request.getAttribute("ticketDetails");
  }
  if (thisTicket == null) {
    thisTicket = (Ticket) request.getAttribute("ticket");
  }
%>
<table width="100%" border="0">
  <tr>
    <td nowrap width="100%"> <table width="100%" class="empty">
      
        <tr><td nowrap colspan="2" align="left">
          <strong><dhv:label name="">Zona di Controllo sottoposto a Sequestro/Blocco: </dhv:label></strong>
          <dhv:permission name="zonecontrollo-view">
            <a href="javascript:popURL('ZoneControllo.do?command=Details&orgId=<%= thisTicket.getOrgId() %>&ticketId=<%=thisTicket.getId() %>&popup=true&viewOnly=true','ZoneControlloDetails','650','500','yes','yes');"><%= toHtml(OrgDetails.getName()) %></a>
          </dhv:permission>
          <dhv:permission name="zonecontrollo-view" none="true">
            <%= toHtml(thisTicket.getCompanyName()) %>
          </dhv:permission>
        </td></tr>
      </table>
    </td>
    <%-- td nowrap align="right">
      <img src="images/icons/stock_print-16.gif" border="0" align="absmiddle" height="16" width="16"/>
      <a href="TroubleTicketsSanzioni.do?command=PrintReport&id=<%= thisTicket.getId() %>"><dhv:label name="accounts.tickets.print">Printable Ticket Form</dhv:label></a>
    </td --%>
  </tr>
  <tr>
    <%--td nowrap width="100%">
      <strong><dhv:label name="quotes.quotes.header.status">Status:</dhv:label></strong>
  <% if (thisTicket.isTrashed()) { %>
        <dhv:label name="global.trashed">Trashed</dhv:label>&nbsp;
        <% if (thisTicket.getClosed() == null){ %>
          (<dhv:label name="quotes.open">Open</dhv:label>)
        <%} else{%>
          (<font color="red">Closed on
            <zeroio:tz timestamp="<%= thisTicket.getClosed() %>" timeZone="<%= User.getTimeZone() %>" showTimeZone="true"/>
          </font>)
        <%}%>
  <% } else if (thisTicket.getClosed() == null){ %>
        <dhv:label name="quotes.open">Open</dhv:label>
  <%} else{%>
        <font color="red">Closed on
        <zeroio:tz timestamp="<%= thisTicket.getClosed() %>" timeZone="<%= User.getTimeZone() %>" showTimeZone="true"/>
        </font>
  <%}%>
      </td --%>
    
  </tr>
</table>
<br />

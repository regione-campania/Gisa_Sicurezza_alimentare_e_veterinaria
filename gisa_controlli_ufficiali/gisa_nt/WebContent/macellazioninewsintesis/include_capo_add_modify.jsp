<%@page import="org.aspcfs.modules.macellazioninewsintesis.utils.ConfigTipo"%>
<%
ConfigTipo configTipo = (ConfigTipo) request.getSession().getAttribute("configTipo");
String fileToInclude = "include_capo_add_modify" + configTipo.getIdTipo() + ".jsp";
%>


<jsp:include page="<%=fileToInclude%>"/>
 
</body>
